<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="SubmittedSurveyViewerPage.aspx.cs" Inherits="Admin_SubmittedSurveyViewerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-sm-12">
            <h1 class="card container py-2 h4" style="font-weight: bold;">View Individual Survey</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container pt-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="SubSurveyNumLabel" runat="server" Text="" Style="display: none"></asp:Label>
                    <div class="col-sm-4 px-0">
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="SubSurveyODS">
                            <EmptyDataTemplate>
                                <span>No data was returned.</span>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Label ID="UnitLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Unit Number:"></asp:Label>
                                <asp:Label Text='<%# Eval("unitNumber") %>' runat="server" ID="UnitNumberLabel" /><br />
                                <asp:Label ID="MealLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Meal Name:"></asp:Label>
                                <asp:Label Text='<%# Eval("mealName") %>' runat="server" ID="MealNameLabel" /><br />
                                <asp:Label ID="ParticipantLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Participant Type:"></asp:Label>
                                <asp:Label Text='<%# Eval("participantType") %>' runat="server" ID="ParticipantTypeLabel" />
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <div class="col-sm-4 px-0">
                        <asp:ListView ID="ListView2" runat="server" DataSourceID="SubSurveyODS">
                            <EmptyDataTemplate>
                                <span>No data was returned.</span>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Label ID="AgeLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Age Range:"></asp:Label>
                                <asp:Label Text='<%# Eval("ageRange") %>' runat="server" ID="AgeRangeLabel" /><br />
                                <asp:Label ID="GenLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Gender:"></asp:Label>
                                <asp:Label Text='<%# Eval("gender") %>' runat="server" ID="GenderLabel" /><br />
                                <asp:Label ID="DateLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Date Entered:"></asp:Label>
                                <asp:Label Text='<%# Eval("dateEntered") %>' runat="server" ID="DateEnteredLabel" />
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <div class="col-sm-4 px-0">
                        <asp:ListView ID="SubSurveyList" runat="server" DataSourceID="SubSurveyODS">
                            <EmptyDataTemplate>
                                <span>No data was returned.</span>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Label ID="ContactLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Requested?:"></asp:Label>
                                <asp:Label Text='<%# Eval("contactRequest") %>' runat="server" ID="ContactStatusLabel" /><br />
                                <asp:Label ID="ContactedLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Status:"></asp:Label>
                                <asp:Label Text='<%# Eval("contacted") %>' runat="server" ID="Label2" /><br />
                               <asp:Label ID="ContactRoomLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Room Number:"></asp:Label>
                                <asp:Label Text='<%# Eval("contactRoomNumber") %>' runat="server" ID="ContactRoomNumberLabel" /><br />
                                <asp:Label ID="ContactPhoneLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Phone Number:"></asp:Label>
                                <asp:Label Text='<%# Eval("contactPhoneNumber") %>' runat="server" ID="ContactPhoneNumberLabel" />
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <div class="row container mx-auto px-0">
                        <asp:Button ID="ResolveButton" class="col-sm-2 mx-auto mb-2 btn btn-success border border-dark" runat="server" Text="Resolve" OnClick="ResolveButton_Click"></asp:Button>
                        <asp:Button ID="UnresolveButton" class="col-sm-2 mx-auto mb-2 btn btn-danger border border-dark" runat="server" Text="Unresolve" OnClick="UnresolveButton_Click" Visible="false" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container pt-2 mt-2">
                <div class="row container mx-auto px-0">
                    <div class="col-sm-2 px-0">
                        <asp:Label ID="Question1Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 1:"></asp:Label><br />
                        <asp:Label ID="Question1aLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 1a:"></asp:Label><br />
                        <asp:Label ID="Response1aLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 1a:"></asp:Label><br />
                        <asp:Label ID="Question1bLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 1b:"></asp:Label><br />
                        <asp:Label ID="Response1bLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 1b:"></asp:Label><br />
                        <asp:Label ID="Question1cLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 1c:"></asp:Label><br />
                        <asp:Label ID="Response1cLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 1c:"></asp:Label><br />
                        <asp:Label ID="Question1dLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 1d:"></asp:Label><br />
                        <asp:Label ID="Response1dLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 1d:"></asp:Label><br />
                        <asp:Label ID="Question1eLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 1e:"></asp:Label><br />
                        <asp:Label ID="Response1eLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 1e:"></asp:Label><br />
                        <asp:Label ID="Question2Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 2:"></asp:Label><br />
                        <asp:Label ID="Response2Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 2:"></asp:Label><br />
                        <asp:Label ID="Question3Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 3:"></asp:Label><br />
                        <asp:Label ID="Response3Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 3:"></asp:Label><br />
                        <asp:Label ID="Question4Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 4:"></asp:Label><br />
                        <asp:Label ID="Response4Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 4:"></asp:Label><br />
                        <asp:Label ID="Question5Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Question 5:"></asp:Label><br />
                        <asp:Label ID="Response5Label" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Response 5:"></asp:Label><br />
                    </div>
                    <div class="col-sm-10 px-0">
                         <div class="col-sm-12 px-0">
                        <asp:Label ID="Label18" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-family: Verdana, Arial, Helvetica, sans-serif; line-height: 38px; margin-left: -45px;" Text="During this hospital stay, how would you describe the following features of your meals?"></asp:Label>
                    </div>
                        <asp:ListView ID="AnswersList" runat="server" DataSourceID="AnswerODS">
                            <EmptyDataTemplate>
                                <span>No data was returned.</span>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Label Text='<%# Eval("question") %>' class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="line-height: 38px; margin-left: -45px;" ID="QuestionLabel" /><br />
                                <asp:Label Text='<%# Eval("response") %>' class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="line-height: 38px; margin-left: -45px;" ID="ResponseLabel" /><br />
                            </ItemTemplate>
                            <LayoutTemplate>
                                <div runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;"><span runat="server" id="itemPlaceholder" /></div>
                                <div style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF;">
                                </div>
                            </LayoutTemplate>
                        </asp:ListView>
                    </div>
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Button ID="BackToSurveyListButton" class="col-sm-2 mx-auto my-2 btn btn-info border border-dark" runat="server" Text="Back to Survey List" OnClick="BackToSurveyListButton_Click"></asp:Button>
                </div>
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
