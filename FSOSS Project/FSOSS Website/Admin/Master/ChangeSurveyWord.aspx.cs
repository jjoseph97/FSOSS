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
    /// When the page loads, the SuccessAlert and ErrorAlert labels (messages for the user to see) are turned off.
    /// The DataSoruceID on the SurveyWordListView is set to the ActiveSurveyWordODS Object Data Source.
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        SuccessAlert.Visible = false;
        ErrorAlert.Visible = false;

        if (!this.IsPostBack)
        {
            // This is the initial load of the page...
            if (SearchWordTextBox.Text == "")
            {
                SurveyWordListView.DataSourceID = "ActiveSurveyWordODS";
            }
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SearchWordButton_Click(object sender, EventArgs e)
    {
        if(SearchWordTextBox.Text.Trim() == "")
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Search cannot be empty.";
        }
        else
        {
            string searchWord = SearchWordTextBox.Text.Trim();
            SuccessAlert.Visible = true;

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
            if (searchWord == "")
            {
                SuccessAlert.Visible = false;
            }
            else
            {
                SuccessAlert.Text = "Found the following results for \"" + searchWord + "\". To clear the results and search again, click on the \"Clear Search\" Button.";
                SearchWordTextBox.ReadOnly = true;
                SearchWordTextBox.BackColor = System.Drawing.Color.LightGray;
                SearchWordButton.Visible = false;
                ClearSearchButton.Visible = true;
            }
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ClearSearchButton_Click(object sender, EventArgs e)
    {
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
        SearchWordTextBox.Text = "";
        SearchWordButton.Visible = true;
        ClearSearchButton.Visible = false;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddWordButton_Click(object sender, EventArgs e)
    {
        PotentialSurveyWordController sysmgr = new PotentialSurveyWordController();

        string addWord = AddWordTextBox.Text.Trim();
        Regex validWord = new Regex("^[a-zA-Z]+$");

        if (addWord == "" || addWord == null)
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Error: You must type in a word to add. Field cannot be empty.";
        }
        else if (!validWord.IsMatch(addWord))
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Error: Please enter only alphabetical letters and no spaces.";
        }
        else if (addWord.Length < 4 || addWord.Length > 8)
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Error: New survey word must be between 4 to 8 characters characters in length.";
        }
        else
        {
            SuccessAlert.Visible = true;
            SuccessAlert.Text = sysmgr.AddWord(addWord);
            SurveyWordListView.DataBind();
            AddWordTextBox.Text = "";
        }
    }

    /// <summary>
    /// 
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
    /// 
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
            if (SurveyWordListView.DataSourceID == "ActiveSurveyWordODS")
            {
                Button disabledBtn = (Button)e.Item.FindControl("DisableButton");
                disabledBtn.Visible = true;
                Button enabledBtn = (Button)e.Item.FindControl("EnableButton");
                enabledBtn.Visible = false;
            }
            else if (SurveyWordListView.DataSourceID == "ArchivedSurveyWordODS")
            {
                Button disabledBtn = (Button)e.Item.FindControl("DisableButton");
                disabledBtn.Visible = false;
                Button enabledBtn = (Button)e.Item.FindControl("EnableButton");
                enabledBtn.Visible = true;
            }
        }
    }

    /// <summary>
    /// 
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
            Regex validWord = new Regex("^[a-zA-Z]+$");
            TextBox surveyWord = (TextBox)e.Item.FindControl("surveyWordTextBox");
            string updateWord = surveyWord.Text.Trim();

            if (updateWord.Length < 4 || updateWord.Length > 8)
            {
                ErrorAlert.Visible = true;
                ErrorAlert.Text = "Error: Updated survey word must be between 4 to 8 characters in length.";
            }
            else if (!validWord.IsMatch(updateWord))
            {
                ErrorAlert.Visible = true;
                ErrorAlert.Text = "Error: Please enter only alphabetical letters and no spaces.";
            }
            else
            {
                SuccessAlert.Visible = true;
                SuccessAlert.Text = "The survey word has been updated to \"" + updateWord + "\".";
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
            Label surveyWord = (Label)e.Item.FindControl("surveyWordLabel");
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                Button disabledBtn = (Button)e.Item.FindControl("DisableButton");
                Button enabledBtn = (Button)e.Item.FindControl("EnableButton");
                if (disabledBtn.Visible == true)
                {
                    ErrorAlert.Visible = true;
                    ErrorAlert.Text = "The survey word \"" + surveyWord.Text + "\" has been disabled.";
                }
                else if (enabledBtn.Visible == true)
                {
                    SuccessAlert.Visible = true;
                    SuccessAlert.Text = "The survey word \"" + surveyWord.Text + "\" has been enabled.";
                }
            }
        }
    }
}