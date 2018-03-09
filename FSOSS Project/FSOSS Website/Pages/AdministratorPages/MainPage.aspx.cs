using FSOSS.System.BLL;
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
        message.Text = HttpContext.Current.Request.RawUrl.StartsWith("/Pages/AdministratorPages").ToString();

        
        if (Session["securityID"] == null || Session["securityID"].ToString() == "") // Redirect user to login if not logged in
        {
            Response.Redirect("~/Pages/AdministratorPages/Login.aspx");
        }
        else if (Session["securityID"].ToString() != "2") // Return HTTP Code 403 if security ID is not 2 (Master Administrator)
        {
            Context.Response.StatusCode = 403;
        }

        // this will need to change
        // TODO: Look up how to asynchronous pending requests
        if (!Page.IsPostBack)
        {
            Placeholder.Text = "sunshine";
            PendingRequestNumberLabel.Text = "16";
        }

        // below is how to handle query strings from URL
        // example: website.ca?bob=123
        // ? starts query
        // bob is identifier
        // 123 is the value of bob
        if (!String.IsNullOrEmpty(Request.QueryString["id"]))
        {
            string idtest = Convert.ToString(Request.QueryString["id"]);
            //message.Text = "The ID passed in was: " + idtest;
        }
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

        message.Text = Session["userID"].ToString();
    }

    protected void RecentReportsButton_Click(object sender, EventArgs e)
    {
        message.Text = "You clicked the \"View Recent Reports\" Button";

        AdministratorAccountController test = new AdministratorAccountController();
        message.Text = test.GetSecurityID(1).ToString();
        switch (Session["securityID"].ToString())
        {
            case "1":
                message.Text = "Standard Admin";
                break;
            case "2":
                message.Text = "Master Admin";
                break;

        }

    }
}