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
        if (String.IsNullOrEmpty(Request.QueryString["id"]))
            Response.Redirect("~/Admin/Master/EditUserFilter");
        else
        {
            SuccessMessage.Visible = false;
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
    // TODO: Rameses - clean up this method
    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(Request.QueryString["id"]).Equals(Convert.ToInt32(Session["userID"])) && DeactivateCheckBox.Checked)
        {
            SuccessMessage.Visible = true;
            SuccessMessage.Text = "Bad";
        }
        else
        {
            if (String.IsNullOrEmpty(ConfirmPasswordTextBox.Text))
            {
                // Disable validation checks for password input
                ConfirmPasswordRFV.Enabled = false;
                ConfirmPasswordCV.Enabled = false;

                // Validate page
                Page.Validate();
                if (IsValid)
                {
                    // Update user excluding the password change
                    // Update user including the password change
                    AdministratorAccountController sysmgr = new AdministratorAccountController();
                    try
                    {
                        SuccessMessage.Visible = true;
                        SuccessMessage.Text = "Successfully updated: " + sysmgr.UpdateAdministratorAccount(UserNameTextBox.Text, FirstNameTextBox.Text, LastNameTextBox.Text, DeactivateCheckBox.Checked, int.Parse(SecurityLevelDDL.SelectedItem.Value));
                    }
                    catch (Exception)
                    {

                        throw;
                    }
                }
            }
            else
            {
                Page.Validate();
                if (IsValid)
                {
                    // Update user including the password change
                    AdministratorAccountController sysmgr = new AdministratorAccountController();
                    try
                    {
                        SuccessMessage.Visible = true;
                        SuccessMessage.Text = "Successfully updated: " + sysmgr.UpdateAdministratorAccount(UserNameTextBox.Text, PasswordTextBox.Text, FirstNameTextBox.Text, LastNameTextBox.Text, DeactivateCheckBox.Checked, int.Parse(SecurityLevelDDL.SelectedItem.Value));
                    }
                    catch (Exception)
                    {

                        throw;
                    }
                }
            }
        }
    }
}