using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DummyResults : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DateLabel.Text = DateTime.Now.ToString();
        SelectedUnitLabel.Text = Session["Unit"].ToString();
        SelectedParticipantTypeLabel.Text = Session["ParticipantType"].ToString();
        SelectedMealTypeLabel.Text = Session["MealType"].ToString();

        SelectedQ1ALabel.Text = Session["Q1A"].ToString();
        SelectedQ1BLabel.Text = Session["Q1B"].ToString();
        SelectedQ1CLabel.Text = Session["Q1C"].ToString();
        SelectedQ1DLabel.Text = Session["Q1D"].ToString();
        SelectedQ1ELabel.Text = Session["Q1E"].ToString();



    }
}