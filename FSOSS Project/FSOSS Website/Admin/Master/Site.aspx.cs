using FSOSS.System.BLL;
using FSOSS.System.Data.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_MasterAdministratorPages_Site : System.Web.UI.Page
{
    static public bool seeArchive = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if ((int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }

        if (!IsPostBack)
        {
            ListView1.Visible = true;
            ListView1.DataBind();
            seeArchive = false;
        }
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        // if an exception was thrown, handle with messageusercontrol to display the exception for error
        if (e.ReturnValue == null)
        {
            MessageUserControl.HandleDataBoundException(e);
        }
        else // else show the ReturnValue(success message) as a string to display to the user 
        {
            string successMessage = e.ReturnValue.ToString();
            MessageUserControl.TryRun(() =>
            {
            }, "Success", successMessage);
        }
    }

    protected void ToggleView(object sender, EventArgs e)
    {
        if (seeArchive)
        {
            seeArchive = false;

            ListView1.DataSourceID = "SiteODS";
            ListView1.DataBind();
            RevealButton.Text = "Show Archived";
        }
        else
        {
            seeArchive = true;
            ListView1.DataSourceID = "ArchivedODS";
            ListView1.DataBind();
            RevealButton.Text = "Show Active";
        }
    }

    protected void AddSite_Click(object sender, EventArgs e)
    {
        SiteController sysmgr = new SiteController();
        SurveyWordController swControl = new SurveyWordController();
        UnitController unControl = new UnitController();

        string siteName = AddSiteTextBox.Text.Trim();
        int employee = int.Parse(Session["userid"].ToString());

        MessageUserControl.TryRun(() =>
        {
            sysmgr.AddSite(siteName, employee); // adds the site to the database
            swControl.NewSite_NewWord(siteName); // assigns a survey word to the site
            unControl.NewSite_NewUnit(siteName, employee); // adds the Not Applicable Unit option to the site

            ListView1.DataBind();
            AddSiteTextBox.Text = "";
        }, "Success", "Successfully added the new site: \"" + siteName + "\"");
    }
}