<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Units.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_UnitsCrud" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight:bold;"> Manage Units</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="SuccessAlert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
    
         <div class="col-sm-12">
             <div class="card container mb-2">
               <asp:Label ID="SearchUnitLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Search units: " />
               <asp:DropDownList ID="SiteDropDownList" runat="server" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID"></asp:DropDownList>
               <asp:Button ID="SearchUnitButton" class="btn btn-info" runat="server" Text="Search" OnClick="SearchUnitButton_Click" />
                 </div>
          </div>
       
         <div class="card container mb-2">
              <div class="row container mx-auto px-0">
                    <asp:Button ID="DisplayArchivedButton" class="col-sm-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="DisplayArchivedButton_Click"></asp:Button>
                    <asp:Button ID="DisplayActiveButton" class="col-sm-2 mt-2 btn btn-info border border-dark" runat="server" Text="Show Active" OnClick="DisplayActiveButton_Click" Visible="false"></asp:Button>
                </div>
           

         </div>



        <asp:ObjectDataSource ID="SiteODS" runat="server" 
            OldValuesParameterFormatString="{0}" 
            SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>



       
     
   </div>

</asp:Content>

