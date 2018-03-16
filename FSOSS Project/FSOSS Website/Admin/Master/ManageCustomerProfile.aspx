<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageCustomerProfile.aspx.cs" Inherits="Admin_Master_ManageCustomerProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Manage Customer Profile:</h1>
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
                    <asp:Label ID="CustomerProfileLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Customer Profile:"></asp:Label>
                    <asp:DropDownList ID="CustomerProfileDropDownList" class="col-sm-3 my-2 form-control" runat="server" DataSourceID="SiteODS" AppendDataBoundItems="true">
                        <asp:ListItem Text="Gender" Value="0" Selected="True" />
                    </asp:DropDownList>
                    <asp:Button ID="ViewCustomerProfileButton" class="col-sm-1 offset-sm-2 my-2 btn btn-info" runat="server" Text="View"/>
                </div>
            </div>
            <div class="card container">
                <%--site show section--%>
                <asp:ListView ID="ListView1" runat="server" DataSourceID="SiteODS">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #E0FFFF; color: #333333;">
                            <td class="pl-3">
                                <asp:Label Text='Male' runat="server" ID="siteNameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                            <tr style="background-color: #E0FFFF; color: #333333;">
                                <td class="pl-3">
                                    <asp:Label Text='Female' runat="server" ID="Label1" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button1" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button2" /></td>
                                <tr style="background-color: #E0FFFF; color: #333333;">
                                    <td class="pl-3">
                                        <asp:Label Text='Other' runat="server" ID="Label4" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button3" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button4" /></td>
                                </tr>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #FFFFFF; color: #333333;">
                            <td class="pl-3">
                                <asp:Label Text='Male' runat="server" ID="siteNameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                            <tr style="background-color: #FFFFFF; color: #333333;">
                                <td class="pl-3">
                                    <asp:Label Text='Female' runat="server" ID="Label1" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button1" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button2" /></td>
                                <tr style="background-color: #FFFFFF; color: #333333;">
                                    <td class="pl-3">
                                        <asp:Label Text='Other' runat="server" ID="Label4" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button3" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button4" /></td>
                                </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                            <th runat="server" class="col-sm-6 py-2">Gender</th>
                                            <th runat="server" class="col-sm-3 py-2">Edit</th>
                                            <th runat="server" class="col-sm-3 py-2">Delete</th>

                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                            <td>
                                <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
            </div>
        </div>
        <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
    </div>
</asp:Content>

