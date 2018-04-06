using System;
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

        //if (Session["securityID"] == null) // Redirect user to login if not logged in
        //{
        //    Response.Redirect("~/Admin/Login.aspx");
        //}
        //else if (Session["securityID"].ToString() != "2" && Session["securityID"].ToString() != "1") // Return HTTP Code 403
        //{
        //    Context.Response.StatusCode = 403;
        //}

    }

    protected void SearchUnitButton_Click(object sender, EventArgs e)
    {
       

    }



    protected void DisplayActiveButton_Click(object sender, EventArgs e)
    {


        DisplayActiveButton.Visible = false;
        DisplayArchivedButton.Visible = true;

    }

    protected void DisplayArchivedButton_Click(object sender, EventArgs e)
    {
        DisplayActiveButton.Visible = true;
        DisplayArchivedButton.Visible = false;
    }

   
}