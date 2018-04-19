<%@ Page Title="Unauthorized" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="http403.aspx.cs" Inherits="http403" %>

<asp:Content ID="http403" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="justify-content-center text-center">
        <div class="jumbotron">
            <h1 class="display-1">403</h1>
            <hr />
            <h2>Unauthorized</h2>
            <p>
                You are unauthorized to access this page.
                    <br />
                Please go to the survey page by clicking the button below or click the back button on your browser.
            </p>
            <asp:Button ID="TheButton" runat="server" CssClass="btn btn-primary" Text="Survey Page" PostBackUrl="~/" />
        </div>
    </div>
</asp:Content>

