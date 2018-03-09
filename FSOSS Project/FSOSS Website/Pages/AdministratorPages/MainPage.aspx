<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MainPage.aspx.cs" Inherits="Pages_AdministratorPages_MainPage" %>

<asp:Content ID="AdminMainPage" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="form-group row">
        <asp:Label ID="HospitalLabel" runat="server" AssociatedControlID="HospitalDDL" CssClass="col-sm-2 col-md-2 col-form-label" Text="Hospital: " />
        <div class="col-sm-10 col-md-4">
            <asp:DropDownList ID="HospitalDDL" runat="server" CssClass="form-control" AppendDataBoundItems="true" OnSelectedIndexChanged="HospitalDDL_SelectedIndexChanged" AutoPostBack="true" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID">
                
            </asp:DropDownList>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12 text-center">
            <b>The word of the day is: </b>
            <asp:Label ID="Placeholder" runat="server" />
        </div>
    </div>
    <div class="form-group row">
        <asp:Label ID="PendingRequestsLabel" runat="server" Text="Pending Contact Requests" />
        <asp:Label ID="PendingRequestNumberLabel" runat="server" CssClass="bg-dark text-white" />
        <asp:Button ID="ViewButton" runat="server" Text="View" CssClass="btn btn-primary" OnClick="ViewButton_Click" />
    </div>
    <div class="form-group row">
        <asp:Button ID="RecentSurveysButton" runat="server" Text="View Recent Surveys" CssClass="btn btn-primary" OnClick="RecentSurveysButton_Click" />
    </div>
    <div class="form-group row">
        <asp:Button ID="RecentReportsButton" runat="server" Text="View Recent Reports" CssClass="btn btn-primary" OnClick="RecentReportsButton_Click" />
    </div>

    <%-- Delete below --%>
    <div class="row">
        <asp:Label ID="message" runat="server" />
    </div>
    <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SiteContactCountODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetContactRequestTotal" TypeName="FSOSS.System.BLL.SubmittedSurveyController">
        <SelectParameters>
            <asp:ControlParameter ControlID="HospitalDDL" PropertyName="SelectedValue" Name="siteID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

