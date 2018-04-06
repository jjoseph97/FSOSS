using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_ContactListPage : System.Web.UI.Page
{
    /// <summary>
    /// when the page loads, the page checks the user's session's credentials to ensure that they are allowed to access the page.
    /// If the user does, if it is the first time loading the page, the site id is pulled and checked.
    /// It then uses the site id with the method GetContactRequestTotal() to determine the number of  requests for the site,
    /// and sets the ContactCountLabel's text to this number.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        //message.Text = HttpContext.Current.Request.RawUrl.StartsWith("/Pages/AdministratorPages").ToString();


        if (Session["securityID"] == null || Session["securityID"].ToString() == "") // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }

        if (!Page.IsPostBack)
        {

            //retrieve the site id passed from the main screen
            SubmittedSurveyController ssc = new SubmittedSurveyController();
            SiteDDL.DataBind();
            string broughtSite = Request.QueryString["sid"];

            //add check to ensure the passed siteid is a vaild site id

            //set the selection to the given site id
            SiteDDL.SelectedValue = broughtSite;

            string value = SiteDDL.SelectedValue;
            //update label to display the desired value
            if (value != null)
            {
                //PendingRequestNumberLabel.Text = value;
                int siteID = Convert.ToInt32(value);
                int contactCount = ssc.GetContactRequestTotal(siteID);
                ContactCountLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";
            }
        }

    }

    /// <summary>
    /// updates the page when a new site is selected
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SiteDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        SubmittedSurveyController ssc = new SubmittedSurveyController();
        string value = SiteDDL.SelectedValue;

        //PendingRequestNumberLabel.Text = value;
        int siteID = Convert.ToInt32(value);
        int contactCount = ssc.GetContactRequestTotal(siteID);
        ContactCountLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";


    }

    /// <summary>
    /// takes the selected row's submittedSurveyID and passes it to the Submitted Survey viewer page
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e">list view row button</param>
    protected void GoToSSView(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "look")
        {
            Label l = (Label)e.Item.FindControl("submittedSurveyIDLabel");

            string url = "~/Admin/SubmittedSurveyViewerPage.aspx?sid=" + l.Text;
            Response.Redirect(url);
        }

    }

}