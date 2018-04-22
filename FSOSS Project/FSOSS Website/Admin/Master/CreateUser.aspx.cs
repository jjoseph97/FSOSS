using FSOSS.System.BLL;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_CreateUser : System.Web.UI.Page
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
            if (!IsPostBack)
            {
                // Set focus on the First Name text box
                FirstNameTextBox.Focus();
                // Hide the success message field
                SuccessMessage.Visible = false;
                // Clear all text box fields
                ClearFields();
            }
        }
    }
    /// <summary>
    /// This method is used when the Administrator clicks the Create button.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CreateButton_Click(object sender, EventArgs e)
    {
        // Validate the page
        Page.Validate();
        if (!IsValid) // If the page did not validate
        {
            // Show validation summary
            ValidationSummary.Visible = true;
            // Hide success message
            SuccessMessage.Visible = false;
        }
        else // If the page did validate
        {
            // Assign required variables that will be used as parameters
            string firstName = FirstNameTextBox.Text.Trim();
            string lastName = LastNameTextBox.Text.Trim();
            string password = PasswordTextBox.Text;
            int selectedRoleId = Convert.ToInt32(SecurityLevelDDL.SelectedItem.Value);

            // Take the first letter from the First Name, and combine it with the Last Name
            // Replace any last name that has a '-' with an empty string ('')
            string concatName = FirstNameTextBox.Text[0] + lastName.Replace("-", "").Replace(" ", "").Replace("'", "");

            // Add the new Administrator Account
            AdministratorAccountController sysmgr = new AdministratorAccountController();
            string newUser = sysmgr.AddAdministratorAccount(concatName.ToLower(), password, firstName, lastName, selectedRoleId);

            // Display the success message
            SuccessMessage.Visible = true;
            string successHeader = "<span><i class='fas fa-check-circle'></i> Success</span><br/ >";
            SuccessMessage.Text = successHeader + "Successfully added: " + newUser;

            // Clear all the text box fields
            ClearFields();
        }
    }
    /// <summary>
    /// This method is used to clear all text box fields and reset the dropdown list to the first index
    /// </summary>
    private void ClearFields()
    {
        FirstNameTextBox.Text = null;
        LastNameTextBox.Text = null;
        PasswordTextBox.Text = null;
        SecurityLevelDDL.SelectedIndex = 0;
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