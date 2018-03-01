<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ChangeSurveyWord.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_ChangeSurveyWord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Change Survey Words</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card container">
                <div class="row">
                    <asp:Label ID="HospitalLabel" class="col-md-3 my-2" style="font-weight:bold;font-size:large;" runat="server" Text="Hospital: " />
                    <asp:Label ID="Label1" class="col-md-4 pl-0 my-2" style="font-weight:bold;font-size:large;" runat="server" Text="Misericordia Hospital" />
                </div>
                <div class="row">
                    <asp:Label ID="SearchWordLabel" class="col-md-3 my-2" style="font-weight:bold;font-size:large;" runat="server" Text="Search Word: " />
                    <asp:TextBox ID="SearchWordTextBox" class="col-md-4 mr-5 my-2" runat="server" placeholder="Type word to search for..." />
                    <asp:Button ID="SearchWordButton" class="col-md-2 ml-5 my-2 btn btn-info" runat="server" Text="Search" OnClick="SearchWordButton_Click" />
                </div>
                <div class="row">
                    <asp:Label ID="AddWordLabel" class="col-md-3 my-2" style="font-weight:bold;font-size:large;" runat="server" Text="Add Word: " />
                    <asp:TextBox ID="AddWordTextBox" class="col-md-4 mr-5 my-2" runat="server" placeholder="Type word to add..." />
                    <asp:Button ID="AddWordButton" class="col-md-2 ml-5 my-2 btn btn-success" runat="server" Text="Add" OnClick="AddWordButton_Click" />
                </div>
            </div>
            <div class="card container">
                <%-- ListView to be configured to survey word ODS... --%>
                <asp:ListView runat="server" DataSourceID="SurveyWordODS"></asp:ListView>
                <%--<asp:ObjectDataSource ID="SurveyWordODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetAllSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController"></asp:ObjectDataSource>--%>
            </div>
        </div>
    </div>

</asp:Content>

