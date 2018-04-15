<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="card col-sm-12 col-md-12 mx-auto pb-4">
        <div class="row">
            <div class="col-sm-12 col-md-8 mx-auto">
                <p class="mt-4">
                    We would like to learn more about your meal experience while you have been in the hospital.
                Your responses will help us to improve and ensure the quality of food and services.
                </p>
                <p><u><b>Individual responses will be kept anonymous and confidential.</b></u></p>
            </div>
        </div>
        <asp:Panel runat="server" CssClass="row mt-3" DefaultButton="SurveyButton">
            <div class="col-sm-12 mb-3 col-md-6 mx-auto">
                <b>Please enter the word of the day below to take the survey:</b>
            </div>
            <div class="col-sm-12 mb-2">
                <asp:TextBox ID="WOTDTextBox" runat="server" CssClass="form-control col-md-6 mx-auto" placeholder="Enter word of the day here..." AutoFocus="true" AutoComplete="off" />
            </div>
            <div class="col-sm-12 mb-3">
                <asp:Button ID="SurveyButton" runat="server" CssClass="btn btn-block col-md-6 mx-auto" Text="Begin Survey" OnClick="SurveyButton_Click" BackColor="#223F88" ForeColor="White" />
            </div>
            <div class="col-sm-12 col-md-6 mx-auto mb-3">
                <b>This survey will take approximately 5 minutes of your time.</b>
            </div>
        </asp:Panel>
        <div class="row">
            <div class="col-sm-12 text-center">
                <asp:Label ID="Message" runat="server" CssClass="alert alert-danger p-2 rounded" Visible="false" />
            </div>
        </div>
    </div>

</asp:Content>
