using FSOSS.System.BLL;
using System;
using System.Web.UI;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    /// <summary>
    /// This method is used when the survey participant clicks the Begin Survey button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SurveyButton_Click(object sender, EventArgs e)
    {
        // Verify if the entered word is a valid survey word of the day
        SurveyWordController controller = new SurveyWordController();
        bool isValid = controller.ValidateAccessWord(WOTDTextBox.Text.Trim().ToLower());
        // If the entered word is not valid; display a message to the survey participant
        if (!isValid)
        {
            Message.Visible = true;
            Message.Text = "You entered the wrong word";
            // Set focus to the access word text box
            WOTDTextBox.Focus();
            // Set sytling on the access word text box
            WOTDTextBox.BorderColor = System.Drawing.Color.Red;
            WOTDTextBox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f8d7da");
            WOTDTextBox.ForeColor = System.Drawing.ColorTranslator.FromHtml("#721c24");
        }
        else
        {
            // Create a session for the site based on the word of the day
            SurveyWordController sysmgr = new SurveyWordController();            
            Session["siteID"] = sysmgr.GetSite(WOTDTextBox.Text.Trim().ToLower()).site_id;

            // Create a session for the latest survey version
            SurveyVersionController version = new SurveyVersionController();
            Session["survey_version_id"] = version.GetLatestSurvey().survey_version_id;

            // Create a boolean session to ensure the survey participant is taking the survey
            Session["takingSurvey"] = true;

            // Redirect the survey participant to the Take Survey page
            Response.Redirect("~/TakeSurvey.aspx");
        }
    }
}