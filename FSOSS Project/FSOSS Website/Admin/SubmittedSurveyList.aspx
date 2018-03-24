<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SubmittedSurveyList.aspx.cs" Inherits="Pages_AdministratorPages_SubmittedSurveyList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Submitted Survey List</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container">
                <asp:ListView ID="SubmittedSurveyList" runat="server" >
                    <AlternatingItemTemplate>
                        <tr style="background-color: #bbf2ff; color: #284775;">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="pl-3" ID="unitNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("participantType") %>' runat="server" CssClass="pl-3" ID="participantTypeLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("mealName") %>' runat="server" CssClass="pl-3" ID="Label2" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" CssClass="pl-3" ID="dateEnteredLabel" /></td>
                            <td>
                                <asp:Button runat="server" class="btn btn btn-info mx-3 my-1" CommandName="View" Text="View" ID="ViewButton" PostBackUrl='<%# "~/Admin/SubmittedSurveyViewerPage.aspx?sid=" + Eval("submittedSurveyID") %>' /></td>
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
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>No Submitted Surveys Found.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #FFFFFF; color: #333333;">
                            <td style="display: none;">
                                <asp:Label Text='<%# Eval("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" CssClass="pl-3" ID="unitNumberLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("participantType") %>' runat="server" CssClass="pl-3" ID="participantTypeLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("mealName") %>' runat="server" CssClass="pl-3" ID="Label1" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" CssClass="pl-3" ID="dateEnteredLabel" /></td>
                            <td>
                                <asp:Button runat="server" class="btn btn btn-info mx-3 my-1" CommandName="View" Text="View" ID="ViewButton" PostBackUrl='<%# "~/Admin/SubmittedSurveyViewerPage.aspx?sid=" + Eval("submittedSurveyID") %>' /></td>
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
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                        <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                            <th runat="server" class="col-sm-2 py-2">Unit Number</th>
                                            <th runat="server" class="col-sm-2 py-2">Participant Type</th>
                                            <th runat="server" class="col-sm-2 py-2">Meal Name</th>
                                            <th runat="server" class="col-sm-4 py-2">Date Submitted</th>
                                            <th runat="server" class="col-sm-2 py-2">View Survey</th>
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
                </asp:ListView>
            </div>
        </div>
    </div>
</asp:Content>

