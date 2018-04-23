using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_MasterAdministratorPages_EditQuestions : System.Web.UI.Page
{
    /// <summary>
    /// This method loads at the start of the page
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        // Redirects to login page if not logged in
        if (Session["securityID"] == null) 
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        // else return HTTP Code 403 page 
        else if ((int)Session["securityID"] != 2) 
        {
            Context.Response.StatusCode = 403;
        }

        //finds all the questions and responses to edit
        editQuestion.Visible = false;
        editResponse.Visible = false;
        if (QuestionDDL.SelectedValue != "")
        {
            editQuestion.Visible = true;
            editResponse.Visible = true;
        }
        if (!IsPostBack)
        {
            Message.Visible = false;
        }

    }
    
    /// <summary>
    /// The method updates the chosen question 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void QuestionUpdate_Click(object sender, EventArgs e)
    {
        //initialize variables 
        string newQuestion = DescriptionTextBox.Text.Trim();
        int questionID = Convert.ToInt32(QuestionDDL.SelectedValue);

        MessageUserControl.TryRun(() =>
        {
            //allows access to the question text controller
            QuestionTextController sysmgr = new QuestionTextController();
            //updates the text
            sysmgr.UpdateQuestionsText(questionID, newQuestion);

            editQuestion.Visible = true;
            editResponse.Visible = true;
        }, "Success", headerText.InnerText + " has been successfully updated");  // display success message 
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
    /// changes the viewable question for editing.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void QuestionDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //initialize variables
            int selectedQuestion = int.Parse(QuestionDDL.SelectedValue);
            string description;
            //allows access to the question text controller
            QuestionTextController sysmgr = new QuestionTextController();

            //returns the question description from the database
            description = sysmgr.GetQuestionText(selectedQuestion);
            //if nothing is returned 
            if (String.IsNullOrEmpty(description))
            {
                //don't show the question and the response 
                editQuestion.Visible = false;
                editResponse.Visible = false;
            }
            else
            {
                //show the question and the response
                editQuestion.Visible = true;
                editResponse.Visible = true;

                //don't show the message
                Message.Visible = false;

                // this is the ID for Question ID on the Question Table 
                QuestionID.Value = QuestionDDL.SelectedItem.Value; 
                headerText.InnerText = QuestionDDL.SelectedItem.Text;
                DescriptionTextBox.Text = description;
            }
        }
        catch
        {
            //don't show the question and the response
            editQuestion.Visible = false;
            editResponse.Visible = false;
            //show the message
            Message.Visible = true;
        }
    }
}