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
        editArea.Visible = false;

        if (!IsPostBack)
        {
            Message.Visible = false;
        }

    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        try
        {
            int selectedQuestion = int.Parse(QuestionDDL.SelectedValue);
            string description;
            QuestionTextController sysmgr = new QuestionTextController();

            description = sysmgr.GetQuestionText(selectedQuestion);
            if (String.IsNullOrEmpty(description))
            {
                editArea.Visible = false;
            }

            else
            {
                editArea.Visible = true;
                QuestionID.Value = QuestionDDL.SelectedItem.Value; // this is the ID for Question ID on the Question Table (use for update)
                headerText.InnerText = QuestionDDL.SelectedItem.Text;
                DescriptionTextBox.Text = description;
            }


        }
        catch
        {
            editArea.Visible = false;
            Message.Visible = true;
            Message.Text = "Error";
        }
    }

    protected void QuestionUpdate_Click(object sender, EventArgs e)
    {
        
        string newQuestion = DescriptionTextBox.Text.Trim();
        int questionID = Convert.ToInt32(QuestionDDL.SelectedValue);

        QuestionTextController sysmgr = new QuestionTextController();
        sysmgr.UpdateQuestionsText(questionID, newQuestion);

        editArea.Visible = true;
    }
}