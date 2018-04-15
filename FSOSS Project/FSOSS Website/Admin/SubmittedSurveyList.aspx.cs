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
    // This is for the filter session data that is passed from the previous page, in order to populate the ListView
    public FilterPOCO filter = new FilterPOCO();

    /// <summary>
    /// When the page loads first the page checks if the user has proper authentication to access this page, and is redirected to login if not.
    /// Following that, the filter session data is brought in from the previous page and the page checks to see if the filter is null. 
    /// If the filter is null then the user is redirected back to the previous page to prevent browsing to this page directly with no data.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        filter = (FilterPOCO)(Session["filter"]);
        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if ((int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        else if (!IsPostBack)
        { 
            if (filter == null) // check and redirect to the previous page if the filter is null
            {
                Response.Redirect("ViewSurveyFilter.aspx");
            }
        }
    }

    /// <summary>
    /// This method is to pull the data from filter and populate the ListView. The reason for Page_PreRender is to set the datasource and bind once to avoid error when the page loads.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_PreRender(object sender, EventArgs e)
    {
        SubmittedSurveyController sysmgr = new SubmittedSurveyController();
        List<SubmittedSurveyPOCO> submittedSurveyData = sysmgr.GetSubmittedSurveyList(filter.siteID, filter.startingDate, filter.endDate, filter.mealID, filter.unitID); // get the list of submitted surveys with the filter data
        SubmittedSurveyList.DataSource = submittedSurveyData; // set the ListView with the filterd submitted survey list data
        SubmittedSurveyList.DataBind(); // rebind the ListView
    }
}