<%@ Page Title="Administrator Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Pages_AdministratorPages_MainPage" %>

<asp:Content ID="AdminMainPage" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="card">
        <div class="col-sm-12 col-md-8 mx-auto mt-3" >
            <asp:Label ID="WelcomeMessage" runat="server" CssClass="h2 offset-3" />
        </div>

        <div class="row col-md-8 mx-auto my-3">
            <asp:Label ID="HospitalLabel" runat="server" AssociatedControlID="HospitalDDL" CssClass="my-auto pl-0 col-sm-1 col-md-1 offset-sm-3" Text="Site: " />
            <asp:DropDownList ID="HospitalDDL" runat="server" CssClass="form-control col-sm-8 col-md-5 pl-0" OnSelectedIndexChanged="HospitalDDL_SelectedIndexChanged" AutoPostBack="true" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID" />
        </div>

        <div class="col-sm-12 col-md-8 offset-4 px-2">
            <asp:Label Text="The word of the day is:" runat="server" />
            <asp:Label ID="WOTDLabel" runat="server" CssClass="h4 mx-auto" Font-Bold="true" ForeColor="#223f88" />
        </div>

        <div id="PendingContactSection" runat="server" class="mt-3 mx-auto my-3 col-md-12">
            <div class="form-inline col-md-4 mx-auto my-3 px-1">
                <asp:Label ID="PendingRequestsLabel" runat="server" Text="Pending Contact Requests:" />
                <asp:Label ID="PendingRequestNumberLabel" runat="server" CssClass="h4" />
                <asp:Button ID="ViewButton" runat="server" Text="View" CssClass="btn btn-secondary" OnClick="ViewButton_Click" />
            </div>
        </div>

        <div class="form-inline mx-auto">
            <div class="col-md-6 mb-2">
                <asp:Button ID="RecentSurveysButton" runat="server" Text="View Recent Surveys" CssClass="btn btn-block" OnClick="RecentSurveysButton_Click" BackColor="#223F88" ForeColor="white" />
            </div>

            <div class="col-md-6 mb-2">
                <asp:Button ID="RecentReportsButton" runat="server" Text="View Recent Reports" CssClass="btn btn-block" OnClick="RecentReportsButton_Click" BackColor="#223F88" ForeColor="white" />
            </div>
        </div>


    </div>



    <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SiteContactCountODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetContactRequestTotal" TypeName="FSOSS.System.BLL.SubmittedSurveyController">
        <SelectParameters>
            <asp:ControlParameter ControlID="HospitalDDL" PropertyName="SelectedValue" Name="siteID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

