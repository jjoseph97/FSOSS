using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
// All the imported non-auto generated namespaces and classes that are use for this page stored in a specific region for better organization
#region
// Namespaces and classes imported in order to use POCO clases
using FSOSS.System.Data.POCOs;
// Namespaces and classes imported in order to use Controller clases
using FSOSS.System.BLL;
// Namespaces and classes imported in order to use JSON Class and JSON Objects
using Newtonsoft.Json;
// Namespaces and classes imported in order to WebMethod Class
using System.Web.Services;
// Namespaces and classes imported in order to use Entity Class
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_AdministratorPages_ReportPage : System.Web.UI.Page
{
    /// <summary>
    /// Default Web Page Method use to initialize pages and check if the user is logged in and if it passes the required filters for generating reports.
    /// </summary>
    /// <param name="sender">default parameter of type object created for Page_Load</param>
    /// <param name="e">default parameter of type EventArgs created for Page_Load</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        // Set the visibility for Alert Message Label to hidden.
        Alert.Visible = false;
        // Check if the user is logged in. Redirect to Admin Login page if the user doesn't have a securityId
        if (Session["securityID"] == null)
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else
        {
            // Initialize and set filter variable with the type of FilterPOCO and retrieve the Session state with an ID of "filter" that is passed from the ViewReportFilter page
            // to be use for the generating report.
            FilterPOCO filter = (FilterPOCO)(Session["filter"]);
            // Check if the filter has a value. Redirect the user to ViewReportFilter page if the the filter doesn't have any values.
            if (filter == null)
            {
                Response.Redirect("~/Admin/ViewReportFilter.aspx");
            }
            else
            {
                // Instantiate Report Controller, Meal Controller, Site Controller, Site Name, FinalReportPOCO and Meal variable.
                ReportController reportMgr = new ReportController();
                MealController mealMgr = new MealController();
                Meal meal = new Meal();
                FinalReportPOCO report = new FinalReportPOCO();
                SiteController siteMgr = new SiteController();
                string siteName = "";
                // Initialize report by calling GenerateOverAllReport method from Report Controller which return a FinalReportPOCO object.
                report = reportMgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
                // Initialize Site Name variable by calling DisplaySiteName method from Site Controller which return a string.
                siteName = siteMgr.DisplaySiteName(filter.siteID);
                // Check if siteName is null, change the Site Name variable to "All sites".
                if (siteName == null)
                {
                    siteName = "All sites";
                }
                // Initialize Meal variable by calling GetMeal method from Meal Controller which return a Meal object.
                meal = mealMgr.GetMeal(filter.mealID);
                // Check if meal variable is null. 
                if (meal == null)
                {
                    //if meal variable is null change the FilterDescription Label Text to the described markup.
                    FilterDescription.Text = "Report from " + siteName + " from " + filter.startingDate.ToString("MMMM-dd-yyyy") + " to " + filter.endDate.ToString("MMMM-dd-yyyy") +
                    " with no meal filter.";
                }
                else
                {
                    //if meal variable is not null change the FilterDescription Label Text to the described markup.
                    FilterDescription.Text = "Report from " + siteName + " from " + filter.startingDate.ToString("MMMM-dd-yyyy") + " to " + filter.endDate.ToString("MMMM-dd-yyyy") +
                    " with a meal filter of " + meal.meal_name + ".";
                }
                // Set the TotalNumberOfSubmittedSurvey Label Text to the described markup.
                TotalNumberOfSubmittedSurvey.Text = "Total number of submitted survey with the given criteria: " + report.SubmittedSurveyList.Count().ToString() + " surveys submitted.";
                // Check if the SubmittedSurveyList from report variable has atleast 1 survey.
                if (report.SubmittedSurveyList.Count < 1)
                {
                    // Hide TotalNumberOfSubmittedSurvey Label.
                    TotalNumberOfSubmittedSurvey.Visible = false;
                    // Display EmptyMessage Label.
                    EmptyMessage.Visible = true;
                    // Set EmptyMessage Label to "No Submitted Survey Found. Please check your filter".
                    EmptyMessage.Text = "No Submitted Survey Found. Please check your filter";
                }
            }
        }     
    }
    /// <summary>
    /// Method use to navigate the user to ViewReportFilter page.
    /// </summary>
    /// <param name="sender">default parameter of type object created for Return_Click</param>
    /// <param name="e">default parameter of type EventArgs created for Return_Click</param>
    protected void Return_Click(object sender, EventArgs e)
    {
        //Redirect the user to ViewReportFilter page.
        Response.Redirect("~/Admin/ViewReportFilter.aspx");
    }

    // Static readonly string array use for assigning chart segment color.
    public static readonly string[] COLOR_VALUE = {"rgba(255, 0, 0, 0.3)", "rgba(255, 255, 0, 0.3)", "rgba(0, 153, 0, 0.3)", "rgba(0, 0, 255, 0.3)", "rgba(255, 0, 255, 0.3)", "rgba(102, 255, 255, 0.3)", "rgba(255, 153, 102, 0.3)" };
    // Static readonly string array use for assigning chart segment border color.
    public static readonly string[] BORDER_COLOR_VALUE = { "rgba(255, 0, 0, 1)", "rgba(255, 255, 0, 1)", "rgba(0, 153, 0, 1)", "rgba(0, 0, 255, 1)", "rgba(255, 0, 255, 1)", "rgba(102, 255, 255, 1)", "rgba(255, 153, 102, 1)" };

    /// <summary>
    /// This method is use as a Web Service use for displaying charts on the Report Page  
    /// </summary>
    /// <param name="chartId"></param>
    /// <returns></returns>
    [WebMethod] // This attribute allows XML Web service created using ASP.NET to be the callable from remote Web Clients.
    public static string GetChartData(int chartId)
    {
        FinalReportPOCO report = new FinalReportPOCO();
        List<ChartPOCO> responses = new List<ChartPOCO>();
        List<String> preferencesForOrderByFirstOption = new List<String> { "Very Good", "Good", "Fair", "Poor", "Don't Know/No Opinion", "No Response" };
        List<String> preferencesForOrderBySecondOption = new List<String> { "Portion sizes are too small", "Portion sizes are just right", "Portion sizes are too large", "No Response" };
        List<String> preferencesForOrderByThirdOption = new List<String> { "Always", "Usually", "Occasionally", "Never", "I do not have any specific dietary requirements", "No Response" };
        List<String> preferencesForOrderByFourthOption = new List<String> { "Very Good", "Good", "Fair", "Never", "Poor", "Very Poor" };
        IEnumerable<ChartPOCO> sortedResponses = null;
        ReportController reportMgr = new ReportController();
        FilterPOCO filter = (FilterPOCO)(HttpContext.Current.Session["filter"]);
        // Initialize report by calling GenerateOverAllReport method from Report Controller which return a FinalReportPOCO object.
        report = reportMgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
        if (report.SubmittedSurveyList.Count > 0)
        {
            if (chartId == 1)
            {
                for (int counter = 0; counter < report.QuestionTwoValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionTwoValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionTwoValueList[counter];
                    }
                    response.Value = report.QuestionTwoValueCount[counter];
                    response.Title = report.Question[0];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                       item => preferencesForOrderByFirstOption.IndexOf(item.Text));
                }
            }
            else if (chartId == 2)
            {
                for (int counter = 0; counter < report.QuestionThreeValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionThreeValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionThreeValueList[counter];
                    }
                    response.Value = report.QuestionThreeValueCount[counter];
                    response.Title = report.Question[1];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                     item => preferencesForOrderByFirstOption.IndexOf(item.Text));
                }
            }
            else if (chartId == 3)
            {
                for (int counter = 0; counter < report.QuestionFourValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionFourValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";

                    }
                    else
                    {
                        response.Text = report.QuestionFourValueList[counter];
                    }
                    response.Value = report.QuestionFourValueCount[counter];
                    response.Title = report.Question[2];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                      item => preferencesForOrderByFirstOption.IndexOf(item.Text));
                }
            }
            else if (chartId == 4)
            {
                for (int counter = 0; counter < report.QuestionFiveValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionFiveValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionFiveValueList[counter];
                    }
                    response.Value = report.QuestionFiveValueCount[counter];
                    response.Title = report.Question[3];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                      item => preferencesForOrderByFirstOption.IndexOf(item.Text));
                }
            }
            else if (chartId == 5)
            {
                for (int counter = 0; counter < report.QuestionSixValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionSixValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionSixValueList[counter];
                    }
                    response.Value = report.QuestionSixValueCount[counter];
                    response.Title = report.Question[4];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                      item => preferencesForOrderByFirstOption.IndexOf(item.Text));
                }
            }
            else if (chartId == 6)
            {
                for (int counter = 0; counter < report.QuestionEightValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionEightValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionEightValueList[counter];
                    }
                    response.Value = report.QuestionEightValueCount[counter];
                    response.Title = report.Question[5];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                      item => preferencesForOrderBySecondOption.IndexOf(item.Text));
                }
            }
            else if (chartId == 7)
            {
                for (int counter = 0; counter < report.QuestionNineValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionNineValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionNineValueList[counter];
                    }
                    response.Value = report.QuestionNineValueCount[counter];
                    response.Title = report.Question[6];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                      item => preferencesForOrderByThirdOption.IndexOf(item.Text));
                }
            }
            else if (chartId == 8)
            {
                for (int counter = 0; counter < report.QuestionTenValueCount.Count; counter++)
                {
                    ChartPOCO response = new ChartPOCO();
                    if (report.QuestionTenValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionTenValueList[counter];
                    }
                    response.Value = report.QuestionTenValueCount[counter];
                    response.Title = report.Question[7];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    responses.Add(response);
                    response = null;
                    sortedResponses = responses.OrderBy(
                     item => preferencesForOrderByFourthOption.IndexOf(item.Text));
                }
            }
        }
        return JsonConvert.SerializeObject(sortedResponses);
    }   
}