using FSOSS.System.BLL;
using FSOSS.System.Data.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SurveyButton_Click(object sender, EventArgs e)
    {
        SurveyWordController controller = new SurveyWordController();
        bool isValid = controller.ValidateAccessWord(WOTDTextBox.Text.Trim().ToLower());

        if (!isValid)
        {
            Message.Visible = true;
            Message.Text = "You entered the wrong word";

            WOTDTextBox.Focus();
            WOTDTextBox.BorderColor = System.Drawing.Color.Red;
            WOTDTextBox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f8d7da");
            WOTDTextBox.ForeColor = System.Drawing.ColorTranslator.FromHtml("#721c24");
        }
        else
        {
            SurveyWordController sysmgr = new SurveyWordController();            
            Session["siteID"] = sysmgr.GetSite(WOTDTextBox.Text.Trim().ToLower()).site_id;

            //RETURN LATEST SURVEY ID
            SurveyVersionController version = new SurveyVersionController();
            Session["survey_version_id"] = version.GetLatestSurvey().survey_version_id;


            Session["takingSurvey"] = true;
            Response.Redirect("~/TakeSurvey.aspx");
        }
    }
}