using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_MainPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // this will need to change
        // TODO: Look up how to asynchronous pending requests

        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            string idtest = Convert.ToString(Request.QueryString["id"]);
            //message.Text = "The ID passed in was: " + idtest;
        }

        if (!Page.IsPostBack)
        {
            Placeholder.Text = "sunshine";
            PendingRequestNumberLabel.Text = "16";
        }

        message.Text = Session["username"].ToString();

    }

    protected void HospitalDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        // This will need to change
        if (HospitalDDL.SelectedValue == "1")
        {
            Placeholder.Text = "sunshine";
            PendingRequestNumberLabel.Text = "16";
        }
        else if (HospitalDDL.SelectedValue == "2")
        {
            Placeholder.Text = "dog";
            PendingRequestNumberLabel.Text = "5";
        }
        else
        {
            Placeholder.Text = "null";
            PendingRequestNumberLabel.Text = "null";
        }
    }

    protected void ViewButton_Click(object sender, EventArgs e)
    {
        message.Text = "You clicked the \"View\" Button";

    }

    protected void RecentSurveysButton_Click(object sender, EventArgs e)
    {
        message.Text = "You clicked the \"View Recent Surveys\" Button";
    }

    protected void RecentReportsButton_Click(object sender, EventArgs e)
    {
        message.Text = "You clicked the \"View Recent Reports\" Button";
    }
}