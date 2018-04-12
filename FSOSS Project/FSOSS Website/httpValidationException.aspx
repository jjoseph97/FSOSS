<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="httpValidationException.aspx.cs" Inherits="httpValidationException" %>

<asp:Content ID="httpValidationException" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="justify-content-center text-center">
        <div class="jumbotron">
            <h1 class="display-3">Validation Error</h1>
            <hr />
            <p>Sorry, but HTML entry is not allowed on that page.</p>
            <p>
                Please make sure that your entries do not contain 
                any angle brackets like &lt; or &gt;.
            </p>
            <p><a href='javascript:back()' class="btn btn-primary">Go back</a></p>
        </div>
    </div>
    <script language='JavaScript'>
    function back() { history.go(-1); } </script>
</asp:Content>

