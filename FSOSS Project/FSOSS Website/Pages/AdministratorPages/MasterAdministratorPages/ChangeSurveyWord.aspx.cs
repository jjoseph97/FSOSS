﻿using System;
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
    protected void Page_Load(object sender, EventArgs e)
    {
        Alert.Visible = false;
        ErrorAlert.Visible = false;
    }

    protected void SearchWordButton_Click(object sender, EventArgs e)
    {
        //PotentialSurveyWordController sysmgr = new PotentialSurveyWordController();
        //string searchWord = SearchWordTextBox.Text.Trim();
        //Alert.Visible = true;
        //SurveyWordODS.SelectMethod = sysmgr.GetSurveyWord(searchWord);
        //SurveyWordListView.DataBind();
    }

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
            Alert.Visible = true;
            Alert.Text = sysmgr.AddWord(addWord);
            SurveyWordListView.DataBind();
        }
    }

    protected void SurveyWordListView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Update")
        {
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
                Alert.Visible = true;
                Alert.Text = "The survey word has been updated to \"" + updateWord + "\".";
            }
        }

        if (e.CommandName == "Delete")
        {
            Label surveyWord = (Label)e.Item.FindControl("surveyWordLabel");
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "The survey word \"" + surveyWord.Text + "\" has been removed.";
        }
    }
}