<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SubmittedSurveyViewerPage.aspx.cs" Inherits="Admin_SubmittedSurveyViewerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <div class="card container">
                <asp:Label ID="SubSurveyNumLabel" runat="server" Text="" Style="display: none"></asp:Label>
                <asp:ListView ID="SubSurveyList" runat="server" DataSourceID="SubSurveyODS">
                    <AlternatingItemTemplate>
                        <span style="">
                            <tr>
                                <td>Submitted Survey ID:</td>
                                <td>
                                    <asp:Label Text='<%# Eval("submittedSurveyID") %>' CssClass="pl-3" runat="server" ID="submittedSurveyIDLabel" />
                                </td>
                            </tr>
                            <br />
                            <tr>
                                <td>Unit Number:
                            
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("unitNumber") %>' CssClass="pl-3" runat="server" ID="unitNumberLabel" />
                                </td>
                            </tr>
                            <br /><tr>
                                <td>Meal Name:
                
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("mealName") %>' CssClass="pl-3" runat="server" ID="mealNameLabel" />

                                </td>
                            </tr><br />
                            <tr>
                                <td>Participant Type:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantType") %>' CssClass="pl-3" runat="server" ID="participantTypeLabel" />

                                </td>
                            </tr><br />
                            <tr>
                                <td>Age Range:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("ageRange") %>' CssClass="pl-3" runat="server" ID="ageRangeLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Gender:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("gender") %>' CssClass="pl-3" runat="server" ID="genderLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Date Entered:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateEntered") %>' CssClass="pl-3" runat="server" ID="Label1" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Contact Status:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("contactStatus") %>' CssClass="pl-3" runat="server" ID="contactStatusLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Contact Room Number:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("contactRoomNumber") %>' CssClass="pl-3" runat="server" ID="contactRoomNumberLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Contact Phone Number:
                          </td>
                                <td>
                                     <asp:Label Text='<%# Eval("contactPhoneNumber") %>' CssClass="pl-3" runat="server" ID="contactPhoneNumberLabel" />
                               </td>
                            </tr><br />
                            


                        </span>


                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <span>There is no Submitted Survey information found.</span>


                    </EmptyDataTemplate>

                    <ItemTemplate>
                       <span style="">
                            <tr>
                                <td>Submitted Survey ID:</td>
                                <td>
                                    <asp:Label Text='<%# Eval("submittedSurveyID") %>' CssClass="pl-3" runat="server" ID="submittedSurveyIDLabel" />
                                </td>
                            </tr>
                            <br />
                            <tr>
                                <td>Unit Number:
                            
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("unitNumber") %>' CssClass="pl-3" runat="server" ID="unitNumberLabel" />
                                </td>
                            </tr>
                            <br /><tr>
                                <td>Meal Name:
                
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("mealName") %>' CssClass="pl-3" runat="server" ID="mealNameLabel" />

                                </td>
                            </tr><br />
                            <tr>
                                <td>Participant Type:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("participantType") %>' CssClass="pl-3" runat="server" ID="participantTypeLabel" />

                                </td>
                            </tr><br />
                            <tr>
                                <td>Age Range:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("ageRange") %>' CssClass="pl-3" runat="server" ID="ageRangeLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Gender:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("gender") %>' CssClass="pl-3" runat="server" ID="genderLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Date Entered:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("dateEntered") %>' CssClass="pl-3" runat="server" ID="Label1" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Contact Status:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("contactStatus") %>' CssClass="pl-3" runat="server" ID="contactStatusLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Contact Room Number:
                                </td>
                                <td>
                                    <asp:Label Text='<%# Eval("contactRoomNumber") %>' CssClass="pl-3" runat="server" ID="contactRoomNumberLabel" />
                                </td>
                            </tr><br />
                            <tr>
                                <td>Contact Phone Number:
                          </td>
                                <td>
                                     <asp:Label Text='<%# Eval("contactPhoneNumber") %>' CssClass="pl-3" runat="server" ID="contactPhoneNumberLabel" />
                               </td>
                            </tr><br />
                            


                        </span>


                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
                        <div style="">
                        </div>


                    </LayoutTemplate>

                </asp:ListView>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container">
                <asp:ListView ID="AnswersList" runat="server" DataSourceID="AnswerODS">
                    <AlternatingItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label Text='<%# Eval("question") %>' runat="server" ID="questionLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("response") %>' runat="server" ID="responseLabel" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label Text='<%# Eval("question") %>' runat="server" ID="questionLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("response") %>' runat="server" ID="responseLabel" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                                        <tr runat="server" style="">
                                            <th runat="server">Question</th>
                                            <th runat="server">Response</th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server">
                                <td runat="server" style=""></td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="SubSurveyODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubmittedSurvey" TypeName="FSOSS.System.BLL.SubmittedSurveyController">
        <SelectParameters>
            <asp:ControlParameter ControlID="SubSurveyNumLabel" PropertyName="Text" Name="subSurNum" Type="Int32"></asp:ControlParameter>

        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="AnswerODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubmittedSurveyAnswers" TypeName="FSOSS.System.BLL.SubmittedSurveyController">
        <SelectParameters>
            <asp:ControlParameter ControlID="SubSurveyNumLabel" PropertyName="Text" Name="subSurNum" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

