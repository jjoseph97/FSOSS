<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Units.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_UnitsCrud" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Manage Units</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="col-sm-12">
                <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
            </div>
            <asp:Label ID="SuccessAlert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row">
                    <asp:Label ID="SearchUnitLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Search units: " />
                    <asp:DropDownList ID="SiteDropDownList" class="col-sm-4 my-2 form-control" runat="server" DataSourceID="SiteODS" DataTextField="siteName" OnSelectedIndexChanged="SiteDropDownList_SelectedIndexChanged" AutoPostBack="true" DataValueField="siteID"></asp:DropDownList>
                </div>
            </div>
            <asp:Label ID="SelectedSiteID" runat="server" Visible="false" />
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <asp:Button ID="ArchivedButton" class="col-sm-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="ArchivedButton_Click" Visible="false"></asp:Button>
                <asp:Button ID="ActiveButton" class="col-sm-2 mt-2 btn btn-info border border-dark" runat="server" Text="Show Active" OnClick="ActiveButton_Click" Visible="false"></asp:Button>

                <%----------------------------------------------------------------------%>
                <%--------------------  Active Units ListView --------------------------%>
                <%----------------------------------------------------------------------%>
                <asp:ListView ID="UnitsListView" runat="server" DataSourceID="UnitsODS" DataKeyNames="unitID" InsertItemPosition="FirstItem">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #bbf2ff; color: #284775;">
                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="px-3" ID="unitNumberLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="px-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="px-3" ID="usernameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" class="btn btn-success mx-3 my-1" />
                            </td>
                            <td>
                                <asp:Button runat="server" CommandName="Delete" Text="Disable" ID="DeleteButton" class="btn btn-danger mx-3 my-1" />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="background-color: #fdff94;">
                            <td>
                                <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" CssClass="px-3" ID="unitNumberTextBox" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Bind("unitID") %>' runat="server" ID="unitIDTextBox" Visible="false" /></td>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" class="btn btn-success mx-3 my-1" />
                            </td>
                            <td>
                                <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" class="btn btn-warning mx-3 my-1" />
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <InsertItemTemplate>
                        <tr>
                            <td>
                                <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" placeholder="Add a New Unit Number.." CssClass="px-3 col-md-12" ID="unitNumberTextBox" /></td>
                            <td></td>
                            <td></td>
                            <td>
                                <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" class="btn btn-primary mx-3 my-1" />
                            </td>
                            <td>
                                <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" class="btn fsoss-grey mx-3 my-1" />
                            </td>
                        </tr>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #E0FFFF; color: #333333;">
                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="px-3" ID="unitNumberLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="px-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="px-3" ID="usernameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" class="btn btn-success mx-3 my-1" />
                            </td>
                            <td>
                                <asp:Button runat="server" CommandName="Delete" Text="Disable" ID="DeleteButton" class="btn btn-danger mx-3 my-1" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        </table>
                    <table runat="server" style="width: 100%;" class="my-2">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                    <tr runat="server">
                                        <th runat="server" class="w-25 p-3">Unit Number</th>
                                        <th runat="server" class="w-25 p-3">Last Modified On</th>
                                        <th runat="server" class="w-20 p-3">Last Modified By</th>
                                        <th runat="server" class="w-15 p-3">Insert Unit</th>
                                        <th runat="server" class="w-15 p-3">Clear</th>
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
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="px-3" ID="unitNumberLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="px-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="px-3" ID="usernameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="Button2" class="btn btn-success mx-3 my-1" />
                            </td>
                            <td>
                                <asp:Button runat="server" CommandName="Delete" Text="Disable" ID="Button1" class="btn btn-danger mx-3 my-1" />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>


                <%---------------------------------------------------------------------%>
                <%-- -----------------Archived UNITS Listview Section------------------%>
                <%---------------------------------------------------------------------%>
                <asp:ListView ID="ArchivedUnitsListView" runat="server" Visible="false" DataKeyNames="unitID" DataSourceID="ArchivedUnitsODS">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #bbf2ff; color: #284775;">

                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>

                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="px-3" ID="unitNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="px-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="px-3" ID="usernameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CommandName="Delete" Text="Enable" ID="DeleteButton" class="btn btn-success mx-3 my-1" />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>

                    <EmptyDataTemplate>
                        <table runat="server" style="">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>

                    <ItemTemplate>
                        <tr style="background-color: #E0FFFF; color: #333333;">

                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>

                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="px-3" ID="unitNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="px-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="px-3" ID="usernameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CommandName="Delete" Text="Enable" ID="DeleteButton" class="btn btn-success mx-3 my-1" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" class="my-2" style="width: 100%;">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server">
                                            <th runat="server" class="col-sm-3 py-2">Unit Number</th>
                                            <th runat="server" class="col-sm-3">Last Modified On</th>
                                            <th runat="server" class="col-sm-2">Last Modified By</th>
                                            <th class="col-sm-1"></th>
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

                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>

                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="px-3" ID="unitNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="px-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="px-3" ID="usernameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CommandName="Delete" Text="Enable" ID="DeleteButton" class="btn btn-success mx-3 my-1" />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
            </div>
        </div>

        <%-- ---------------------------------------------------ObjectDataSources-------------------------------------%>
        <%-- -----------------Site Search ODS-----------------------%>
        <asp:ObjectDataSource ID="SiteODS" runat="server"
            OldValuesParameterFormatString="{0}"
            SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>

        <%-- -----------------Active Units List ODS------------------%>
        <asp:ObjectDataSource ID="UnitsODS" runat="server" DeleteMethod="SwitchUnitSatus" InsertMethod="AddUnit" OldValuesParameterFormatString="{0}"
            SelectMethod="GetActiveUnitList" TypeName="FSOSS.System.BLL.UnitController" UpdateMethod="UpdateUnit"
            OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
            <DeleteParameters>
                <asp:Parameter Name="unitID" Type="Int32"></asp:Parameter>
                <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="unitNumber" Type="String"></asp:Parameter>
                <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                <asp:ControlParameter ControlID="SelectedSiteID" PropertyName="Text" Name="siteID" Type="Int32"></asp:ControlParameter>
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SiteDropDownList" PropertyName="SelectedValue" Name="site_id" Type="Int32"></asp:ControlParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="unitID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="unitNumber" Type="String"></asp:Parameter>
                <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
            </UpdateParameters>
        </asp:ObjectDataSource>

        <%-- -----------------Archived Units List ODS------------------%>
        <asp:ObjectDataSource ID="ArchivedUnitsODS" runat="server" DeleteMethod="SwitchUnitSatus" OldValuesParameterFormatString="{0}"
            SelectMethod="GetArchivedUnits" TypeName="FSOSS.System.BLL.UnitController"
            OnDeleted="CheckForException">
            <DeleteParameters>
                <asp:Parameter Name="unitID" Type="Int32"></asp:Parameter>
                <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
            </DeleteParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SiteDropDownList" PropertyName="SelectedValue" Name="siteID" Type="Int32"></asp:ControlParameter>
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>

</asp:Content>

