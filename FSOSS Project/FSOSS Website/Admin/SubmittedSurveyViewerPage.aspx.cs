using FSOSS.System.BLL;
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

        string ssn = Request.QueryString["sid"];
        SubSurveyNumLabel.Text = ssn;
        int surveyNum = Convert.ToInt32(ssn);

        SubmittedSurveyController ssc = new SubmittedSurveyController();
        if (ssc.wantsContact(surveyNum))
        {
            ContactResolve.Visible = true;
        }
        else
        {

            ContactResolve.Visible = false;
        }

    }

    protected void ResolveButton_Click(object sender, EventArgs e)
    {
        
        string ssn = Request.QueryString["sid"];
        SubSurveyNumLabel.Text = ssn;
        int surveyNum = Convert.ToInt32(ssn);
        SubmittedSurveyController ssc = new SubmittedSurveyController();
        ssc.contactSurvey(surveyNum);
        
        ContactResolve.Visible = false;
        SubSurveyList.DataBind();
    }

    protected void UnresolveButton_Click(object sender, EventArgs e)
    {

    }

    protected void BackToSurveyListButton_Click(object sender, EventArgs e)
    {

    }
}