using System;
using System.Web.UI;
using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;

public partial class Pages_AdministratorPages_MainPage : System.Web.UI.Page
{
    /// <summary>
    /// When the page loads first the page checks if the user is logged in, and is redirected to the login page if not.
    /// Then the method checks if the user has has proper authentication (Master Administrator role) to access this page.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirect Administrator to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else
        {
            if (!Page.IsPostBack)
            {
                SubmittedSurveyController ssc = new SubmittedSurveyController();
                HospitalDDL.DataBind();
                // Default the dropdown list to Misericordia Hospital
                HospitalDDL.SelectedValue = "1";
                string value = HospitalDDL.SelectedValue;
                if (value != null)
                {
                    // Assign variables to be used
                    int siteID = Convert.ToInt32(value);
                    int contactCount = ssc.GetContactRequestTotal(siteID);

                    // Get the survey word of the day for the selected site
                    SurveyWordController surveyWordManager = new SurveyWordController();
                    WOTDLabel.Text = surveyWordManager.GetSurveyWord(siteID);

                    // Change styling to grab the Administrator's attention if the contact count is greater than zero (0)
                    if (contactCount > 0)
                    {
                        PendingRequestNumberLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";
                        PendingRequestNumberLabel.Font.Bold = true;
                        PendingRequestNumberLabel.ForeColor = System.Drawing.ColorTranslator.FromHtml("#223f88");
                        PendingContactSection.Attributes["style"] = " background-color: #a6ebf7";
                    }
                    // Hide the View button and clear the highlight styling
                    else
                    {
                        PendingRequestNumberLabel.Text = "&nbsp; 0 &nbsp;";
                        ViewButton.Visible = false;
                    }
                }
            }
            // Display a welcome message with the Administrator's username
            WelcomeMessage.Text = "Welcome, " + Session["username"].ToString();
        }
    }
    /// <summary>
    /// This method is used when the Administrator changes the selected index on the dropdown list
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void HospitalDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        // Update the contact request count
        SubmittedSurveyController ssc = new SubmittedSurveyController();
        string value = HospitalDDL.SelectedValue;
        int siteID = Convert.ToInt32(value);
        int contactCount = ssc.GetContactRequestTotal(siteID);
        // Change styling to grab the Administrator's attention if the contact count is greater than zero (0)
        if (contactCount > 0)
        {
            ViewButton.Visible = true;
            PendingRequestNumberLabel.Text = "&nbsp;" + contactCount.ToString() + " &nbsp;";
            PendingRequestNumberLabel.Font.Bold = true;
            PendingRequestNumberLabel.ForeColor = System.Drawing.ColorTranslator.FromHtml("#223f88");
            PendingContactSection.Attributes["style"] = " background-color: #a6ebf7";
        }
        // Hide the View button and clear the highlight styling
        else
        {
            PendingContactSection.Attributes["style"] = null;
            PendingRequestNumberLabel.Text = "&nbsp; 0 &nbsp;";
            ViewButton.Visible = false;
        }

        // Update the survey word of the day on the new selected site
        SurveyWordController surveyWordManager = new SurveyWordController();
        WOTDLabel.Text = surveyWordManager.GetSurveyWord(siteID);
    }
    /// <summary>
    /// This method is used when the Administrator clicks the View button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ViewButton_Click(object sender, EventArgs e)
    {
        string value = HospitalDDL.SelectedValue;
        int siteID = Convert.ToInt32(value);
        string url = "~/Admin/ContactListPage.aspx?sid=" + siteID.ToString();
        Response.Redirect(url);
    }
    /// <summary>
    /// This method is used when the Administrator clicks the View Recent Surveys button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void RecentSurveysButton_Click(object sender, EventArgs e)
    {
        FilterPOCO filter = new FilterPOCO(); // Create the filter object for adding the filter details
        filter.startingDate = DateTime.Today.AddDays(-7); // Last 7 days ago
        filter.endDate = DateTime.Now; // Current time and day
        filter.siteID = int.Parse(HospitalDDL.SelectedValue); // Retrieve selected site
        filter.mealID = 0; // Defaults to "All Meals"
        filter.unitID = 0; // Defaults to "All Units"
        Session["filter"] = filter; // Create the session to be passed to the SubmittedSurveyList page
        Response.Redirect("SubmittedSurveyList.aspx"); // Redirect to the SubmittedSurveyList page with the filter details
    }
    /// <summary>
    /// This method is used when the Administrator clicks the View Recent Reports button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void RecentReportsButton_Click(object sender, EventArgs e)
    {
        FilterPOCO filter = new FilterPOCO(); // Create the filter object for adding the filter details
        filter.startingDate = DateTime.Today.AddDays(-7); // Last 7 days ago
        filter.endDate = DateTime.Now; // Current time and day
        filter.siteID = int.Parse(HospitalDDL.SelectedValue); // Retrieve selected site
        filter.mealID = 0; // Defaults to "All Meals"
        Session["filter"] = filter; // Create the session to be passed to the SubmittedSurveyList page
        Response.Redirect("~/Admin/ReportPage.aspx"); // Redirect to the ReportPage with the filter details

    }
}