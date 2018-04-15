<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Pages_AdministratorPages_Login" %>

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
    <asp:Panel runat="server" CssClass="form-signin card bg-light" DefaultButton="LoginButton">
        <div class="card-header h3 text-center mb-2 bg-light">Please Login</div>
        <div class="form-group">
            <asp:Label ID="UsernameLabel" runat="server" AssociatedControlID="UsernameTextbox" CssClass="col-sm-12">Username: </asp:Label>
            <div class="col-sm-12">
                <asp:TextBox ID="UsernameTextBox" runat="server" CssClass="form-control" AutoComplete="off" Placeholder="Enter username" AutoFocus="true" />
                <asp:RequiredFieldValidator ID="UsernameRFV" ControlToValidate="UsernameTextBox" runat="server" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox" CssClass="col-sm-12">Password: </asp:Label>
            <div class="col-sm-12">
                <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" AutoComplete="off" Placeholder="Enter password" AutoFocus="true" />
                <asp:RequiredFieldValidator ID="PasswordRFV" ControlToValidate="PasswordTextBox" runat="server" />
            </div>
        </div>
        <div class="col-sm-12 mt-2 mb-2">
            <asp:Button ID="LoginButton" runat="server" CssClass="btn btn-primary col-sm-12" Text="Log in" OnClick="LoginButton_Click" CausesValidation="false" />
        </div>
    </asp:Panel>
    <div class="text-center mt-3">
        <div class="col-sm-12">
            <asp:Label ID="Message" runat="server" CssClass="alert alert-danger p-2 rounded" Visible="false" />
        </div>
    </div>
</asp:Content>

