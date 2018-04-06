using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
#region
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
    }

    protected void SearchUnitButton_Click(object sender, EventArgs e)
    {
       

    }



    protected void DisplayActiveButton_Click(object sender, EventArgs e)
    {

    }

    protected void DisplayArchivedButton_Click(object sender, EventArgs e)
    {

    }
}