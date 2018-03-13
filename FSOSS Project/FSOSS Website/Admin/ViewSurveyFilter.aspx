<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewSurveyFilter.aspx.cs" Inherits="Admin_Master_ViewSurveyFilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 page-header" style="font-weight: bold;">View Surveys</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="HospitalLabelReportLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Hospital:"></asp:Label>
                    <asp:DropDownList ID="HospitalDropDownList" class="col-sm-3 my-2 form-control" runat="server" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID">
                        <asp:ListItem Text="Select All" Value="0" Selected="True" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="StartingPeriodLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large;" Text="Starting Period:"></asp:Label>
                    <div id="StartDatePicker" class="col-sm-3 input-group date px-0 my-2">
                        <asp:TextBox id="StartingPeriodTextBox" type="date" class="col-8 col-md-10 form-control" runat="server"/>
                        <span class="input-group-btn border">
                            <label for="<%= StartingPeriodTextBox.ClientID %>" class="btn btn-default p-1 m-0">
                                <i class="fas fa-calendar-alt" style="font-size: 30px;"></i>
                            </label>
                        </span>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="EndingPeriodLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large;" Text="Ending Period:"></asp:Label>
                    <div id="EndDatePicker" class="col-sm-3 input-group date px-0 my-2">
                        <asp:TextBox id="EndingPeriodTextBox" type="date" class="col-8 col-md-10 form-control" runat="server"/>
                        <span class="input-group-btn border">
                            <label for="<%= EndingPeriodTextBox.ClientID %>" class="btn btn-default p-1 m-0">
                                <i class="fas fa-calendar-alt" style="font-size: 30px;"></i>
                            </label>
                        </span>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="MealLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Filter by Meal:"></asp:Label>
                    <asp:DropDownList ID="MealDropDownList" class="col-sm-3 my-2 form-control" runat="server"
                        DataSourceID="MealODS"
                        DataTextField="mealName"
                        DataValueField="mealID">
                        <asp:ListItem Text="All Meals" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="UnitLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Filter by Unit:"></asp:Label>
                    <asp:DropDownList ID="UnitDropDownList" class="col-sm-3 my-2 form-control" runat="server"
                        DataSourceID="UnitODS"
                        DataTextField="unitNumber"
                        DataValueField="unitID">
                        <asp:ListItem Text="All Units" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Button ID="ViewButton" class="offset-sm-5 col-sm-1 btn btn-info mb-2" runat="server" Text="View" OnClick="ViewButton_Click" />
                </div>
            </div>
        </div>
        <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="MealODS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetMealList" TypeName="FSOSS.System.BLL.MealController"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="UnitODS" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitController">
            <SelectParameters>
                <asp:Parameter Name="site_id" Type="Int32"></asp:Parameter>
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>

