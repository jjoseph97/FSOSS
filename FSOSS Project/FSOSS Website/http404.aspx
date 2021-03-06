﻿<%@ Page Title="Page Not Found" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="http404.aspx.cs" Inherits="http404" %>

<asp:Content ID="http403" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="justify-content-center text-center">
        <div class="jumbotron">
            <h1 class="display-1">404</h1>
            <hr />
            <h2>Page Not Found</h2>
            <p>
                The requested page does not exist.
                    <br />
                Please go to the survey page by clicking the button below or click the back button on your browser.
            </p>
            <asp:Button ID="TheButton" runat="server" CssClass="btn btn-primary" Text="Survey Page" PostBackUrl="~/" />
        </div>
    </div>
</asp:Content>

