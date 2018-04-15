using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
#region
using FSOSS.System.BLL;
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_AdministratorPages_MainPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if ((int)Session["securityID"] != 1 && (int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        else
        {
            if (!Page.IsPostBack)
            {
                SubmittedSurveyController ssc = new SubmittedSurveyController();
                HospitalDDL.DataBind();
                HospitalDDL.SelectedValue = "1";
                string value = HospitalDDL.SelectedValue;
                if (value != null)
                {
                    //PendingRequestNumberLabel.Text = value;
                    int siteID = Convert.ToInt32(value);
                    int contactCount = ssc.GetContactRequestTotal(siteID);
                    SurveyWordController surveyWordManager = new SurveyWordController();
                    WOTDLabel.Text =surveyWordManager.GetSurveyWord(siteID); 
                    if (contactCount > 0)
                    {
                        PendingRequestNumberLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";
                        PendingRequestNumberLabel.Font.Bold = true;
                        PendingRequestNumberLabel.ForeColor = System.Drawing.ColorTranslator.FromHtml("#223f88");
                        PendingContactSection.Attributes["style"] = " background-color: #a6ebf7";
                    }
                    else
                    {
                        PendingRequestNumberLabel.Text = "&nbsp; 0 &nbsp;";
                        ViewButton.Visible = false;
                    }
                }
            }
            WelcomeMessage.Text = "Welcome, " + Session["username"].ToString();
        }
    }

    protected void HospitalDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        //update the contact request count
        SubmittedSurveyController ssc = new SubmittedSurveyController();
        string value = HospitalDDL.SelectedValue;
        int siteID = Convert.ToInt32(value);
        int contactCount = ssc.GetContactRequestTotal(siteID);
        if (contactCount > 0)
        {
            ViewButton.Visible = true;
            PendingRequestNumberLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";
            PendingRequestNumberLabel.Font.Bold = true;
            PendingRequestNumberLabel.ForeColor = System.Drawing.ColorTranslator.FromHtml("#223f88");
            PendingContactSection.Attributes["style"] = " background-color: #a6ebf7";
        }
        else
        {
            PendingContactSection.Attributes["style"] = null;
            PendingRequestNumberLabel.Text = "&nbsp; 0 &nbsp;";
            ViewButton.Visible = false;
        }
        SurveyWordController surveyWordManager = new SurveyWordController();
        WOTDLabel.Text = surveyWordManager.GetSurveyWord(siteID);
    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        string value = HospitalDDL.SelectedValue;
        int siteID = Convert.ToInt32(value);
        string url = "~/Admin/ContactListPage.aspx?sid=" + siteID.ToString();
        Response.Redirect(url);
    }

    protected void RecentSurveysButton_Click(object sender, EventArgs e)
    {
        string url = "~/Admin/SubmittedSurveyList.aspx";
        Response.Redirect(url);
    }

    protected void RecentReportsButton_Click(object sender, EventArgs e)
    {

    }
}