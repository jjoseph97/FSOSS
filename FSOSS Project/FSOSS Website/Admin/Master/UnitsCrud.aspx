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
               <asp:Button ID="SearchUnitButton" class="col-sm-2 offset-sm-2 my-2 btn btn-info" runat="server" Text="Search" OnClick="SearchUnitButton_Click" />
                 </div>
          </div>

         <div class="card container mb-2">
             <asp:ListView ID="UnitsListView" runat="server" DataSourceID="UnitsCrud" InsertItemPosition="LastItem" Visible="false">
                 <AlternatingItemTemplate>
                     <tr style="background-color: #FFFFFF; color: #284775;">
                         <td>
                             <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                             <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                         </td>
                         <td>
                             <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                     </tr>
                 </AlternatingItemTemplate>
                 <EditItemTemplate>
                     <tr style="background-color: #999999;">
                         <td>
                             <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                             <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                         </td>
                         <td>
                             <asp:TextBox Text='<%# Bind("unitID") %>' runat="server" ID="unitIDTextBox" /></td>
                         <td>
                             <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" ID="unitNumberTextBox" /></td>
                         <td>
                             <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                     </tr>
                 </EditItemTemplate>
                 <EmptyDataTemplate>
                     <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
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
                             <asp:TextBox Text='<%# Bind("unitID") %>' runat="server" ID="unitIDTextBox" /></td>
                         <td>
                             <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" ID="unitNumberTextBox" /></td>
                         <td>
                             <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                     </tr>
                 </InsertItemTemplate>
                 <ItemTemplate>
                     <tr style="background-color: #E0FFFF; color: #333333;">
                         <td>
                             <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                             <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                         </td>
                         <td>
                             <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                     </tr>
                 </ItemTemplate>
                 <LayoutTemplate>
                     <table runat="server">
                         <tr runat="server">
                             <td runat="server">
                                 <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                     <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                         <th runat="server"></th>
                                         <th runat="server">unitID</th>
                                         <th runat="server">unitNumber</th>
                                         <th runat="server">dateModified</th>
                                     </tr>
                                     <tr runat="server" id="itemPlaceholder"></tr>
                                 </table>
                             </td>
                         </tr>
                         <tr runat="server">
                             <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF"></td>
                         </tr>
                     </table>
                 </LayoutTemplate>
                 <SelectedItemTemplate>
                     <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                         <td>
                             <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                             <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                         </td>
                         <td>
                             <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                     </tr>
                 </SelectedItemTemplate>
             </asp:ListView>

         </div>



        <asp:ObjectDataSource ID="SiteODS" runat="server" 
            OldValuesParameterFormatString="original_{0}" 
            SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
        

        <asp:ObjectDataSource ID="UnitsCrud" runat="server" DeleteMethod="DisableUnit" InsertMethod="AddUnit" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitController" UpdateMethod="UpdateUnit">
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

