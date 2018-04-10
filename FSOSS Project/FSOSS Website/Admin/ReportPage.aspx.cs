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
#endregion

public partial class Pages_AdministratorPages_ReportPage : System.Web.UI.Page
{

   
    protected void Page_Load(object sender, EventArgs e)
    {
        Alert.Visible = false;
        FilterPOCO filter = (FilterPOCO)(Session["filter"]);
        if(filter == null)
        {
          Response.Redirect("~/Admin/ViewReportFilter.aspx");
        }                       
    }

    [WebMethod]
    public static string  GetDataListViaPOCO()
    {

        FilterPOCO filter = (FilterPOCO)(HttpContext.Current.Session["filter"]);
        ReportController sysmgr = new ReportController();
        FinalReportPOCO report = sysmgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
        List<ChartPOCO> responses = new List<ChartPOCO>();
        for (int counter = 0; counter < report.QuestionTwoValueCount.Count; counter++)
        {
            ChartPOCO response = new ChartPOCO
            {
                Text = report.QuestionTwoValueList[counter],
                Value = report.QuestionTwoValueCount[counter]
            };
            responses.Add(response);
            response = null;
        }
        return JsonConvert.SerializeObject(responses);
    }
}