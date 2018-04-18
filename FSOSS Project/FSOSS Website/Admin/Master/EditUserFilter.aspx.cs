using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_EditUserFilter : System.Web.UI.Page
{
    private string successHeader = "<span><i class='fas fa-check-circle'></i> Success</span><br/ >";
    private string failedHeader = "<span><i class='fas fa-exclamation-triangle'></i> Processing Error</span><br/>";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        if ((int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        ClearMessages();
    }

    protected void SearchUserButton_Click(object sender, EventArgs e)
    {
        string searchWord = SearchUserTextBox.Text.Trim();
        Regex validWord = new Regex("^[a-zA-Z]+[0-9]*");

        if (string.IsNullOrEmpty(searchWord))
        {
            DisplayFailedMessage("The search field cannot be empty.");
            BindAdministratorAccountODS();
        }
        else if (searchWord.Length > 100)
        {
            DisplayFailedMessage("The search field will only accept 100 characters.");
            BindAdministratorAccountODS();
        }
        else if (!validWord.IsMatch(searchWord))
        {
            DisplayFailedMessage("The search field must start with a letter.");
            BindAdministratorAccountODS();
        }
        else if (validWord.IsMatch(searchWord))
        {
            AdministratorAccountListView.DataSourceID = "SearchedAdministratorAccountODS";
            AdministratorAccountListView.DataBind();

            if (AdministratorAccountListView.Items.Any())
            {
                DisplaySuccessMessage("Successfully searched for \"" + searchWord + "\"");
            }
            else
            {
                DisplayFailedMessage("No results were found for \"" + searchWord + "\"");
                BindAdministratorAccountODS();
            }
        }
        else
        {
            DisplayFailedMessage("No results were found for \"" + searchWord + "\"");
            BindAdministratorAccountODS();
        }
    }

    private void DisplaySuccessMessage(string message)
    {
        FailedMessage.Visible = false;
        SuccessMessage.Visible = true;
        SuccessMessage.Text = successHeader + message;
    }

    private void DisplayFailedMessage(string message)
    {
        SuccessMessage.Visible = false;
        FailedMessage.Visible = true;
        FailedMessage.Text = failedHeader + message;
    }

    private void ClearMessages()
    {
        SuccessMessage.Visible = false;
        FailedMessage.Visible = false;
    }

    private void BindAdministratorAccountODS()
    {
        AdministratorAccountListView.DataSourceID = "AdministratorAccountODS";
        AdministratorAccountListView.DataBind();
    }

    protected void ResetButton_Click(object sender, EventArgs e)
    {
        SuccessMessage.Visible = false;
        FailedMessage.Visible = false;
        SearchUserTextBox.Text = "";
        BindAdministratorAccountODS();

    }
}