﻿using System;
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
            
        }
    }

    protected void SearchSite_Click(object sender, EventArgs e)
    {

    }

    protected void AddSite_Click(object sender, EventArgs e)
    {
        string siteName = AddSiteTextBox.Text.Trim();
        Regex validWord = new Regex("^[a-zA-Z]+$");
        string employee = User.Identity.Name;

        if (siteName == "" || siteName == null)
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Error: Please enter a site name. Field cannot be empty.";
        }
        else if (!validWord.IsMatch(siteName))
        {
            ErrorAlert.Visible = true;
            ErrorAlert.Text = "Error: Please enter only alphabetical letters and no spaces.";
        }
        else
        {
            Alert.Visible = true;
            Alert.Text = sysmgr.AddSite(siteName, );
            ListView1.DataBind();
            AddSiteTextBox.Text = "";
        }
    }
}