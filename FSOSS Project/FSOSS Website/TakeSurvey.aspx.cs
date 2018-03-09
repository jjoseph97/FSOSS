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
        if (!IsPostBack)
        {
            if (Session["ParticipantType"] != null)
            {
                ParticipantType.SelectedValue = Session["ParticipantType"].ToString();
                ParticipantType.SelectedItem.Selected = true;
            }
            if (Session["MealType"] != null)
            {
                MealType.SelectedValue = Session["MealType"].ToString();
                MealType.SelectedItem.Selected = true;
            }
            if (Session["MealType"] != null)
            {
                MealType.SelectedValue = Session["MealType"].ToString();
                MealType.SelectedItem.Selected = true;
            }
            if (Session["Q1A"] != null )
            {
                Q1A.SelectedValue = Session["Q1A"].ToString();
                Q1A.SelectedItem.Selected = true;
            }
            if (Session["Q1B"] != null )
            {
                Q1B.SelectedValue = Session["Q1B"].ToString();
                Q1B.SelectedItem.Selected = true;
            }
            if (Session["Q1C"] != null)
            {
                Q1C.SelectedValue = Session["Q1C"].ToString();
                Q1C.SelectedItem.Selected = true;
            }
            if (Session["Q1D"] != null)
            {
                Q1D.SelectedValue = Session["Q1D"].ToString();
                Q1D.SelectedItem.Selected = true;
            }
            if (Session["Q1E"] != null)
            {
                Q1E.SelectedValue = Session["Q1E"].ToString();
                Q1E.SelectedItem.Selected = true;
            }
        }
    }

    protected void NextButton_Click(object sender, EventArgs e)
    {
       if (Q4.SelectedValue == "")
        {
            // throw friendly error message
            Message.Text = "Please select an option";
        }
        else
        {
            Session["Q1A"] = Q1A.SelectedValue;
            Session["Q1B"] = Q1A.SelectedValue;
            Session["Q1C"] = Q1A.SelectedValue;
            Session["Q1D"] = Q1A.SelectedValue;
            Session["Q1E"] = Q1A.SelectedValue;
            
        }
        Response.Redirect("~/DemographicsPage.aspx", false);
    }
    
}