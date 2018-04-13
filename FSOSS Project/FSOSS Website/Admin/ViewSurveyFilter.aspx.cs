using FSOSS.System.BLL;
using FSOSS.System.Data.POCOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ViewSurveyFilter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // this is for the client side input values to be retained after the page loads when a validation error is triggered (so the text is not lost)
        string startingPeriodInput = Request.Form["StartingPeriodInput"];
        string endingPeriodInput = Request.Form["EndingPeriodInput"];
        this.startingInputValue = startingPeriodInput;
        this.endingInputValue = endingPeriodInput;

        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if ((int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }
        else if (!IsPostBack) // this is for loading the dropdown lists on the page with the data from the database
        {
            SiteController siteController = new SiteController();
            List<SitePOCO> siteList = siteController.GetSiteList(); // get sites for the sites drop down list
            HospitalDropDownList.DataSource = siteList;
            HospitalDropDownList.DataValueField = "siteID";
            HospitalDropDownList.DataTextField = "siteName";
            HospitalDropDownList.DataBind();
            MealController mealController = new MealController();
            List<MealPOCO> mealList = mealController.GetMealList(); // get meals for the meals drop down list
            MealDropDownList.DataSource = mealList;
            MealDropDownList.DataValueField = "mealID";
            MealDropDownList.DataTextField = "mealName";
            MealDropDownList.DataBind();
        }
    }

    protected string startingInputValue { get; set; } // this is in order to get and set the starting date input text on page reload
    protected string endingInputValue { get; set; } // this is in order to get and set the end date input text on page reload

    /// <summary>
    /// This method is required to use the MessageUserControl on the page in order to handle thrown exception messages for errors from the controller
    /// as well as info and success messages from the code behind.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        // if an exception was thrown, handle with messageusercontrol to display the exception for error
        MessageUserControl.HandleDataBoundException(e);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ViewButton_Click(object sender, EventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            FilterPOCO filter = new FilterPOCO();
            string startingPeriodInput = Request.Form["StartingPeriodInput"];
            string endingPeriodInput = Request.Form["EndingPeriodInput"];
            if (startingPeriodInput != "")
            {
                filter.startingDate = DateTime.ParseExact(startingPeriodInput + " 00:00:00:000000", "yyyy-MM-dd HH:mm:ss:ffffff", null);
                if (endingPeriodInput != "")
                {
                    filter.endDate = DateTime.ParseExact(endingPeriodInput + " 23:59:59:000000", "yyyy-MM-dd HH:mm:ss:ffffff", null);
                    filter.siteID = int.Parse(HospitalDropDownList.SelectedValue);
                    filter.mealID = int.Parse(MealDropDownList.SelectedValue);
                    if (UnitDropDownList.Enabled == false)
                    {
                        filter.unitID = 0;
                    }
                    else
                    {
                        filter.unitID = int.Parse(UnitDropDownList.SelectedValue);
                    }
                    Session["filter"] = filter;
                    Response.Redirect("SubmittedSurveyList.aspx");
                }
                else
                {
                    
                    throw new Exception("Please select an ending period");
                }
            }
            else
            {
                
                throw new Exception("Please select a starting period");
                
            }
        }, "Success", "Redirecting to the survey list page.");
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void HospitalDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        // if the site drop down list has changed (not all hospitals but a particular one) then retrieve the units from the database and populate the unit drop odwn list
        if (HospitalDropDownList.SelectedIndex != 0) 
        {
            UnitLabel.Visible = true;
            UnitDropDownList.Visible = true;
            UnitDropDownList.Enabled = true;
            UnitController unitController = new UnitController();
            int selectedSiteID = int.Parse(HospitalDropDownList.SelectedValue);
            List<UnitsPOCO> unitList = unitController.GetUnitList(selectedSiteID);
            UnitDropDownList.DataSource = unitList;
            UnitDropDownList.DataValueField = "unitID";
            UnitDropDownList.DataTextField = "unitNumber";
            UnitDropDownList.DataBind();
        }
        else // else, if no hospital has been selected (all hospitals) hide the unit drop down and do not populate the datasource
        {
            UnitDropDownList.AppendDataBoundItems = false;
            UnitDropDownList.DataSource = "";
            UnitDropDownList.DataBind();
            UnitLabel.Visible = false;
            UnitDropDownList.Visible = false;
            UnitDropDownList.Enabled = false;
        }
    }
}