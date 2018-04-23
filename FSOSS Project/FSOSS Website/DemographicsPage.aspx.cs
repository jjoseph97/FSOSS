using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Survey_DemographicsPage : System.Web.UI.Page
{
    /// <summary>
    /// The method loads during the start of the page
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["takingSurvey"] == null ||      // if participant doesn't take a survey
            (Session["Unit"] == null                // doesn't choose an option for unit number
            && Session["MealType"] == null          // doesn't choose an option for meal type 
            && Session["ParticipantType"] == null   // doesn't choose an option for participant type  
            && Session["Q4"] == null))              // doesn't choose an option for Question 4
        {
            // abandon the session and redirect the participant to the survey access page 
            Session.Abandon();
            Response.Redirect("~/");
        }

        if (!IsPostBack)
        {
            QuestionTextController sysmgr = new QuestionTextController(); // this allows access to the question text controller 
            GenderLabel.Text = sysmgr.GetQuestionGender();  // populates the gender drop-down
            AgeRangeLabel.Text = sysmgr.GetQuestionAgeRange();  // populates the age range drop-down

            //if there is a session for the customer profile check box, assign the session to the session value 
            if (Session["CustomerProfileCheckBox"] != null)
                //coverts the session customer profile check box to a boolean 
                CustomerProfileCheckBox.Checked = Convert.ToBoolean(Session["CustomerProfileCheckBox"]);

            //if customer profile check box is checked 
            if (CustomerProfileCheckBox.Checked)
            {
                //dislay the gender and age range drop-downs 
                CustomerProfileContent.Visible = true;
                AgeDDL.SelectedValue = Session["AgeDDL"].ToString();
                GenderDDL.SelectedValue = Session["GenderDDL"].ToString();
            }
            else
                //else don't display the the gender and age range drop-downs  
                CustomerProfileContent.Visible = false;

            //if there is a session for the contact requests check box, assign the session to the session value 
            if (Session["ContactRequestsCheckBox"] != null)
                ContactRequestsCheckBox.Checked = Convert.ToBoolean(Session["ContactRequestsCheckBox"]);

            //if contact requests check box is checked 
            if (ContactRequestsCheckBox.Checked)
            {
                //display the phone number and room number text boxes
                ContactRequestsContent.Visible = true;
                PhoneTextBox.Text = Session["PhoneTextBox"].ToString();
                RoomTextBox.Text = Session["RoomTextBox"].ToString();
            }
            else
                //else don't display the phone number and room number text boxes.
                ContactRequestsContent.Visible = false;
        }
    }

    /// <summary>
    /// The method toggles the customer profile check box
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CustomerProfileCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        //if check box is checked 
        if (CustomerProfileCheckBox.Checked)
        {
            //display the customer profile div 
            CustomerProfileContent.Visible = true;
        }
        else
            //don't display customer profile div 
            CustomerProfileContent.Visible = false;
    }

    /// <summary>
    /// The method toggles the contact request check box 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ContactRequestsCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        //if check box is checked
        if (ContactRequestsCheckBox.Checked)
        {
            //display contact requests div
            ContactRequestsContent.Visible = true;
        }
        else
            //don't display contact requests div 
            ContactRequestsContent.Visible = false;
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        int surveyVersionId = Convert.ToInt32(Session["survey_version_id"]);
        int unitId = int.Parse(Session["Unit"].ToString());
        int mealId = int.Parse(Session["MealType"].ToString());
        int participantTypeId = int.Parse(Session["ParticipantType"].ToString());
        int ageRangeId;
        int genderId;
        bool customerProfileCheckBox = CustomerProfileCheckBox.Checked; 
        bool contactRequest = ContactRequestsCheckBox.Checked; 
        string contactRoomNumber = "";
        string contactPhoneNumber = "";
        string q1AResponse = Session["Q1A"].ToString();
        string q1BResponse = Session["Q1B"].ToString();
        string q1CResponse = Session["Q1C"].ToString();
        string q1DResponse = Session["Q1D"].ToString();
        string q1EResponse = Session["Q1E"].ToString();
        string q2Response = Session["Q2"].ToString();
        string q3Response = Session["Q3"].ToString();
        string q4Response = Session["Q4"].ToString();

        //If Q5 is null or empty return as an empty string
        string q5Response = String.IsNullOrEmpty(Session["Q5"].ToString()) ? "" : Session["Q5"].ToString();

        if (!customerProfileCheckBox)
        {
            ageRangeId = 1; // This defaults to the "Prefer not to answer"
            genderId = 1; // This defaults to the "Prefer not to answer"
        }
        else
        {
            ageRangeId = int.Parse(AgeDDL.SelectedItem.Value); // TODO - use the stored Session value
            genderId = int.Parse(GenderDDL.SelectedItem.Value); // TODO - use the stored Session value
        }

        //Regex validation for phone number 
        Regex validNum = new Regex("^\\(?([0-9]{3})\\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$"); //check to see that the phone number is 10 digits. 

        //Regex validation for room number
        Regex validRoomNum = new Regex("^([0-9a-zA-Z]){0,10}$"); //check to see that room number is no more than ten characters.

        //If checkbox is not checked display N/A and submit survey
        if (!contactRequest)
        {
            contactRoomNumber = "N/A";
            contactPhoneNumber = "N/A";

            SubmittedSurveyController sysmgr = new SubmittedSurveyController();
            sysmgr.SubmitSurvey(surveyVersionId, unitId, mealId, participantTypeId, ageRangeId, genderId, contactRequest, contactRoomNumber, contactPhoneNumber, q1AResponse, q1BResponse, q1CResponse, q1DResponse, q1EResponse, q2Response, q3Response, q4Response, q5Response);

            Response.Redirect("~/Thankyou");
        }

        // else proceed with validations on contact fields.
        else
        {
            //initialize the variables in both fields 
            contactPhoneNumber = PhoneTextBox.Text;
            contactRoomNumber = RoomTextBox.Text;

            //if phone number text field is blank, set it to N/A
            if (PhoneTextBox.Text == "")
            {
                contactPhoneNumber = "N/A";
            }
            //else if the field is not valid display an error message and set contact phone number to blank
            else if (!validNum.IsMatch(PhoneTextBox.Text)) //check for only numbers and no letters
            {
                PhoneNumber.Visible = true;
                contactPhoneNumber = "";
            }
            //else toggle the error message to false
            else
            {
                PhoneNumber.Visible = false;
            }

            //if room number text field is blank, set it to N/A
            if (RoomTextBox.Text == "")
            {
                contactRoomNumber = "N/A";
            }
            //else if the field is not valid display an error message and set contact room number to blank
            else if (!validRoomNum.IsMatch(RoomTextBox.Text))
            {
                RoomNumber.Visible = true;
                contactRoomNumber = "";
            }
            //else toggle the error message to false
            else
            {
                RoomNumber.Visible = false;
            }

            //if both fields are valid submit the survey
            if (contactRoomNumber != "" && contactPhoneNumber != "")
            {
                PhoneNumber.Visible = false;
                RoomNumber.Visible = false;

                SubmittedSurveyController sysmgr = new SubmittedSurveyController();
                sysmgr.SubmitSurvey(surveyVersionId, unitId, mealId, participantTypeId, ageRangeId, genderId, contactRequest, contactRoomNumber, contactPhoneNumber, q1AResponse, q1BResponse, q1CResponse, q1DResponse, q1EResponse, q2Response, q3Response, q4Response, q5Response);

                Response.Redirect("~/Thankyou");
            }
        }
    }

    /// <summary>
    /// This method saves the chosen values into a session when the participant clicks the back button 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void BackButton_Click(object sender, EventArgs e)
    {
        Session["CustomerProfileCheckBox"] = CustomerProfileCheckBox.Checked; //the method captures the checkbox value if checked for the customer profile into a session
        
        // the method captures and saves the chosen options for gender and age range into a session  
        Session["GenderDDL"] = GenderDDL.SelectedValue;
        Session["AgeDDL"] = AgeDDL.SelectedValue;

        Session["ContactRequestsCheckBox"] = ContactRequestsCheckBox.Checked; //the method captures the check box if checked for contact requests into a session
        
        //the method captures and saves the entered phone number and room number into a session 
        Session["PhoneTextBox"] = PhoneTextBox.Text;
        Session["RoomTextBox"] = RoomTextBox.Text;

        //redirects the participant to the take survey page
        Response.Redirect("~/TakeSurvey");
    }
}