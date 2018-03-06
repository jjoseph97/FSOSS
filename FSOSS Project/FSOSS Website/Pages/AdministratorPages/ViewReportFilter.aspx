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
                     <asp:Label ID="HospitalLabelReportLabelID" runat="server" Text="Hospital:"></asp:Label>&nbsp;&nbsp;&nbsp;
                     <asp:DropDownList ID="HospitalDropDownList" runat="server">
                         <asp:ListItem Text="Select All"/>
                     </asp:DropDownList>
                </div>
                <div class="row">
                   <asp:Label ID="StartingPeriodLabelID" runat="server" Text="Starting Period:"></asp:Label>&nbsp;&nbsp;&nbsp;
                   <asp:TextBox ID="StartingPeriodTextBoxID" runat="server" Text =""></asp:TextBox>&nbsp;
                    <asp:Calendar ID="StartingPeriodCalendar" runat="server" OnSelectionChanged="StartingPeriodCalendar_SelectionChanged"></asp:Calendar>
                </div>
                <div class="row">
                   
                </div>
            </div>
      

    </div>

</asp:Content>

