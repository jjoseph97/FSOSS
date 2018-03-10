<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ContactListPage.aspx.cs" Inherits="Pages_AdministratorPages_ContactListPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">Contact Requests</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="SiteLabel" runat="server" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Site: "></asp:Label>
            <asp:DropDownList ID="SiteDDL" runat="server" class="col-sm-4 my-2" DataSourceID="SiteODS" DataTextField="siteName" DataValueField="siteID"></asp:DropDownList>
        </div>
    </div>
    <div>
        <div class="card container">
            <div class="row container mx-auto px-0">

                <asp:Label ID="COntactLabel" runat="server" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Requests"></asp:Label><br />
                <asp:Label ID="ContactCountLabel" class="col-sm-4 my-2 text-center text-sm-left" Style="font-weight: bold; font-size: large; line-height: 38px;" runat="server"></asp:Label>
            </div>
            <asp:ListView ID="ContactRequestList" runat="server" DataSourceID="ContactRequestODS" OnItemCommand="GoToSSView">
                <AlternatingItemTemplate>
                    <tr style="background-color: #bbf2ff; color: #284775;">
                        <td style="display:none">
                            <asp:Label Text='<%# Bind("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
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
                        <td>
                            <asp:Button runat="server" CommandName="look" Text="View" ID="ViewButton" />
                            <asp:Button runat="server" CommandName="Update" Text="Contacted" ID="ContactButton" />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("unitID") %>' runat="server" ID="unitIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("participantTypeID") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("dateEntered") %>' runat="server" ID="dateEnteredTextBox" /></td>

                        <td>
                            <asp:TextBox Text='<%# Bind("contactRoomNumber") %>' runat="server" ID="contactRoomNumberTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("contactPhoneNumber") %>' runat="server" ID="contactPhoneNumberTextBox" /></td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="">
                        <tr>
                            <td>There are no more Contact Requests.</td>
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
                            <asp:TextBox Text='<%# Bind("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("unitNumber") %>' runat="server" ID="unitIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("participantType") %>' runat="server" ID="participantTypeIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("dateEntered") %>' runat="server" ID="dateEnteredTextBox" /></td>

                        <td>
                            <asp:TextBox Text='<%# Bind("contactRoomNumber") %>' runat="server" ID="contactRoomNumberTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("contactPhoneNumber") %>' runat="server" ID="contactPhoneNumberTextBox" /></td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="background-color: #FFFFFF; color: #333333;">
                        <td style="display:none">
                            <asp:Label Text='<%# Bind("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /></td>
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
                        <td>
                            <asp:Button runat="server" CommandName="look" Text="View" ID="ViewButton" />
                            <asp:Button runat="server" CommandName="Update" Text="Contacted" ID="ContactButton" />
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif; width: 100%;" border="1">
                                    <tr runat="server" style="background-color: #38dcff; color: #333333;">
                                        <th hidden runat="server">submittedSurveyID</th>
                                        <th runat="server">Unit</th>
                                        <th runat="server">Participant Type</th>
                                        <th runat="server">Date Entered</th>
                                        <th runat="server">Room Number</th>
                                        <th runat="server">Phone Number</th>
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

