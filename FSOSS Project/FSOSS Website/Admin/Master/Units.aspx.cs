﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
#region
using System.Text.RegularExpressions;
using FSOSS.System.BLL;
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

    }

    protected void SearchUnitButton_Click(object sender, EventArgs e)
    {
        UnitsListView.Visible = true;
        DisplayArchivedButton.Visible = true;

    }



    protected void DisplayActiveButton_Click(object sender, EventArgs e)
    {

        UnitsListView.Visible = false;
        //ArchivedUnitsListView.Visible = true;
        //ArchivedUnitsListView.DataBind();

        DisplayActiveButton.Visible = false;
        DisplayArchivedButton.Visible = true;

    }

    protected void DisplayArchivedButton_Click(object sender, EventArgs e)
    {
        UnitsListView.Visible = true;
        //ArchivedUnitsListView.Visible = false;
        UnitsListView.DataBind();
        DisplayActiveButton.Visible = true;
        DisplayArchivedButton.Visible = false;
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
}