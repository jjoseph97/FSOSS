<%@ Page Title="Administrator Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Pages_AdministratorPages_MainPage" %>

<asp:Content ID="AdminMainPage" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row border rounded">
        <div class="col-sm-12 col-md-8 mx-auto mt-3 px-0">
            <asp:Label ID="WelcomeMessage" runat="server" CssClass="h2 offset-md-3" />
        </div>

        <div class="row col-12 mx-auto my-3 px-0">
            <asp:Label ID="HospitalLabel" runat="server" AssociatedControlID="HospitalDDL" CssClass="my-auto px-0 col-1 col-md-1 offset-md-4" Text="Site: " />
            <asp:DropDownList ID="HospitalDDL" runat="server" CssClass="form-control col-11 col-md-3 px-0" OnSelectedIndexChanged="HospitalDDL_SelectedIndexChanged" AutoPostBack="true" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID" />
        </div>

        <asp:Panel ID="WOTDSection" runat="server" CssClass="col-sm-12 col-md-4 offset-md-4 px-0">
            <asp:UpdatePanel ID="UpdateWOTDSection" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Label Text="Survey word:" runat="server" />
                    <asp:Label ID="WOTDLabel" runat="server" CssClass="h4 pl-1 mx-auto" Font-Bold="true" ForeColor="#223f88" />
                    <asp:Button ID="GenereteWordButton" runat="server" Text="Generate Word" CssClass="btn btn-secondary float-right" OnClick="GenereteWordButton_Click" OnClientClick="return confirm('Are you sure you would like to generate a new survey word of the day for this site?')" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>

        <div id="PendingContactSection" runat="server" class="my-3 col-md-12 px-0">
            <div class="col-sm-12 col-md-8 offset-md-4 my-3 px-0">
                <asp:Label ID="PendingRequestsLabel" runat="server" Text="Pending Contact Requests:" />
                <asp:Label ID="PendingRequestNumberLabel" runat="server" CssClass="h4" />
                <asp:Button ID="ViewButton" runat="server" Text="View" CssClass="btn btn-secondary" OnClick="ViewButton_Click" />
            </div>
        </div>

        <div class="row form-inline mx-auto col-12 px-0">
            <div class="col-6 col-lg-3 col-xl-2 mb-2 pl-0 offset-lg-3 offset-xl-4">
                <asp:Button ID="RecentSurveysButton" runat="server" Text="View Recent Surveys" CssClass="btn btn-block" OnClick="RecentSurveysButton_Click" BackColor="#223F88" ForeColor="white" />
            </div>

            <div class="col-6 col-lg-3 col-xl-2 mb-2 pr-0">
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

