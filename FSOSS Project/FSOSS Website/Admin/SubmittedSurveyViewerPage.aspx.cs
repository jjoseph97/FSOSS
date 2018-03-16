using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_SubmittedSurveyViewerPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string ssn = Request.QueryString["field"];
        SubSurveyNumLabel.Text = ssn;

        


    }

    protected void ResolveButton_Click(object sender, EventArgs e)
    {

    }

    protected void UnresolveButton_Click(object sender, EventArgs e)
    {

    }

    protected void BackToSurveyListButton_Click(object sender, EventArgs e)
    {

    }
}