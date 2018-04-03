using FSOSS.System.BLL;
using FSOSS.System.Data.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pages_AdministratorPages_MasterAdministratorPages_Site : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Alert.Visible = false;
        ErrorAlert.Visible = false;


        if (Session["securityID"] == null) // Redirect user to login if not logged in
        {
            Response.Redirect("~/Admin/Login.aspx");
        }
        else if (Session["securityID"].ToString() != "2" && Session["securityID"].ToString() != "1") // Return HTTP Code 403
        {
            Context.Response.StatusCode = 403;
        } else
        {
            ListView1.Visible = true;
            ArchivedListView.Visible = false;
            ListView1.DataBind();

            ShowActiveButton.Visible = false;
            ShowArchivedButton.Visible = true;
        }

        if (!IsPostBack)
        {
            ListView1.DataBind();
            ArchivedListView.DataBind();
        }
    }

    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ShowArchivedButton_Click(object sender, EventArgs e)
    {
        ListView1.Visible = false;
        ArchivedListView.Visible = true;
        ArchivedListView.DataBind();

        ShowActiveButton.Visible = true;
        ShowArchivedButton.Visible = false;

    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void ShowActiveButton_Click(object sender, EventArgs e)
    {
        ListView1.Visible = true;
        ArchivedListView.Visible = false;
        ListView1.DataBind(); 

        ShowActiveButton.Visible = false;
        ShowArchivedButton.Visible = true;
    }

    protected void SearchSite_Click(object sender, EventArgs e)
    {

    }

    protected void AddSite_Click(object sender, EventArgs e)
    {
        SiteController sysmgr = new SiteController();
        SurveyWordController swControl = new SurveyWordController();
        UnitController unControl = new UnitController();

        string siteName = AddSiteTextBox.Text.Trim();
        Regex validWord = new Regex("^[a-zA-Z ]+$");
        int employee = int.Parse(Session["userid"].ToString());

        if (siteName == "" || siteName == null)
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Error: Please enter a site name. Field cannot be empty.";
        }
        else if (!validWord.IsMatch(siteName))
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Error: Please enter only alphabetical letters.";
        }
        else
        {
            Alert.Visible = true;
            Alert.Text = sysmgr.AddSite(siteName, employee); // adds the site to the database

            swControl.NewSite_NewWord(siteName);
            //unControl.NewSite_NewUnit(siteName); 

            ListView1.DataBind();
            AddSiteTextBox.Text = "";
        }
    }

    //protected void UpdateButton_Click(object sender,  EventArgs e)
    //{
    //    int siteid = int.Parse((ListView1.EditItem.FindControl("SiteIdLabel") as Label).Text);
    //    string siteName = ((ListView1.EditItem.FindControl("siteNameTextBox") as TextBox).Text);
    //    int employee = int.Parse(Session["userid"].ToString());

    //    SiteController sysmgr = new SiteController();
    //    sysmgr.UpdateSite(siteid, siteName, employee);
    //    ListView1.DataBind();
        
        
    //}

    //protected void Delete_Click(object sender, EventArgs e)
    //{
    //    int siteid = int.Parse((ListView1.EditItem.FindControl("SiteIdLabel") as Label).Text);

    //    SiteController sysmgr = new SiteController();
    //    sysmgr.DisableSite(siteid);
    //    ListView1.DataBind();
    //}
}