using FSOSS.System.BLL;
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
        Page.Form.DefaultButton = SurveyButton.UniqueID; // Enables user to press enter button
    }

    protected void SurveyButton_Click(object sender, EventArgs e)
    {
        SurveyWordController controller = new SurveyWordController();
        bool isValid = controller.ValidateAccessWord(WOTDTextBox.Text.ToLower());

        //if (WOTDTextBox.Text != "spring")
        if (!isValid)
        {
            Message.Visible = true;
            Message.Text = "You entered the wrong word";

            WOTDTextBox.Focus();
            WOTDTextBox.BorderColor = System.Drawing.Color.Red;
            WOTDTextBox.BackColor = System.Drawing.ColorTranslator.FromHtml("#f8d7da");
            WOTDTextBox.ForeColor = System.Drawing.ColorTranslator.FromHtml("#721c24");

            // have a Session to capture latest survey id and site id
        }
        //else if (WOTDTextBox.Text == "spring")
        else
        {
            Session["takingSurvey"] = true;
            Response.Redirect("~/TakeSurvey.aspx");
        }
    }
}