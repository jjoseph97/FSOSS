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
        if (Session["takingSurvey"] == null)
        {
            Response.Redirect("~/");
        }
        if (!IsPostBack)
        {
            //Display the site name 
            SiteController site = new SiteController();
            SiteName.Text = "Hospital: <span style=font-weight:bold;>" + site.DisplaySiteName(Convert.ToInt32(Session["siteID"])) + "</span>";

            QuestionTextController sysmgr = new QuestionTextController();
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


            if (Session["Unit"] != null)
            {
                UnitDropDownList.SelectedValue = Session["Unit"].ToString();
                UnitDropDownList.SelectedItem.Selected = true;
            }
            if (Session["ParticipantType"] != null)
            {
                ParticipantTypeDropDownList.SelectedValue = Session["ParticipantType"].ToString();
                ParticipantTypeDropDownList.SelectedItem.Selected = true;
            }
            if (Session["MealType"] != null)
            {
                MealTypeDropDownList.SelectedValue = Session["MealType"].ToString();
                MealTypeDropDownList.SelectedItem.Selected = true;
            }

            if (Session["Q1A"] != null )
            {
                Q1AResponse.SelectedValue = Session["Q1A"].ToString();
                Q1AResponse.SelectedItem.Selected = true;
            }
            if (Session["Q1B"] != null )
            {
                Q1BResponse.SelectedValue = Session["Q1B"].ToString();
                Q1BResponse.SelectedItem.Selected = true;
            }
            if (Session["Q1C"] != null)
            {
                Q1CResponse.SelectedValue = Session["Q1C"].ToString();
                Q1CResponse.SelectedItem.Selected = true;
            }
            if (Session["Q1D"] != null)
            {
                Q1DResponse.SelectedValue = Session["Q1D"].ToString();
                Q1DResponse.SelectedItem.Selected = true;
            }
            if (Session["Q1E"] != null)
            {
                Q1EResponse.SelectedValue = Session["Q1E"].ToString();
                Q1EResponse.SelectedItem.Selected = true;
            }

            if (Session["Q2"] != null)
            {
                Q2Response.SelectedValue = Session["Q2"].ToString();
                Q2Response.SelectedItem.Selected = true;
            }
            if (Session["Q3"] != null)
            {
                Q3Response.SelectedValue = Session["Q3"].ToString();
                Q3Response.SelectedItem.Selected = true;
            }
            if (Session["Q4"] != null)
            {
                Q4Response.SelectedValue = Session["Q4"].ToString();
                Q4Response.SelectedItem.Selected = true;
            }
            if (Session["Q5"] != null)
            {
                Question5.Text = Session["Q5"].ToString();
            }
        }
    }

    protected void NextButton_Click(object sender, EventArgs e)
    {

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
        Response.Redirect("~/DemographicsPage.aspx", false);
        
        
    }
    
}