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
        if (Session["username"] != null)
        {
            UsernameTextBox.Text = Session["username"].ToString();
        }
    }

    protected void LoginButton_Click(object sender, EventArgs e)
    {
        // Obviously this will need to change ;)
        if (UsernameTextBox.Text == "foo" && PasswordTextBox.Text == "bar")
        {
            // TODO: Create ValidateLogin function on PostgreSQL
            Session["username"] = UsernameTextBox.Text;
            Response.Redirect("~/Pages/AdministratorPages/MainPage.aspx?id=1");
        }
        else
        {
            message.Visible = true;
            message.Text = "Invalid";
        }
    }

    protected void btnTest_Click(object sender, EventArgs e)
    {
        // not the best way to do security because it's using cookies...
        // If we are to use ASP.NET Identity, it will add in tables to our db. Thus changing our ERD which won't have any relationships
        // to other entities.
        // We can consult with J if need be.

        Session.Abandon(); // use this when logging out
        Response.Redirect(Request.RawUrl); // refreshes the page
    }
}