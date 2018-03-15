﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Pages_AdministratorPages_MainPage" %>

<asp:Content ID="AdminMainPage" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card">
        <div class="col-sm-12 ml-12 mt-3">
            <asp:Label ID="WelcomeMessage" runat="server" Text="Welcome, " CssClass="h4" />
        </div>

        <div class="form-inline mx-auto my-3">
            <asp:Label ID="HospitalLabel" runat="server" AssociatedControlID="HospitalDDL" CssClass="col-sm-4" Text="Hospital: " />
            <asp:DropDownList ID="HospitalDDL" runat="server" CssClass="form-control col-sm-8" OnSelectedIndexChanged="HospitalDDL_SelectedIndexChanged" AutoPostBack="true" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID" />
        </div>

        <div class="col-sm-12 text-center">
            <asp:Label Text="The word of the day is:" runat="server" Font-Bold="true" />
            <asp:Label ID="WOTDLabel" runat="server" CssClass="h4" Font-Bold="true" />
        </div>

        <div id="PendingContactSection" runat="server" class="px-1 my-3 mx-auto">
            <div class="form-inline mx-auto my-3">
                <asp:Label ID="PendingRequestsLabel" runat="server" Text="Pending Contact Requests:" />
                <asp:Label ID="PendingRequestNumberLabel" runat="server" />
                <asp:Button ID="ViewButton" runat="server" Text="View" CssClass="btn " OnClick="ViewButton_Click" BackColor="#a6ebf7" />
            </div>
        </div>

        <hr />

        <div class="form-group mx-auto">
            <asp:Button ID="RecentSurveysButton" runat="server" Text="View Recent Surveys" CssClass="btn" OnClick="RecentSurveysButton_Click" BackColor="#223F88" Forecolor="white" />
        </div>

        <div class="form-group mx-auto">
            <asp:Button ID="RecentReportsButton" runat="server" Text="View Recent Reports" CssClass="btn" OnClick="RecentReportsButton_Click" BackColor="#223F88" Forecolor="white"/>
        </div>


    </div>



    <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SiteContactCountODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetContactRequestTotal" TypeName="FSOSS.System.BLL.SubmittedSurveyController">
        <SelectParameters>
            <asp:ControlParameter ControlID="HospitalDDL" PropertyName="SelectedValue" Name="siteID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
