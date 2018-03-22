<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CreateUser.aspx.cs" Inherits="Admin_Master_CreateUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4 font-weight-bold">Create New User</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="SuccessMessage" runat="server" CssClass="card container h5 alert alert-success p-2" />
            <asp:ValidationSummary runat="server" ID="ValidationSummary"
                HeaderText="Failed to create the user due to the following:"
                CssClass="card container h5 alert alert-danger p-2" />
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <div class="card container">
                <div class="col-sm-8">

                    <div class="form-group mt-3 row">
                        <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstNameTextBox" CssClass="col-md-4 col-form-label font-weight-bold text-md-right" Text="First Name:" />
                        <div class="col-sm-8">
                            <asp:TextBox ID="FirstNameTextBox" runat="server" CssClass="form-control" AutoComplete="false" AutoFocus="true" />
                            <asp:RequiredFieldValidator ErrorMessage="First Name is required" ControlToValidate="FirstNameTextBox" runat="server" 
                                Display="None" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ErrorMessage="First Name must start with a capital letter and will only contain letters" ControlToValidate="FirstNameTextBox" runat="server"
                                ValidationExpression="^[A-Z][a-z]*$" Display="None" SetFocusOnError="true" />
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label ID="LastNameLabel" runat="server" AssociatedControlID="LastNameTextBox" CssClass="col-sm-4 col-form-label font-weight-bold text-md-right" Text="Last Name:" />
                        <div class="col-sm-8">
                            <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="form-control" AutoComplete="false" />
                            <asp:RequiredFieldValidator ErrorMessage="Last Name is required" ControlToValidate="LastNameTextBox" runat="server" 
                                Display="None" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ErrorMessage="Last Name must start with a capital letter and will only contain letters" ControlToValidate="LastNameTextBox" runat="server" 
                                ValidationExpression="^[A-Z][a-z]*-{0,1}[a-zA-Z]*$" Display="None" SetFocusOnError="true"/>
                        </div>
                    </div>

                    <div class="form-group row">
                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordTextBox" CssClass="col-sm-4 col-form-label font-weight-bold text-md-right" Text="Password:" />
                        <div class="col-sm-8">
                            <asp:TextBox ID="PasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" AutoComplete="false" />
                            <asp:RequiredFieldValidator ErrorMessage="Password is required" ControlToValidate="PasswordTextBox" runat="server" 
                                Display="None" SetFocusOnError="true" />
                            <asp:RegularExpressionValidator ErrorMessage="Password must be a minimum of 8 characters long, contain at least one upper case letter, one lower case letter, and one numeric digit" ControlToValidate="PasswordTextBox" runat="server" 
                                Display="None" ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$" SetFocusOnError="true" />
                        </div>
                    </div>
                    <div class="form-group row">
                        <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPasswordTextBox" CssClass="col-sm-4 col-form-label font-weight-bold text-md-right" Text="Confirm Password:" />
                        <div class="col-sm-8">
                            <asp:TextBox ID="ConfirmPasswordTextBox" runat="server" TextMode="Password" CssClass="form-control" AutoComplete="false" />
                            <asp:RequiredFieldValidator ErrorMessage="Please confirm the password" ControlToValidate="ConfirmPasswordTextBox" runat="server" 
                                Display="None"/>
                            <asp:CompareValidator ErrorMessage="Please confirm the password" ControlToValidate="ConfirmPasswordTextBox" runat="server"
                                Display="None" ControlToCompare="PasswordTextBox" />
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
                            <asp:Button ID="CreateButton" runat="server" CssClass="btn btn-primary btn-block" Text="Create User" OnClick="CreateButton_Click" CausesValidation="false"/>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

