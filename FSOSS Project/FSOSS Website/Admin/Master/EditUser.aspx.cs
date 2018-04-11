using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_EditUser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Set Default button for page
        Page.Form.DefaultButton = UpdateButton.UniqueID; // Enables user to press enter button

        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if ((int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        else
        {
            if (String.IsNullOrEmpty(Request.QueryString["id"]))
                Response.Redirect("~/Admin/Master/EditUserFilter");
            else
            {
                SuccessMessage.Visible = false;
                FailedMessage.Visible = false;
                int id = int.Parse(Request.QueryString["id"].ToString());

                if (!IsPostBack)
                {
                    // Populate user information fields
                    AdministratorAccountController sysmgr = new AdministratorAccountController();
                    AdministratorAccountPOCO info = sysmgr.GetAdministratorInformation(id);

                    UserNameTextBox.Text = info.username;
                    FirstNameTextBox.Text = info.firstName;
                    LastNameTextBox.Text = info.lastName;
                    SecurityLevelDDL.SelectedValue = info.roleId.ToString();
                    DeactivateCheckBox.Checked = info.archivedBool;
                }
            }
        }
    }
    // TODO: Rameses - clean up this method
    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(Request.QueryString["id"]).Equals(Convert.ToInt32(Session["userID"])) && DeactivateCheckBox.Checked)
        {
            SuccessMessage.Visible = false;
            FailedMessage.Visible = true;
            FailedMessage.Text = "You cannot Deactivate your own account.";
        }
        else if (UserNameTextBox.Text.Equals("webmaster") && DeactivateCheckBox.Checked)
        {
            SuccessMessage.Visible = false;
            FailedMessage.Visible = true;
            FailedMessage.Text = "You cannot Deactivate the webmaster account.";
        }
        else if (UserNameTextBox.Text.Equals("webmaster") && SecurityLevelDDL.SelectedValue.Equals("1"))
        {
            SuccessMessage.Visible = false;
            FailedMessage.Visible = true;
            FailedMessage.Text = "You cannot set the webmaster account as Standard Administrator.";
            SecurityLevelDDL.SelectedValue = "2";
        }
        else
        {
            if (String.IsNullOrEmpty(ConfirmPasswordTextBox.Text) && String.IsNullOrEmpty(PasswordTextBox.Text))
            {
                // Disable validation checks for password input
                ConfirmPasswordRFV.Enabled = false;
                ConfirmPasswordCV.Enabled = false;

                // Validate page
                Page.Validate();
                if (IsValid)
                {
                    // Update user excluding the password change
                    AdministratorAccountController sysmgr = new AdministratorAccountController();
                    string updatedUser = sysmgr.UpdateAdministratorAccount(UserNameTextBox.Text, FirstNameTextBox.Text, LastNameTextBox.Text, DeactivateCheckBox.Checked, int.Parse(SecurityLevelDDL.SelectedItem.Value));
                    SuccessMessage.Visible = true;
                    SuccessMessage.Text = "Successfully updated: " + updatedUser;
                }
            }
            else
            {
                ConfirmPasswordRFV.Enabled = true;
                ConfirmPasswordCV.Enabled = true;
                Page.Validate();
                if (IsValid)
                {
                    // Update user including the password change
                    AdministratorAccountController sysmgr = new AdministratorAccountController();
                    string updatedUser = sysmgr.UpdateAdministratorAccount(UserNameTextBox.Text, PasswordTextBox.Text, FirstNameTextBox.Text, LastNameTextBox.Text, DeactivateCheckBox.Checked, int.Parse(SecurityLevelDDL.SelectedItem.Value));
                    SuccessMessage.Visible = true;
                    SuccessMessage.Text = "Successfully updated: " + updatedUser;
                }
            }
        }
    }

    protected void FirstNameLengthValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (FirstNameTextBox.Text.Trim().Length < 50);
    }

    protected void LastNameLengthValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (LastNameTextBox.Text.Trim().Length < 50);
    }
}