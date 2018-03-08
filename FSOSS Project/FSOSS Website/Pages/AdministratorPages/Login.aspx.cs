using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.DefaultButton = LoginButton.UniqueID; // Enables user to press enter button

    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        string username = UsernameTextBox.Text.ToLower();
        string password = PasswordTextBox.Text;

        AdministratorAccountController sysmgr = new AdministratorAccountController();
        bool isValid = sysmgr.VerifyLogin(username, password);

        if (isValid)
        {
            // if valid store userID, username, and securityID in sessions
            Session["username"] = username.ToLower();
            int userID = sysmgr.GetUserID(username);
            Session["userID"] = userID;
            Session["securityID"] = sysmgr.GetSecurityID(userID);

            Response.Redirect("~/Pages/AdministratorPages/MainPage");
        }
        else
        {
            message.Visible = true;
            message.Text = "Invalid";
            //Session.Abandon(); // use this when logging out
            //Response.Redirect(Request.RawUrl); // refreshes the page
        }
    }
}