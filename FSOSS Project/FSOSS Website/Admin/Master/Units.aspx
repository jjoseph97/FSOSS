﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Units.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_UnitsCrud" %>

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
                <asp:DropDownList ID="SiteDropDownList" class="col-sm-4 my-2" runat="server" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID"></asp:DropDownList>
                <asp:Button ID="SearchUnitButton" class="col-sm-2 offset-sm-2 my-2 btn btn-info"  runat="server" Text="Search" OnClick="SearchUnitButton_Click" />
             </div>
            </div>

            <asp:Label ID="SelectedSiteID" runat="server" Visible="false" />

        </div>
        <div class="col-sm-12">
        <div class="card container mb-2">
            
           
                <asp:Button ID="ArchivedButton" class="col-sm-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived"  OnClick="ArchivedButton_Click" Visible="false"></asp:Button>
                <asp:Button ID="ActiveButton" class="col-sm-2 mt-2 btn btn-info border border-dark" runat="server" Text="Show Active"  OnClick="ActiveButton_Click" Visible="false"></asp:Button>
            


            <%--------------------  Active Units ListView --------------------------%>
            
            <asp:ListView ID="UnitsListView" runat="server" Visible="False" DataSourceID="UnitsODS" DataKeyNames="unitID" InsertItemPosition="FirstItem">



                <AlternatingItemTemplate>
                    <tr  style="background-color: #bbf2ff; color: #284775;">


                        <td>
                            <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                        <td style="display: none;">
                            <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>

                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Disable" ID="DeleteButton" class="btn btn-danger mx-3 my-1" />
                            </td>
                        <td>
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" class="btn btn-success mx-3 my-1"  />
                        </td>

                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="background-color: #fdff94;">
                       

                        
                        <td>
                            <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" ID="unitNumberTextBox" /></td>
                        <td style="display: none;">
                            <asp:Label Text='<%# Bind("unitID") %>' runat="server" ID="unitIDTextBox" Visible="false" /></td>
                         <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" class="btn btn-success mx-3 my-1"  />
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
                    <tr style="" >


                        <td>
                            <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" ID="unitNumberTextBox" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" class="btn btn-primary mx-3 my-1" />
                            </td>
                        <td>
                            <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" class="btn btn-warning mx-3 my-1" />
                        </td>
                    </tr>
                   
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="background-color: #E0FFFF; color: #333333;">


                        <td>
                            <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                        <td style="display: none;">
                            <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Disable" ID="DeleteButton"  class="btn btn-danger mx-3 my-1" />
                            </td>
                        <td>
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" class="btn btn-success mx-3 my-1" />
                        </td>

                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    </table>
                    <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                        <tr runat="server">
                            <td runat="server">
                                 <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                    <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                        <th runat="server">Unit Number</th>
                                        <th runat="server"></th>
                                          <th runat="server"></th>


                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                         <tr runat="server" class="mx-2 my-2">
                                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                        <asp:DataPager runat="server" ID="DataPager2">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">


                        <td>
                            <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                        <td style="display: none;">
                            <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Disable" ID="Button1" class="btn btn-danger mx-3 my-1" />
                            </td>
                        <td>
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="Button2" class="btn btn-success mx-3 my-1" />
                        </td>

                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>


        

        <%-- -----------------Archived UNITS Listview Section------------------%>
        <asp:ListView ID="ArchivedUnitsListView" runat="server" Visible="false" DataKeyNames="unitID" DataSourceID="ArchivedUnitsODS">
            <AlternatingItemTemplate>
                <tr style="background-color: #bbf2ff; color: #284775;">
                   
                    <td style="display: none;">
                        <asp:Label Text='<%# Eval("unitID") %>' runat="server" ID="unitIDLabel" Visible="false" /></td>
                 
                    <td>
                        <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
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
                        <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                    <td>
                        <asp:Button runat="server" CommandName="Delete" Text="Enable" ID="DeleteButton" class="btn btn-success mx-3 my-1"/>
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                             <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                    <th runat="server" class="col-sm-4 py-2" >Unit Number</th>
                                    <th runat="server" class="col-sm-6 py-2">Date Modified</th>
                                    <th runat="server" class="col-sm-4 py-2" ></th>

                              
                                </tr>
                                <tr runat="server" id="itemPlaceholder"></tr>
                            </table>
                        </td>
                    </tr>
                     <tr runat="server" class="mx-2 my-2">
                                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                        <asp:DataPager runat="server" ID="DataPager2">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
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
                        <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /></td>
                    <td>
                        <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                  <td>
                        <asp:Button runat="server" CommandName="Delete" Text="Enable" ID="DeleteButton" class="btn btn-success mx-3 my-1"/>
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


        <%--OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException"--%>
        <%--<asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>--%>
    </div>

</asp:Content>

