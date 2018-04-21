<%@ Page Title="Edit User Search" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditUserSearch.aspx.cs" Inherits="Admin_Master_EditUserSearch" %>

<asp:Content ID="EditUserSearch" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4 font-weight-bold">Edit User Search</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="SuccessMessage" runat="server" CssClass="card container h5 alert alert-success" Font-Size="Medium" Visible="false" />
            <asp:Label ID="FailedMessage" runat="server" CssClass="card container h5 alert alert-danger" Font-Size="Medium" Visible="false" />
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="SearchUserButton">
                    <asp:Label ID="SearchUserLabel" class="col-sm-3 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Search User: " />
                    <asp:TextBox ID="SearchUserTextBox" class="col-sm-6 my-2 form-control" runat="server" placeholder="Search for username, first name or last name..." AutoComplete="off" />
                    <asp:Button ID="SearchUserButton" class="col-sm-2 offset-sm-1 my-2 btn btn-info" runat="server" Text="Search" OnClick="SearchUserButton_Click" />
                    <asp:Button ID="ClearSearchButton" CssClass="col-sm-2 offset-sm-10 my-2 btn btn-light border border-info" runat="server" Text="Clear Search" OnClick="ClearSearchButton_Click" />
                </asp:Panel>
            </div>

            <div class="card container">
                <asp:ListView ID="AdministratorAccountListView" runat="server" DataSourceID="AdministratorAccountODS">
                    <AlternatingItemTemplate>
                        <tr class="fsoss-listview-alternate">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("id") %>' runat="server" ID="idLabel" Visible="false" CssClass="px-3" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("firstName") %>' runat="server" ID="firstNameLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("lastName") %>' runat="server" ID="lastNameLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("archived") %>' runat="server" ID="archivedLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:LinkButton Text="Edit" runat="server" PostBackUrl='<%# "~/Admin/Master/EditUser.aspx?id=" + Eval("id") %>' CssClass="btn btn btn-success mx-3 my-1" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <p class="text-center">No users were found.</p>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr class="fsoss-listview-itemtemplate">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("id") %>' runat="server" ID="idLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("firstName") %>' runat="server" ID="firstNameLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("lastName") %>' runat="server" ID="lastNameLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("archived") %>' runat="server" ID="archivedLabel" CssClass="px-3" /></td>
                            <td>
                                <asp:LinkButton Text="Edit" runat="server" PostBackUrl='<%# "~/Admin/Master/EditUser.aspx?id=" + Eval("id") %>' CssClass="btn btn btn-success mx-3 my-1" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server">
                                            <th runat="server" class="w-30 p-3">Username</th>
                                            <th runat="server" class="w-25 p-3">First Name</th>
                                            <th runat="server" class="w-25 p-3">Last Name</th>
                                            <th runat="server" class="w-10 p-3">Status</th>
                                            <th runat="server" class="w-10 p-3">Edit</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" class="mx-2 my-2">
                                <td runat="server" class="listview-pager">
                                    <asp:DataPager runat="server" ID="SurveyListDataPager">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark mt-2" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                                <asp:TemplatePagerField>
                                                <PagerTemplate>
                                                    <div class="my-2 text-white">
                                                        <b>Page 
                                                            <asp:Label runat="server" ID="CurrentPageLabel" Text='<%# ( Container.StartRowIndex / Container.PageSize) + 1 %>' />
                                                            of
                                                            <asp:Label runat="server" ID="TotalPagesLabel" Text='<%# Math.Ceiling( ((double)Container.TotalRowCount) / Container.PageSize) %>' />
                                                            (
                                                            <asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' />
                                                            records)
                                                        </b>
                                                    </div>
                                                </PagerTemplate>
                                            </asp:TemplatePagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:ObjectDataSource runat="server" ID="AdministratorAccountODS" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllAdministratorAccountList" TypeName="FSOSS.System.BLL.AdministratorAccountController"></asp:ObjectDataSource>
                <asp:ObjectDataSource runat="server" ID="SearchedAdministratorAccountODS" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSearchedAdministratorAccountList" TypeName="FSOSS.System.BLL.AdministratorAccountController">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="SearchUserTextBox" PropertyName="Text" Name="searchedWord" Type="String"></asp:ControlParameter>
                    </SelectParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
    </div>
</asp:Content>

