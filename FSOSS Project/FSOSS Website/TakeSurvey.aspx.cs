using FSOSS.System.BLL;
using FSOSS.System.Data.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_Survey_TakeSurvey : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // if the participant doesn't take a survey
        if (Session["takingSurvey"] == null)
        {
            //abandon the session
            Session.Abandon();
            //redirect the participant to the survey access page
            Response.Redirect("~/");
        }
        if (!IsPostBack)
        {  
            SiteController site = new SiteController(); //allows access to the site controller
            
            //displays the hospital name at the top of the survey  
            SiteName.Text = "Hospital: <span style=font-weight:bold;>" + site.DisplaySiteName(Convert.ToInt32(Session["siteID"])) + "</span>";

            //Populate question labels 
            QuestionTextController sysmgr = new QuestionTextController(); //allows access to the question text controller
            Q1.Text = "1. " + sysmgr.GetQuestion1();  
            Q1A.Text = sysmgr.GetQuestion1A();
            Q1B.Text = sysmgr.GetQuestion1B();
            Q1C.Text = sysmgr.GetQuestion1C();
            Q1D.Text = sysmgr.GetQuestion1D();
            Q1E.Text = sysmgr.GetQuestion1E();
            Q2.Text = "2. " + sysmgr.GetQuestion2();
            Q3.Text = "3. " + sysmgr.GetQuestion3();
            Q4.Text = "4. " + sysmgr.GetQuestion4();
            Q5.Text = "5. " + sysmgr.GetQuestion5();

            //if there is a session value for unit
            if (Session["Unit"] != null) 
            {
                //choose selected unit 
                UnitDropDownList.SelectedValue = Session["Unit"].ToString();
                UnitDropDownList.SelectedItem.Selected = true;
            }
            //if there is a session value for participant type 
            if (Session["ParticipantType"] != null) 
            {
                //choose selected participant type 
                ParticipantTypeDropDownList.SelectedValue = Session["ParticipantType"].ToString();
                ParticipantTypeDropDownList.SelectedItem.Selected = true;
            }
            //if there is a session value for meal type 
            if (Session["MealType"] != null) 
            {
                //choose selected meal type 
                MealTypeDropDownList.SelectedValue = Session["MealType"].ToString();
                MealTypeDropDownList.SelectedItem.Selected = true;
            }
            //if there is a session for Q1A 
            if (Session["Q1A"] != null) 
            {
                //choose selected Q1A 
                Q1AResponse.SelectedValue = Session["Q1A"].ToString();
                Q1AResponse.SelectedItem.Selected = true;
            }
            //if there is a session for Q1B
            if (Session["Q1B"] != null)  
            {
                //choose selected Q1B
                Q1BResponse.SelectedValue = Session["Q1B"].ToString();
                Q1BResponse.SelectedItem.Selected = true;
            }
            //if there is a session for Q1C
            if (Session["Q1C"] != null)  
            {
                //choose selected Q1C
                Q1CResponse.SelectedValue = Session["Q1C"].ToString();
                Q1CResponse.SelectedItem.Selected = true;
            }
            //if there is a session for Q1D
            if (Session["Q1D"] != null)  
            {
                //choose selected Q1D
                Q1DResponse.SelectedValue = Session["Q1D"].ToString();
                Q1DResponse.SelectedItem.Selected = true;
            }
            //if there is a session for Q1E
            if (Session["Q1E"] != null)  
            {
                //choose selected Q1E
                Q1EResponse.SelectedValue = Session["Q1E"].ToString();
                Q1EResponse.SelectedItem.Selected = true;
            }
            //if there is a session for Q2
            if (Session["Q2"] != null)
            {
                //choose selected Q2
                Q2Response.SelectedValue = Session["Q2"].ToString();
                Q2Response.SelectedItem.Selected = true;
            }
            //if there is a session for Q3
            if (Session["Q3"] != null)
            {
                //choose selected Q3
                Q3Response.SelectedValue = Session["Q3"].ToString();
                Q3Response.SelectedItem.Selected = true;
            }
            //if there is a session for Q4
            if (Session["Q4"] != null)
            {
                //choose selected Q4
                Q4Response.SelectedValue = Session["Q4"].ToString();
                Q4Response.SelectedItem.Selected = true;
            }
            //if there is a session for Q5
            if (Session["Q5"] != null)
            {
                //choose selected Q5
                Question5.Text = Session["Q5"].ToString();
            }
        }
    }

    /// <summary>
    /// The method saves the chosen options and entered text into a session when the participant clicks the next button 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void NextButton_Click(object sender, EventArgs e)
    {
        //captures the chosen option from the drop-down and stores it into a session
        Session["Unit"] = UnitDropDownList.SelectedValue; 
        Session["ParticipantType"] = ParticipantTypeDropDownList.SelectedValue;  
        Session["MealType"] = MealTypeDropDownList.SelectedValue;  
        Session["Q1A"] = Q1AResponse.SelectedValue;  
        Session["Q1B"] = Q1BResponse.SelectedValue;  
        Session["Q1C"] = Q1CResponse.SelectedValue;  
        Session["Q1D"] = Q1DResponse.SelectedValue; 
        Session["Q1E"] = Q1EResponse.SelectedValue;  
        Session["Q2"] = Q2Response.SelectedValue;  
        Session["Q3"] = Q3Response.SelectedValue;  
        Session["Q4"] = Q4Response.SelectedValue;  
        Session["Q5"] = Question5.Text;

        //redirects the participant to the demographics page when the next button is clicked
        Response.Redirect("~/DemographicsPage.aspx", false); 


    }

}