using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_ContactListPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //message.Text = HttpContext.Current.Request.RawUrl.StartsWith("/Pages/AdministratorPages").ToString();


        if (Session["securityID"] == null || Session["securityID"].ToString() == "") // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }

        if (!Page.IsPostBack)
        {


            SubmittedSurveyController ssc = new SubmittedSurveyController();
            SiteDDL.DataBind();
            string broughtSite = Request.QueryString["sid"];

            //add check to ensure the passed siteid is a vaild site id

            SiteDDL.SelectedValue = broughtSite;

            string value = SiteDDL.SelectedValue;
            if (value != null)
            {
                //PendingRequestNumberLabel.Text = value;
                int siteID = Convert.ToInt32(value);
                int contactCount = ssc.GetContactRequestTotal(siteID);
                ContactCountLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";
            }
        }

    }


    protected void SiteDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        SubmittedSurveyController ssc = new SubmittedSurveyController();
        string value = SiteDDL.SelectedValue;

        //PendingRequestNumberLabel.Text = value;
        int siteID = Convert.ToInt32(value);
        int contactCount = ssc.GetContactRequestTotal(siteID);
        ContactCountLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";


    }


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