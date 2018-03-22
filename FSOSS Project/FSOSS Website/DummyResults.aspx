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

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="Participant Type: " runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedParticipantType" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="Meal Type: " runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedMealType" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="1: During your hospital stay, how would you describe the following features of your meals?" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="The variety of food in your daily meals " runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedQ1A" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="The taste and flavour of your meals" runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedQ1B" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="The temperature of your hot food" runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedQ1C" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="The overall appearance of your meal" runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedQ1D" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <asp:Label Text="The helpfulness of the staff who deliver your meals" runat="server" />
        </div>
        <div class="col-sm-8">
            <asp:Label ID="SelectedQ1E" runat="server" />
        </div>
    </div>


    
</asp:Content>

