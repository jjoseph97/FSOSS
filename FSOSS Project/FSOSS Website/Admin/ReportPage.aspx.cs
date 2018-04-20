using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
// All the imported non-auto generated namespaces and classes that are use for this page stored in a specific region for better organization
#region
// Namespaces and classes imported in order to use POCO clases
using FSOSS.System.Data.POCOs;
// Namespaces and classes imported in order to use FSOSS Controller clases
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
                    // If meal variable is null change the FilterDescription Label Text to the described markup.
                    FilterDescription.Text = "Report from " + siteName + " from " + filter.startingDate.ToString("MMMM-dd-yyyy") + " to " + filter.endDate.ToString("MMMM-dd-yyyy") +
                    " with no meal filter.";
                }
                else
                {
                    // If meal variable is not null change the FilterDescription Label Text to the described markup.
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
    /// This method is use as a Web Service use for displaying charts on the Report Page. 
    /// </summary>
    /// <param name="chartId">Parameter use to identify which chart is accessing the web method and to identify which value to be process and retrieve</param>
    /// <returns>Return a Serialize JSON Object to be use for ChartJS</returns>
    [WebMethod] // This attribute allows XML Web service created using ASP.NET to be the callable from remote Web Clients.
    public static string GetChartData(int chartId)
    {
        // Instantiate Report POCO, Chart POCO, Chart POCO List, Preferred Response Order List, Sorted Response Variable, and Report Controller variables
        FinalReportPOCO report = new FinalReportPOCO();
        List<ChartPOCO> responses = new List<ChartPOCO>();
        ChartPOCO response = new ChartPOCO();
        // List of Preferred Response Order based on the Question Responses answers
        List<String> preferencesForOrderByFirstOption = new List<String> { "Very Good", "Good", "Fair", "Poor", "Don't Know/No Opinion", "No Response" };
        List<String> preferencesForOrderBySecondOption = new List<String> { "Portion sizes are too small", "Portion sizes are just right", "Portion sizes are too large", "No Response" };
        List<String> preferencesForOrderByThirdOption = new List<String> { "Always", "Usually", "Occasionally", "Never", "I do not have any specific dietary requirements", "No Response" };
        List<String> preferencesForOrderByFourthOption = new List<String> { "Very Good", "Good", "Fair", "Never", "Poor", "Very Poor" };
        IEnumerable<ChartPOCO> sortedResponses = null;
        ReportController reportMgr = new ReportController();
        // Get the Filter to be use as a parameter to get the data for report. 
        FilterPOCO filter = (FilterPOCO)(HttpContext.Current.Session["filter"]);
        // Initialize report by calling GenerateOverAllReport method from Report Controller which return a FinalReportPOCO object.
        report = reportMgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
        // Check if the the retrieve report has atleast 1 survey submitted.
        if (report.SubmittedSurveyList.Count > 0)
        {
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart1 for Question 1A.
            if (chartId == 1)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionTwoValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionTwoValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionTwoValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionTwoValueCount[counter];
                    response.Title = report.Question[0];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;
                                
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.     
                sortedResponses = responses.OrderBy(item => preferencesForOrderByFirstOption.IndexOf(item.Text));
            }
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart2 for Question 1B.
            else if (chartId == 2)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionThreeValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionThreeValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionThreeValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionThreeValueCount[counter];
                    response.Title = report.Question[1];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;               
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.  
                sortedResponses = responses.OrderBy(item => preferencesForOrderByFirstOption.IndexOf(item.Text));
            }
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart3 for Question 1C.
            else if (chartId == 3)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionFourValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionFourValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";

                    }
                    else
                    {
                        response.Text = report.QuestionFourValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionFourValueCount[counter];
                    response.Title = report.Question[2];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;                    
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.
                sortedResponses = responses.OrderBy(item => preferencesForOrderByFirstOption.IndexOf(item.Text));
            }
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart4 for Question 1D.
            else if (chartId == 4)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionFiveValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionFiveValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionFiveValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionFiveValueCount[counter];
                    response.Title = report.Question[3];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.
                sortedResponses = responses.OrderBy(item => preferencesForOrderByFirstOption.IndexOf(item.Text));
            }
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart5 for Question 1E.
            else if (chartId == 5)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionSixValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionSixValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionSixValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionSixValueCount[counter];
                    response.Title = report.Question[4];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;                   
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.
                sortedResponses = responses.OrderBy(item => preferencesForOrderByFirstOption.IndexOf(item.Text));
            }
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart6 for Question 2.
            else if (chartId == 6)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionEightValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionEightValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionEightValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionEightValueCount[counter];
                    response.Title = report.Question[5];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;                
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.
                sortedResponses = responses.OrderBy(item => preferencesForOrderBySecondOption.IndexOf(item.Text));
            }
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart7 for Question 3.
            else if (chartId == 7)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionNineValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionNineValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionNineValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionNineValueCount[counter];
                    response.Title = report.Question[6];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;                   
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.
                sortedResponses = responses.OrderBy(item => preferencesForOrderByThirdOption.IndexOf(item.Text));
            }
            // Check to see if what ajax call is accessing the data and process the desired value to be retrieves.
            // Retrieves data for Chart8 for Question 4.
            else if (chartId == 8)
            {
                // Loop to the specific List from report POCO based on the chart.
                for (int counter = 0; counter < report.QuestionTenValueCount.Count; counter++)
                {
                    // Check and handle if the retrieve string is empty
                    if (report.QuestionTenValueList[counter].Equals(""))
                    {
                        response.Text = "No Response";
                    }
                    else
                    {
                        response.Text = report.QuestionTenValueList[counter];
                    }
                    // Set the Chart POCO attributes based on the current Object being looped in.
                    response.Value = report.QuestionTenValueCount[counter];
                    response.Title = report.Question[7];
                    response.Color = COLOR_VALUE[counter];
                    response.BorderColor = BORDER_COLOR_VALUE[counter];
                    // Add the ChartPOCO Object to the ChartPOCO List 
                    responses.Add(response);
                    // Clear the ChartPOCO Object
                    response = null;                 
                }
                // Sort the responses based on the preferred option declared and assigned it to the sortedResponse variable of IEnumerable type.
                sortedResponses = responses.OrderBy(item => preferencesForOrderByFourthOption.IndexOf(item.Text));
            }
        }
        // Convert sortedResponses variable of type IEnumerable to Serialze JSON Ojject using JsonConvert.SerializeObject method.
        // Return sortedResponses of type JSON Object
        return JsonConvert.SerializeObject(sortedResponses);
    }   
}