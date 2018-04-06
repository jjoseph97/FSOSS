<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Units.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_UnitsCrud" %>
<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight:bold;"> Manage Units</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="col-sm-12">
                <uc1:messageusercontrol runat="server" class="alert alert-danger mb-2 card" id="MessageUserControl" />
            </div>
            <asp:Label ID="SuccessAlert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
    
         <div class="col-sm-12">
             <div class="card container mb-2">
               <asp:Label ID="SearchUnitLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Search units: " />
               <asp:DropDownList ID="SiteDropDownList" class="col-sm-3 my-2 form-control" runat="server" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID"></asp:DropDownList>
               <asp:Button ID="SearchUnitButton" class="btn btn-info" runat="server" Text="Search" OnClick="SearchUnitButton_Click" />
                 </div>


          </div>
       
         <div class="card container mb-2">
              <div class="row container mx-auto px-0">
                    <asp:Button ID="DisplayArchivedButton" class="col-sm-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="DisplayArchivedButton_Click" Visible="false"></asp:Button>
                    <asp:Button ID="DisplayActiveButton" class="col-sm-2 mt-2 btn btn-info border border-dark" runat="server" Text="Show Active" OnClick="DisplayActiveButton_Click" Visible="false"></asp:Button>
                </div>


<%--------------------  Active Units ListView --------------------------%>
             <asp:ListView ID="UnitsListView" runat="server" DataSourceID="UnitsCrudODS" DataKeyNames="unitID" InsertItemPosition="LastItem" Visible="false">
                 <AlternatingItemTemplate>
                     <tr style="background-color: #bdfeff; color: #284775;">
                        
                         <td>
                             <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                          <td>
                             <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text="Close" ID="Button1" /></td>
                         <td>
                             <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-primary mx-3 my-1" Text="Edit" ID="Button2" />
                         </td>
                         
                      
                     </tr>
                 </AlternatingItemTemplate>
                 <EditItemTemplate>
                     <tr style="background-color: #bdfeff;">
                       
                         <td>
                             <asp:Label Text='<%# Bind("unitID") %>' runat="server" ID="unitIDTextBox" /></td>
                         <td>
                             <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" ID="unitNumberTextBox" /></td>
                           <td>
                             <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-primary mx-3 my-1" Text="Update" ID="UpdateButton" /></td>
                         <td>
                             <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
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
                     <tr style="background-color: #E0FFFF; color: #333333;">
                        
                         <td>
                             <asp:Label Text='<%# Bind("unitID") %>' runat="server" ID="unitIDTextBox" /></td>
                         <td>
                             <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" ID="unitNumberTextBox" /></td>
                          <td>
                             <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /></td>
                         <td>
                             <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                         </td>
                      
                     </tr>
                 </InsertItemTemplate>
                 <ItemTemplate>
                     <tr style="background-color: #E0FFFF; color: #333333;">
                        
                         <td>
                             <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                          <td>
                             <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text="Close" ID="DeleteButton" /></td>
                            <td>
                             <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-primary mx-3 my-1" Text="Edit" ID="EditButton" />

                         </td>
                 
                     </tr>
                 </ItemTemplate>
                 <LayoutTemplate>
                     <table runat="server">
                         <tr runat="server">
                             <td runat="server">
                                 <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                     <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                         <th runat="server">Unit ID</th>
                                         <th runat="server">Unit Number</th>
                                         <th runat="server">Close Unit</th>
                                         <th runat="server"></th>
                                    
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
                     <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                      
                         <td>
                             <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                         <td>
                             <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>

                            <td>
                             <asp:Button runat="server" CommandName="Delete" Text="Close" CssClass="btn btn btn-danger mx-3 my-1" ID="DeleteButton" />
                         </td>
                          <td>
                             <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-primary mx-3 my-1" Text="Edit" ID="EditButton" />
                          </td>
            
                     </tr>
                 </SelectedItemTemplate>
             </asp:ListView>

         </div>

 <%-- -----------------Archived UNITS Listview Section------------------%>








<%-- ---------------------------------------------------ObjectDataSources-------------------------------------%>


<%-- -----------------Site Search ODS-----------------------%>
        <asp:ObjectDataSource ID="SiteODS" runat="server" 
            OldValuesParameterFormatString="{0}" 
            SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>




<%-- -----------------Active Units List ODS------------------%>
        <asp:ObjectDataSource ID="UnitsCrudODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitController" DataObjectTypeName="FSOSS.System.Data.POCOs.UnitsPOCO" DeleteMethod="SwitchUnitSatus" InsertMethod="AddUnit" UpdateMethod="UpdateUnit">
            <SelectParameters>
                <asp:ControlParameter ControlID="SiteDropDownList" PropertyName="SelectedValue" Name="site_id" Type="Int32"></asp:ControlParameter>
            </SelectParameters>
        </asp:ObjectDataSource>
  
        

<%-- -----------------Archived Units List ODS------------------%>     
      



   </div>

</asp:Content>

