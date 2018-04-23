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
    private string failedHeader = "<span><i class='fas fa-exclamation-triangle'></i> Processing Error</span><br/>";

    protected void Page_Load(object sender, EventArgs e)
    {
        // this is for the client side input values to be retained after the page loads when a validation error is triggered (so the text is not lost)
        string startingPeriodInput = Request.Form["StartingPeriodInput"];
        string endingPeriodInput = Request.Form["EndingPeriodInput"];
        this.startingInputValue = startingPeriodInput;
        this.endingInputValue = endingPeriodInput;

        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (!IsPostBack)
        {
            MealController mealController = new MealController();
            Alert.Visible = false;
            Alert.Text = "";
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
            if (Session["securityID"] == null)
            {
                Response.Redirect("~/Admin/Login.aspx");
            }
        }
        Alert.Text = "";
        Alert.Visible = false;
    }

    protected string startingInputValue { get; set; } // this is in order to get and set the starting date input text on page reload
    protected string endingInputValue { get; set; } // this is in order to get and set the end date input text on page reload

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        FilterPOCO filter = new FilterPOCO();
        DateTime dateToParse;
        string startingPeriodInput = String.Format("{0}", Request.Form["StartingPeriodInput"]);
        if (startingPeriodInput != "" || DateTime.TryParseExact(startingPeriodInput, "yyyy-MM-dd HH:mm:ss:ffffff", null, System.Globalization.DateTimeStyles.None, out dateToParse))
        {
            string endingPeriodInput = Request.Form["EndingPeriodInput"];
            filter.startingDate = DateTime.ParseExact(startingPeriodInput + " 00:00:00:000000", "yyyy-MM-dd HH:mm:ss:ffffff", null);
            if (filter.startingDate < DateTime.Now)
            {
                if (endingPeriodInput != "" || DateTime.TryParseExact(endingPeriodInput, "yyyy-MM-dd HH:mm:ss:ffffff", null, System.Globalization.DateTimeStyles.None, out dateToParse))
                {
                    filter.endDate = DateTime.ParseExact(endingPeriodInput + " 23:59:59:999999", "yyyy-MM-dd HH:mm:ss:ffffff", null);
                    if (filter.startingDate <= filter.endDate)
                    {
                        this.startingInputValue = startingPeriodInput;
                        this.endingInputValue = endingPeriodInput;
                        filter.siteID = int.Parse(HospitalDropDownList.SelectedValue);
                        filter.mealID = int.Parse(MealDropDownList.SelectedValue);
                        Alert.Visible = false;
                        Session["filter"] = filter;
                        Response.Redirect("~/Admin/ReportPage.aspx");
                    }
                    else
                    {
                        Alert.Text = failedHeader + String.Format("Start date of report cannot be above the end date. Start date {0} : End date {1} ", filter.startingDate.ToString("MMMM-dd-yyyy HH:mm:ss"), filter.endDate.ToString("MMMM-dd-yyyy HH:mm:ss"));
                        Alert.Visible = true;
                    }

                }
                else
                {
                    Alert.Text = failedHeader + "Please select a valid ending period";
                    Alert.Visible = true;
                }
            }
            else
            {
                Alert.Text = failedHeader + String.Format("Start date of report cannot be above the Current date {0}. Start date {1}", DateTime.Now.ToString("MMMM-dd-yyyy HH:mm:ss"), filter.startingDate.ToString("MMMM-dd-yyyy HH:mm:ss"));
                Alert.Visible = true;
            }
        }
        else
        {
            Alert.Text = failedHeader + "Please select a valid starting period";
            Alert.Visible = true;
        }
    }

}