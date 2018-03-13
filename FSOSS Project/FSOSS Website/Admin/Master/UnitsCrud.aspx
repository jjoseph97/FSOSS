﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="UnitsCrud.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_UnitsCrud" %>

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
                    <asp:Label ID="Label1" runat="server" Text="Site Name"></asp:Label>
                    <asp:DropDownList ID="SiteDropDownList" runat="server" DataSourceID="SiteList" DataTextField="siteName" DataValueField="siteID"></asp:DropDownList>
                    <asp:Button ID="Button1" runat="server" Text="Search"  OnClick="Button1_Click"/>
                    </div>
            </div>      
            <div class="card container">
                <asp:GridView ID="UnitsGridView" runat="server" Visible="false" AutoGenerateColumns="False" DataSourceID="UnitListCRUD" AllowPaging="True">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowSelectButton="True"></asp:CommandField>
                        <asp:BoundField DataField="unitID" HeaderText="unitID" SortExpression="unitID"></asp:BoundField>
                        <asp:BoundField DataField="unitNumber" HeaderText="unitNumber" SortExpression="unitNumber"></asp:BoundField>
                    </Columns>
                </asp:GridView>
            </div>

        </div>


        <asp:ObjectDataSource ID="SiteList" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetSiteList" 
            TypeName="FSOSS.System.BLL.SiteController">

        </asp:ObjectDataSource>

        <asp:ObjectDataSource ID="UnitListCRUD" runat="server" DeleteMethod="DeleteUnit" InsertMethod="AddUnit" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitController">
            <DeleteParameters>
                <asp:Parameter Name="unit_id" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="unit_number" Type="String"></asp:Parameter>
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SiteDropDownList" PropertyName="SelectedValue" Name="site_id" Type="Int32"></asp:ControlParameter>
            </SelectParameters>
        </asp:ObjectDataSource>
       
   </div>
</asp:Content>

