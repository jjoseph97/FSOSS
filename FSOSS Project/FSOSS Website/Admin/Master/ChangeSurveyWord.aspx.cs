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
    /// The DataSoruceID on the SurveyWordListView is set to the SurveyWordODS Object Data Source.
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        SuccessAlert.Visible = false;
        ErrorAlert.Visible = false;

        SurveyWordListView.DataSourceID = "SurveyWordODS";

    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SearchWordButton_Click(object sender, EventArgs e)
    {
        string searchWord = SearchWordTextBox.Text.Trim();
        SuccessAlert.Visible = true;
        
        SurveyWordListView.DataSourceID = "SearchSurveyWordODS";

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
            ClearSearchButton.Visible = true;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ClearSearchButton_Click(object sender, EventArgs e)
    {
        SurveyWordListView.DataSourceID = "SurveyWordODS";
        SurveyWordListView.DataBind();
        SearchWordTextBox.ReadOnly = false;
        SearchWordTextBox.BackColor = System.Drawing.Color.White;
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
            // assign the appropriate ODS if a search term has been entered
            if (SearchWordTextBox.Text == "")
            {
                SurveyWordListView.DataSourceID = "SurveyWordODS";
            }
            else
            {
                SurveyWordListView.DataSourceID = "SearchSurveyWordODS";
            }
        }

        if (e.CommandName == "Update")
        {
            // assign the appropriate ODS if a search term has been entered
            if (SearchWordTextBox.Text == "")
            {
                SurveyWordListView.DataSourceID = "SurveyWordODS";
            }
            else
            {
                SurveyWordListView.DataSourceID = "SearchSurveyWordODS";
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
                SurveyWordListView.DataSourceID = "SurveyWordODS";
            }
            else
            {
                SurveyWordListView.DataSourceID = "SearchSurveyWordODS";
            }
            Label surveyWord = (Label)e.Item.FindControl("surveyWordLabel");
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "The survey word \"" + surveyWord.Text + "\" has been disabled.";
        }
    }

}