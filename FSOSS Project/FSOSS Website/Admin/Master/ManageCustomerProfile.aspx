<%@ Page Title="Manager Customer Profile" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageCustomerProfile.aspx.cs" Inherits="Admin_Master_ManageCustomerProfile" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Manage Customer Profile:</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="col-md-12">
                <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
            </div>
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="col-md-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="CustomerProfileLabel" class="col-md-4 my-2 text-center text-md-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Select Customer Profile Category:"></asp:Label>
                    <asp:DropDownList ID="CustomerProfileDropDownList" class="col-md-3 my-2 form-control" runat="server" AppendDataBoundItems="true" OnSelectedIndexChanged="CustomerProfileDDL_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Text="Age Ranges" Value="0" Selected="True" />
                        <asp:ListItem Text="Genders" Value="1" />
                        <asp:ListItem Text="Meals" Value="3" />
                        <asp:ListItem Text="Participant Types" Value="2" />
                    </asp:DropDownList>
                </div>
                <asp:Button ID="RevealButton" class="col-md-3 col-lg-2 mt-2 my-2 mx-3 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="ToggleView" /><br />

            </div>
            <div class="card container">
                <%--site show section--%>
                <%--The gender list--%>
                <div id="Genders" runat="server">
                    <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="AddGenderButton">
                        <asp:Label ID="AddGenderLabel" class="col-md-4 my-2 text-center text-md-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Gender: " />
                        <asp:TextBox ID="AddGenderBox" class="col-md-4 my-2 form-control" runat="server" placeholder="Type gender to add..." Style="background-color: #FFFFFF;" />
                        <asp:Button ID="AddGenderButton" class="col-md-2 offset-md-2 my-2 btn btn-success" runat="server" Text="Add Gender" OnClick="AddGenderButton_Click" />
                    </asp:Panel>

                    <%-- ODS for Active Genders  --%>
                    <asp:ObjectDataSource ID="GenderODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetGenderList" TypeName="FSOSS.System.BLL.GenderController" DeleteMethod="ArchiveGender" InsertMethod="AddGender" UpdateMethod="UpdateGender" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="genderDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="genderDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>

                    <%-- ODS for archived Genders --%>
                    <asp:ObjectDataSource ID="ArchivedGenderODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetArchivedGenderList" TypeName="FSOSS.System.BLL.GenderController" DeleteMethod="ArchiveGender" UpdateMethod="UpdateGender" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="genderDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>

                    <%-- The Gender ListView --%>
                    <asp:ListView ID="GenderListView" runat="server" DataSourceID="GenderODS" DataKeyNames="genderID" OnItemDataBound="ListView_ItemDataBound">
                        <AlternatingItemTemplate>
                            <tr class="fsoss-listview-alternate">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("genderID") %>' runat="server" ID="genderIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("genderDescription") %>' runat="server" ID="genderDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr class="listview-header">
                                <td style="display: none">
                                    <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("genderID") %>' runat="server" ID="genderIDTextBox" /></td>
                                <td>
                                    <asp:Panel runat="server" DefaultButton="UpdateButton">
                                        <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("genderDescription") %>' runat="server" ID="genderDescriptionTextBox" />
                                    </asp:Panel>
                                </td>
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="CancelButton" />
                                </td>
                                <td>
                            </tr>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <p class="text-center">No Genders data were found.</p>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr class="fsoss-listview-itemtemplate">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("genderID") %>' runat="server" ID="genderIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("genderDescription") %>' runat="server" ID="genderDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" style="width: 100%;">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                            <tr runat="server">
                                                <th runat="server" class="w-25 p-3">Gender</th>
                                                <th runat="server" class="w-25 p-3">Last Modified On</th>
                                                <th runat="server" class="w-20 p-3">Last Modified By</th>
                                                <th runat="server" class="w-15 p-3">Edit</th>
                                                <th runat="server" class="w-15 p-3">Change Availability</th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF"></td>
                                </tr>
                                <tr runat="server" class="mx-2 my-2">
                                    <td runat="server" class="listview-pager">
                                        <asp:DataPager runat="server" ID="SurveyListDataPager">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark mt-2" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                                <asp:TemplatePagerField>
                                                    <PagerTemplate>
                                                        <div class="my-2 text-white">
                                                            <b>Page
                                                                <asp:Label runat="server" ID="CurrentPageLabel" Text='<%# ( Container.StartRowIndex / Container.PageSize) + 1 %>' />
                                                                of
                                                            <asp:Label runat="server" ID="TotalPagesLabel" Text='<%# Math.Ceiling( ((double)Container.TotalRowCount) / Container.PageSize) %>' />
                                                                (<asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' />
                                                                records)
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
                        <SelectedItemTemplate>
                            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("genderID") %>' runat="server" ID="genderIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("genderDescription") %>' runat="server" ID="genderDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>

                <%-- The participant type list--%>
                <div id="ParticipantTypes" runat="server">
                    <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="AddPTButton">
                        <asp:Label ID="AddPTLabel" class="col-md-4 my-2 text-center text-md-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Participant Type: " />
                        <asp:TextBox ID="AddPTBox" class="col-md-4 my-2 form-control" runat="server" placeholder="Type participant type to add..." Style="background-color: #FFFFFF;" />
                        <asp:Button ID="AddPTButton" class="col-md-2 offset-md-2 my-2 btn btn-success" runat="server" Text="Add Participant Type" OnClick="AddPTButton_Click" />
                    </asp:Panel>

                    <%-- pt ods --%>
                    <asp:ObjectDataSource ID="PTODS" runat="server" DeleteMethod="ArchiveParticipantType" InsertMethod="AddParticipantType" OldValuesParameterFormatString="{0}" SelectMethod="GetParticipantTypeList" TypeName="FSOSS.System.BLL.ParticipantController" UpdateMethod="UpdateParticipantType" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="participantTypeID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="participantTypeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="participantTypeID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="participantTypeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="ArchivedPTODS" runat="server" DeleteMethod="ArchiveParticipantType" InsertMethod="AddParticipantType" OldValuesParameterFormatString="{0}" SelectMethod="GetArchivedParticipantTypeList" TypeName="FSOSS.System.BLL.ParticipantController" UpdateMethod="UpdateParticipantType" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="participantTypeID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="participantTypeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="participantTypeID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="participantTypeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>

                    <%-- pt listview --%>
                    <asp:ListView ID="PTListview" runat="server" DataSourceID="PTODS" DataKeyNames="participantTypeID" OnItemDataBound="ListView_ItemDataBound">
                        <AlternatingItemTemplate>
                            <tr class="fsoss-listview-alternate">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td class="pl-3">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>

                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr class="listview-header">
                                <td style="display: none">
                                    <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                <td>
                                    <asp:Panel runat="server" DefaultButton="UpdateButton">
                                        <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" MaxLength="25" />
                                    </asp:Panel>
                                </td>
                                <td></td>

                                <td></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="CancelButton" />
                                </td>
                            </tr>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <p class="text-center">No Participant Types data were found.</p>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr class="fsoss-listview-itemtemplate">

                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td class="pl-3">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                            <tr runat="server">
                                                <th runat="server" class="w-25 p-3">Participant Type</th>
                                                <th runat="server" class="w-25 p-3">Last Modified On</th>
                                                <th runat="server" class="w-20 p-3">Last Modified By</th>
                                                <th runat="server" class="w-15 p-3">Edit</th>
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
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                                <asp:TemplatePagerField>
                                                    <PagerTemplate>
                                                        <div class="my-2 text-white">
                                                            <b>Page
                                                                <asp:Label runat="server" ID="CurrentPageLabel" Text='<%# ( Container.StartRowIndex / Container.PageSize) + 1 %>' />
                                                                of
                                                            <asp:Label runat="server" ID="TotalPagesLabel" Text='<%# Math.Ceiling( ((double)Container.TotalRowCount) / Container.PageSize) %>' />
                                                                (<asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' />
                                                                records)
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
                        <SelectedItemTemplate>
                            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td class="pl-3">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" />
                                </td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn btn-success mx-3 my-1" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>

                <%--the meal list--%>
                <div id="Meals" runat="server">
                    <%-- Add Meals --%>
                    <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="AddMealsButton">
                        <asp:Label ID="AddMealsLabel" class="col-md-4 my-2 text-center text-md-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Meal: " />
                        <asp:TextBox ID="AddMealsTextBox" class="col-md-4 my-2 form-control" runat="server" placeholder="Type meals to add..." Style="background-color: #FFFFFF;" />
                        <asp:Button ID="AddMealsButton" class="col-md-2 offset-md-2 my-2 btn btn-success" runat="server" Text="Add Meal" OnClick="AddMealButton_Click" />
                    </asp:Panel>

                    <%-- ODS Section --%>
                    <asp:ObjectDataSource ID="MealsODS" runat="server" DeleteMethod="ArchiveMeal" OldValuesParameterFormatString="{0}" SelectMethod="GetMealList" TypeName="FSOSS.System.BLL.MealController" UpdateMethod="UpdateParticipantType" InsertMethod="AddMeal" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="mealID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="mealName" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="mealID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="mealName" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="ArchivedMealsODS" runat="server" DeleteMethod="ArchiveMeal" InsertMethod="AddMeal" OldValuesParameterFormatString="{0}" SelectMethod="GetArchivedMealList" TypeName="FSOSS.System.BLL.MealController" UpdateMethod="UpdateParticipantType" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="mealID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="mealName" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="mealID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="mealName" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>

                    <%-- The Meals Listview --%>
                    <asp:ListView ID="MealsListView" runat="server" DataSourceID="MealsODS" DataKeyNames="mealID" OnItemDataBound="ListView_ItemDataBound">
                        <AlternatingItemTemplate>
                            <tr class="fsoss-listview-alternate">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("mealID") %>' runat="server" ID="mealIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr class="listview-header">
                                <td style="display: none">
                                    <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("mealID") %>' runat="server" ID="mealIDTextBox" /></td>
                                <td>
                                    <asp:Panel runat="server" DefaultButton="UpdateButton">
                                        <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("mealName") %>' runat="server" ID="mealNameTextBox" />
                                    </asp:Panel>
                                </td>
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="CancelButton" />
                                </td>
                            </tr>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <p class="text-center">No Meals data were found.</p>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr class="fsoss-listview-itemtemplate">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("mealID") %>' runat="server" ID="mealIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" style="width: 100%;">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                            <tr runat="server">
                                                <th runat="server" class="w-25 p-3">Meal</th>
                                                <th runat="server" class="w-25 p-3">Last Modified On</th>
                                                <th runat="server" class="w-20 p-3">Last Modified By</th>
                                                <th runat="server" class="w-15 p-3">Edit</th>
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
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                                <asp:TemplatePagerField>
                                                    <PagerTemplate>
                                                        <div class="my-2 text-white">
                                                            <b>Page
                                                                <asp:Label runat="server" ID="CurrentPageLabel" Text='<%# ( Container.StartRowIndex / Container.PageSize) + 1 %>' />
                                                                of
                                                            <asp:Label runat="server" ID="TotalPagesLabel" Text='<%# Math.Ceiling( ((double)Container.TotalRowCount) / Container.PageSize) %>' />
                                                                (<asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' />
                                                                records)
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
                        <SelectedItemTemplate>
                            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("mealID") %>' runat="server" ID="mealIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>
                <%-- end of meals--%>


                <%--the age range list--%>
                <div id="AgeRanges" runat="server">
                    <%-- Add Age Range --%>
                    <asp:Panel runat="server" CssClass="row container mx-auto px-0" DefaultButton="AddAgeRangeButton">
                        <asp:Label ID="AddAgeRangeLabel" class="col-md-4 my-2 text-center text-md-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Age Range: " />
                        <asp:TextBox ID="AddAgeRangeTextBox" class="col-md-4 my-2 form-control" runat="server" placeholder="Type age range to add..." Style="background-color: #FFFFFF;" />
                        <asp:Button ID="AddAgeRangeButton" class="col-md-2 offset-md-2 my-2 btn btn-success" runat="server" Text="Add Age Range" OnClick="AddARButton_Click" />
                    </asp:Panel>

                    <%-- ODS Section --%>
                    <asp:ObjectDataSource ID="AgeRangeODS" runat="server" DeleteMethod="ArchiveAgeRange" InsertMethod="AddAgeRange" OldValuesParameterFormatString="{0}" SelectMethod="GetAgeRangeList" TypeName="FSOSS.System.BLL.AgeRangeController" UpdateMethod="UpdateAgeRange" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="ageRangeID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ageRangeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="ageRangeID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="ageRangeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    <asp:ObjectDataSource ID="ArchivedAgeRangeODS" runat="server" DeleteMethod="ArchiveAgeRange" InsertMethod="AddAgeRange" OldValuesParameterFormatString="{0}" SelectMethod="GetArchivedAgeRangeList" TypeName="FSOSS.System.BLL.AgeRangeController" UpdateMethod="UpdateAgeRange" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="ageRangeID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="ageRangeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="ageRangeID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="ageRangeDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32" DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>

                    <%-- The Age Range ListView --%>
                    <asp:ListView ID="AgeRangeListView" runat="server" DataSourceID="AgeRangeODS" DataKeyNames="ageRangeID" OnItemDataBound="ListView_ItemDataBound">
                        <AlternatingItemTemplate>
                            <tr class="fsoss-listview-alternate">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("ageRangeID") %>' runat="server" ID="ageRangeIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr class="listview-header">
                                <td style="display: none">
                                    <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("ageRangeID") %>' runat="server" ID="ageRangeIDTextBox" /></td>
                                <td>
                                    <asp:Panel runat="server" DefaultButton="UpdateButton">
                                        <asp:TextBox CssClass="mx-3 my-1" Text='<%# Bind("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionTextBox" />
                                    </asp:Panel>
                                </td>
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="CancelButton" />
                                </td>
                            </tr>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <p class="text-center">No Age Ranges data were found.</p>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr class="fsoss-listview-itemtemplate">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("ageRangeID") %>' runat="server" ID="ageRangeIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                            <tr runat="server">
                                                <th runat="server" class="w-25 p-3">Age Range</th>
                                                <th runat="server" class="w-25 p-3">Last Modified On</th>
                                                <th runat="server" class="w-20 p-3">Last Modified By</th>
                                                <th runat="server" class="w-15 p-3">Edit</th>
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
                                                <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                                <asp:TemplatePagerField>
                                                    <PagerTemplate>
                                                        <div class="my-2 text-white">
                                                            <b>Page
                                                                <asp:Label runat="server" ID="CurrentPageLabel" Text='<%# ( Container.StartRowIndex / Container.PageSize) + 1 %>' />
                                                                of
                                                            <asp:Label runat="server" ID="TotalPagesLabel" Text='<%# Math.Ceiling( ((double)Container.TotalRowCount) / Container.PageSize) %>' />
                                                                (<asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' />
                                                                records)
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
                        <SelectedItemTemplate>
                            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                                <td style="display: none">
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("ageRangeID") %>' runat="server" ID="ageRangeIDLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>

                </div>
                <%--end of age range--%>
            </div>
        </div>
    </div>
</asp:Content>

