using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
#region
using System.Text.RegularExpressions;
using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;
using FSOSS.System.Data;
using FSOSS.System.Data.Entity;
#endregion

public partial class Pages_AdministratorPages_MasterAdministratorPages_UnitsCrud : System.Web.UI.Page
{
    static private bool seeArchive = false;

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (Session["securityID"].ToString() != "2" && Session["securityID"].ToString() != "1") // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }


        // Catches the initial site ID when the page loads from the SideDropDownList and displays Active units Listview for that site.
        if (!IsPostBack)
        {
            seeArchive = false;
            SiteDropDownList.DataBind();
            

            SelectedSiteID.Text = SiteDropDownList.SelectedValue;

            if (SelectedSiteID == null)
            {
                throw new Exception("Select an existsing Site");
            }
            else
            {
                UnitsListView.Visible = true;
                UnitsListView.DataBind();
            }
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
    /// This method catches the the value of the site dropdownlist when changed 
    /// and displays the active units for that site. 
    /// <summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void SiteDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {

        SelectedSiteID.Text = SiteDropDownList.SelectedValue;

        UnitsListView.Visible = true;
        ArchivedUnitsListView.DataBind();
        UnitsListView.DataBind();
    }
    /// <summary>
    /// This button on click method is for adding a new unit to the selected site in the database. 
    /// <summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>

    protected void AddUnitButton_Click(object sender, EventArgs e)
    {
        int siteId = int.Parse(SelectedSiteID.Text);
        int userId = (int)Session["userID"];
        string unitNumber = AddUnitTextBox.Text.Trim();
        UnitController sysmgr = new UnitController();
        MessageUserControl.TryRun(() =>
        {
            sysmgr.AddUnit(unitNumber, userId, siteId);
            UnitsListView.DataBind();
            AddUnitTextBox.Text = "";

        }, "Success", "Successfully added the new unit: \"" + unitNumber + "\"");
    }

    protected void ToggleView(object sender, EventArgs e)
    {
        if (seeArchive)
        {
            seeArchive = false;
            UnitsListView.Visible = true;
            UnitsListView.DataBind();
            ArchivedUnitsListView.Visible = false;

            RevealButton.Text = "Show Archived";

        }
        else
        {
            seeArchive = true;
            ArchivedUnitsListView.Visible = true;
            ArchivedUnitsListView.DataBind();
            UnitsListView.Visible = false;

            RevealButton.Text = "Show Active";

        }
    }
}