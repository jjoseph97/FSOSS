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
    // Markup use for displaying error glyph and message
    private string failedHeader = "<span><i class='fas fa-exclamation-triangle'></i> Processing Error</span><br/>";

    /// <summary>
    /// Default Web Page Method use to initialize pages and check if the user is logged in.
    /// Initialize drop down lists alert labels
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        // this is for the client side input values to be retained after the page loads when a validation error is triggered (so the text is not lost)
        string startingPeriodInput = Request.Form["StartingPeriodInput"];
        string endingPeriodInput = Request.Form["EndingPeriodInput"];
        this.startingInputValue = startingPeriodInput;
        this.endingInputValue = endingPeriodInput;
        // Redirect user to login if not logged in
        if (Session["securityID"] == null) 
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (!IsPostBack)
        {
            // Initialize Meal Controller, Meal List, Site Controller, and SitePOCO List variable
            MealController mealController = new MealController();
            List<MealPOCO> mealList = mealController.GetMealList();
            SiteController siteController = new SiteController();
            List<SitePOCO> siteList = siteController.GetSiteList();
            // Initialize Alert Label
            Alert.Visible = false;
            Alert.Text = "";
            // Iniitalize and setup Meal Drop down list
            MealDropDownList.DataSource = mealList;
            MealDropDownList.DataValueField = "mealID";
            MealDropDownList.DataTextField = "mealName";
            MealDropDownList.DataBind();
            // Iniitalize and setup Site/Hospital Drop down list
            HospitalDropDownList.DataSource = siteList;
            HospitalDropDownList.DataValueField = "siteID";
            HospitalDropDownList.DataTextField = "siteName";
            HospitalDropDownList.DataBind();         
        }
        // Initialize Alert Label
        Alert.Text = "";
        Alert.Visible = false;
    }
    // this is in order to get and set the starting date input text on page reload
    protected string startingInputValue { get; set; }
    // this is in order to get and set the end date input text on page reload
    protected string endingInputValue { get; set; }

    /// <summary>
    /// Validate if the are correct filter parameters are passed and redirect the administartor to the report page if all the filter is valid.
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void ViewButton_Click(object sender, EventArgs e)
    {
        // Initialize filter POCO
        FilterPOCO filter = new FilterPOCO();
        // Get the value from the StartingPerioud calendar input
        string startingPeriodInput = String.Format("{0}", Request.Form["StartingPeriodInput"]);
        // Check if the starting period is empty or the starting perioud is not a valid date and time format
        if (startingPeriodInput != "" || DateTime.TryParseExact(startingPeriodInput, "yyyy-MM-dd HH:mm:ss:ffffff", null, System.Globalization.DateTimeStyles.None, out DateTime dateToParse))
        {
            //  Get the value from the EndingPeriod calendar input
            string endingPeriodInput = Request.Form["EndingPeriodInput"];
            // Set the filter startingDate
            filter.startingDate = DateTime.ParseExact(startingPeriodInput + " 00:00:00:000000", "yyyy-MM-dd HH:mm:ss:ffffff", null);
            // check if the filter date is greate
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
                        Alert.Text = failedHeader + String.Format("Starting date must be before the end date.");
                        Alert.Visible = true;
                    }

                }
                else
                {
                    Alert.Text = failedHeader + "Please select an ending period";
                    Alert.Visible = true;
                }
            }
            else
            {
                Alert.Text = failedHeader + String.Format("Starting date cannot be after today's date.");
                Alert.Visible = true;
            }
        }
        else
        {
            Alert.Text = failedHeader + "Please select a starting period";
            Alert.Visible = true;
        }
    }

}