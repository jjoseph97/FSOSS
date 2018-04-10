﻿using FSOSS.System.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ManageCustomerProfile : System.Web.UI.Page
{
    static public bool seeArchive = false;

    
    /// <summary>
    /// when the page loads, if it is the first time loading the page, the gender list is set to viewable, and 
    ///only active options are visible.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if ((int)Session["securityID"] != 2 ) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        //set the viewable lists, and set to view active options
        else if (!IsPostBack)
        {
            seeArchive = false;
            AgeRanges.Visible = false;
            Meals.Visible = false;
            ParticipantTypes.Visible = false;
            Genders.Visible = true;
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
            PTListview.DataSourceID = "PTODS";
            PTListview.DataBind();
            RevealButton.Text = "Show Archived";
           
        }
        else
        {
            seeArchive = true;
            PTListview.DataSourceID = "ArchivedPTODS";
            PTListview.DataBind();
            RevealButton.Text = "Show Active";
            
        }
    }

    /// <summary>
    /// changes the viewable listview for the newly selected category.
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CustomerProfileDDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        //finding the customer profile choice to display
        String selection = CustomerProfileDropDownList.SelectedValue;
        //selected.InnerText = selection;
        //1 is Age Range
        if (selection == "1")
        {
            AgeRanges.Visible = true;
            Meals.Visible = false;
            ParticipantTypes.Visible = false;
            Genders.Visible = false;
        }
        //2 is Participant Type
        else if (selection == "2")
        {
            AgeRanges.Visible = false;
            Meals.Visible = false;
            ParticipantTypes.Visible = true;
            Genders.Visible = false;
        }
        //3 is Meal
        else if (selection == "3")
        {
            AgeRanges.Visible = false;
            Meals.Visible = true;
            ParticipantTypes.Visible = false;
            Genders.Visible = false;
        }
        //0 is Gender, and if the selection is somehow none of those, we still set it to Gender
        else
        {
            AgeRanges.Visible = false;
            Meals.Visible = false;
            ParticipantTypes.Visible = false;
            Genders.Visible = true;
        }
    }




    /// <summary>
    /// This button on click method is for adding a new Participant Type to the database.
    /// Added April 10. Modification of Potential SUrvey Word's Add method.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddPTButton_Click(object sender, EventArgs e)
    {
        string ptDesc = AddPTBox.Text.Trim();
        int userID = Convert.ToInt32(Session["userID"]);

        MessageUserControl.TryRun(() =>
        {
            ParticipantController sysmgr = new ParticipantController();

            sysmgr.AddParticipantType(ptDesc, userID);
            PTListview.DataBind();
            AddPTBox.Text = "";

        }, "Success", "Successfully added the new participant type: \"" + ptDesc + "\"");
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