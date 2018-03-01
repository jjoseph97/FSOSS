<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ParticpantSampleCRUD.aspx.cs" Inherits="Pages_ParticpantSampleCRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="row">
        <h3>Read Data</h3>
        <asp:Label ID="ParticipantTypeIDLabel" runat="server" Text="Participant Type ID"></asp:Label>
        <asp:TextBox ID="ParticipantTypeIDTextBox" Text="" runat="server"></asp:TextBox>
        <asp:Label ID="ParticipantTypeDescription" runat="server" Text="Participant Type Description"></asp:Label>
        <asp:TextBox ID="ParticipantTypeDescriptionTextBox" Text="" runat="server"></asp:TextBox>
        <asp:Button ID="SearchButton" runat="server" Text="Search" OnClick="SearchButton_Click" />
    </div>

    
    <div class="row">
        <h3>Create Data</h3>
        <asp:Label ID="Label1" runat="server" Text="Enter Participant Description"></asp:Label>
        <asp:TextBox ID="AddParticipantTypeDescriptionTextBox" Text="" runat="server"></asp:TextBox>
        <asp:Button ID="AddButton" runat="server" Text="Add" OnClick="AddButton_Click"/>
         <asp:Label ID="Status" runat="server" Text="Status"></asp:Label>
    </div>

     <div class="row">
        <h3>Update Data</h3>
        <asp:Label ID="Label3" runat="server" Text="Participant Type ID"></asp:Label>
        <asp:Label ID="UpdateParticipantIDLabel" Text="" runat="server"></asp:Label>
        <asp:Label ID="Label2" runat="server" Text="Enter New Participant Description"></asp:Label>
        <asp:TextBox ID="UpdateDescription" Text="" runat="server"></asp:TextBox>
        <asp:Button ID="UpdateButton" runat="server" Text="Update" OnClick="UpdateButton_Click" />
        <asp:Label ID="UpdateStatus" runat="server" Text="Status"></asp:Label>
    </div>

    <div class="row">
        <h3>Delete Data</h3>
        <asp:Label ID="Label4" runat="server" Text="Participant Type ID"></asp:Label>
        <asp:TextBox ID="DeleteParticipantID" Text="" runat="server"></asp:TextBox>
        <asp:Button ID="Delete" runat="server" Text="Delete" OnClick="Delete_Click" />
        <asp:Label ID="DeleteStatus" runat="server" Text="Status"></asp:Label>
    </div>

</asp:Content>

