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
                        <asp:Label ID="SiteLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Site:"></asp:Label>
                        <asp:Label runat="server" ID="SiteNameLabel" Text="" /><br />
                        <asp:Label ID="UnitLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Unit Number:"></asp:Label>
                        <asp:Label runat="server" ID="UnitNumberLabel" Text="" /><br />
                        <asp:Label ID="MealLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Meal Name:"></asp:Label>
                        <asp:Label runat="server" ID="MealNameLabel" Text="" /><br />
                        <asp:Label ID="ParticipantLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Participant Type:"></asp:Label>
                        <asp:Label runat="server" ID="ParticipantTypeLabel" Text="" />
                    </div>
                    <div class="col-sm-4 px-0">
                        <asp:Label ID="AgeLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Age Range:"></asp:Label>
                        <asp:Label runat="server" ID="AgeRangeLabel" Text="" /><br />
                        <asp:Label ID="GenLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Gender:"></asp:Label>
                        <asp:Label runat="server" ID="GenderLabel" Text="" /><br />
                        <asp:Label ID="DateLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Date Entered:"></asp:Label>
                        <asp:Label runat="server" ID="DateEnteredLabel" Text="" />
                    </div>
                    <div class="col-sm-4 px-0">
                        <asp:Label ID="ContactReqLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Requested?"></asp:Label>
                        <asp:Label runat="server" ID="ContactRequestLabel" Text="" /><br />
                        <asp:Label ID="ContactStatLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Status:"></asp:Label>
                        <asp:Label runat="server" ID="ContactStatusLabel" Text="" /><br />
                        <asp:Label ID="ContactRoomLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Room Number:"></asp:Label>
                        <asp:Label runat="server" ID="ContactRoomNumberLabel" Text="" /><br />
                        <asp:Label ID="ContactPhoneLabel" class="col-sm-4 px-0 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text="Contact Phone Number:"></asp:Label>
                        <asp:Label runat="server" ID="ContactPhoneNumberLabel" Text="" />
                    </div>
                    <div id="ContactResolve" class="row container mx-auto px-0" runat="server">
                        <asp:Button ID="ResolveButton" class="col-sm-2 mx-auto mb-2 btn btn-success border border-dark" runat="server" Text="Resolve" OnClick="ResolveButton_Click" OnClientClick="return confirm('Are you Sure?')"></asp:Button>
                        <asp:Button ID="UnresolveButton" class="col-sm-2 mx-auto mb-2 btn btn-danger border border-dark" runat="server" Text="Unresolve" OnClick="UnresolveButton_Click" Visible="false" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="card container py-2 mt-2">
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question1Label" class="col-sm-12 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="1. During this hospital stay, how would you describe the following features of your meals?"></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question1aLabel" class="col-sm-11 offset-sm-1 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="a."></asp:Label><br />
                    <asp:Label ID="Response1aLabel" class="col-sm-11 offset-sm-1 pl-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question1bLabel" class="col-sm-11 offset-sm-1 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="b."></asp:Label><br />
                    <asp:Label ID="Response1bLabel" class="col-sm-11 offset-sm-1 pl-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question1cLabel" class="col-sm-11 offset-sm-1 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="c."></asp:Label><br />
                    <asp:Label ID="Response1cLabel" class="col-sm-11 offset-sm-1 pl-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question1dLabel" class="col-sm-11 offset-sm-1 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="d."></asp:Label><br />
                    <asp:Label ID="Response1dLabel" class="col-sm-11 offset-sm-1 pl-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question1eLabel" class="col-sm-11 offset-sm-1 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="e."></asp:Label><br />
                    <asp:Label ID="Response1eLabel" class="col-sm-11 offset-sm-1 pl-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question2Label" class="col-sm-12 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="2."></asp:Label><br />
                    <asp:Label ID="Response2Label" class="col-sm-12 px-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question3Label" class="col-sm-12 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="3."></asp:Label><br />
                    <asp:Label ID="Response3Label" class="col-sm-12 px-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question4Label" class="col-sm-12 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="4."></asp:Label><br />
                    <asp:Label ID="Response4Label" class="col-sm-12 px-4 text-center text-sm-left" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
                <div class="row container mx-auto px-0">
                    <asp:Label ID="Question5Label" class="col-sm-12 px-0 text-center text-sm-left" runat="server" Style="font-size: large; line-height: 38px;" Text="5."></asp:Label><br />
                    <asp:Label ID="Response5Label" class="col-sm-12 px-4 text-center text-sm-left border border-dark rounded" runat="server" Style="font-weight: bold; font-size: large; line-height: 38px;" Text=""></asp:Label><br />
                </div>
            </div>
            <div class="row container mx-auto px-0">
                <asp:Button ID="BackToSurveyListButton" class="col-sm-2 mx-auto my-2 btn btn-info border border-dark" runat="server" Text="Back to Survey List" OnClick="BackToSurveyListButton_Click"></asp:Button>
            </div>
        </div>
    </div>
</asp:Content>
