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

    /// <summary>
    /// when the page loads, if it is the first time loading the page, the ListView1 is visible and the seeArchive boolean is set to false
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
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

    /// <summary>
    /// This method is required to use the MessageUserControl on the page in order to handle thrown exception messages for errors from the controller
    /// as well as info and success messages from the code behind.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
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

    /// <summary>
    /// when the view active/archive is clicked, this changes the chosen ods for all listviews to the other ods.
    /// if the archived ods is being used, then the active ods is set, and vice-versa.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
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

    /// <summary>
    /// An on-click method that adds a site to the database, adds assigns a new survey word to the site, and adds a "Not Applicable" unit associated with the new site.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
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

    /// <summary>
    /// This method changes the class of the DeleteButton so that when the listview is displaying active sites, the DeleteButton will have the class "btn-danger". If the listview is displaying archived sites, the DeleteButton will have the class "btn-success".
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Button disableBtn = (Button)e.Item.FindControl("DeleteButton");
            if(disableBtn != null)
            { 
                if (seeArchive)
                {
                    disableBtn.Attributes.Remove("btn btn btn-danger mx-3 my-1");
                    disableBtn.CssClass = "btn btn btn-success mx-3 my-1";
                }
                else
                {
                    disableBtn.Attributes.Remove("btn btn btn-success mx-3 my-1");
                    disableBtn.CssClass = "btn btn btn-danger mx-3 my-1";
                }
            }
        }
    }
}