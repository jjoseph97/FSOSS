<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ChangeSurveyWord.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_ChangeSurveyWord" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight:bold;">Change Survey Words</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
            <asp:Label ID="SuccessAlert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="SearchWordLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Search Word: " />
                    <asp:TextBox ID="SearchWordTextBox" class="col-sm-4 my-2" runat="server" placeholder="Type word to search for..." style="background-color: #FFFFFF;" />
                    <asp:Button ID="SearchWordButton" class="col-sm-2 offset-sm-2 my-2 btn btn-info" runat="server" Text="Search" OnClick="SearchWordButton_Click" />
                    <asp:Button ID="ClearSearchButton" class="col-sm-2 offset-sm-2 my-2 btn btn-light border border-info" runat="server" Text="Clear Search" OnClick="ClearSearchButton_Click" Visible="false" />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="AddWordLabel" class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Add Word: " />
                    <asp:TextBox ID="AddWordTextBox" class="col-sm-4 my-2" runat="server" placeholder="Type word to add..." style="background-color: #FFFFFF;" />
                    <asp:Button ID="AddWordButton" class="col-sm-2 offset-sm-2 my-2 btn btn-success" runat="server" Text="Add" OnClick="AddWordButton_Click" />
                </div>
            </div>
            <div class="card container">
                <div class="row container mx-auto px-0">
                    <asp:Button ID="ShowArchivedButton" class="col-sm-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="ShowArchivedButton_Click"></asp:Button>
                    <asp:Button ID="ShowActiveButton" class="col-sm-2 mt-2 btn btn-info border border-dark" runat="server" Text="Show Active" OnClick="ShowActiveButton_Click" Visible="false"></asp:Button>
                </div>
                <asp:ListView ID="SurveyWordListView" runat="server" DataSourceID="ActiveSurveyWordODS" DataKeyNames="surveyWordID" OnItemDataBound="SurveyWordListView_ItemDataBound" OnItemCommand="SurveyWordListView_ItemCommand">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #bbf2ff; color: #284775;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("surveyWordID") %>' runat="server" ID="surveyWordIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" CssClass="pl-3" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Disable" ID="DisableButton" />
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Delete" Text="Enable" ID="EnableButton" Visible="false" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="background-color: #fdff94;">
                            <td style="display:none;">
                                <asp:TextBox Text='<%# Bind("surveyWordID") %>' runat="server" ID="surveyWordIDTextBox" Visible="false" /></td>
                            <td>
                                <asp:TextBox Text='<%# Bind("surveyWord") %>' runat="server" CssClass="pl-3" ID="surveyWordTextBox" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Update" Text="Update" ID="UpdateButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Cancel" Text="Cancel" ID="CancelButton" /></td>
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
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" CssClass="pl-3" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Disable" ID="DisableButton" />
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Delete" Text="Enable" ID="EnableButton" Visible="false" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                            <th runat="server" class="col-sm-6 py-2">Survey Word</th>
                                            <th runat="server" class="col-sm-3 py-2">Edit Word</th>
                                            <th runat="server" class="col-sm-3 py-2">Change Availability</th>
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
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" CssClass="pl-3" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Disable" ID="DisableButton" />
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Delete" Text="Enable" ID="EnableButton" Visible="false" /></td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:ObjectDataSource ID="ActiveSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetActiveSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController" 
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord" InsertMethod="AddWord" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ArchivedSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetArchivedSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController" 
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord" InsertMethod="AddWord" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="SearchActiveSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetSearchedActiveSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController" 
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="SearchWordTextBox" PropertyName="Text" Name="surveyWord" Type="String"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="SearchArchivedSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetSearchedArchivedSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController" 
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord"  OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="SearchWordTextBox" PropertyName="Text" Name="surveyWord" Type="String"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
    </div>
</asp:Content>

