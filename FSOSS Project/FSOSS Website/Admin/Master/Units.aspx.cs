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
    protected void Page_Load(object sender, EventArgs e)
    {
        SuccessAlert.Visible = false;
        ErrorAlert.Visible = false;

        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (Session["securityID"].ToString() != "2" && Session["securityID"].ToString() != "1") // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        SelectedSiteID.Text = SiteDropDownList.SelectedValue;
    }

    //protected void SearchUnitButton_Click(object sender, EventArgs e)
    //{
    //    UnitsListView.Visible = true;
    //    ArchivedButton.Visible = true;
    //    SelectedSiteID.Text = SiteDropDownList.SelectedValue;
    //}


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

    protected void ActiveButton_Click(object sender, EventArgs e)
    {
        UnitsListView.Visible = true;
        ArchivedUnitsListView.Visible = false;
        UnitsListView.DataBind();

        ArchivedButton.Visible= true;
        ActiveButton.Visible = false;


    }

    protected void ArchivedButton_Click(object sender, EventArgs e)
    {
        UnitsListView.Visible = false;
        ArchivedUnitsListView.Visible = true;
        ArchivedUnitsListView.DataBind();

        ActiveButton.Visible = true;
        ArchivedButton.Visible = false;

    }

    protected void SiteDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        string value = SiteDropDownList.SelectedValue;
        int site_id = Convert.ToInt32(value);

        UnitsListView.Visible = true;
        ArchivedButton.Visible = true;
        ArchivedUnitsListView.DataBind();
        UnitsListView.DataBind();
    }
}