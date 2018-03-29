<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ManageCustomerProfile.aspx.cs" Inherits="Admin_Master_ManageCustomerProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Manage Customer Profile:</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
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
                    <asp:Button ID="ViewCustomerProfileButton" class="col-sm-1 offset-sm-2 my-2 btn btn-info" runat="server" Text="View" />
                    <asp:Button ID="RevealButton" runat="server" Text="Show Archived" OnClick="ToggleView" />
                </div>
            </div>
            <div class="card container">
                <%--site show section--%>
                <%--The gender list--%>
                <div ID="Genders" runat="server">
                    <asp:ListView ID="DemographicListview" runat="server" DataSourceID="SiteODS">
                        <AlternatingItemTemplate>
                            <tr style="background-color: #E0FFFF; color: #333333;">
                                <td class="pl-3">
                                    <asp:Label Text='Male' runat="server" ID="siteNameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                                <tr style="background-color: #E0FFFF; color: #333333;">
                                    <td class="pl-3">
                                        <asp:Label Text='Female' runat="server" ID="Label1" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button1" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button2" /></td>
                                    <tr style="background-color: #E0FFFF; color: #333333;">
                                        <td class="pl-3">
                                            <asp:Label Text='Other' runat="server" ID="Label4" /></td>
                                        <td>
                                            <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button3" /></td>
                                        <td>
                                            <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button4" /></td>
                                    </tr>
                        </AlternatingItemTemplate>
                        <EmptyDataTemplate>
                            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                                <tr>
                                    <td>No data was returned.</td>
                                </tr>
                            </table>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr style="background-color: #FFFFFF; color: #333333;">
                                <td class="pl-3">
                                    <asp:Label Text='Male' runat="server" ID="siteNameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                                <tr style="background-color: #FFFFFF; color: #333333;">
                                    <td class="pl-3">
                                        <asp:Label Text='Female' runat="server" ID="Label1" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button1" /></td>
                                    <td>
                                        <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button2" /></td>
                                    <tr style="background-color: #FFFFFF; color: #333333;">
                                        <td class="pl-3">
                                            <asp:Label Text='Other' runat="server" ID="Label4" /></td>
                                        <td>
                                            <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="Button3" /></td>
                                        <td>
                                            <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="Button4" /></td>
                                    </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                            <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                                <th runat="server" class="col-sm-6 py-2">Gender</th>
                                                <th runat="server" class="col-sm-3 py-2">Edit</th>
                                                <th runat="server" class="col-sm-3 py-2">Delete</th>

                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <SelectedItemTemplate>
                            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                                <td>
                                    <asp:Label CssClass="mx-3 my-1" Text='<%# Eval("siteName") %>' runat="server" ID="siteNameLabel" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                                <td>
                                    <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Delete" Text="Delete" ID="DeleteButton" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>

                <%-- The participant type list--%>
                <div ID="ParticipantTypes" runat="server">
                    <asp:ListView ID="PTListview" InsertItemPosition="LastItem" runat="server" DataSourceID="PTODS" DataKeyNames="participantTypeID">
                        <AlternatingItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>




                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("administratorAccountId") %>' runat="server" ID="administratorAccountIdTextBox" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Bind("archivedYn") %>' runat="server" ID="archivedYnCheckBox" /></td>
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
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("administratorAccountId") %>' runat="server" ID="administratorAccountIdTextBox" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Bind("archivedYn") %>' runat="server" ID="archivedYnCheckBox" /></td>
                            </tr>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>




                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                            <tr runat="server" style="">
                                                <th runat="server"></th>
                                                <th runat="server">participantTypeID</th>
                                                <th runat="server">participantTypeDescription</th>

                                                <th runat="server">dateModified</th>
                                                <th runat="server">administratorAccountId</th>
                                                <th runat="server">archivedYn</th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="">
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
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>

                <%--the meal list--%>
               <div ID="Meals" runat="server">
                    <asp:ListView ID="ListView1" InsertItemPosition="LastItem" runat="server" DataSourceID="PTODS" DataKeyNames="participantTypeID">
                        <AlternatingItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>




                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("administratorAccountId") %>' runat="server" ID="administratorAccountIdTextBox" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Bind("archivedYn") %>' runat="server" ID="archivedYnCheckBox" /></td>
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
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("administratorAccountId") %>' runat="server" ID="administratorAccountIdTextBox" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Bind("archivedYn") %>' runat="server" ID="archivedYnCheckBox" /></td>
                            </tr>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>




                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                            <tr runat="server" style="">
                                                <th runat="server"></th>
                                                <th runat="server">participantTypeID</th>
                                                <th runat="server">participantTypeDescription</th>

                                                <th runat="server">dateModified</th>
                                                <th runat="server">administratorAccountId</th>
                                                <th runat="server">archivedYn</th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="">
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
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>


                <%--the age range list--%>
                <div ID="AgeRanges" runat="server">
                    <asp:ListView ID="ListView2" InsertItemPosition="LastItem" runat="server" DataSourceID="PTODS" DataKeyNames="participantTypeID">
                        <AlternatingItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>




                        </AlternatingItemTemplate>
                        <EditItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("administratorAccountId") %>' runat="server" ID="administratorAccountIdTextBox" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Bind("archivedYn") %>' runat="server" ID="archivedYnCheckBox" /></td>
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
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                                </td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("dateModified") %>' runat="server" ID="dateModifiedTextBox" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("administratorAccountId") %>' runat="server" ID="administratorAccountIdTextBox" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Bind("archivedYn") %>' runat="server" ID="archivedYnCheckBox" /></td>
                            </tr>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>




                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                            <tr runat="server" style="">
                                                <th runat="server"></th>
                                                <th runat="server">participantTypeID</th>
                                                <th runat="server">participantTypeDescription</th>

                                                <th runat="server">dateModified</th>
                                                <th runat="server">administratorAccountId</th>
                                                <th runat="server">archivedYn</th>
                                            </tr>
                                            <tr runat="server" id="itemPlaceholder"></tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr runat="server">
                                    <td runat="server" style="">
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
                            <tr style="">
                                <td>
                                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeID") %>' runat="server" ID="participantTypeIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantTypeDescription") %>' runat="server" ID="participantTypeDescriptionLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateModified") %>' runat="server" ID="dateModifiedLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("administratorAccountId") %>' runat="server" ID="administratorAccountIdLabel" /></td>
                                <td>
                                    <asp:CheckBox Checked='<%# Eval("archivedYn") %>' runat="server" ID="archivedYnCheckBox" Enabled="false" /></td>
                            </tr>
                        </SelectedItemTemplate>
                    </asp:ListView>
                </div>
                <asp:ObjectDataSource ID="PTODS" runat="server" DeleteMethod="ArchiveParticipantType" InsertMethod="AddParticipantType" OldValuesParameterFormatString="original_{0}" SelectMethod="GetParticipantTypeList" TypeName="FSOSS.System.BLL.ParticipantController" UpdateMethod="UpdateParticipantType" DataObjectTypeName="FSOSS.System.Data.POCOs.ParticipantTypePOCO"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ArchivedPTODS" runat="server" DataObjectTypeName="FSOSS.System.Data.POCOs.ParticipantTypePOCO" DeleteMethod="ArchiveParticipantType" InsertMethod="AddParticipantType" OldValuesParameterFormatString="original_{0}" SelectMethod="GetArchivedParticipantTypeList" TypeName="FSOSS.System.BLL.ParticipantController" UpdateMethod="UpdateParticipantType"></asp:ObjectDataSource>

            </div>
        </div>
        <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
    </div>
</asp:Content>

