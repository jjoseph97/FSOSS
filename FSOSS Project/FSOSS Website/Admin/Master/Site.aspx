<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Site.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_Site" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight:bold;"> Manage Site</h1>
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
                    <asp:Label ID="SearchSiteLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Search Site: " />
                    <asp:TextBox ID="SearcSiteTextBox" class="col-sm-4 my-2" runat="server" placeholder="Enter site to search for..." />
                    <asp:Button ID="SearchSiteButton" class="col-sm-2 offset-sm-2 my-2 btn btn-info" runat="server" Text="Search" OnClick="SearchSite_Click" />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="AddWordLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Add Site: " />
                    <asp:TextBox ID="AddSiteTextBox" class="col-sm-4 my-2" runat="server" placeholder="Type word to add..." />
                    <asp:Button ID="AddSiteButton" class="col-sm-2 offset-sm-2 my-2 btn btn-success" runat="server" Text="Add" OnClick="AddSite_Click" />
                </div>
            </div>    
            <div class="card container"> <%--site show section--%>
                <asp:ListView ID="ListView1" runat="server" DataSourceID="SiteODS">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #bdfeff; color: #284775;">
                            <td>
                                <asp:Label Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" /></td>
                                 <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                                <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="background-color: #bdfeff;">
                            <td>
                                <asp:TextBox CssClass="mx-3" Text='<%# Bind("siteName") %>' runat="server" ID="siteNameTextBox" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Update" Text="Update" ID="UpdateButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Cancel" Text="Cancel" ID="CancelButton" /></td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #E0FFFF; color: #333333;">
                            <td>
                                <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" /></td>
                             <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                            <th runat="server" class="col-sm-6 py-2">Site</th>
                                            <th runat="server" class="col-sm-3 py-2">Edit</th>
                                            <th runat="server" class="col-sm-3 py-2">Delete</th>

                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                           <%-- <tr runat="server">
                                <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                    <asp:DataPager runat="server" ID="DataPager1">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                            <asp:NumericPagerField></asp:NumericPagerField>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>--%>
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
