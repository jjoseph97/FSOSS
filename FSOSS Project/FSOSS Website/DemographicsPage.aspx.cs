using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Survey_DemographicsPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["takingSurvey"] == null)
        {
            Response.Redirect("~/");
        }
        if (CustomerProfileCheckBox.Checked)
            CustomerProfileContent.Visible = true;
        else
            CustomerProfileContent.Visible = false;

        if (ContactRequestsCheckBox.Checked)
            ContactRequestsContent.Visible = true;
        else
            ContactRequestsContent.Visible = false;
    }

    protected void CustomerProfileCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (CustomerProfileCheckBox.Checked)
        {
            CustomerProfileContent.Visible = true;
            GenderDDL.SelectedItem.Value = "";
            GenderDDL.SelectedItem.Selected = true;
            AgeDDL.SelectedItem.Value = "";
            AgeDDL.SelectedItem.Selected = true;
        }
        else
            CustomerProfileContent.Visible = false;
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/DummyResults");
    }

    protected void ContactRequestsCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (ContactRequestsCheckBox.Checked)
        {
            ContactRequestsContent.Visible = true;
            PhoneTextBox.Text = "";
            RoomTextBox.Text = "";
        }
        else
            CustomerProfileContent.Visible = false;
    }
}