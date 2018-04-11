﻿using System;
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

    protected void Page_Load(object sender, EventArgs e)
    {
        LoginButton.Text = Session["userID"] != null ? "Log out" : "Log in";
        
        if (!HttpContext.Current.Request.RawUrl.StartsWith("/Admin") && !HttpContext.Current.Request.RawUrl.StartsWith("/admin"))
        {
            //logolink.HRef = "~/Admin";
            //LogoLink.PostBackUrl = "~/Admin/";
            //FSOSSNavbar.Visible = true;
            //hamburger.Visible = true;
            FSOSSNavbar.Visible = false;
            hamburger.Visible = false;
        }
        //else
        //{
        //    //logolink.HRef = "~/";
        //    //LogoLink.PostBackUrl = "~/";
        //    FSOSSNavbar.Visible = false;
        //    hamburger.Visible = false;
        //}

        if (Session["securityID"] != null)
        {
            if (Session["securityID"].ToString() != "2")
            {
                MasterAdminDropDown.Visible = false;
            }
            else
            {
                MasterAdminDropDown.Visible = true;
            }
        }
    }

    protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
    {
        Context.GetOwinContext().Authentication.SignOut();
    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        if (LoginButton.Text == "Log out")
        {
            Session.Abandon();
            Response.Redirect("~/Admin");
        }
        else
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
    }

    protected void LogoLink_Click(object sender, EventArgs e)
    {
        //if (!HttpContext.Current.Request.RawUrl.StartsWith("/Admin") && !HttpContext.Current.Request.RawUrl.StartsWith("/admin"))
        //{
        //    Session.Abandon();
        //}

        if (HttpContext.Current.Request.RawUrl.StartsWith("/Admin") || HttpContext.Current.Request.RawUrl.StartsWith("/admin"))
        {
            //logolink.HRef = "~/Admin";
            Response.Redirect("~/Admin");
        }
        else
        {
            //logolink.HRef = "~/";
            Session.Abandon();
            Response.Redirect("~/");
            
            //FSOSSNavbar.Visible = false;
            //hamburger.Visible = false;
        }
    }
}