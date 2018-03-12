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
            if (!IsPostBack)
            {
                FirstNameTextBox.Text = null;
                LastNameTextBox.Text = null;
                PasswordTextBox.Text = null;
            }
        }
    }

    protected void CreateButton_Click(object sender, EventArgs e)
    {
        char firstLetter = FirstNameTextBox.Text[0];
        string firstName = FirstNameTextBox.Text;
        string lastName = LastNameTextBox.Text;
        string password = PasswordTextBox.Text;
        int selectedRoleId = Convert.ToInt32(SecurityLevelDDL.SelectedItem.Value);
        string concatName;

        concatName = firstLetter + lastName;

        AdministratorAccountController sysmgr = new AdministratorAccountController();
        string newUser = sysmgr.AddUser(concatName.ToLower(), password, firstName, lastName, selectedRoleId);

        SuccessMessage.Visible = true;
        SuccessMessage.Text = "Successfully added: " + newUser;
        FirstNameTextBox.Text = null;
        LastNameTextBox.Text = null;
    }
}