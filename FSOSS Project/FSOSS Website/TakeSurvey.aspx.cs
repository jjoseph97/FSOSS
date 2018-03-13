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
            if (Session["UnitNumber"] != null)
            {
                UnitNumber.SelectedValue = Session["UnitNumber"].ToString();
                UnitNumber.SelectedItem.Selected = true;
            }
            if (Session["ParticpantType"] != null)
            {
                ParticipantType.SelectedValue = Session["ParticipantType"].ToString();
                ParticipantType.SelectedItem.Selected = true;
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

            if (Session["Q2"] != null)
            {
                Q2.SelectedValue = Session["Q2"].ToString();
                Q2.SelectedItem.Selected = true;
            }
            if (Session["Q3"] != null)
            {
                Q3.SelectedValue = Session["Q3"].ToString();
                Q3.SelectedItem.Selected = true;
            }
            if (Session["Q4"] != null)
            {
                Q4.SelectedValue = Session["Q4"].ToString();
                Q4.SelectedItem.Selected = true;
            }
            if (Session["Q5"] != null)
            {
                Q5.Text = Session["Q5"].ToString();
            }
        }
    }

    protected void NextButton_Click(object sender, EventArgs e)
    {
       if (Q4.SelectedItem.Value == "")
        {
            // throw friendly error message
            Message.Text = "Please select an option";
        }
        else
        {
            Session["UnitNumber"] = UnitNumber.SelectedValue;
            Session["ParticipantType"] = ParticipantType.SelectedValue;
            Session["MealType"] = MealType.SelectedValue;

            Session["Q1A"] = Q1A.SelectedValue;
            Session["Q1B"] = Q1B.SelectedValue;
            Session["Q1C"] = Q1C.SelectedValue;
            Session["Q1D"] = Q1D.SelectedValue;
            Session["Q1E"] = Q1E.SelectedValue;

            Session["Q2"] = Q2.SelectedValue;
            Session["Q3"] = Q3.SelectedValue;
            Session["Q4"] = Q4.SelectedValue;
            Session["Q5"] = Q5.Text;
            Response.Redirect("~/DemographicsPage.aspx", false);
        }
        
    }
    
}