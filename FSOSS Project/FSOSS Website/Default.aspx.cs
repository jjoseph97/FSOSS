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
            message.Visible = true;
            message.Text = "Wrong word";
            message.CssClass = "text-white bg-danger p-2";
        }
        else if (WOTDTextBox.Text == "sunshine")
        {
            message.Visible = true;
            message.Text = "Correct";
            message.CssClass = "bg-success text-white p-2";

            //Response.Redirect("");
        }
        else
        {
            message.Visible = false;
        }
    }
}