<%@ Page Title="Change Survey Word" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ChangeSurveyWord.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_ChangeSurveyWord" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Change Survey Words</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
        </div>
        <div class="col-md-12">
            <div class="card container mb-2">
                <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="SearchWordButton">
                    <asp:Label ID="SearchWordLabel" class="col-md-4 my-2 text-center text-md-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Search Word: " />
                    <asp:TextBox ID="SearchWordTextBox" class="col-md-4 my-2 form-control" runat="server" placeholder="Type word to search for..." Style="background-color: #FFFFFF;" />
                    <asp:Button ID="SearchWordButton" class="col-md-2 offset-md-2 my-2 btn btn-info" runat="server" Text="Search" OnClick="SearchWordButton_Click" />
                    <asp:Button ID="ClearSearchButton" class="col-md-2 offset-md-2 my-2 btn btn-light border border-info" runat="server" Text="Clear Search" OnClick="ClearSearchButton_Click" Visible="false" />
                </asp:Panel>
                <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="AddWordButton">
                    <asp:Label ID="AddWordLabel" class="col-md-4 my-2 text-center text-md-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Word: " />
                    <asp:TextBox ID="AddWordTextBox" class="col-md-4 my-2 form-control" runat="server" placeholder="Type word to add..." Style="background-color: #FFFFFF;" />
                    <asp:Button ID="AddWordButton" class="col-md-2 offset-md-2 my-2 btn btn-success" runat="server" Text="Add Word" OnClick="AddWordButton_Click" />
                </asp:Panel>
            </div>
            <div class="card container">
                <div class="row container mx-auto px-0">
                    <asp:Button ID="ShowArchivedButton" class="col-md-3 col-lg-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="ShowArchivedButton_Click"></asp:Button>
                    <asp:Button ID="ShowActiveButton" class="col-md-3 col-lg-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Active" OnClick="ShowActiveButton_Click" Visible="false"></asp:Button>
                </div>
                <asp:ListView ID="SurveyWordListView" runat="server" DataSourceID="ActiveSurveyWordODS" DataKeyNames="surveyWordID" OnItemDataBound="SurveyWordListView_ItemDataBound">
                    <AlternatingItemTemplate>
                        <tr class="fsoss-listview-alternate">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("surveyWordID") %>' runat="server" ID="surveyWordIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" CssClass="pl-3" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="pl-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="pl-3" ID="usernameLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Disable" ID="DisableButton" />
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Delete" Text="Enable" ID="EnableButton" Visible="false" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr class="listview-header">
                            <td style="display: none;">
                                <asp:TextBox Text='<%# Bind("surveyWordID") %>' runat="server" ID="surveyWordIDTextBox" Visible="false" /></td>
                            <td>
                                <asp:Panel runat="server" DefaultButton="UpdateButton">
                                    <asp:TextBox Text='<%# Bind("surveyWord") %>' runat="server" CssClass="mx-3 pl-3" ID="surveyWordTextBox" />
                                </asp:Panel>
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="pl-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="pl-3" ID="usernameLabel" /></td>
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
                        <tr class="fsoss-listview-itemtemplate">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("surveyWordID") %>' runat="server" ID="surveyWordIDLabel" Visible="false" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("surveyWord") %>' runat="server" CssClass="pl-3" ID="surveyWordLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateModified") %>' runat="server" CssClass="pl-3" ID="dateModifiedLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("username") %>' runat="server" CssClass="pl-3" ID="usernameLabel" /></td>
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
                                    <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server">
                                            <th runat="server" class="w-20 p-3">Survey Word</th>
                                            <th runat="server" class="w-25 p-3">Last Modified On</th>
                                            <th runat="server" class="w-25 p-3">Last Modified By</th>
                                            <th runat="server" class="w-15 p-3">Edit Word</th>
                                            <th runat="server" class="w-15 p-3">Change Availability</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" class="mx-2 my-2">
                                <td runat="server" class="listview-pager">
                                    <asp:DataPager runat="server" ID="SurveyListDataPager">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark mt-2" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                            <asp:TemplatePagerField>
                                                <PagerTemplate>
                                                    <div class="my-2 text-white">
                                                        <b>Page <asp:Label runat="server" ID="CurrentPageLabel" Text='<%# ( Container.StartRowIndex / Container.PageSize) + 1 %>' /> of
                                                            <asp:Label runat="server" ID="TotalPagesLabel" Text='<%# Math.Ceiling( ((double)Container.TotalRowCount) / Container.PageSize) %>' /> (<asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' /> records)
                                                        </b>
                                                    </div>
                                                </PagerTemplate>
                                            </asp:TemplatePagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
                <asp:ObjectDataSource ID="ActiveSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetActiveSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController"
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord" InsertMethod="AddWord" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ArchivedSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetArchivedSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController"
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord" InsertMethod="AddWord" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="SearchActiveSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetSearchedActiveSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController"
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="SearchWordTextBox" PropertyName="Text" Name="surveyWord" Type="String"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="SearchArchivedSurveyWordODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetSearchedArchivedSurveyWord" TypeName="FSOSS.System.BLL.PotentialSurveyWordController"
                    DeleteMethod="ChangeAvailability" UpdateMethod="UpdateWord" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                    <DeleteParameters>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="SearchWordTextBox" PropertyName="Text" Name="surveyWord" Type="String"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="surveyWord" Type="String"></asp:Parameter>
                        <asp:Parameter Name="surveyWordID" Type="Int32"></asp:Parameter>
                        <asp:SessionParameter Name="userID" SessionField="userID" Type="Int32"></asp:SessionParameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
    </div>
</asp:Content>

