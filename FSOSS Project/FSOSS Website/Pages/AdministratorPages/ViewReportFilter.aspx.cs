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

    }

    protected void StartingPeriodCalendar_SelectionChanged(object sender, EventArgs e)
    {
       // StartingPeriodTextBoxID.Text =  StartingPeriodCalendar.SelectedDate.ToString("MMMM dd, yyyy");
    }

    protected void EndingPeriodCalendar_SelectionChanged(object sender, EventArgs e)
    {
        
        // EndingPeriodTexBoxID.Text = EndingPeriodCalendar.SelectedDate.ToString("MMMM dd, yyyy");
    }



    protected void ViewButtonID_Click(object sender, EventArgs e)
    {
        
    }
}