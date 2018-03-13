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
        if (WOTDTextBox.Text != "sunshine")
        {
            Message.Visible = true;
            Message.Text = "You entered the wrong word";
            Message.CssClass = "text-white bg-danger p-2 rounded";
        }
        else if (WOTDTextBox.Text == "sunshine")
        {
            Session["takingSurvey"] = true;
            Response.Redirect("~/TakeSurvey.aspx");
        }
        else
        {
            Message.Visible = false;
        }
    }
}