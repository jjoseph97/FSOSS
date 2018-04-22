using FSOSS.System.BLL;
using System;
using System.Web.UI;

public partial class Pages_AdministratorPages_Login : System.Web.UI.Page
{
    /// <summary>
    /// When the page loads first the page checks if the user is logged in, and is redirected to the login page if not.
    /// Then the method checks if the user has has proper authentication (Master Administrator role) to access this page.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        // Hide all navigation bar links
        var fsossnavbar = Master.FindControl("FSOSSNavbar");
        var hamburger = Master.FindControl("hamburger");
        fsossnavbar.Visible = false;
        hamburger.Visible = false;
        // Redirect Administrator if they are already logged in
        if (Session["adminID"] != null)
            Response.Redirect("~/Admin");
    }
    /// <summary>
    /// This method is used when the individual clicks the Login button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void LoginButton_Click(object sender, EventArgs e)
    {
        // Validate the page
        Page.Validate();

        // If the page did not validate; display a message to the individual
        if (!IsValid)
            DisplayMessage("Username and password is required.");
        // If the page did validate
        else
        {
            // Assign the variables to be used
            string username = UsernameTextBox.Text.Trim().ToLower();
            string password = PasswordTextBox.Text;

            AdministratorAccountController sysmgr = new AdministratorAccountController();
            // If the Administrator username is not active
            if (!sysmgr.AdministratorAccountIsActive(username))
                DisplayMessage("You are currently deactivated. Please contact a Master Administrator.");
            else
            {
                // Validate if the login credentials exist
                bool isValid = sysmgr.VerifyLogin(username, password);
                if (isValid)
                {
                    // If valid store userID, username, and securityID in sessions
                    AdministratorRoleController roleController = new AdministratorRoleController();
                    Session["username"] = username.ToLower();
                    int userID = sysmgr.GetAdministratorAccountID(username);
                    Session["adminID"] = userID;
                    Session["securityID"] = roleController.GetAdministratorRole(userID).security_role_id;
                    // Redirect individual to the Administrator home page
                    Response.Redirect("~/Admin");
                }
                // If login credentials are not valid; display message to the individual
                else
                    DisplayMessage("Invalid username or password");
            }
        }
    }
    /// <summary>
    /// This method is used to display a message to the individual
    /// </summary>
    /// <param name="message"></param>
    private void DisplayMessage(string message)
    {
        Message.Visible = true;
        Message.Text = message;
    }
}