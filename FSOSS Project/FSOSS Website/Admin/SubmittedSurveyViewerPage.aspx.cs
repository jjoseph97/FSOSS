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
    /// When the page loads first the page checks if the admin has proper authentication to access this page, and is redirected to login if not.
    /// Following that, the query string for the surveyID (sid) is obtained to populate the page with the appropriate submitted survey details. 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirect admin to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (!IsPostBack)
        {
            string ssn = Request.QueryString["sid"]; // retreive the surveyID through a query string request passed from the submitted survey list page
            int subSurveyID = Convert.ToInt32(ssn);

            SubmittedSurveyController ssc = new SubmittedSurveyController();
            // if the query string is null, the survey id is not a number or is not a valid number (too big or references a non-existant submitted survey), 
            // then the admin is taken back to the view survey filter page
            if (ssn == null || !ssc.ValidSurvey(subSurveyID))
            {
                Response.Redirect("ViewSurveyFilter.aspx");
            }
            else // else, the submitted survey details are shown on the page
            {
                if (ssc.RequestsContact(subSurveyID))  // the "Resolve" button will be shown if the admin wishes to be contacted and the issue has not been resolved yet
                {
                    ContactResolve.Visible = true;
                }
                else // else, the "Resolve" button will not be shown
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
                ContactRequestLabel.Text = (subSurveyDetailsList.contactRequest == false) ? "No" : "Yes";
                ContactStatusLabel.Text = (subSurveyDetailsList.contacted == false) ? "Not resolved" : "Resolved";
                ContactRoomNumberLabel.Text = subSurveyDetailsList.contactRoomNumber.ToString();
                ContactPhoneNumberLabel.Text = subSurveyDetailsList.contactPhoneNumber.ToString();

                if (ContactRequestLabel.Text == "No") // if the contact request was false on this survey, don't display the empty contact details
                {
                    ContactStatLabel.Visible = false;
                    ContactStatusLabel.Visible = false;
                    ContactRoomLabel.Visible = false;
                    ContactRoomNumberLabel.Visible = false;
                    ContactPhoneLabel.Visible = false;
                    ContactPhoneNumberLabel.Visible = false;
                }

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
                Question2Label.Text = "2. " + subSuveyAnswerList[5].question.ToString();
                Question3Label.Text = "3. " + subSuveyAnswerList[6].question.ToString();
                Question4Label.Text = "4. " + subSuveyAnswerList[7].question.ToString();
                Question5Label.Text = "5. " + subSuveyAnswerList[8].question.ToString();
            }
        }
    }

    /// <summary>
    /// This method is used to resolve an individual submitted survey that has a unresolved contact request attached to it.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ResolveButton_Click(object sender, EventArgs e)
    {
        string ssn = Request.QueryString["sid"]; // get the survey ID from the URL query string
        MessageUserControl.TryRun(() =>
        {
            int surveyID = Convert.ToInt32(ssn);
            SubmittedSurveyController ssc = new SubmittedSurveyController();
            ssc.ContactSurvey(surveyID); // send the survey ID to the ContactSurvey method on the SubmittedSurveyController
            ContactResolve.Visible = false; // remove the resolve button after it's been clicked
            Response.Redirect(Request.RawUrl); // reload the page to see the new contact information populated
        }, "Success", "The survey's contact request has been resolved."); // display a success message if the submitted survey was resolved correctly
    }
}