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
            HospitalDropDownList.DataTextField = "siteName";
            HospitalDropDownList.DataBind();
           // int userID = int.Parse(Session["userID"].ToString());
        }
        
    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        FilterPOCO filter = new FilterPOCO();
        DateTime dateToParse;
        string startingPeriodInput = String.Format("{0}", Request.Form["StartingPeriodInput"]);
        if (startingPeriodInput != "" || DateTime.TryParseExact(startingPeriodInput, "yyyy-MM-dd HH:mm:ss:ffffff", null, System.Globalization.DateTimeStyles.None, out dateToParse))
        {
            string endingPeriodInput = Request.Form["EndingPeriodInput"];
            filter.startingDate = DateTime.ParseExact(startingPeriodInput + " 00:00:00:000000","yyyy-MM-dd HH:mm:ss:ffffff",null);
            if(endingPeriodInput != "" || DateTime.TryParseExact(endingPeriodInput, "yyyy-MM-dd HH:mm:ss:ffffff", null, System.Globalization.DateTimeStyles.None, out dateToParse))
            {
                filter.endDate = DateTime.ParseExact(endingPeriodInput + " 00:00:00:000000", "yyyy-MM-dd HH:mm:ss:ffffff", null);
                if (filter.startingDate <= filter.endDate)
                {                  
                    filter.siteID = int.Parse(HospitalDropDownList.SelectedValue);
                    filter.mealID = int.Parse(MealDropDownList.SelectedValue);
                    Session["filter"] = filter;
                    Response.Redirect("~/Admin/ReportPage.aspx");
                }
                else
                {
                    Alert.Text = String.Format("Start date of report cannot be above the end date. Start date {0} : End date {1} ", filter.startingDate, filter.endDate);
                    Alert.Visible = true;
                }
               
            }
            else
            {
                Alert.Text = "Please select a valid ending period";
                Alert.Visible = true;
            }           
        }
        else
        {
            Alert.Text = "Please select a valid starting period";
            Alert.Visible = true;
        }
     
     
     
        
    }

}