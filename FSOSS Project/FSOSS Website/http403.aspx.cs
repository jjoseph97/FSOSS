using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class http403 : System.Web.UI.Page
{
    /// <summary>
    /// This method is used during the start of the web page. The method will hide all navigation links.
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        Master.FindControl("FSOSSNavbar").Visible = false;
        Master.FindControl("hamburger").Visible = false;
        Master.FindControl("LogoLink").Visible = false;
    }
}