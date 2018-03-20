using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_CreateUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (Session["securityID"].ToString() != "2") // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        else
        {
            // Set Default button for page
            Page.Form.DefaultButton = CreateButton.UniqueID; // Enables user to press enter button

            if (!IsPostBack)
            {
                SuccessMessage.Visible = false;
                ClearFields();
            }
        }
    }

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        Page.Validate();
        if (!IsValid)
        {
            ValidationSummary.Visible = true;
            SuccessMessage.Visible = false;
        }
        else
        {
            string firstName = FirstNameTextBox.Text;
            string lastName = LastNameTextBox.Text;
            string password = PasswordTextBox.Text;
            int selectedRoleId = Convert.ToInt32(SecurityLevelDDL.SelectedItem.Value);

            // Replace any last name that has a '-' with an empty string ('') -- March 20, 2018
            string concatName = FirstNameTextBox.Text[0] + lastName.Replace("-", "");

            AdministratorAccountController sysmgr = new AdministratorAccountController();
            string newUser = sysmgr.AddUser(concatName.ToLower(), password, firstName, lastName, selectedRoleId);

            SuccessMessage.Visible = true;
            SuccessMessage.Text = "Successfully added: " + newUser;

            ClearFields();
        }

    }

    private void ClearFields()
    {
        FirstNameTextBox.Text = null;
        LastNameTextBox.Text = null;
        PasswordTextBox.Text = null;
        SecurityLevelDDL.SelectedIndex = 0;
    }
}