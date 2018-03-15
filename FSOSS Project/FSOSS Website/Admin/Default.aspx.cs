using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_MainPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (Session["securityID"].ToString() != "2" && Session["securityID"].ToString() != "1") // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        else
        {
            if (!Page.IsPostBack)
            {
                WOTDLabel.Text += "flower"; // Replace with proper Word of the day

                SubmittedSurveyController ssc = new SubmittedSurveyController();
                HospitalDDL.DataBind();
                HospitalDDL.SelectedValue = "1";

                string value = HospitalDDL.SelectedValue;
                if (value != null)
                {
                    //PendingRequestNumberLabel.Text = value;
                    int siteID = Convert.ToInt32(value);
                    int contactCount = ssc.GetContactRequestTotal(siteID);

                    if (contactCount > 0)
                    {
                        PendingRequestNumberLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";
                        PendingRequestNumberLabel.Font.Bold = true;
                        PendingRequestNumberLabel.CssClass += " text-danger";
                        PendingContactSection.Attributes["class"] += " card border-dark bg-warning";
                    }
                    else
                    {
                        PendingRequestNumberLabel.Text = "&nbsp; 0 &nbsp;";
                        ViewButton.Visible = false;
                    }
                }
            }

            WelcomeMessage.Text += Session["username"].ToString();
        }
    }

    protected void HospitalDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        //update the contact request count
        SubmittedSurveyController ssc = new SubmittedSurveyController();
        string value = HospitalDDL.SelectedValue;
        int siteID = Convert.ToInt32(value);
        int contactCount = ssc.GetContactRequestTotal(siteID);
        PendingRequestNumberLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";

        //TO ADD update the survey word of the day


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

    }

    protected void RecentReportsButton_Click(object sender, EventArgs e)
    {

    }
}