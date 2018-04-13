using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region
using FSOSS.System.Data.POCOs;
using FSOSS.System.Data.DTO;
using FSOSS.System.BLL;
using Newtonsoft.Json;
using System.Web.Services;
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_AdministratorPages_ReportPage : System.Web.UI.Page
{
    public static FinalReportPOCO report = new FinalReportPOCO();


    protected void Page_Load(object sender, EventArgs e)
    {
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
            }
            else
            {
                mealFilter = meal.meal_name;
            }
            FilterDescription.Text = "Report from " + siteName + " from " + filter.startingDate.ToString("MMMM-dd-yyyy") + " to " + filter.endDate.ToString("MMMM-dd-yyyy") + 
                " with a meal filter of " + mealFilter + ".";
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
    public static readonly string[] COLOR_VALUE = {"rgba(255, 0, 0, 0.4)", "rgba(255, 255, 0, 0.4)", "rgba(0, 153, 0, 0.4)", "rgba(0, 0, 255, 0.4)", "rgba(255, 0, 255, 0.4)" };
    public static readonly string[] BORDER_COLOR_VALUE = { "rgba(255, 0, 0, 1)", "rgba(255, 255, 0, 1)", "rgba(0, 153, 0, 1)", "rgba(0, 0, 255, 1)", "rgba(255, 0, 255, 1)" };
    [WebMethod]
    public static string GetQuestionTwoData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();      
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
        }
        return JsonConvert.SerializeObject(responses);
    }


    [WebMethod]
    public static string GetQuestionThreeData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();
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
        }
        return JsonConvert.SerializeObject(responses);
    }

    [WebMethod]
    public static string GetQuestionFourData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();
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
        }
        return JsonConvert.SerializeObject(responses);
    }
    [WebMethod]
    public static string GetQuestionFiveData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();
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
        }
        return JsonConvert.SerializeObject(responses);
    }

    [WebMethod]
    public static string GetQuestionSixData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();
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
        }
        return JsonConvert.SerializeObject(responses);
    }

    [WebMethod]
    public static string GetQuestionEightData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();
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
        }
        return JsonConvert.SerializeObject(responses);
    }

    [WebMethod]
    public static string GetQuestionNineData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();
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
        }
        return JsonConvert.SerializeObject(responses);
    }

    [WebMethod]
    public static string GetQuestionTenData()
    {
        List<ChartPOCO> responses = new List<ChartPOCO>();
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
        }
        return JsonConvert.SerializeObject(responses);
    }

    
}