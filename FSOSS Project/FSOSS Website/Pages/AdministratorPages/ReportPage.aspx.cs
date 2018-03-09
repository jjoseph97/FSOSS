using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_ReportPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Alert.Visible = true;
        Filter filter = (Filter)(Session["filter"]);
        if(filter != null)
        {
            Alert.Text = "It has value";
        }
        else
        {
            Alert.Text = "It has no value";
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