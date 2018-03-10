<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewReportFilter.aspx.cs" Inherits="Pages_AdministratorPages_ViewReportFilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.0/css/bootstrap-datepicker3.standalone.css" />
    <script type="text/javascript" src="../Scripts/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.6.1/js/bootstrap-datepicker.min.js"></script>
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 page-header" style="font-weight: bold;">View Report</h1>
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
                    <asp:Label ID="HospitalLabelReportLabelID" class="col-sm-4 my-2 text-center text-sm-left" runat="server" style="font-weight:bold;font-size:large; line-height:38px;" Text="Hospital:"></asp:Label>
                    <asp:DropDownList ID="HospitalDropDownList" class="col-sm-3 my-2" runat="server">
                        <asp:ListItem Text="Select All" Value="0" Selected="True" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="StartingPeriodLabelID" class="col-sm-4 my-2 text-center text-sm-left" runat="server" style="font-weight:bold;font-size:large;" Text="Starting Period:"></asp:Label>
                    <div id="start-date-picker" class="col-sm-8 input-group date px-0 my-2" style="height:38px;">
                        <input id="StartingPeriodTextBoxID" class="col-sm-4" runat="server" text="" />
                        <span class="input-group-addon">
                            <i class="fas fa-calendar-alt p-1 " style="font-size:42px; border:1px solid;"></i>
                        </span>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                        <asp:Label ID="EndingPeriodLabelID" class="col-sm-4 my-2 text-center text-sm-left" runat="server" style="font-weight:bold;font-size:large;" Text="Ending Period:"></asp:Label>
                    <div id="end-date-picker" class="col-sm-8 input-group date px-0 my-2" style="height:38px;">
                        <input id="EndingPeriodTexBoxID" class="col-sm-4" runat="server" text="" />
                        <div class="input-group-addon">
                            <i class="fas fa-calendar-alt p-1 " style="font-size:42px; border:1px solid;"></i>
                        </div>
                    </div>
                </div>
                <div class="row container mx-auto px-0">

                        <asp:Label ID="MealLabelID" class="col-sm-4 my-2 text-center text-sm-left" runat="server" style="font-weight:bold;font-size:large; line-height:38px;" Text="Meal:"></asp:Label>
                    <asp:DropDownList ID="MealDropDownList" class="col-sm-3 my-2" runat="server" 
                        DataSourceID="MealODS" 
                        DataTextField="mealName" 
                        DataValueField="mealID">
                            <asp:ListItem Text="No Meal" />
                        </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">

                        <asp:Button ID="ViewButtonID" class="offset-sm-4 col-sm-2 btn btn-info mb-2" runat="server" Text="View" OnClick="ViewButtonID_Click" />
                </div>
            </div>
        </div>
        <asp:ObjectDataSource ID="MealODS" runat="server"
            OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetMealList"
            TypeName="FSOSS.System.BLL.MealController"></asp:ObjectDataSource>
        <asp:ObjectDataSource ID="SiteODS" runat="server"></asp:ObjectDataSource>
    </div>
    <script>
        $(document).ready(function () {
            $("#start-date-picker").datepicker({
                autoclose: true,
                format: 'yyyy-mm-dd',
                todayHighlight: true,
                clearBtn: true,
                orientation: 'bottom',
            });
        });
    </script>
    <script>
        $(document).ready(function () {
            $("#end-date-picker").datepicker({
                autoclose: true,
                format: 'yyyy-mm-dd',
                todayHighlight: true,
                clearBtn: true,
                orientation: 'bottom'
            });
        });
    </script>
</asp:Content>

