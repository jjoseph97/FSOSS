using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Thankyou : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["takingSurvey"] == null
            && Session["Unit"] == null
            && Session["MealType"] == null
            && Session["ParticipantType"] == null
            && Session["Q4"] == null)
        {
            Response.Redirect("~/");
        }
    }
}