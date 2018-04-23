using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_EditUser : System.Web.UI.Page
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
        else if ((int)Session["securityID"] != 2) // Return HTTP Code 403 if not Master Administrator
        {
            Context.Response.StatusCode = 403;
        }
        else
        {
            if (String.IsNullOrEmpty(Request.QueryString["id"])) // If the query string is empty or null; redirect Administrator to EditUserSearch web page
                Response.Redirect("~/Admin/Master/EditUserSearch");
            else
            {
                // Hide all messages
                SuccessMessage.Visible = false;
                FailedMessage.Visible = false;
                int id;
                // Try to parse the query string to an integer
                if (int.TryParse(Request.QueryString["id"].ToString(), out id))
                {
                    // Assign query string
                    id = int.Parse(Request.QueryString["id"].ToString());
                    if (!IsPostBack)
                    {
                        AdministratorAccountController sysmgr = new AdministratorAccountController();
                        // Get Administrator Account Information passing in the ID
                        AdministratorAccountPOCO info = sysmgr.GetAdministratorInformation(id);

                        if (info == null)
                        {
                            Response.Redirect("~/Admin/Master/EditUserSearch");
                        }
                        else
                        {
                            // Populate user information fields
                            UserNameTextBox.Text = info.username;
                            FirstNameTextBox.Text = info.firstName;
                            LastNameTextBox.Text = info.lastName;
                            SecurityLevelDDL.SelectedValue = info.roleId.ToString();
                            DeactivateCheckBox.Checked = info.archivedBool;
                        }
                    }
                }
                // If the query string cannot be converted to an integer; redirect the Administrator to the EditUserSearch web page
                else
                {
                    Response.Redirect("~/Admin/Master/EditUserSearch");
                }
            }
        }
    }
    /// <summary>
    /// This method is used when the Administrator clicks the Update button.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        // If the query string equals the currently logged in Administrator ID and the Administrator wants to deactive their own account
        // Alert the Administrator with a message
        if (Convert.ToInt32(Request.QueryString["id"]).Equals(Convert.ToInt32(Session["adminID"])) && DeactivateCheckBox.Checked)
        {
            DisplayFailedMessage("You cannot Deactivate your own account.");
            DeactivateCheckBox.Checked = false;
        }
        // Else if an Administrator tries to deactivate the webmaster
        // Alert the Administrator with a message
        else if (UserNameTextBox.Text.Equals("webmaster") && DeactivateCheckBox.Checked)
        {
            DisplayFailedMessage("You cannot Deactivate the webmaster account.");
            DeactivateCheckBox.Checked = false;
        }
        // Else if the Administrator tries to change the webmaster's security level
        // Alert the Administrator with a message
        else if (UserNameTextBox.Text.Equals("webmaster") && SecurityLevelDDL.SelectedValue.Equals("1"))
        {
            DisplayFailedMessage("You cannot set the webmaster account as Standard Administrator.");
            SecurityLevelDDL.SelectedValue = "2";
        }
        else
        {
            // If the Password text box fields are empty
            // Run the overloaded update method that doesn't use the password parameter
            if (String.IsNullOrEmpty(ConfirmPasswordTextBox.Text) && String.IsNullOrEmpty(PasswordTextBox.Text))
            {
                // Disable validation that checks for password input
                ConfirmPasswordRFV.Enabled = false;
                ConfirmPasswordCV.Enabled = false;

                // Validate page
                Page.Validate();
                if (IsValid)
                {
                    // Update user excluding the password change
                    AdministratorAccountController sysmgr = new AdministratorAccountController();
                    string username = UserNameTextBox.Text.Trim();
                    string firstname = FirstNameTextBox.Text.Trim();
                    string lastname = LastNameTextBox.Text.Trim();
                    bool archive = DeactivateCheckBox.Checked;
                    int securityId = int.Parse(SecurityLevelDDL.SelectedItem.Value);
                    string updatedUser = sysmgr.UpdateAdministratorAccount(username, firstname, lastname, archive, securityId);
                    DisplaySuccessMessage("Successfully updated: " + updatedUser);
                }
            }
            else /// Run the overloaded update method that uses the password parameter
            {
                // Disable validation that checks for password input
                ConfirmPasswordRFV.Enabled = true;
                ConfirmPasswordCV.Enabled = true;

                // Validate page
                Page.Validate();
                if (IsValid)
                {
                    // Update user including the password change
                    AdministratorAccountController sysmgr = new AdministratorAccountController();
                    string username = UserNameTextBox.Text.Trim();
                    string password = PasswordTextBox.Text;
                    string firstname = FirstNameTextBox.Text.Trim();
                    string lastname = LastNameTextBox.Text.Trim();
                    bool archive = DeactivateCheckBox.Checked;
                    int securityId = int.Parse(SecurityLevelDDL.SelectedItem.Value);
                    string updatedUser = sysmgr.UpdateAdministratorAccount(username, password, firstname, lastname, archive, securityId);
                    DisplaySuccessMessage("Successfully updated: " + updatedUser + "'s password");
                }
            }
        }
    }
    /// <summary>
    /// This method is used to display a successful message
    /// </summary>
    /// <param name="message"></param>
    private void DisplaySuccessMessage(string message)
    {
        string successHeader = "<span><i class='fas fa-check-circle'></i> Success</span><br/ >";
        FailedMessage.Visible = false;
        SuccessMessage.Visible = true;
        SuccessMessage.Text = successHeader + message;
    }
    /// <summary>
    /// This method is used to dispaly a failed message
    /// </summary>
    /// <param name="message"></param>
    private void DisplayFailedMessage(string message)
    {
        string failedHeader = "<span><i class='fas fa-exclamation-triangle'></i> Processing Error</span><br/>";
        SuccessMessage.Visible = false;
        FailedMessage.Visible = true;
        FailedMessage.Text = failedHeader + message;
    }
    /// <summary>
    /// This method is used to validate if the First Name text box input is less than 50 characters
    /// </summary>
    /// <param name="source"></param>
    /// <param name="args"></param>
    protected void FirstNameLengthValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (FirstNameTextBox.Text.Trim().Length < 50);
    }
    /// <summary>
    /// This method is used to validate if the Last Name text box input is less than 50 characters
    /// </summary>
    /// <param name="source"></param>
    /// <param name="args"></param>
    protected void LastNameLengthValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = (LastNameTextBox.Text.Trim().Length < 50);
    }
}