<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ViewReportFilter.aspx.cs" Inherits="Pages_AdministratorPages_ViewReportFilter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
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
                    <asp:Label ID="HospitalLabelReportLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Hospital:"></asp:Label>
                    <asp:DropDownList ID="HospitalDropDownList" class="col-sm-3 my-2 form-control" runat="server" AppendDataBoundItems="true">
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
                    <asp:Label ID="MealLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Meal:"></asp:Label>
                    <asp:DropDownList ID="MealDropDownList" class="col-sm-3 my-2 form-control" runat="server">
                        <asp:ListItem Text="No Meal" Selected="True" Value="0" />
                    </asp:DropDownList>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Button ID="ViewButton" class="offset-sm-5 col-sm-1 btn btn-info mb-2" runat="server" Text="View" OnClick="ViewButton_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

