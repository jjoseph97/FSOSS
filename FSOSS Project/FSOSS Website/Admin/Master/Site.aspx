﻿<%@ Page Title="Manage Sites" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Site.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_Site" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight:bold;">Manage Site</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
        </div>
    </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="AddWordLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Add Site: " />
                    <asp:TextBox ID="AddSiteTextBox" class="col-sm-4 my-2" runat="server" placeholder="Type word to add..." />
                    <asp:Button ID="AddSiteButton" class="col-sm-2 offset-sm-2 my-2 btn btn-success" runat="server" Text="Add" OnClick="AddSite_Click" />
                </div>
            </div>    

        <div class="card container"> <%--site show section--%>
            <asp:Button ID="RevealButton" class="col-sm-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="ToggleView" /><br />
            <br />
                <asp:ListView ID="ListView1" runat="server" DataSourceID="SiteODS" DataKeyNames="siteID">
                    <AlternatingItemTemplate>
                        <tr class="fsoss-listview-alternate">                          
                            <td>
                                <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteID") %>' runat="server" ID="SiteIdLabel" Visible="False" />
                                <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" />
                            </td>
                            <td> <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /> </td>
                             <td> <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /> </td>
                                 <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr class="listview-header"> 
                            <td>
                              <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteID") %>' runat="server" ID="SiteIdLabel" Visible="False" />
                                <asp:TextBox CssClass="mx-3" Text='<%# Bind("siteName") %>' runat="server" ID="siteNameTextBox" /></td>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton"  CommandName="Update" /></td>
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
                            <td><asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td><asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                             <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td><asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer"  class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server" >
                                            <th runat="server" class="col-sm-4 py-2">Site</th>
                                            <th runat="server" class="col-sm-3 py-2">Last Modified On</th>
                                            <th runat="server" class="col-sm-3 py-2">Last Modified By</th>
                                            <th runat="server" class="col-sm-1 py-2">Edit</th>
                                            <th runat="server" class="col-sm-1 py-2">Change Availability</th>

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
                                <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteID") %>' runat="server" ID="SiteIdLabel" Visible="False" />
                                <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" /></td>
                            <td><asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td><asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                             <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td><asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
           
  
        </div>
    </div>


       <%-- ODS SECTION--%>
    <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController" UpdateMethod="UpdateSite" DeleteMethod="ArchiveSite" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException" InsertMethod="AddSite">
        <DeleteParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="newSiteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="siteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ArchivedODS" runat="server" DeleteMethod="ArchiveSite" OldValuesParameterFormatString="{0}" SelectMethod="GetArchived" TypeName="FSOSS.System.BLL.SiteController" UpdateMethod="UpdateSite" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException" InsertMethod="AddSite">
        <DeleteParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="newSiteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="siteID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="siteName" Type="String"></asp:Parameter>
            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
        </UpdateParameters>
    </asp:ObjectDataSource>

</asp:Content>
