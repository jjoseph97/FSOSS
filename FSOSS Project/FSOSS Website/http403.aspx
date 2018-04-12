<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="http403.aspx.cs" Inherits="http403" %>

<asp:Content ID="http403" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="justify-content-center text-center">
            <div class="jumbotron">
                <h1 class="display-1">403</h1>
                <hr />
                <h2>Unauthorized</h2>
                <p>You are unauthorized to access this page.
                    <br />
                    Please go to the FSOSS home page by clicking the button below
                    <br />
                    or click the back button on your browser.
                </p>
                <asp:Button ID="TheButton" runat="server" CssClass="btn btn-primary" Text="FSOSS Home" PostBackUrl="~/" />
            </div>
        </div>
</asp:Content>

