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

public partial class Pages_AdministratorPages_MasterAdministratorPages_ChangeSurveyWord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SearchWordButton_Click(object sender, EventArgs e)
    {

    }

    protected void AddWordButton_Click(object sender, EventArgs e)
    {
        PotentialSurveyWordController sysmgr = new PotentialSurveyWordController();
        PotentialSurveyWord potentialSurveyWord = new PotentialSurveyWord();
        Alert.Visible = true;
        Alert.Text = sysmgr.AddWord(AddWordTextBox.Text);
        SurveyWordListView.DataBind();
    }
}