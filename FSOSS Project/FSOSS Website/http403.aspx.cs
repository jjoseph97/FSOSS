using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class http403 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var fsossnavbar = Master.FindControl("FSOSSNavbar");
        var hamburger = Master.FindControl("hamburger");
        fsossnavbar.Visible = false;
        hamburger.Visible = false;
    }
}