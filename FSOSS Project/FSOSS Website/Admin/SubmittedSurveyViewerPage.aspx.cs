using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_SubmittedSurveyViewerPage : System.Web.UI.Page
{
    /// <summary>
    /// When the page loads, the query string for the surveyID (sid) is obtained to populate the page with the appropriate submitted survey details. 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        string ssn = Request.QueryString["sid"]; // retreive the surveyID through a query string request passed from the submitted survey list page
        int subSurveyID;
        bool good = Int32.TryParse(ssn, out subSurveyID);

        SubmittedSurveyController ssc = new SubmittedSurveyController();
        if (ssn == null) // if the query string is null, the user may have came to this page directly and is taken back to the view survey filter page
        {
            Response.Redirect("ViewSurveyFilter.aspx");
        }
        //if the submitted survey ID is a bad number (too big or references a non-existant submitted survey)
        else if (!good || ssc.validSurvey(subSurveyID))
        {
            ContactResolve.Visible = false;
            MessageUserControl.TryRun(() =>
            {
                throw new Exception("Submitted Survey #" + subSurveyID + " does not exist.");
            },"?","what?");
        }
        else
        {
            SubSurveyIDLabel.Text = ssn;
            
            if (ssc.wantsContact(subSurveyID))
            {
                ContactResolve.Visible = true;
            }
            else
            {
                ContactResolve.Visible = false;
            }

            // this is to populated the survey details on the first part of the page
            SubmittedSurveyPOCO subSurveyDetailsList = ssc.GetSubmittedSurvey(subSurveyID);
            SiteNameLabel.Text = subSurveyDetailsList.site.ToString();
            UnitNumberLabel.Text = subSurveyDetailsList.unitNumber.ToString();
            MealNameLabel.Text = subSurveyDetailsList.mealName.ToString();
            ParticipantTypeLabel.Text = subSurveyDetailsList.participantType.ToString();
            AgeRangeLabel.Text = subSurveyDetailsList.ageRange.ToString();
            GenderLabel.Text = subSurveyDetailsList.gender.ToString();
            DateEnteredLabel.Text = subSurveyDetailsList.dateEntered.ToString();
            ContactRequestLabel.Text = subSurveyDetailsList.contactRequest.ToString();
            ContactStatusLabel.Text = subSurveyDetailsList.contacted.ToString();
            ContactRoomNumberLabel.Text = subSurveyDetailsList.contactRoomNumber.ToString();
            ContactPhoneNumberLabel.Text = subSurveyDetailsList.contactPhoneNumber.ToString();

            // this is to populated the survey questions and answers on the second part of the page
            List<ParticipantResponsePOCO> subSuveyAnswerList = ssc.GetSubmittedSurveyAnswers(subSurveyID).ToList();
            Response1aLabel.Text = subSuveyAnswerList[0].response.ToString();
            Response1bLabel.Text = subSuveyAnswerList[1].response.ToString();
            Response1cLabel.Text = subSuveyAnswerList[2].response.ToString();
            Response1dLabel.Text = subSuveyAnswerList[3].response.ToString();
            Response1eLabel.Text = subSuveyAnswerList[4].response.ToString();
            Response2Label.Text = subSuveyAnswerList[5].response.ToString();
            Response3Label.Text = subSuveyAnswerList[6].response.ToString();
            Response4Label.Text = subSuveyAnswerList[7].response.ToString();
            Response5Label.Text = subSuveyAnswerList[8].response.ToString();
            Question1aLabel.Text = "a. " + subSuveyAnswerList[0].question.ToString() + ":";
            Question1bLabel.Text = "b. " + subSuveyAnswerList[1].question.ToString() + ":";
            Question1cLabel.Text = "c. " + subSuveyAnswerList[2].question.ToString() + ":";
            Question1dLabel.Text = "d. " + subSuveyAnswerList[3].question.ToString() + ":";
            Question1eLabel.Text = "e. " + subSuveyAnswerList[4].question.ToString() + ":";
            Question2Label.Text = "2. " + subSuveyAnswerList[5].question.ToString() + ":";
            Question3Label.Text = "3. " + subSuveyAnswerList[6].question.ToString() + ":";
            Question4Label.Text = "4. " + subSuveyAnswerList[7].question.ToString() + ":";
            Question5Label.Text = "5. " + subSuveyAnswerList[8].question.ToString() + ":";
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
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ResolveButton_Click(object sender, EventArgs e)
    {
        string ssn = Request.QueryString["sid"];
        SubSurveyIDLabel.Text = ssn;
        int surveyNum = Convert.ToInt32(ssn);
        SubmittedSurveyController ssc = new SubmittedSurveyController();
        ssc.contactSurvey(surveyNum);
        ContactResolve.Visible = false; // remove the resolve button after it's been clicked
        Response.Redirect(Request.RawUrl); // reload the page to see the new contact information populated
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BackToSurveyListButton_Click(object sender, EventArgs e)
    {

    }
}