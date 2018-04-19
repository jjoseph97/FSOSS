<%@ Page Title="Reports Filter" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewReportFilter.aspx.cs" Inherits="Pages_AdministratorPages_ViewReportFilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(function () {
            $("#StartingPeriodInput").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true }).val();
            $("#StartingPeriodInput").datepicker("option", "showAnim", "show");
        });
        $(function () {
            $("#EndingPeriodInput").datepicker({ dateFormat: 'yy-mm-dd', changeMonth: true, changeYear: true }).val();
            $("#EndingPeriodInput").datepicker("option", "showAnim", "show");
        });
    </script>
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 page-header" style="font-weight: bold;">View Report</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="Alert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="HospitalLabelReportLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Hospital:"></asp:Label>
                    <asp:DropDownList ID="HospitalDropDownList" class="col-sm-4 my-2 form-control" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="Select All" Value="0" Selected="True" />
                    </asp:DropDownList>
                </div>
            <div class="row container mx-auto px-0">
                    <asp:Label ID="StartingPeriodLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large;" Text="Starting Period:"></asp:Label>
                    <div id="StartDatePicker" class="col-sm-4 input-group date px-0 my-2">
                        <input id="StartingPeriodInput" name="StartingPeriodInput" type="text" class="col-11 col-md-11 form-control" placeholder="YYYY-MM-DD" value="<%= this.startingInputValue %>" autocomplete="off" />
                        <span class="input-group-btn border">
                            <label for="StartingPeriodInput" class="btn btn-default p-1 m-0">
                                <i class="fas fa-calendar-alt" style="font-size: 30px;"></i>
                            </label>
                        </span>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="EndingPeriodLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large;" Text="Ending Period:"></asp:Label>
                    <div id="EndDatePicker" class="col-sm-4 input-group date px-0 my-2">
                        <input id="EndingPeriodInput" name="EndingPeriodInput" type="text" class="col-11 col-md-11 form-control" placeholder="YYYY-MM-DD" value="<%= this.endingInputValue %>" autocomplete="off" />
                        <span class="input-group-btn border">
                            <label for="EndingPeriodInput" class="btn btn-default p-1 m-0">
                                <i class="fas fa-calendar-alt" style="font-size: 30px;"></i>
                            </label>
                        </span>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="MealLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Meal:"></asp:Label>
                    <asp:DropDownList ID="MealDropDownList" class="col-sm-4 my-2 form-control" runat="server" AppendDataBoundItems="true">
                        <asp:ListItem Text="All Meals" Selected="True" Value="0" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Button ID="ViewButton" class="offset-sm-5 col-sm-2 btn btn-info mb-2" runat="server" Text="View" OnClick="ViewButton_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

