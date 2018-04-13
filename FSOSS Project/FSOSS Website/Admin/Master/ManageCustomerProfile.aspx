<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageCustomerProfile.aspx.cs" Inherits="Admin_Master_ManageCustomerProfile" %>


<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Manage Customer Profile:</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="col-sm-12">
                <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
            </div>
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
        <div class="col-sm-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="CustomerProfileLabel" class="col-sm-4 my-2 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Customer Profile:"></asp:Label>
                    <asp:DropDownList ID="CustomerProfileDropDownList" class="col-sm-3 my-2 form-control" runat="server" AppendDataBoundItems="true" OnSelectedIndexChanged="CustomerProfileDDL_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Text="Genders" Value="0" Selected="True" />
                        <asp:ListItem Text="Age Ranges" Value="1" />
                        <asp:ListItem Text="Participant Types" Value="2" />
                        <asp:ListItem Text="Meals" Value="3" />
                    </asp:DropDownList>
                    <%--<asp:Button ID="ViewCustomerProfileButton" class="col-sm-1 offset-sm-2 my-2 btn btn-info" runat="server" Text="View" />--%>
                </div>
                <asp:Button ID="RevealButton" class="col-sm-2 mt-2 btn btn-secondary border border-info" runat="server" Text="Show Archived" OnClick="ToggleView" /><br />

            </div>
            <div class="card container">
                <%--site show section--%>
                <%--The gender list--%>
                <%--<Label id="selected" runat="server"></Label>--%>
                <div id="Genders" runat="server">
                    <div class="row container mx-auto my-2 px-0">
                        <asp:Label ID="AddGenderLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Gender: " />
                        <asp:TextBox ID="AddGenderBox" class="col-sm-4 my-2" runat="server" placeholder="Type gender to add..." Style="background-color: #FFFFFF;" />
                        <asp:Button ID="Button1" class="col-sm-2 offset-sm-2 my-2 btn btn-success" runat="server" Text="Add Gender" OnClick="AddGenderButton_Click" />
                    </div>
                    
                    <%-- ODS for Active Genders  --%>
                    <asp:ObjectDataSource ID="GenderODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetGenderList" TypeName="FSOSS.System.BLL.GenderController" DeleteMethod="ArchiveGender" InsertMethod="AddGender" UpdateMethod="UpdateGender" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="genderDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
                        </InsertParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="genderDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>
               
                    <%-- ODS for archived Genders --%>
                    <asp:ObjectDataSource ID="ArchivedGenderODS" runat="server" OldValuesParameterFormatString="{0}" SelectMethod="GetArchivedGenderList" TypeName="FSOSS.System.BLL.GenderController" DeleteMethod="ArchiveGender" UpdateMethod="UpdateGender" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
                        <DeleteParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="genderID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="genderDescription" Type="String"></asp:Parameter>
                            <asp:SessionParameter SessionField="userID" Name="admin" Type="Int32"  DefaultValue="0"></asp:SessionParameter>
                        </UpdateParameters>
                    </asp:ObjectDataSource>

                    <%-- The Gender ListView --%>
                    <asp:ListView ID="GenderListView" runat="server" DataSourceID="GenderODS" DataKeyNames="genderID">
                        <AlternatingItemTemplate>
                            <tr style="background-color: #FFFFFF; color: #284775;">
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("genderID") %>' runat="server" ID="genderIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("genderDescription") %>' runat="server" ID="genderDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr style="background-color: #999999;">
                                <td style="display: none">
                                    <asp:TextBox Text='<%# Bind("genderID") %>' runat="server" ID="genderIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("genderDescription") %>' runat="server" onkeydown = "return (event.keyCode!=13)" ID="genderDescriptionTextBox" /></td>
                                <td></td>
                                <td></td>
                                <td><asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton" /></td>
                                <td><asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="CancelButton" /> </td>
                                <td>
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
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("genderID") %>' runat="server" ID="genderIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("genderDescription") %>' runat="server" ID="genderDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
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
                                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                            <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                                <th runat="server" class="col-sm-6 py-2">Gender</th>
                                                <th runat="server" class="col-sm-4 py-2">Date Modified</th>
                                                <th runat="server" class="col-sm-4 py-2">Modified by</th>
                                                <th runat="server" class="col-sm-2 py-2">Edit </th>
                                                <th runat="server" class="col-sm-2 py-2">Archive</th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF"></td>
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
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("genderID") %>' runat="server" ID="genderIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("genderDescription") %>' runat="server" ID="genderDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
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
                    <div class="row container mx-auto px-0">
                        <asp:Label ID="AddPTLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Participant Type: " />
                        <asp:TextBox ID="AddPTBox" class="col-sm-4 my-2" runat="server" placeholder="Type participant type to add..." Style="background-color: #FFFFFF;" onkeydown = "return (event.keyCode!=13);"/>
                        <asp:Button ID="AddPTButton" class="col-sm-2 offset-sm-2 my-2 btn btn-success" runat="server" Text="Add Participant Type" OnClick="AddPTButton_Click" />
                    </div>
                    <asp:ListView ID="PTListview" runat="server" DataSourceID="PTODS" DataKeyNames="participantTypeID">
                        <AlternatingItemTemplate>
                            <tr style="background-color: #E0FFFF; color: #333333;">

                                <td style="display: none">
                                    <asp:Label Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td class="pl-3">
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>

                                <td>
                                    <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>

                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <asp:Panel DefaultButton="UpdateButton" runat="server">
                                <tr style="">
                                    <td style="display: none">
                                        <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                    <td class="pl-3">
                                        <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" onkeydown = "return (event.keyCode!=13);" ID="participantTypeDescriptionTextBox" MaxLength="25" />
                                    </td>
                                    <td></td>

                                    <td></td>
                                    <td>
                                        <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="UpdateButton" /></td>
                                    <td>
                                        <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="CancelButton" />
                                    </td>
                                </tr>
                            </asp:Panel>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                <tr>
                                    <td>No Participant Types were found.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <%--<InsertItemTemplate>
                            <tr style="">



                                <td class="pl-3">
                                    <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" MaxLength="25" />
                                </td>
                                <td></td>

                                <td></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Insert" CssClass="btn btn btn-success mx-3 my-1" Text="Insert" ID="InsertButton" /></td>
                                <td>
                                    <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Clear" ID="CancelButton" />
                                </td>
                            </tr>
                        </InsertItemTemplate>--%>
                        <ItemTemplate>
                            <tr style="background-color: #FFFFFF; color: #333333;">

                                <td style="display: none">
                                    <asp:Label Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td class="pl-3">
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
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
                                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                            <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                                <th runat="server" class="col-sm-6 py-2">Participant Type</th>
                                                <th runat="server" class="col-sm-4 py-2">Modified On</th>
                                                <th runat="server" class="col-sm-45 py-2">Last Edited By</th>
                                                <th runat="server" class="col-sm-3 py-2"></th>
                                                <th runat="server" class="col-sm-3 py-2"></th>
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
                                    <asp:Label Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td class="pl-3">
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
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
                    <div class="row container mx-auto px-0">
                        <asp:Label ID="AddMealsLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Meal: " />
                        <asp:TextBox ID="AddMealsTextBox" class="col-sm-4 my-2" runat="server" placeholder="Type meals to add..." Style="background-color: #FFFFFF;" onkeydown = "return (event.keyCode!=13);"/>
                        <asp:Button ID="AddMealsButton" class="col-sm-2 offset-sm-2 my-2 btn btn-success" runat="server" Text="Add Meal" OnClick="AddMealButton_Click" />
                    </div>

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
                    <asp:ListView ID="MealsListView" runat="server" DataSourceID="MealsODS" DataKeyNames="mealID">
                        <AlternatingItemTemplate>
                            <tr style="background-color: #FFFFFF; color: #284775;">
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("mealID") %>' runat="server" ID="mealIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                               <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr style="background-color: #999999;">
                                <td style="display: none">
                                    <asp:TextBox Text='<%# Bind("mealID") %>' runat="server" ID="mealIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("mealName") %>' runat="server" ID="mealNameTextBox" /></td>
                                <td></td>
                                <td></td>
                                <td>
                                        <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="Button2" /></td>
                                    <td>
                                        <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="Button3" />
                                    </td>
                            </tr>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                <tr>
                                    <td>No data was returned.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                       <%-- <InsertItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("mealID") %>' runat="server" ID="mealIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("mealName") %>' runat="server" ID="mealNameTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </InsertItemTemplate>--%>
                        <ItemTemplate>
                            <tr style="background-color: #E0FFFF; color: #333333;">
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("mealID") %>' runat="server" ID="mealIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                                <th runat="server">Meal</th>
                                                <th runat="server">Date Modified</th>
                                                <th runat="server">Modified By</th>
                                                <th runat="server"></th>
                                                <th runat="server"></th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                        <asp:DataPager runat="server" ID="DataPager1">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("mealID") %>' runat="server" ID="mealIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>

                </div><%-- end of meals--%>


                <%--the age range list--%>
                <div id="AgeRanges" runat="server">
                    <%-- Add Age Range --%>
                    <div class="row container mx-auto px-0">
                        <asp:Label ID="AddAgeRangeLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server" Text="Add Age Range: " />
                        <asp:TextBox ID="AddAgeRangeTextBox" class="col-sm-4 my-2" runat="server" placeholder="Type age range to add..." Style="background-color: #FFFFFF;" onkeydown = "return (event.keyCode!=13);"/>
                        <asp:Button ID="AddAgeRangeButton" class="col-sm-2 offset-sm-2 my-2 btn btn-success" runat="server" Text="Add Age Range" OnClick="AddARButton_Click" />
                    </div>

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
                    <asp:ObjectDataSource ID="ArchivedAgeRangeODS" runat="server" DeleteMethod="ArchiveAgeRange" InsertMethod="AddAgeRange" OldValuesParameterFormatString="original_{0}" SelectMethod="GetArchivedMealList" TypeName="FSOSS.System.BLL.AgeRangeController" UpdateMethod="UpdateAgeRange" OnDeleted="CheckForException" OnInserted="CheckForException" OnUpdated="CheckForException">
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
                    <asp:ListView ID="AgeRangeListView" runat="server" DataSourceID="AgeRangeODS" DataKeyNames="ageRangeID">
                        <AlternatingItemTemplate>
                            <tr style="background-color: #FFFFFF; color: #284775;">
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("ageRangeID") %>' runat="server" ID="ageRangeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr style="background-color: #999999;">
                                <td style="display: none">
                                    <asp:TextBox Text='<%# Bind("ageRangeID") %>' runat="server" ID="ageRangeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionTextBox" /></td>
                                <td></td>
                                 <td></td>
                                <td>
                                        <asp:Button runat="server" CommandName="Update" CssClass="btn btn btn-success mx-3 my-1" Text="Update" ID="Button4" /></td>
                                    <td>
                                        <asp:Button runat="server" CommandName="Cancel" CssClass="btn btn btn-danger mx-3 my-1" Text="Cancel" ID="Button5" />
                                    </td>
                            </tr>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                <tr>
                                    <td>No data was returned.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <%--<InsertItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("ageRangeID") %>' runat="server" ID="ageRangeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </InsertItemTemplate>--%>
                        <ItemTemplate>
                            <tr style="background-color: #E0FFFF; color: #333333;">
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("ageRangeID") %>' runat="server" ID="ageRangeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                                <th runat="server">Age Range</th>
                                                <th runat="server">Date Modified</th>
                                                <th runat="server">Modified By</th>
                                                <th runat="server"></th>
                                                <th runat="server"></th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                        <asp:DataPager runat="server" ID="DataPager3">
                                            <Fields>
                                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                            </Fields>
                                        </asp:DataPager>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                                <td style="display: none">
                                    <asp:Label Text='<%# Eval("ageRangeID") %>' runat="server" ID="ageRangeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("ageRangeDescription") %>' runat="server" ID="ageRangeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                 <td>
                                    <asp:Label Text='<%# Eval("username") %>' runat="server" ID="usernameLabel" /></td>
                                <td>
                                <asp:Button runat="server" CommandName="Edit" CssClass="btn btn btn-success mx-3 my-1" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" CssClass="btn btn btn-danger mx-3 my-1" Text='<%# seeArchive==false?"Disable":"Enable" %>' ID="DeleteButton" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>

                </div> <%--end of age range--%>


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

            </div>
        </div>

    </div>
</asp:Content>

