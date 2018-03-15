﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DemographicsPage.aspx.cs" Inherits="Pages_Survey_DemographicsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%--Customer Profile--%>
    <div class="form-check">
        <asp:CheckBox ID="CustomerProfileCheckBox" runat="server" CssClass="form-check-input" OnCheckedChanged="CustomerProfileCheckBox_CheckedChanged" AutoPostBack="true" />
        <asp:Label ID="CustomerProfileCheckBoxLabel" runat="server" AssociatedControlID="CustomerProfileCheckBox" CssClass="form-check-lable" Text="Customer Profile" Font-Bold="true" />
    </div>

    <br />

    <div id="CustomerProfileContent" runat="server">
        <div class="row">
            <asp:Label class="col-md-2 ml-md-5 my-2" runat="server" Text="Gender:"></asp:Label>
            <asp:DropDownList ID="GenderDDL" CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem Value="">Select Gender</asp:ListItem>
                <asp:ListItem>Male</asp:ListItem>
                <asp:ListItem>Female</asp:ListItem>
                <asp:ListItem>Other</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-2 ml-md-5 my-2" runat="server" Text="Age Range:"></asp:Label>
            <asp:DropDownList ID="AgeDDL" CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem>Select Age Range</asp:ListItem>
                <asp:ListItem>Under 18 years</asp:ListItem>
                <asp:ListItem>18 to 34 years</asp:ListItem>
                <asp:ListItem>35 to 54 years</asp:ListItem>
                <asp:ListItem>55 to 74 years</asp:ListItem>
                <asp:ListItem>Age 75 or older</asp:ListItem>
            </asp:DropDownList><br />
        </div>
    </div>

    <br />
    <br />

    <%--Contact Requests--%>
    <div class="form-check">
        <asp:CheckBox ID="ContactRequestsCheckBox" runat="server" CssClass="form-check-input" OnCheckedChanged="ContactRequestsCheckBox_CheckedChanged" AutoPostBack="true" />
        <asp:Label ID="ContactRequestsCheckBoxLabel" runat="server" AssociatedControlID="ContactRequestsCheckBox" CssClass="form-check-lable"
            Text="If you have any meal or service concerns, please check the box and provide your <br/> phone number and room number so that we can contact you."
            Font-Bold="true" />
    </div>

    <br />

    <div id ="ContactRequestsContent" runat="server">
        <div class="row">
            <asp:Label CssClass="col-md-2 ml-md-5 my-2" runat="server" Text="Phone Number:"></asp:Label>
            <asp:TextBox CssClass="col-md-4 form-control" ID="PhoneTextBox" runat="server" placeholder="Enter phone number to be reached at"></asp:TextBox>
        </div>
        <br />
        <div class="row">
            <asp:Label CssClass="col-md-2 ml-md-5 my-2" runat="server" Text="Room Number:"></asp:Label>
            <asp:TextBox CssClass="col-md-4 form-control" ID="RoomTextBox" runat="server" placeholder="Enter room number e.g.001"></asp:TextBox>
        </div>
    </div>

    <%--Back to questions--%>
    <asp:Button CssClass="" ID="BackButton" runat="server" Text="Back" PostBackUrl="~/TakeSurvey.aspx" />

    <%--Submit Survey Button--%>
    <asp:Button CssClass="" ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />
</asp:Content>
