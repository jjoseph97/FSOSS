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
    /// When the page loads, the DataSourceID on the SurveyWordListView is set to the ActiveSurveyWordODS Object Data Source.
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            // This is the initial load of the page.
            if (SearchWordTextBox.Text == "")
            {
                SurveyWordListView.DataSourceID = "ActiveSurveyWordODS";
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
    /// This button on click method is for when the user clicks the "Search" button. Results in the ListView are returned matching the search string.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SearchWordButton_Click(object sender, EventArgs e)
    {
        string searchWord = SearchWordTextBox.Text.Trim();
        MessageUserControl.TryRun(() =>
        {
            if (searchWord == "")
            {
                throw new Exception("Search cannot be empty.");
            }
            else
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
                SurveyWordListView.DataBind();

                SearchWordTextBox.ReadOnly = true;
                SearchWordTextBox.BackColor = System.Drawing.Color.LightGray;
                SearchWordButton.Visible = false;
                ClearSearchButton.Visible = true;
            }
        }, "Success", "Found the following results for \"" + searchWord + "\". To clear the results and search again, click on the \"Clear Search\" Button.");
    }

    /// <summary>
    /// This button on click method is to clear the search and return to a ListView with full results for the user.
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

        SurveyWordListView.DataBind();
        SearchWordTextBox.ReadOnly = false;
        SearchWordTextBox.BackColor = System.Drawing.Color.White;
        SearchWordTextBox.Text = "";
        SearchWordButton.Visible = true;
        ClearSearchButton.Visible = false;
    }

    /// <summary>
    /// This button on click method is for adding a new survey word to the database.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddWordButton_Click(object sender, EventArgs e)
    {
        string newWord = AddWordTextBox.Text.Trim();
        MessageUserControl.TryRun(() =>
        {
            PotentialSurveyWordController sysmgr = new PotentialSurveyWordController();

            sysmgr.AddWord(newWord);
            SurveyWordListView.DataBind();
            AddWordTextBox.Text = "";
          
        }, "Success", "Successfully added the new survey word: \"" + newWord + "\"");
    }

    /// <summary>
    /// This button on click method is for showing the current archived survey words that are in the database.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ShowArchivedButton_Click(object sender, EventArgs e)
    {
        SurveyWordListView.DataSourceID = "ArchivedSurveyWordODS";
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
        SurveyWordListView.DataSourceID = "ActiveSurveyWordODS";
        SurveyWordListView.DataBind();

        // this is to clear the search when switching from active to archived words
        ClearSearchButton_Click(null, EventArgs.Empty);
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
            Button disabledBtn = (Button)e.Item.FindControl("DisableButton");
            Button enabledBtn = (Button)e.Item.FindControl("EnableButton");
            if (disabledBtn != null || enabledBtn != null)
            {
                if (SurveyWordListView.DataSourceID == "ActiveSurveyWordODS")
                {
                    disabledBtn.Visible = true;
                    enabledBtn.Visible = false;
                }
                else if (SurveyWordListView.DataSourceID == "SearchActiveSurveyWordODS")
                {
                    disabledBtn.Visible = true;
                    enabledBtn.Visible = false;
                }
                else if (SurveyWordListView.DataSourceID == "ArchivedSurveyWordODS")
                {
                    disabledBtn.Visible = false;
                    enabledBtn.Visible = true;
                }
                else if (SurveyWordListView.DataSourceID == "SearchArchivedSurveyWordODS")
                {
                    disabledBtn.Visible = false;
                    enabledBtn.Visible = true;
                }
            }
        }
    }

    /// <summary>
    /// This method is for responding to certain button commands that are returned from the ListView in order to assign the ListView to the correct ODS.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SurveyWordListView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit")
        {
            // check if currently in archived words, or in active words
            if (SurveyWordListView.DataSourceID == "ArchivedSurveyWordODS")
            {
                // assign the appropriate ODS if a search term has been entered
                if (SearchWordTextBox.Text == "")
                {
                    SurveyWordListView.DataSourceID = "ArchivedSurveyWordODS";
                }
                else if (SearchWordTextBox.Text != "")
                {
                    SurveyWordListView.DataSourceID = "SearchArchivedSurveyWordODS";
                }
            }
            else if (SurveyWordListView.DataSourceID == "ActiveSurveyWordODS")
            {
                // assign the appropriate ODS if a search term has been entered
                if (SearchWordTextBox.Text == "")
                {
                    SurveyWordListView.DataSourceID = "ActiveSurveyWordODS";
                }
                else
                {
                    SurveyWordListView.DataSourceID = "SearchActiveSurveyWordODS";
                }
            }
        }

        if (e.CommandName == "Update")
        {
            // check if currently in archived words, or in active words
            if (SurveyWordListView.DataSourceID == "ArchivedSurveyWordODS")
            {
                // assign the appropriate ODS if a search term has been entered
                if (SearchWordTextBox.Text == "")
                {
                    SurveyWordListView.DataSourceID = "ArchivedSurveyWordODS";
                }
                else if (SearchWordTextBox.Text != "")
                {
                    SurveyWordListView.DataSourceID = "SearchArchivedSurveyWordODS";
                }
            }
            else if (SurveyWordListView.DataSourceID == "ActiveSurveyWordODS")
            {
                // assign the appropriate ODS if a search term has been entered
                if (SearchWordTextBox.Text == "")
                {
                    SurveyWordListView.DataSourceID = "ActiveSurveyWordODS";
                }
                else
                {
                    SurveyWordListView.DataSourceID = "SearchActiveSurveyWordODS";
                }
            }
        }

        if (e.CommandName == "Delete")
        {
            // assign the appropriate ODS if a search term has been entered
            if (SearchWordTextBox.Text == "")
            {
                SurveyWordListView.DataSourceID = "ActiveSurveyWordODS";
            }
            else
            {
                SurveyWordListView.DataSourceID = "SearchActiveSurveyWordODS";
            }
        }
    }
}