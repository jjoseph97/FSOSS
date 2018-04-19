<%@ Page Title="Manage Sites" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Site.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_Site" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Manage Sites</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
        </div>
    <div class="col-md-12">
        <div class="card container mb-2">
            <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="AddSiteButton">
                <asp:Label ID="AddWordLabel" class="col-md-4 my-2 text-center text-md-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Site: " />
                <asp:TextBox ID="AddSiteTextBox" class="col-md-4 my-2 form-control" runat="server" placeholder="Type word to add..." AutoComplete="off" />
                <asp:Button ID="AddSiteButton" class="col-md-2 offset-md-2 my-2 btn btn-success" runat="server" Text="Add" OnClick="AddSite_Click" />
            </asp:Panel>
        </div>
        <div class="card container">
            <%--site show section--%>
            <asp:Button ID="RevealButton" class="col-md-3 col-lg-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="ToggleView" />
            <asp:ListView ID="ListView1" runat="server" DataSourceID="SiteODS" DataKeyNames="siteID" OnItemDataBound="ListView1_ItemDataBound">
                <AlternatingItemTemplate>
                    <tr class="fsoss-listview-alternate">
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteID") %>' runat="server" ID="SiteIdLabel" Visible="False" />
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" />
                        </td>
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" />
                        </td>
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" />
                        </td>
                        <td>
                            <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton"/></td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr class="listview-header">
                        <td>
                            <asp:Panel runat="server" DefaultButton="UpdateButton">
                                <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteID") %>' runat="server" ID="SiteIdLabel" Visible="False" />
                                <asp:TextBox CssClass="mx-3" Text='<%# Bind("siteName") %>' runat="server" ID="siteNameTextBox" AutoComplete="off" />
                            </asp:Panel>
                        </td>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton" CommandName="Update" /></td>
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
                    <tr class="fsoss-listview-itemtemplate">
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteID") %>' runat="server" ID="SiteIdLabel" Visible="False" />
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" /></td>
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                        <td>
                            <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                    <tr runat="server">
                                        <th runat="server" class="w-25 p-3">Site</th>
                                        <th runat="server" class="w-25 p-3">Last Modified On</th>
                                        <th runat="server" class="w-20 p-3">Last Modified By</th>
                                        <th runat="server" class="w-15 p-3">Edit Word</th>
                                        <th runat="server" class="w-15 p-3">Change Availability</th>
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
                                                        (<asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' />
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
                <SelectedItemTemplate>
                    <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteID") %>' runat="server" ID="SiteIdLabel" Visible="False" />
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" /></td>
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                        <td>
                            <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                        <td>
                            <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
            </div>
        </div>
    </div>


    <%-- ODS SECTION--%>
    <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController" UpdateMethod="UpdateSite" DeleteMethod="ArchiveSite" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException" InsertMethod="AddSite">
        <DeleteParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="newSiteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="siteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ArchivedODS" runat="server" DeleteMethod="ArchiveSite" OldValuesParameterFormatString="{0}" SelectMethod="GetArchived" TypeName="FSOSS.System.BLL.SiteController" UpdateMethod="UpdateSite" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException" InsertMethod="AddSite">
        <DeleteParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="newSiteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="siteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
        </UpdateParameters>
    </asp:ObjectDataSource>

</asp:Content>
