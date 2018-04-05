using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_SubmittedSurveyList : System.Web.UI.Page
{
    public FilterPOCO filter = new FilterPOCO();

    protected void Page_Load(object sender, EventArgs e)
    {
        filter = (FilterPOCO)(Session["filter"]);
        if (filter == null)
        {
            Response.Redirect("ViewSurveyFilter.aspx");
        }
    }

    protected override void OnLoad(EventArgs e)
    {
        base.OnLoad(e);
        SubmittedSurveyController sysmgr = new SubmittedSurveyController();
        List<SubmittedSurveyPOCO> submittedSurveyData = sysmgr.GetSubmittedSurveyList(filter.siteID, filter.startingDate, filter.endDate, filter.mealID, filter.unitID);
        SubmittedSurveyList.DataSource = submittedSurveyData;
        SubmittedSurveyList.DataBind();
    }
}