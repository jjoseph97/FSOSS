using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region
using FSOSS.System.Data.POCOs;
using FSOSS.System.BLL;
using Newtonsoft.Json;
using System.Web.Services;
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_AdministratorPages_ReportPage : System.Web.UI.Page
{
    /// <summary>
    /// Default Web Page Method use to check requirements 
    /// </summary>
    /// <param name="sender">default parameter for Page_Load event</param>
    /// <param name="e">default parameter for Page_Load event</param>
    protected void Page_Load(object sender, EventArgs e)
    {
        FinalReportPOCO report = new FinalReportPOCO();
        Alert.Visible = false;
        FilterPOCO filter = (FilterPOCO)(Session["filter"]);
        if(filter == null)
        {
          Response.Redirect("~/Admin/ViewReportFilter.aspx");
        }                  
        else
        {
            if (Session["securityID"] == null)
            {
                Response.Redirect("~/Admin/Login.aspx");
            }
            ReportController sysmgr = new ReportController();
            report = sysmgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
            SiteController siteMgr = new SiteController();
            string siteName = "";
            siteName = siteMgr.DisplaySiteName(filter.siteID);
            if (siteName == null)
            {
                siteName = "All sites";
            }
            MealController mealMgr = new MealController();
            Meal meal = new Meal();
            meal = mealMgr.GetMeal(filter.mealID);
            string mealFilter;
            if(meal == null)
            {
                mealFilter = "none";
                FilterDescription.Text = "Report from " + siteName + " from " + filter.startingDate.ToString("MMMM-dd-yyyy") + " to " + filter.endDate.ToString("MMMM-dd-yyyy") +
                " with no meal filter.";
            }
            else
            {
                mealFilter = meal.meal_name;
                FilterDescription.Text = "Report from " + siteName + " from " + filter.startingDate.ToString("MMMM-dd-yyyy") + " to " + filter.endDate.ToString("MMMM-dd-yyyy") +
                " with a meal filter of " + mealFilter + ".";
            }

            TotalNumberOfSubmittedSurvey.Text = "Total number of submitted survey with the given criteria: "+report.SubmittedSurveyList.Count().ToString() + " surveys submitted.";
            if(report.QuestionTenValueCount.Count < 1)
            {
                TotalNumberOfSubmittedSurvey.Visible = false;
                EmptyMessage.Visible = true;
                EmptyMessage.Text = "No Submitted Survey Found. Please check your filter";
            }
        } 
    }
    protected void Return_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Admin/ViewReportFilter.aspx");
    }
    public static readonly string[] COLOR_VALUE = {"rgba(255, 0, 0, 0.3)", "rgba(255, 255, 0, 0.3)", "rgba(0, 153, 0, 0.3)", "rgba(0, 0, 255, 0.3)", "rgba(255, 0, 255, 0.3)", "rgba(102, 255, 255, 0.3)", "rgba(255, 153, 102, 0.3)" };
    public static readonly string[] BORDER_COLOR_VALUE = { "rgba(255, 0, 0, 1)", "rgba(255, 255, 0, 1)", "rgba(0, 153, 0, 1)", "rgba(0, 0, 255, 1)", "rgba(255, 0, 255, 1)", "rgba(102, 255, 255, 1)", "rgba(255, 153, 102, 1)" };

    [WebMethod]
    public static string GetChartData(int chartId)
    {
        FinalReportPOCO report = new FinalReportPOCO();
        List<ChartPOCO> responses = new List<ChartPOCO>();
        List<String> preferencesForOrderByFirstOption = new List<String> { "Very Good", "Good", "Fair", "Poor", "Don't Know/No Opinion", "No Response" };
        List<String> preferencesForOrderBySecondOption = new List<String> { "Portion sizes are too small", "Portion sizes are just right", "Portion sizes are too large", "No Response" };
        List<String> preferencesForOrderByThirdOption = new List<String> { "Always", "Usually", "Occasionally", "Never", "I do not have any specific dietary requirements", "No Response" };
        List<String> preferencesForOrderByFourthOption = new List<String> { "Very Good", "Good", "Fair", "Never", "Poor", "Very Poor" };
        IEnumerable<ChartPOCO> sortedResponses = null;
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
        return JsonConvert.SerializeObject(sortedResponses);
    }   
}