using FSOSS.System.Data.POCOs;
using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_ViewReportFilter : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        // get id for verification here
        if(!IsPostBack)
        {
            MealController mealController = new MealController();
            Alert.Visible = false;
            ErrorAlert.Visible = false;
            List<MealPOCO> mealList = mealController.GetMealList();
            MealDropDownList.DataSource = mealList;
            MealDropDownList.DataValueField = "mealID";
            MealDropDownList.DataTextField = "mealName";
            MealDropDownList.DataBind();
            SiteController siteController = new SiteController();
            List<SitePOCO> siteList = siteController.GetSiteList();
            HospitalDropDownList.DataSource = siteList;
            HospitalDropDownList.DataValueField = "siteID";
            HospitalDropDownList.DataValueField = "siteName";
            HospitalDropDownList.DataBind();
           
        }
        
    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        FilterPOCO filter = new FilterPOCO();
        if(StartingPeriodTextBox.Text != "")
        {
            
            filter.startingDate = DateTime.Parse(StartingPeriodTextBox.Text);
            if(EndingPeriodTextBox.Text != "")
            {
                filter.endDate = DateTime.Parse(EndingPeriodTextBox.Text);
                filter.siteID = int.Parse(HospitalDropDownList.SelectedValue);
                filter.mealID = int.Parse(MealDropDownList.SelectedValue);
                Session["filter"] = filter;
                Response.Redirect("~/Admin/ReportPage.aspx");
            }
            else
            {
                Alert.Text = "Please select ending period";
                Alert.Visible = true;
            }           
        }
        else
        {
            Alert.Text = "Please select starting period";
            Alert.Visible = true;
        }
     
     
     
        
    }

}