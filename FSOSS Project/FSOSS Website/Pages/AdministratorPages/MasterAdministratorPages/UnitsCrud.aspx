<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UnitsCrud.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_UnitsCrud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight:bold;"> Manage Units</h1>
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
                    <asp:DropDownList ID="SiteDropDownList" runat="server" DataSourceID="SiteList" DataTextField="siteName" DataValueField="siteID"></asp:DropDownList>
                    </div>
            </div>      
            <div class="card container">
                <asp:ListView ID="ListView1" runat="server" DataSourceID="UnitList">
                    <AlternatingItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label Text='<%# Eval("unit_id") %>' runat="server" ID="unit_idLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("unit_number") %>' runat="server" ID="unit_numberLabel" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                                <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                            </td>
                            <td>
                                <asp:TextBox Text='<%# Bind("unit_id") %>' runat="server" ID="unit_idTextBox" /></td>
                            <td>
                                <asp:TextBox Text='<%# Bind("unit_number") %>' runat="server" ID="unit_numberTextBox" /></td>
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
                        <tr style="">
                            <td>
                                <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                            </td>
                            <td>
                                <asp:TextBox Text='<%# Bind("unit_id") %>' runat="server" ID="unit_idTextBox" /></td>
                            <td>
                                <asp:TextBox Text='<%# Bind("unit_number") %>' runat="server" ID="unit_numberTextBox" /></td>
                        </tr>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label Text='<%# Eval("unit_id") %>' runat="server" ID="unit_idLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("unit_number") %>' runat="server" ID="unit_numberLabel" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                        <tr runat="server" style="">
                                            <th runat="server">unit_id</th>
                                            <th runat="server">unit_number</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style=""></td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label Text='<%# Eval("unit_id") %>' runat="server" ID="unit_idLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("unit_number") %>' runat="server" ID="unit_numberLabel" /></td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
            </div>

        </div>
        <asp:ObjectDataSource ID="SiteList" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetSiteList" 
            TypeName="FSOSS.System.BLL.SiteController">

        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="UnitList" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitsController"></asp:ObjectDataSource>
   </div>
</asp:Content>

