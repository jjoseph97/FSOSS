using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_MasterAdministratorPages_EditQuestions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirects to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if ((int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }

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

    protected void QuestionUpdate_Click(object sender, EventArgs e)
    {

        string newQuestion = DescriptionTextBox.Text.Trim();
        int questionID = Convert.ToInt32(QuestionDDL.SelectedValue);

        MessageUserControl.TryRun(() =>
        {
            QuestionTextController sysmgr = new QuestionTextController();
            sysmgr.UpdateQuestionsText(questionID, newQuestion);

            editQuestion.Visible = true;
            editResponse.Visible = true;
        }, "Success", headerText.InnerText + " has been successfully updated");
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
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void QuestionDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int selectedQuestion = int.Parse(QuestionDDL.SelectedValue);
            string description;
            QuestionTextController sysmgr = new QuestionTextController();

            description = sysmgr.GetQuestionText(selectedQuestion);
            if (String.IsNullOrEmpty(description))
            {
                editQuestion.Visible = false;
                editResponse.Visible = false;
            }

            else
            {
                editQuestion.Visible = true;
                editResponse.Visible = true;
                Message.Visible = false;
                QuestionID.Value = QuestionDDL.SelectedItem.Value; // this is the ID for Question ID on the Question Table (use for update)
                headerText.InnerText = QuestionDDL.SelectedItem.Text;
                DescriptionTextBox.Text = description;
            }


        }
        catch
        {
            editQuestion.Visible = false;
            editResponse.Visible = false;
            Message.Visible = true;
        }
    }
}