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
               <asp:Label ID="SearchUnitLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Search units: " />
               <asp:DropDownList ID="SiteDropDownList" runat="server" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID"></asp:DropDownList>
               <asp:Button ID="SearchUnitButton" class="btn btn-info" runat="server" Text="Search" OnClick="SearchUnitButton_Click" />
                 </div>
          </div>
        <div class="col-sm-12">
             <div class="card container mb-2">
                 <asp:Button ID="SearchArchiveButton" class="btn btn-info" runat="server" Text="Search Archived Units" />
              </div>
          </div>



         <div class="card container mb-2">
             <asp:GridView ID="unitsCrudGridview" runat="server" AutoGenerateColumns="False" DataSourceID="UnitsODS" AllowPaging="True" Visible="false">
                 <Columns>  
                     <asp:BoundField DataField="unitID" HeaderText="unitID" SortExpression="unitID"></asp:BoundField>
                     <asp:BoundField DataField="unitNumber" HeaderText="unitNumber" SortExpression="unitNumber"></asp:BoundField>
                     <asp:BoundField DataField="dateModified" HeaderText="dateModified" SortExpression="dateModified"></asp:BoundField>
                     <asp:BoundField DataField="administratorAccountId" HeaderText="administratorAccountId" SortExpression="administratorAccountId"></asp:BoundField>
                     <asp:CheckBoxField DataField="isClosedyn" HeaderText="isClosedyn" SortExpression="isClosedyn"></asp:CheckBoxField>
                     <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ShowSelectButton="True"></asp:CommandField>
                 </Columns>
             </asp:GridView>

         </div>



        <asp:ObjectDataSource ID="SiteODS" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
        

        <asp:ObjectDataSource ID="UnitsODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitController" DeleteMethod="DisableUnit" InsertMethod="AddUnit" UpdateMethod="UpdateUnit">
            <DeleteParameters>
                <asp:Parameter Name="unit_id" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="unit_number" Type="String"></asp:Parameter>
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="SiteDropDownList" PropertyName="SelectedValue" Name="site_id" Type="Int32"></asp:ControlParameter>
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="unit_id" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="unit_number" Type="String"></asp:Parameter>
            </UpdateParameters>
        </asp:ObjectDataSource>
     
   </div>

</asp:Content>

