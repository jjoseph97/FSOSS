using System;
using System.Linq;
using System.Text.RegularExpressions;

public partial class Admin_Master_EditUserSearch : System.Web.UI.Page
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
        if ((int)Session["securityID"] != 2) // Return HTTP Code 403 if not Master Administrator
        {
            Context.Response.StatusCode = 403;
        }
        // Hide all messages on page load
        ClearMessages();
    }
    /// <summary>
    /// This method is used when the Administrator clicks the Search button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SearchUserButton_Click(object sender, EventArgs e)
    {
        // Assign the search word variable to be used
        string searchWord = SearchUserTextBox.Text.Trim();
        // This regular expression will validate for a alphabet of at least one or more instances and a digit of zero or more instances
        Regex validWord = new Regex("^[a-zA-Z]+[0-9]*");

        // If the searched word is empty; display a message and bind the Administrator Account ODS
        if (string.IsNullOrEmpty(searchWord))
        {
            DisplayFailedMessage("The search field cannot be empty.");
            BindAdministratorAccountODS();
        }
        // If the searched word is more than 100 characters; display a message and bind the Administrator Account ODS
        else if (searchWord.Length > 100)
        {
            DisplayFailedMessage("The search field will only accept 100 characters.");
            BindAdministratorAccountODS();
        }
        // If the searched word does not match the regular expression; display a message and bind the Administrator Account ODS
        else if (!validWord.IsMatch(searchWord))
        {
            DisplayFailedMessage("The search field must start with a letter.");
            BindAdministratorAccountODS();
        }
        // If the searched word passes the regular expression
        else if (validWord.IsMatch(searchWord))
        {
            // Change the DataSourceID to the searched account ODS and bind the list view
            AdministratorAccountListView.DataSourceID = "SearchedAdministratorAccountODS";
            AdministratorAccountListView.DataBind();

            // If there was any results returned; display a message to the Administrator
            if (AdministratorAccountListView.Items.Any())
            {
                DisplaySuccessMessage("Successfully searched for \"" + searchWord + "\"");
            }
            // If there was no results; display a message and bind to the Administrator Account ODS
            else
            {
                DisplayFailedMessage("No results were found for \"" + searchWord + "\"");
                BindAdministratorAccountODS();
            }
        }
        // If there was no results; display a message to the Administrator
        else
        {
            DisplayFailedMessage("No results were found for \"" + searchWord + "\"");
            BindAdministratorAccountODS();
        }
    }
    /// <summary>
    /// This method is used to display a success message
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
    /// This method is used to display a failed message
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
    /// This method hides all messages
    /// </summary>
    private void ClearMessages()
    {
        SuccessMessage.Visible = false;
        FailedMessage.Visible = false;
    }
    /// <summary>
    /// This method is used to bind the list view to the Administrator Account ODS
    /// </summary>
    private void BindAdministratorAccountODS()
    {
        AdministratorAccountListView.DataSourceID = "AdministratorAccountODS";
        AdministratorAccountListView.DataBind();
    }
    /// <summary>
    /// This method is used when the Administrator clicks the Clear button
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ClearSearchButton_Click(object sender, EventArgs e)
    {
        // Hide all messages
        ClearMessages();
        // Clear the search text box field
        SearchUserTextBox.Text = "";
        // Bind the list view with the Administrator Account ODS
        BindAdministratorAccountODS();

    }
}