using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ManageCustomerProfile : System.Web.UI.Page
{
    static public bool seeArchive = false;
    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            seeArchive = false;
            AgeRanges.Visible = false;
            Meals.Visible = false;
            ParticipantTypes.Visible = false;
            Genders.Visible = true;
        }
        

    }


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
}