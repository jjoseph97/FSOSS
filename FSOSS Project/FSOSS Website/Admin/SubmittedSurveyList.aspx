﻿<%@ Page Title="View Submitted Surveys" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SubmittedSurveyList.aspx.cs" Inherits="Pages_AdministratorPages_SubmittedSurveyList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Submitted Survey List</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container">
                <asp:ListView ID="SubmittedSurveyListView" runat="server">
                    <AlternatingItemTemplate>
                        <tr class="fsoss-listview-alternate">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("site") %>' runat="server" CssClass="pl-3" ID="siteLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="pl-3" ID="unitNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("participantType") %>' runat="server" CssClass="pl-3" ID="participantTypeLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("mealName") %>' runat="server" CssClass="pl-3" ID="Label2" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" CssClass="pl-3" ID="dateEnteredLabel" /></td>
                            <td>
                                <asp:Button runat="server" class="btn btn-secondary mx-3 my-1" CommandName="View" Text="View" ID="ViewButton" PostBackUrl='<%# "~/Admin/SubmittedSurveyViewerPage.aspx?sid=" + Eval("submittedSurveyID") %>' /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contactRequest") %>' runat="server" ID="contactStatusLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contacted") %>' runat="server" ID="Label3" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contactRoomNumber") %>' runat="server" ID="contactRoomNumberLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contactPhoneNumber") %>' runat="server" ID="contactPhoneNumberLabel" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <p class="text-center">No submitted surveys were found.</p>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr class="fsoss-listview-itemtemplate">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("site") %>' runat="server" CssClass="pl-3" ID="siteLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="pl-3" ID="unitNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("participantType") %>' runat="server" CssClass="pl-3" ID="participantTypeLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("mealName") %>' runat="server" CssClass="pl-3" ID="Label1" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" CssClass="pl-3" ID="dateEnteredLabel" /></td>
                            <td>
                                <asp:Button runat="server" class="btn btn-secondary mx-3 my-1" CommandName="View" Text="View" ID="ViewButton" PostBackUrl='<%# "~/Admin/SubmittedSurveyViewerPage.aspx?sid=" + Eval("submittedSurveyID") %>' /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contactRequest") %>' runat="server" ID="contactStatusLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contacted") %>' runat="server" ID="contactedLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contactRoomNumber") %>' runat="server" ID="contactRoomNumberLabel" /></td>
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("contactPhoneNumber") %>' runat="server" ID="contactPhoneNumberLabel" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server">
                                            <th runat="server" class="w-20 p-3">Hospital</th>
                                            <th runat="server" class="w-15 p-3">Unit Number</th>
                                            <th runat="server" class="w-15 p-3">Participant Type</th>
                                            <th runat="server" class="w-15 p-3">Meal Name</th>
                                            <th runat="server" class="w-25 p-3">Date Submitted</th>
                                            <th runat="server" class="w-10 p-3">View Survey</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" class="mx-2 my-2">
                                <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                    <asp:DataPager runat="server" ID="SurveyListDataPager">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-primary text-light border border-dark mt-2" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                            <asp:TemplatePagerField>
                                                <PagerTemplate>
                                                    <div class="my-2 text-white font-weight-bold">
                                                        <asp:Label runat="server" ID="CurrentPageLabel">Page <%# ( Container.StartRowIndex / Container.PageSize) + 1 %> of</asp:Label>
                                                        <asp:Label runat="server" ID="TotalPagesLabel"><%# Math.Ceiling( ((double)Container.TotalRowCount) / Container.PageSize) %></asp:Label>
                                                        <asp:Label runat="server" ID="TotalItemsLabel">(<%# Container.TotalRowCount %> records)</asp:Label>
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
            </div>
        </div>
    </div>
</asp:Content>

