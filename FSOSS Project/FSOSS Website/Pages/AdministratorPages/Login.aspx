<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Pages_AdministratorPages_Login" %>

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
                <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="form-control col-md-12" AutoComplete="off" Placeholder="Enter username" Required="true" AutoFocus="true" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox" CssClass="col-sm-12">Password: </asp:Label>
            <div class="col-sm-12">
                <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="form-control col-md-12" AutoComplete="off" Placeholder="Enter password" Required="true" AutoFocus="true" />
            </div>
        </div>
        <div class="col-sm-12 mt-4 mb-5">
            <asp:Button ID="LoginButton" runat="server" CssClass="btn btn-primary col-sm-12" Text="Log in" />
        </div>
    </div>
</asp:Content>

