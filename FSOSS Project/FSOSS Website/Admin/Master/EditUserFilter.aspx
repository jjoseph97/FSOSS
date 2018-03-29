<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditUserFilter.aspx.cs" Inherits="Admin_Master_EditUserFilter" %>

<asp:Content ID="EditUserFilter" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4 font-weight-bold">Edit User Filter</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="SearchUserLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Search User: " />
                    <asp:TextBox ID="SearchUserTextBox" class="col-sm-4 my-2 form-control" runat="server" placeholder="Type user to search for..." AutoComplete="off"/>
                    <asp:Button ID="SearchUserButton" class="col-sm-2 offset-sm-2 my-2 btn btn-info" runat="server" Text="Search" />
                </div>
            </div>

            <div class="card container">
                <asp:ListView runat="server" DataSourceID="AdministratorAccountODS">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #FFFFFF; color: #284775;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("id") %>' runat="server" ID="idLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("firstName") %>' runat="server" ID="firstNameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("lastName") %>' runat="server" ID="lastNameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("archived") %>' runat="server" ID="archivedLabel" /></td>
                            <td>
                                <asp:LinkButton Text="text" runat="server" PostBackUrl='<%# "~/Admin/Master/EditUser.aspx?id=" + Eval("id") %>' />
                            </td>
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
                        <tr style="background-color: #E0FFFF; color: #333333;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("id") %>' runat="server" ID="idLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("firstName") %>' runat="server" ID="firstNameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("lastName") %>' runat="server" ID="lastNameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("archived") %>' runat="server" ID="archivedLabel" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                        <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                            <th runat="server">username</th>
                                            <th runat="server">firstName</th>
                                            <th runat="server">lastName</th>
                                            <th runat="server">archived</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                    <asp:DataPager runat="server" ID="DataPager2">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:ObjectDataSource runat="server" ID="AdministratorAccountODS" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllUserList" TypeName="FSOSS.System.BLL.AdministratorAccountController"></asp:ObjectDataSource>
            </div>
        </div>
    </div>
</asp:Content>

