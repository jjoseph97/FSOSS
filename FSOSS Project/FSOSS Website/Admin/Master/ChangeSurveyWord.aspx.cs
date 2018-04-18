using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region
using FSOSS.System.BLL;
using FSOSS.System.Data;
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_AdministratorPages_MasterAdministratorPages_ChangeSurveyWord : System.Web.UI.Page
{
    /// <summary>
    /// When the page loads first the page checks if the user has proper authentication to access this page, and is redirected to login if not.
    /// Following this, for each page load the search text box is checked if a search was entered or not, and the text field background color is styled appropriately
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void Page_Load(object sender, EventArgs e)
    {
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
            if (SearchWordTextBox.Text == "") // check if the SearchWordTextBox is empty, then change the back color to white indicating the user can enter a search in this field if desired
            {
                SearchWordTextBox.Attributes.Remove("style");
                SearchWordTextBox.BackColor = System.Drawing.Color.White;
            }
            else  // else, check if the SearchWordTextBox is not empty, then change the back color to light gray indicating the user cannot change it
            {
                SearchWordTextBox.Attributes.Remove("style");
                SearchWordTextBox.BackColor = System.Drawing.Color.LightGray;
            }
        }
    }

    /// <summary>
    /// This method is required to use the MessageUserControl on the page in order to handle thrown exception messages for errors from the controller
    /// as well as info and success messages from the code behind.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        // if an exception was thrown, handle with messageusercontrol to display the exception for error
        if (e.ReturnValue == null)
        {
            MessageUserControl.HandleDataBoundException(e);
        }
        else // else show the ReturnValue(success message) as a string to display to the user 
        {
            string successMessage = e.ReturnValue.ToString();
            MessageUserControl.TryRun(() =>
            {
            }, "Success", successMessage);
        }
    }

    /// <summary>
    /// This button on click method is for when the user clicks the "Search" button and the search field background color is set to light gray.
    /// Survey words in the ListView are returned and now showing matching the search string that was entered.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SearchWordButton_Click(object sender, EventArgs e)
    {
        string searchWord = SearchWordTextBox.Text.Trim();
        MessageUserControl.TryRun(() =>
        {
            Regex validWord = new Regex("^[a-zA-Z]+$");
            if (searchWord == "") // check if the search is empty and display an error
            {
                throw new Exception("The search field cannot be empty."); 
            }
            else if (searchWord.Length > 8) // check that the length of the search is a maximum of 8 characters and display an error
            {
                throw new Exception("The search field can only be a maximum of 8 characters in length.");
            }
            else if (!validWord.IsMatch(searchWord)) // check that there is only alphabetical letters and no spaces in the search and display an error
            {
                throw new Exception("Please enter only alphabetical letters and no spaces in the search field.");
            }
            else if (SurveyWordListView.Items.Any()) // check if any results were returned
            {
                // this check is to determine whether to search for active or archived words depending on the current ODS
                if(SurveyWordListView.DataSourceID == "ActiveSurveyWordODS")
                {
                    SurveyWordListView.DataSourceID = "SearchActiveSurveyWordODS";
                }
                else if(SurveyWordListView.DataSourceID == "ArchivedSurveyWordODS")
                {
                    SurveyWordListView.DataSourceID = "SearchArchivedSurveyWordODS";
                }
                SurveyWordListView.DataBind(); // rebind the ListView with the appropraite ODS

                SearchWordTextBox.ReadOnly = true;
                SearchWordTextBox.Attributes.Remove("style"); // clear the style attribute to remove the existing white background color
                SearchWordTextBox.BackColor = System.Drawing.Color.LightGray; // set the SearchWordTextBox back color to light gray indicating the user cannot change it
                SearchWordButton.Visible = false;
                ClearSearchButton.Visible = true;
            }
            else // display error message to the user if no results were returned
            {
                throw new Exception("No results were found.");
            }
        }, "Success", "Found the following results for \"" + searchWord + "\". To clear the filtered results, click on the \"Clear Search\" Button.");
    }

    /// <summary>
    /// This button on click method is to clear the search field, change the background color to white and return to a ListView with full results for the user.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ClearSearchButton_Click(object sender, EventArgs e)
    {
        // this check is to determine whether to clear the search for active or archived words depending on the current ODS
        if (SurveyWordListView.DataSourceID == "SearchActiveSurveyWordODS")
        {
            SurveyWordListView.DataSourceID = "ActiveSurveyWordODS";
        }
        else if (SurveyWordListView.DataSourceID == "SearchArchivedSurveyWordODS")
        {
            SurveyWordListView.DataSourceID = "ArchivedSurveyWordODS";
        }
        SurveyWordListView.DataBind(); // rebind the ListView with the appropraite ODS

        SearchWordTextBox.ReadOnly = false;
        SearchWordTextBox.Attributes.Remove("style"); // clear the style attribute to remove the existing light gray background color
        SearchWordTextBox.BackColor = System.Drawing.Color.White; // set the SearchWordTextBox back color to white indicating the user can enter a search in this field if desired
        SearchWordTextBox.Text = "";
        SearchWordButton.Visible = true;
        ClearSearchButton.Visible = false;
    }

    /// <summary>
    /// This method is for adding a new survey word to the database when the user clicks on the "Add Word" button.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddWordButton_Click(object sender, EventArgs e)
    {
        string newWord = AddWordTextBox.Text.Trim().ToLower();
        int userID = Convert.ToInt32(Session["userID"]); // get the userID for the user who is currently logged in

        MessageUserControl.TryRun(() =>
        {
            PotentialSurveyWordController sysmgr = new PotentialSurveyWordController();

            sysmgr.AddWord(newWord, userID); // send the new survey word and userID data to the AddWord method in the PotentialSurveyWordController
            SurveyWordListView.DataBind();
            AddWordTextBox.Text = ""; // set the add word text field back to blank text
          
        }, "Success", "Successfully added the new survey word: \"" + newWord + "\""); // display a success message if the survey word was added correctly
    }

    /// <summary>
    /// This button on click method is for showing the current archived survey words that are in the database.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ShowArchivedButton_Click(object sender, EventArgs e)
    {
        SurveyWordListView.DataSourceID = "ArchivedSurveyWordODS"; // show the current archived survey words on the ListView
        SurveyWordListView.DataBind();
        // this is to clear the search when switching from active to archived words
        ClearSearchButton_Click(null, EventArgs.Empty);
        ShowActiveButton.Visible = true;
        ShowArchivedButton.Visible = false;

    }

    /// <summary>
    /// This button on click method is for showing the current active survey words that are in the database.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ShowActiveButton_Click(object sender, EventArgs e)
    {
        SurveyWordListView.DataSourceID = "ActiveSurveyWordODS"; // show the current active survey words on the ListView
        SurveyWordListView.DataBind();

        ClearSearchButton_Click(null, EventArgs.Empty); // this is to clear the search when switching from active to archived words
        ShowActiveButton.Visible = false;
        ShowArchivedButton.Visible = true;
    }

    /// <summary>
    /// This method is in order to change the "Disabled" button to "Enabled", and vice versa depending on the current ODS
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SurveyWordListView_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Button disableBtn = (Button)e.Item.FindControl("DisableButton");
            Button enableBtn = (Button)e.Item.FindControl("EnableButton");
            if (disableBtn != null || enableBtn != null) // check if the found EnableButton control and DisableButton control is not returned as null
            {
                if (SurveyWordListView.DataSourceID == "ActiveSurveyWordODS") // if the ListView is populated with active survey words, show the disabled button
                {
                    disableBtn.Visible = true;
                    enableBtn.Visible = false;
                }
                else if (SurveyWordListView.DataSourceID == "SearchActiveSurveyWordODS") // if the ListView is populated with searched active survey words, show the disabled button
                {
                    disableBtn.Visible = true;
                    enableBtn.Visible = false;
                }
                else if (SurveyWordListView.DataSourceID == "ArchivedSurveyWordODS") // if the ListView is populated with archived survey words, show the disabled button
                {
                    disableBtn.Visible = false;
                    enableBtn.Visible = true;
                }
                else if (SurveyWordListView.DataSourceID == "SearchArchivedSurveyWordODS") // if the ListView is populated with searched archived survey words, show the disabled button
                {
                    disableBtn.Visible = false;
                    enableBtn.Visible = true;
                }
            }
        }
    }
}