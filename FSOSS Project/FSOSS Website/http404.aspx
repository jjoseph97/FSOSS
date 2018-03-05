<%@ Page Title="Page Not Found" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="http404.aspx.cs" Inherits="http404" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
        <div class="justify-content-center text-center">
            <div class="jumbotron">
                <h1 class="display-1">404</h1>
                <hr />
                <h3 class="display-4">Page Not Found</h3>
                <p>The requested page does not exist.
                    <br />
                    Please go to the FSOSS home page by clicking the button below.</p>
                <asp:Button ID="TheButton" runat="server" CssClass="btn btn-primary" Text="FSOSS Home" PostBackUrl="~/" />
            </div>
        </div>
</asp:Content>

