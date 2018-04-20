<%@ Page Title="Contact Requests" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ContactListPage.aspx.cs" Inherits="Pages_AdministratorPages_ContactListPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="col-sm-12 card container mb-3">
        <div class="row">
            <h1 class="mx-3 py-2 h4" style="font-weight: bold;">Contact Requests</h1>
        </div>
    </div>
    <div>
        <div class="card container">
            <div class="row">
                    <asp:Label ID="SiteLabel" runat="server" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Site: "></asp:Label>
                    <asp:DropDownList ID="SiteDDL" runat="server" class="col-sm-4 my-2 form-control" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID" OnSelectedIndexChanged="SiteDDL_SelectedIndexChanged" AutoPostBack="true" ></asp:DropDownList>
            </div>
            <div class="row">

                <asp:Label ID="COntactLabel" runat="server" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Requests"></asp:Label><br />
                <asp:Label ID="ContactCountLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server"></asp:Label>
            </div>
            <asp:ListView ID="ContactRequestList" runat="server" DataSourceID="ContactRequestODS" OnItemCommand="GoToSSView">
                <AlternatingItemTemplate>
                    <tr class="fsoss-listview-alternate">
                        <td style="display: none">
                            <asp:Label Text='<%# Bind("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("unitNumber") %>' CssClass="pl-3" runat="server" ID="unitIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("participantType") %>' CssClass="pl-3" runat="server" ID="participantTypeIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("mealName") %>' runat="server" CssClass="pl-3" ID="Label2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("dateEntered") %>' CssClass="pl-3" runat="server" ID="dateEnteredLabel" /></td>

                        <td>
                            <asp:Label Text='<%# Eval("contactRoomNumber") %>' CssClass="pl-3" runat="server" ID="contactRoomNumberLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("contactPhoneNumber") %>' CssClass="pl-3" runat="server" ID="contactPhoneNumberLabel" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="look" Text="View" ID="ViewButton" class="btn btn btn-secondary mx-3 my-1" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EmptyDataTemplate>
                    <p class="text-center">There are no more Contact Requests for this site.</p>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr class="fsoss-listview-itemtemplate">
                        <td style="display: none">
                            <asp:Label Text='<%# Bind("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("unitNumber") %>' CssClass="pl-3" runat="server" ID="unitIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("participantType") %>' CssClass="pl-3" runat="server" ID="participantTypeIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("mealName") %>' runat="server" CssClass="pl-3" ID="Label2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("dateEntered") %>' CssClass="pl-3" runat="server" ID="dateEnteredLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("contactRoomNumber") %>' CssClass="pl-3" runat="server" ID="contactRoomNumberLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("contactPhoneNumber") %>' CssClass="pl-3" runat="server" ID="contactPhoneNumberLabel" /></td>
                        <td>
                            <asp:Button runat="server" CommandName="look" Text="View" ID="ViewButton" class="btn btn btn-secondary mx-3 my-1" />
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                    <tr runat="server">
                                        <th hidden runat="server">submittedSurveyID</th>
                                        <th runat="server" class="w-10 py-2 pl-3">Unit Number</th>
                                        <th runat="server" class="w-15 py-2 pl-3">Participant Type</th>
                                        <th runat="server" class="w-15 py-2 pl-3">Meal Name</th>
                                        <th runat="server" class="w-25 py-2 pl-3">Date Submitted</th>
                                        <th runat="server" class="w-10 py-2 pl-3">Room Number</th>
                                        <th runat="server" class="w-15 py-2 pl-3">Phone Number</th>
                                        <th runat="server" class="w-15 py-2 pl-3">View Survey</th>

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
                                                            (
                                                            <asp:Label runat="server" ID="TotalItemsLabel" Text='<%# Container.TotalRowCount %>' />
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
                            <asp:Label Text='<%# Eval("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("participantType") %>' runat="server" ID="participantTypeIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" ID="dateEnteredLabel" /></td>

                        <td>
                            <asp:Label Text='<%# Eval("contactRoomNumber") %>' runat="server" ID="contactRoomNumberLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("contactPhoneNumber") %>' runat="server" ID="contactPhoneNumberLabel" /></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <asp:ObjectDataSource ID="SiteODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSiteList" TypeName="FSOSS.System.BLL.SiteController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ContactRequestODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetContactRequestList" TypeName="FSOSS.System.BLL.SubmittedSurveyController" UpdateMethod="contactSurvey">
        <SelectParameters>
            <asp:ControlParameter ControlID="SiteDDL" PropertyName="SelectedValue" Name="siteID" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="submittedSurveyID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

