using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : MasterPage
{
    private const string AntiXsrfTokenKey = "__AntiXsrfToken";
    private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
    private string _antiXsrfTokenValue;
    /// <summary>
    /// This method was preloaded upon creating the web application. It was not updated by beyond HORIZON SOLUTIONS.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Init(object sender, EventArgs e)
    {
        // The code below helps to protect against XSRF attacks
        var requestCookie = Request.Cookies[AntiXsrfTokenKey];
        Guid requestCookieGuidValue;
        if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
        {
            // Use the Anti-XSRF token from the cookie
            _antiXsrfTokenValue = requestCookie.Value;
            Page.ViewStateUserKey = _antiXsrfTokenValue;
        }
        else
        {
            // Generate a new Anti-XSRF token and save to the cookie
            _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
            Page.ViewStateUserKey = _antiXsrfTokenValue;

            var responseCookie = new HttpCookie(AntiXsrfTokenKey)
            {
                HttpOnly = true,
                Value = _antiXsrfTokenValue
            };
            if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
            {
                responseCookie.Secure = true;
            }
            Response.Cookies.Set(responseCookie);
        }

        Page.PreLoad += master_Page_PreLoad;
    }
    /// <summary>
    /// This method was preloaded upon creating the web application. It was not updated by beyond HORIZON SOLUTIONS.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void master_Page_PreLoad(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Set Anti-XSRF token
            ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
            ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
        }
        else
        {
            // Validate the Anti-XSRF token
            if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
            {
                throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
            }
        }
    }
    /// <summary>
    /// This method is used during the web page load.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        // Assing the navigation login text based on whether the Administrator is logged in
        LoginButton.Text = Session["adminID"] != null ? "Log out" : "Log in";

        // If the individual is not on the Admin page; hide all Administrator navigation links
        if (!HttpContext.Current.Request.RawUrl.StartsWith("/Admin") && !HttpContext.Current.Request.RawUrl.StartsWith("/admin"))
        {
            FSOSSNavbar.Visible = false;
            hamburger.Visible = false;
        }

        // If the Administrator is logged in
        if (Session["securityID"] != null)
        {
            // If the Administrator is not the Master Administrator; hide navigation links for CRUD pages
            if ((int)Session["securityID"] != 2)
                MasterAdminDropDown.Visible = false;
            else
                MasterAdminDropDown.Visible = true;
        }
    }
    /// <summary>
    /// This method was preloaded upon creating the web application. It was not updated by beyond HORIZON SOLUTIONS.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        Context.GetOwinContext().Authentication.SignOut();
    }
    /// <summary>
    /// This method is used when the Administrator clicks the navigation Login button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LoginButton_Click(object sender, EventArgs e)
    {
        // If the button text is "Log out"; clear all session and redirect the Administrator to the Administrator login page
        if (LoginButton.Text == "Log out")
        {
            Session.Abandon();
            Response.Redirect("~/Admin/Login.aspx");
        }
        else
            Response.Redirect("~/Admin/Login.aspx");
    }
    /// <summary>
    /// This method is used when the individual clicks the navigation logo
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LogoLink_Click(object sender, EventArgs e)
    {
        // If the individual is in the Administrator web page; it will redirect the individual to the Administrator home page
        if (HttpContext.Current.Request.RawUrl.StartsWith("/Admin") || HttpContext.Current.Request.RawUrl.StartsWith("/admin"))
            Response.Redirect("~/Admin");
        // If the individual is taking the survey
        else
        {
            // Clear all sessions to clear all saved survey answers
            Session.Abandon();
            // Redirect the individual to the Survey Access page
            Response.Redirect("~/");
        }
    }
}