<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SubmittedSurveyViewerPage.aspx.cs" Inherits="Admin_SubmittedSurveyViewerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight:bold;">View Submitted Survey</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container pt-2">
                <asp:Label ID="SubSurveyNumLabel" runat="server" Text="" Style="display: none"></asp:Label>
                <asp:ListView ID="SubSurveyList" runat="server" DataSourceID="SubSurveyODS">
                    <AlternatingItemTemplate>
                        <span style="background-color: #FFFFFF; color: #284775;">submittedSurveyID:
                            <asp:Label Text='<%# Eval("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /><br />
                            unitNumber:
                            <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /><br />
                            mealName:
                            <asp:Label Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /><br />
                            participantType:
                            <asp:Label Text='<%# Eval("participantType") %>' runat="server" ID="participantTypeLabel" /><br />
                            ageRange:
                            <asp:Label Text='<%# Eval("ageRange") %>' runat="server" ID="ageRangeLabel" /><br />
                            gender:
                            <asp:Label Text='<%# Eval("gender") %>' runat="server" ID="genderLabel" /><br />
                            dateEntered:
                            <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" ID="dateEnteredLabel" /><br />
                            contactStatus:
                            <asp:Label Text='<%# Eval("contactStatus") %>' runat="server" ID="contactStatusLabel" /><br />
                            contactRoomNumber:
                            <asp:Label Text='<%# Eval("contactRoomNumber") %>' runat="server" ID="contactRoomNumberLabel" /><br />
                            contactPhoneNumber:
                            <asp:Label Text='<%# Eval("contactPhoneNumber") %>' runat="server" ID="contactPhoneNumberLabel" /><br />
                            <br />
                        </span>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>             
                    <ItemTemplate>
                        <span style="background-color: #FFFFFF; color: #333333;">submittedSurveyID:
                            <asp:Label Text='<%# Eval("submittedSurveyID") %>' runat="server" ID="submittedSurveyIDLabel" /><br />
                            unitNumber:
                            <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="unitNumberLabel" /><br />
                            mealName:
                            <asp:Label Text='<%# Eval("mealName") %>' runat="server" ID="mealNameLabel" /><br />
                            participantType:
                            <asp:Label Text='<%# Eval("participantType") %>' runat="server" ID="participantTypeLabel" /><br />
                            ageRange:
                            <asp:Label Text='<%# Eval("ageRange") %>' runat="server" ID="ageRangeLabel" /><br />
                            gender:
                            <asp:Label Text='<%# Eval("gender") %>' runat="server" ID="genderLabel" /><br />
                            dateEntered:
                            <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" ID="dateEnteredLabel" /><br />
                            contactStatus:
                            <asp:Label Text='<%# Eval("contactStatus") %>' runat="server" ID="contactStatusLabel" /><br />
                            contactRoomNumber:
                            <asp:Label Text='<%# Eval("contactRoomNumber") %>' runat="server" ID="contactRoomNumberLabel" /><br />
                            contactPhoneNumber:
                            <asp:Label Text='<%# Eval("contactPhoneNumber") %>' runat="server" ID="contactPhoneNumberLabel" /><br />
                            <br />
                        </span>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;"><span runat="server" id="itemPlaceholder" /></div>
                        <div style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF;">
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container pt-2 mt-2">
                <asp:ListView ID="AnswersList" runat="server" DataSourceID="AnswerODS">
                    <AlternatingItemTemplate>
                        <span style="background-color: #FFFFFF; color: #284775;">question:
                            <asp:Label Text='<%# Eval("question") %>' runat="server" ID="questionLabel" /><br />
                            questionTopic:
                            <asp:Label Text='<%# Eval("questionTopic") %>' runat="server" ID="questionTopicLabel" /><br />
                            response:
                            <asp:Label Text='<%# Eval("response") %>' runat="server" ID="responseLabel" /><br />
                            <br />
                        </span>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <span>No data was returned.</span>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <span style="background-color: #FFFFFF; color: #333333;">question:
                            <asp:Label Text='<%# Eval("question") %>' runat="server" ID="questionLabel" /><br />
                            questionTopic:
                            <asp:Label Text='<%# Eval("questionTopic") %>' runat="server" ID="questionTopicLabel" /><br />
                            response:
                            <asp:Label Text='<%# Eval("response") %>' runat="server" ID="responseLabel" /><br />
                            <br />
                        </span>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;"><span runat="server" id="itemPlaceholder" /></div>
                        <div style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF;">
                        </div>
                    </LayoutTemplate>
                </asp:ListView>
            </div>
        </div>
    </div>
    <asp:ObjectDataSource ID="SubSurveyODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubmittedSurvey" TypeName="FSOSS.System.BLL.SubmittedSurveyController">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="sid" DefaultValue="" Name="subSurNum" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="AnswerODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetSubmittedSurveyAnswers" TypeName="FSOSS.System.BLL.SubmittedSurveyController">
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="sid" Name="subSurNum" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>