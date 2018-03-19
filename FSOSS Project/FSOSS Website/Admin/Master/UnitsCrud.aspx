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
        <asp:ListView ID="UnitsListView" runat="server" Visible="false" DataSourceID="UnitsCrud"></asp:ListView>
        


        <asp:ObjectDataSource ID="SiteList" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetSiteList" 
            TypeName="FSOSS.System.BLL.SiteController">

        </asp:ObjectDataSource>
        <asp:ObjectDataSource ID="UnitsCrud" runat="server" DeleteMethod="DisableUnit" InsertMethod="AddUnit" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitController">
            <DeleteParameters>
                <asp:Parameter Name="unit_id" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="unit_number" Type="String"></asp:Parameter>
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="UnitsListView" PropertyName="SelectedValue" Name="site_id" Type="Int32"></asp:ControlParameter>
            </SelectParameters>
        </asp:ObjectDataSource>
       
       
   </div>
</asp:Content>

