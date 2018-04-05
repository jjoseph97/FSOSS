using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Survey_DemographicsPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["takingSurvey"] == null)
        {
            Response.Redirect("~/");
        }

        if (!IsPostBack)
        {
            QuestionTextController sysmgr = new QuestionTextController();
            GenderLabel.Text = sysmgr.GetQuestionGender();
            AgeRangeLabel.Text = sysmgr.GetQuestionAgeRange();

            if (Session["CustomerProfileCheckBox"] != null)
                CustomerProfileCheckBox.Checked = Convert.ToBoolean(Session["CustomerProfileCheckBox"]);

            if (CustomerProfileCheckBox.Checked)
            {
                CustomerProfileContent.Visible = true;
                AgeDDL.SelectedValue = Session["AgeDDL"].ToString();
                GenderDDL.SelectedValue = Session["GenderDDL"].ToString();
            }
            else
                CustomerProfileContent.Visible = false;

            if (Session["ContactRequestsCheckBox"] != null)
                ContactRequestsCheckBox.Checked = Convert.ToBoolean(Session["ContactRequestsCheckBox"]);

            if (ContactRequestsCheckBox.Checked)
            {
                ContactRequestsContent.Visible = true;
                PhoneTextBox.Text = Session["PhoneTextBox"].ToString();
                RoomTextBox.Text = Session["RoomTextBox"].ToString();
            }   
            else
                ContactRequestsContent.Visible = false;
        }
    }

    protected void CustomerProfileCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (CustomerProfileCheckBox.Checked)
        {
            CustomerProfileContent.Visible = true;
        }
        else
            CustomerProfileContent.Visible = false;
    }

    protected void ContactRequestsCheckBox_CheckedChanged(object sender, EventArgs e)
    {
        if (ContactRequestsCheckBox.Checked)
        {
            ContactRequestsContent.Visible = true;
        }
        else
            ContactRequestsContent.Visible = false;
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        int surveyVersionId = Convert.ToInt32(Session["survey_version_id"]); //TODO - create a method to capture Current Survey ID
        int unitId = int.Parse(Session["Unit"].ToString());
        int mealId = int.Parse(Session["MealType"].ToString());
        int participantTypeId = int.Parse(Session["ParticipantType"].ToString());
        int ageRangeId;
        int genderId;
        bool customerProfileCheckBox = CustomerProfileCheckBox.Checked; // TODO - store checkbox booleans in case of return
        bool contactRequest = ContactRequestsCheckBox.Checked; // TODO - store checkbox booleans in case of return
        string contactRoomNumber;
        string contactPhoneNumber;
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

        if (!contactRequest)
        {
            contactRoomNumber = "N/A";
            contactPhoneNumber = "N/A";
        }
        else
        {
            contactRoomNumber = RoomTextBox.Text;
            contactPhoneNumber = PhoneTextBox.Text;
        }

        SubmittedSurveyController sysmgr = new SubmittedSurveyController();
        //sysmgr.SubmitSurvey(1, 1, 1, 1, 1, 1, true, "1234", "7801231234", "", "Good", "Good", "Good", "Good", "Good", "Good", "Good", "Good");
        sysmgr.SubmitSurvey(surveyVersionId, unitId, mealId, participantTypeId, ageRangeId, genderId, contactRequest, contactRoomNumber, contactPhoneNumber, q1AResponse, q1BResponse, q1CResponse, q1DResponse, q1EResponse, q2Response, q3Response, q4Response, q5Response);

        // abandon session
        Session.Abandon();

        Response.Redirect("~/Thankyou");
    }

    protected void BackButton_Click(object sender, EventArgs e)
    {
        // TODO - Store user values into Session[]
        Session["CustomerProfileCheckBox"] = CustomerProfileCheckBox.Checked;
        Session["GenderDDL"] = GenderDDL.SelectedValue;
        Session["AgeDDL"] = AgeDDL.SelectedValue;

        Session["ContactRequestsCheckBox"] = ContactRequestsCheckBox.Checked;
        Session["PhoneTextBox"] = PhoneTextBox.Text;
        Session["RoomTextBox"] = RoomTextBox.Text;
    
        Response.Redirect("~/TakeSurvey");
    }
}