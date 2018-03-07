<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewReportFilter.aspx.cs" Inherits="Pages_AdministratorPages_ViewReportFilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">View Report</h1>
        </div>
    </div>
    <div class ="row">
        <div class="col-md-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
         <div class="card container mb-2">
                <div class="row">
                    <div class ="col-md-3">
                        <asp:Label ID="HospitalLabelReportLabelID" runat="server" Text="Hospital:"></asp:Label>
                    </div>
                    <div class="col-md-9">
                        <asp:DropDownList ID="HospitalDropDownList" runat="server" 
                            DataSourceID="MealODS" 
                            DataTextField="mealDescription" 
                            DataValueField="mealID">
                             <asp:ListItem Text="Select All"/>
                        </asp:DropDownList>
                    </div>                   
                </div>
                <div class="row">
                    <div class="col-md-3">
                         <asp:Label ID="StartingPeriodLabelID" runat="server" Text="Starting Period:"></asp:Label>
                    </div>
                    <div class="col-md-3">
                        <asp:TextBox ID="StartingPeriodTextBoxID" runat="server" Text =""></asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <asp:Calendar ID="StartingPeriodCalendar" runat="server"  OnSelectionChanged="StartingPeriodCalendar_SelectionChanged"></asp:Calendar>
                    </div>
                </div>
                <div class="row">
                   <div class="col-md-3">
                         <asp:Label ID="EndingPeriodLabelID" runat="server" Text="Ending Period:"></asp:Label>
                    </div>
                    <div class="col-md-3">
                        <asp:TextBox ID="EndingPeriodTexBoxID" runat="server" Text =""></asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <asp:Calendar ID="EndingPeriodCalendar" runat="server" OnSelectionChanged="EndingPeriodCalendar_SelectionChanged"></asp:Calendar>                  
                    </div>
                </div>
              <div class="row">
                    <div class ="col-md-3">
                        <asp:Label ID="MealLabelID" runat="server" Text="Meal:"></asp:Label>
                    </div>
                    <div class="col-md-9">
                        <asp:DropDownList ID="MealDropDownList" runat="server">
                             <asp:ListItem Text="No Meal"/>
                        </asp:DropDownList>
                    </div>                   
               </div>
              <div class="row">
                  <asp:Button ID="ViewButtonID"  runat="server" Text="View" OnClick="ViewButtonID_Click" />
              </div>
            </div>
        <asp:ObjectDataSource ID="MealODS" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetMealList" 
            TypeName="FSOSS.System.BLL.MealController">
        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="SiteODS" runat="server">
        </asp:ObjectDataSource>
    </div>

</asp:Content>

