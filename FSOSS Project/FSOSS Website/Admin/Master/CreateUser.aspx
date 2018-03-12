﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="Admin_Master_CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4 font-weight-bold">Create New User</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="SuccessMessage" runat="server" CssClass="card container h5 text-white bg-success" Visible="false" />
            <asp:Label ID="FailedMessage" runat="server" CssClass="card container h5 text-white bg-danger" Visible="false" Text="Failed to create user" />
            <asp:Label ID="concatUsername" runat="server" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <div class="card container">
                <div class="col-sm-8">

                    <div class="form-group row">
                        <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstNameTextBox" CssClass="col-md-4 col-form-label font-weight-bold text-md-right" Text="First Name:" />
                        <div class="col-sm-8">
                            <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="form-control" AutoComplete="false" AutoFocus="true" />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label ID="LastNameLabel" runat="server" AssociatedControlID="LastNameTextBox" CssClass="col-sm-4 col-form-label font-weight-bold text-md-right" Text="Last Name:" />
                        <div class="col-sm-8">
                            <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="form-control" AutoComplete="false" />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox" CssClass="col-sm-4 col-form-label font-weight-bold text-md-right" Text="Password:" />
                        <div class="col-sm-8">
                            <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" AutoComplete="false" />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label ID="SecurityLevelLabel" runat="server" AssociatedControlID="SecurityLevelDDL" CssClass="col-sm-4 col-form-label font-weight-bold text-md-right" Text="Security Level:" />
                        <div class="col-sm-8">
                            <asp:DropDownList ID="SecurityLevelDDL" runat="server" CssClass="form-control" DataSourceID="SecurityRoleODS" DataTextField="securityDescription" DataValueField="securityID" />
                            <asp:ObjectDataSource ID="SecurityRoleODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSecurityRoleList" TypeName="FSOSS.System.BLL.SecurityRoleController"></asp:ObjectDataSource>
                        </div>
                    </div>

                    <div class="form-group row float-md-right">
                        <div class="col-sm-12">
                            <asp:Button ID="CreateButton" runat="server" CssClass="btn btn-primary btn-block" Text="Create User" OnClick="CreateButton_Click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

