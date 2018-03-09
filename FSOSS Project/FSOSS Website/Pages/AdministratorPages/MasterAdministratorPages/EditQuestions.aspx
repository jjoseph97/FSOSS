<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditQuestions.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_EditQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Edit Questions</h1>
            <br />
        </div>
    </div>

    <div class="col-md-12">

        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Survey Questions"></asp:Label>
            <asp:DropDownList ID="QuestionDDL" CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem Value="">Select Question</asp:ListItem>
                <asp:ListItem Value="1">Question 1</asp:ListItem>
                <asp:ListItem Value="2">Question 1A</asp:ListItem>
                <asp:ListItem Value="3">Question 1B</asp:ListItem>
                <asp:ListItem Value="4">Question 1C</asp:ListItem>
                <asp:ListItem Value="5">Question 1D</asp:ListItem>
                <asp:ListItem Value="6">Question 1E</asp:ListItem>
                <asp:ListItem Value="8">Question 2</asp:ListItem>
                <asp:ListItem Value="9">Question 3</asp:ListItem>
                <asp:ListItem Value="10">Question 4</asp:ListItem>
                <asp:ListItem Value="11">Question 5</asp:ListItem>
            </asp:DropDownList><br />
            <asp:Button ID="ViewButton" runat="server" Text="View" OnClick="ViewButton_Click" />
            <div class="col-sm-12">
                <asp:Label ID="Message" runat="server" />
            </div>
        </div>

        <br />

        <%-- EDIT AREA --%>
        <div id="editArea" runat="server" class="row">
            <div class="col-md-12">
                <h1 id="headerText" runat="server"></h1>
                <p>Description:</p>
                <asp:HiddenField ID="QuestionID" runat="server" />
                <asp:TextBox ID="DescriptionTextBox" Height="200px" Width="100%" TextMode="MultiLine" runat="server" />
            </div>
        </div>
    </div>
</asp:Content>

