<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewSurveyFilter.aspx.cs" Inherits="Admin_Master_ViewSurveyFilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
            $(function () {
                $("#StartingPeriodInput").datepicker({ dateFormat: 'yy-mm-dd' }).val();
            });
            $(function () {
                $("#EndingPeriodInput").datepicker({ dateFormat: 'yy-mm-dd' }).val();
            });
    </script>
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 page-header" style="font-weight: bold;">View Surveys</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="SuccessAlert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="HospitalLabelReportLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Hospital:"></asp:Label>
                    <asp:DropDownList ID="HospitalDropDownList" class="col-sm-3 my-2 form-control" runat="server" AutoPostBack="True" OnSelectedIndexChanged="HospitalDropDownList_SelectedIndexChanged" AppendDataBoundItems="true">
                        <asp:ListItem Text="All Hospitals" Value="0" Selected="True" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="StartingPeriodLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large;" Text="Starting Period:"></asp:Label>
                    <div id="StartDatePicker" class="col-sm-3 input-group date px-0 my-2">
                        <input id="StartingPeriodInput" name="StartingPeriodInput" type="text" class="col-8 col-md-10 form-control" />
                        <span class="input-group-btn border">
                            <label for="StartingPeriodInput" class="btn btn-default p-1 m-0">
                                <i class="fas fa-calendar-alt" style="font-size: 30px;"></i>
                            </label>
                        </span>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="EndingPeriodLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large;" Text="Ending Period:"></asp:Label>
                    <div id="EndDatePicker" class="col-sm-3 input-group date px-0 my-2">
                        <input id="EndingPeriodInput" name="EndingPeriodInput" type="text" class="col-8 col-md-10 form-control" />
                        <span class="input-group-btn border">
                            <label for="EndingPeriodInput" class="btn btn-default p-1 m-0">
                                <i class="fas fa-calendar-alt" style="font-size: 30px;"></i>
                            </label>
                        </span>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="MealLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Filter by Meal:"></asp:Label>
                    <asp:DropDownList ID="MealDropDownList" class="col-sm-3 my-2 form-control" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="All Meals" Value="0" Selected="True" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="UnitLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Filter by Unit:" Visible="false"></asp:Label>
                    <asp:DropDownList ID="UnitDropDownList" class="col-sm-3 my-2 form-control" runat="server" AppendDataBoundItems="false" Visible="false" Enabled="false"></asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Button ID="ViewButton" class="offset-sm-5 col-sm-1 btn btn-info mb-2" runat="server" Text="View" OnClick="ViewButton_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

