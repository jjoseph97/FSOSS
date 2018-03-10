using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ViewSurveyFilter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        // just a placeholder link for now, will be changed later
        Response.Redirect("SubmittedSurveyList.aspx");
    }
}