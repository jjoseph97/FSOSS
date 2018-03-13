<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DummyResults.aspx.cs" Inherits="DummyResults" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="Date: " runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="DateLabel" runat="server" />
        </div>
    </div>
    
    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="Unit Number: " runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedUnitLabel" runat="server" />
        </div>
    </div>
    
</asp:Content>

