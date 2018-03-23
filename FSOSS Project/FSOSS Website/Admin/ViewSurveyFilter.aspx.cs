using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ViewSurveyFilter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SuccessAlert.Visible = false;
            ErrorAlert.Visible = false;
            SiteController siteController = new SiteController();
            List<SitePOCO> siteList = siteController.GetSiteList();
            HospitalDropDownList.DataSource = siteList;
            HospitalDropDownList.DataValueField = "siteID";
            HospitalDropDownList.DataTextField = "siteName";
            HospitalDropDownList.DataBind();
            MealController mealController = new MealController();
            List<MealPOCO> mealList = mealController.GetMealList();
            MealDropDownList.DataSource = mealList;
            MealDropDownList.DataValueField = "mealID";
            MealDropDownList.DataTextField = "mealName";
            MealDropDownList.DataBind();
            UnitController unitController = new UnitController();
            int selectedSiteID = int.Parse(HospitalDropDownList.SelectedValue);
            List<UnitsPOCO> unitList = unitController.GetUnitList(selectedSiteID);
            UnitDropDownList.DataSource = unitList;
            UnitDropDownList.DataValueField = "unitID";
            UnitDropDownList.DataTextField = "unitNumber";
            UnitDropDownList.DataBind();
        }
    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        FilterPOCO filter = new FilterPOCO();
        if (StartingPeriodTextBox.Text != "")
        {
            filter.startingDate = DateTime.ParseExact(StartingPeriodTextBox.Text + " 00:00:00:000000", "yyyy-MM-dd HH:mm:ss:ffffff", null);
            if (EndingPeriodTextBox.Text != "")
            {
                filter.endDate = DateTime.ParseExact(EndingPeriodTextBox.Text + " 00:00:00:000000", "yyyy-MM-dd HH:mm:ss:ffffff", null);
                filter.siteID = int.Parse(HospitalDropDownList.SelectedValue);
                filter.mealID = int.Parse(MealDropDownList.SelectedValue);
                filter.unitID = int.Parse(UnitDropDownList.SelectedValue);
                Session["filter"] = filter;
                Response.Redirect("SubmittedSurveyList.aspx");
            }
            else
            {
                SuccessAlert.Text = "Please select an ending period";
                SuccessAlert.Visible = true;
            }
        }
        else
        {
            SuccessAlert.Text = "Please select a starting period";
            SuccessAlert.Visible = true;
        }     
    }
}