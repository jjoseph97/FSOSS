using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_ViewReportFilter : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        // get id for verification here
        if(!IsPostBack)
        {
            Alert.Visible = false;
            ErrorAlert.Visible = false;
        }
        
    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        Filter filter = new Filter();
        if(StartingPeriodTextBox.Value != null)
        {
            filter.startingDate = DateTime.Parse(StartingPeriodTextBox.Value);
            if(EndingPeriodTexBox.Value != null)
            {
                filter.endDate = DateTime.Parse(EndingPeriodTexBox.Value);
                filter.siteID = int.Parse(HospitalDropDownList.SelectedValue);
                filter.mealID = int.Parse(MealDropDownList.SelectedValue);
                Session["filter"] = filter;
                Response.Redirect("~/Admin/ReportPage.aspx");
            }
            else
            {
                Alert.Text = "Please select starting period";
            }           
        }
        else
        {
            Alert.Text = "Please select ending period";
        }
     
     
     
        
    }

     
    protected class Filter
    {
         public DateTime startingDate { get; set; }
         public DateTime endDate { get; set; }
         public int siteID { get; set; }
         public int mealID { get; set; }
    }
}