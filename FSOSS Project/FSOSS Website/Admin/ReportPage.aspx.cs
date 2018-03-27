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
using System.Web.Services;
#endregion

public partial class Pages_AdministratorPages_ReportPage : System.Web.UI.Page
{

    public FilterPOCO filter = new FilterPOCO();
    public FinalReportPOCO finalReport = new FinalReportPOCO();
    protected void Page_Load(object sender, EventArgs e)
    {
        Alert.Visible = false;
        filter = (FilterPOCO)(Session["filter"]);
        if(filter == null)
        {
          Response.Redirect("~/Admin/ViewReportFilter.aspx");
        }
        else
        {
            ReportController sysmgr = new ReportController();
            finalReport = sysmgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
            Page.ClientScript.RegisterStartupScript(Page.GetType(), "PieGraphFunction", "DrawChart", true);
        }
        
        
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        ReportController sysmgr = new ReportController();
        finalReport = sysmgr.GenerateOverAllReport(filter.startingDate, filter.endDate, filter.siteID, filter.mealID);
        // Test if theres any data
        if (finalReport != null)
        {
           
          
        }
        else
        {
            Alert.Visible = true;
            Alert.Text = "Theres no value";
        }
    }
}