﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Pages_AdministratorPages_Login" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        .form-signin {
            width: 100%;
            max-width: 400px;
            padding: 15px;
            margin: 0 auto;
        }
    </style>
    <div class="form-signin card">
        <h3 class="text-center mb-5 mt-3">Please Login</h3>
        <div class="form-group">
            <asp:Label ID="UsernameLabel" runat="server" AssociatedControlID="UsernameTextbox" CssClass="col-sm-12">Username: </asp:Label>
            <div class="col-sm-12">
                <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="form-control" AutoComplete="off" Placeholder="Enter username" AutoFocus="true" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox" CssClass="col-sm-12">Password: </asp:Label>
            <div class="col-sm-12">
                <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" AutoComplete="off" Placeholder="Enter password" AutoFocus="true" />
            </div>
        </div>
        <div class="col-sm-12 mt-4 mb-5">
            <asp:Button ID="LoginButton" runat="server" CssClass="btn btn-primary col-sm-12" Text="Log in" OnClick="LoginButton_Click" />
        </div>
    </div>

    <%-- Delete below --%>
    <div class="col-sm-6 mx-auto text-center">
        <hr />
        <p>this section is for testing purposes. will be deleted.</p>
        <div class="col-sm-12 text-center p-2">
            <asp:Label ID="message" runat="server" CssClass="text-white bg-danger p-2" Visible="false" />
        </div>
        <div class="col-sm-12 mx-auto">
            <asp:Button ID="btnTest" runat="server" Text="Clear Cookies... Not the safest LOL" OnClick="btnTest_Click" />
        </div>
    </div>
</asp:Content>
