using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Thankyou : System.Web.UI.Page
{
    /// <summary>
    /// This method loads during the start of the page.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["takingSurvey"] == null ||     // if the participant doesn't take a survey, 
            (Session["Unit"] == null               // doesn't choose an option for unit number,  
            && Session["MealType"] == null         // doesn't choose an option for meal type 
            && Session["ParticipantType"] == null  //doesn't choose an option for participant type 
            && Session["Q4"] == null))             //doesn't choose an option for question 4
        {
            //abandon the session and redirect the participant to the survey access page
            Session.Abandon();
            Response.Redirect("~/");
        }
        else
        {
            // clear all fields and display thank you page with message
            Session.Abandon();
        }
    }
}