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
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_AdministratorPages_ReportPage : System.Web.UI.Page
{

    public FilterPOCO filter = new FilterPOCO();

    protected void Page_Load(object sender, EventArgs e)
    {
        Alert.Visible = false;
        filter = (FilterPOCO)(Session["filter"]);
        if(filter == null)
        {
          Response.Redirect("~/Admin/ViewReportFilter.aspx");
        }
        
        
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        ReportController sysmgr = new ReportController();
        List<SubmittedSurvey> finalReportDTO = sysmgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
        // Test if theres any data
        if (finalReportDTO != null)
        {
            Alert.Visible = true;
            Alert.Text = "Theres a value";
            ReportCountDummy.Text = finalReportDTO.Count().ToString();
            ReportValues.Text = finalReportDTO.Select(a => a.meal_id).FirstOrDefault().ToString();
        }
        else
        {
            Alert.Visible = true;
            Alert.Text = "Theres no value";
        }
    }
}