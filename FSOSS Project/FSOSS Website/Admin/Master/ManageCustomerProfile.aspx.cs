using FSOSS.System.BLL;
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
        else if ((int)Session["securityID"] != 2) // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        }

        //set the viewable lists, and set to view active options
        if (!IsPostBack)
        {
            seeArchive = false;
            AgeRanges.Visible = true;
            AddAgeRange.Visible = true;
            Meals.Visible = false;
            AddMeal.Visible = false;
            ParticipantTypes.Visible = false;
            AddPT.Visible = false;
            Genders.Visible = false;
            AddGender.Visible = false;
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

            GenderListView.DataSourceID = "GenderODS";
            GenderListView.DataBind();

            MealsListView.DataSourceID = "MealsODS";
            MealsListView.DataBind();

            AgeRangeListView.DataSourceID = "AgeRangeODS";
            AgeRangeListView.DataBind();

            RevealButton.Text = "Show Archived";

        }
        else
        {
            seeArchive = true;
            PTListview.DataSourceID = "ArchivedPTODS";
            PTListview.DataBind();

            GenderListView.DataSourceID = "ArchivedGenderODS";
            GenderListView.DataBind();

            MealsListView.DataSourceID = "ArchivedMealsODS";
            MealsListView.DataBind();

            AgeRangeListView.DataSourceID = "ArchivedAgeRangeODS";
            AgeRangeListView.DataBind();

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
        //1 is Gender
        if (selection == "1")
        {
            AgeRanges.Visible = false;
            AddAgeRange.Visible = false;
            Meals.Visible = false;
            AddMeal.Visible = false;
            ParticipantTypes.Visible = false;
            AddPT.Visible = false;
            Genders.Visible = true;
            AddGender.Visible = true;
        }
        //2 is Participant Type
        else if (selection == "2")
        {
            AgeRanges.Visible = false;
            AddAgeRange.Visible = false;
            Meals.Visible = false;
            AddMeal.Visible = false;
            ParticipantTypes.Visible = true;
            AddPT.Visible = true;
            Genders.Visible = false;
            AddGender.Visible = false;
        }
        //3 is Meal
        else if (selection == "3")
        {
            AgeRanges.Visible = false;
            AddAgeRange.Visible = false;
            Meals.Visible = true;
            AddMeal.Visible = true;
            ParticipantTypes.Visible = false;
            AddPT.Visible = false;
            Genders.Visible = false;
            AddGender.Visible = false;
        }
        //0 is Age Range, and if the selection is somehow none of those, we still set it to Age Range
        else
        {
            AgeRanges.Visible = true;
            AddAgeRange.Visible = true;
            Meals.Visible = false;
            AddMeal.Visible = false;
            ParticipantTypes.Visible = false;
            AddPT.Visible = false;
            Genders.Visible = false;
            AddGender.Visible = false;
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
        int userID = Convert.ToInt32(Session["adminID"]);

        MessageUserControl.TryRun(() =>
        {
            ParticipantController sysmgr = new ParticipantController();

            sysmgr.AddParticipantType(ptDesc, userID);
            PTListview.DataBind();
            AddPTBox.Text = "";

        }, "Success", "Successfully added the new participant type: \"" + ptDesc + "\"");
    }

    /// <summary>
    /// This button on click method is for adding a new Gender to the database.
    /// Added April 12. Modification of Gender's Add method.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddGenderButton_Click(object sender, EventArgs e)
    {
        //finding the customer profile choice to display
        string addItem = AddGenderBox.Text.Trim();
        int userID = Convert.ToInt32(Session["adminID"]);

        MessageUserControl.TryRun(() =>
        {
            GenderController sysmgr = new GenderController();

            sysmgr.AddGender(addItem, userID);
            GenderListView.DataBind();
            AddGenderBox.Text = "";

        }, "Success", "Successfully added the new gender: \"" + addItem + "\"");
    }

    /// <summary>
    /// This button on click method is for adding a new Meal to the database.
    /// Added April 13. Modification of Meal's Add method.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddMealButton_Click(object sender, EventArgs e)
    {
        //finding the customer profile choice to display
        string addItem = AddMealsTextBox.Text.Trim();
        int userID = Convert.ToInt32(Session["adminID"]);

        MessageUserControl.TryRun(() =>
        {
            MealController sysmgr = new MealController();

            sysmgr.AddMeal(addItem, userID);
            MealsListView.DataBind();
            AddMealsTextBox.Text = "";

        }, "Success", "Successfully added the new meal: \"" + addItem + "\"");
    }

    /// <summary>
    /// This button on click method is for adding a new Age Range to the database.
    /// Added April 13. Modification of Age Range's Add method.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void AddARButton_Click(object sender, EventArgs e)
    {
        //finding the customer profile choice to display
        string addItem = AddAgeRangeTextBox.Text.Trim();
        int userID = Convert.ToInt32(Session["adminID"]);

        MessageUserControl.TryRun(() =>
        {
            AgeRangeController sysmgr = new AgeRangeController();

            sysmgr.AddAgeRange(addItem, userID);
            AgeRangeListView.DataBind();
            AddAgeRangeTextBox.Text = "";

        }, "Success", "Successfully added the new age range: \"" + addItem + "\"");
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
    /// This method changes the class of the DeleteButton so that when the listview is displaying active sites, the DeleteButton will have the class "btn-danger". If the listview is displaying archived sites, the DeleteButton will have the class "btn-success"
    /// </summary>
    /// <param name="sender">Contains a reference to the control/object that raised the event.</param>
    /// <param name="e">Contains the event data.</param>
    protected void ListView_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Button disableBtn = (Button)e.Item.FindControl("DeleteButton");

            if (disableBtn != null)
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

