<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ChangeSurveyWord.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_ChangeSurveyWord" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Change Survey Words</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
             <asp:Label ID="DeleteAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
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
                <asp:ListView ID="SurveyWordListView" runat="server" DataSourceID="SurveyWordODS" DataKeyNames="surveyWordID" OnItemCommand="SurveyWordListView_ItemCommand">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #FFFFFF; color: #284775;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("surveyWordID") %>' runat="server" ID="surveyWordIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success ml-2" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger ml-2" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="background-color: #999999;">
                            <td style="display:none;">
                                <asp:TextBox Text='<%# Bind("surveyWordID") %>' runat="server" ID="surveyWordIDTextBox" Visible="false" /></td>
                            <td>
                                <asp:TextBox Text='<%# Bind("surveyWord") %>' runat="server" ID="surveyWordTextBox" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success ml-2" CommandName="Update" Text="Update" ID="UpdateButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger ml-2" CommandName="Cancel" Text="Cancel" ID="CancelButton" /></td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #E0FFFF; color: #333333;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("surveyWordID") %>' runat="server" ID="surveyWordIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success ml-2" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger ml-2" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 85%; margin-top: 15px;">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                            <th runat="server" class="col-md-6">Survey Word</th>
                                            <th runat="server" class="col-md-3">Edit Word</th>
                                            <th runat="server" class="col-md-3">Delete Word</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("surveyWordID") %>' runat="server" ID="surveyWordIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success ml-2" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger ml-2" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:ObjectDataSource ID="SurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetAllSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController" DeleteMethod="DeleteWord" UpdateMethod="UpdateWord" InsertMethod="AddWord">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
    </div>

</asp:Content>

