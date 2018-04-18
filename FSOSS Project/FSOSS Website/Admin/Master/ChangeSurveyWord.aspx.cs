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
    /// When the page loads first the page checks if the user is logged in, and is redirected to the login page if not.
    /// Then the method checks if the user has has proper authentication (Master Administrator rolw) to access this page,
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
    }

    /// <summary>
    /// This method is required to use the MessageUserControl on the page in order to handle success messages and thrown exception messages for errors from the controller.
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
    /// This method is for when the user clicks the "Search" button. Survey words in the ListView are returned and now showing matching the search string that was entered.
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
            else // now rebind the list view with the correct ODS to filter the survey words to match the searchWord
            {
                // this check is to determine whether to search for active or archived words depending on the current ODS
                if (SurveyWordListView.DataSourceID == "ActiveSurveyWordODS")
                {
                    SurveyWordListView.DataSourceID = "SearchActiveSurveyWordODS";
                }
                else if(SurveyWordListView.DataSourceID == "ArchivedSurveyWordODS")
                {
                    SurveyWordListView.DataSourceID = "SearchArchivedSurveyWordODS";
                }
                SurveyWordListView.DataBind(); // rebind the ListView with the appropraite ODS

                if (SurveyWordListView.Items.Any() == false) // check if any results were returned and display error message to the user if no results were returned
                {
                    throw new Exception("No results were found. To clear the search results and try again, click on the \"Clear Search\" Button.");
                }
            }
        }, "Success", "Found the following results for \"" + searchWord + "\". To clear the search results, click on the \"Clear Search\" Button.");
    }

    /// <summary>
    /// This button on click method is to clear the search field and return to a ListView with full results for the user.
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

        SearchWordTextBox.Text = ""; // clear the search word textbox
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