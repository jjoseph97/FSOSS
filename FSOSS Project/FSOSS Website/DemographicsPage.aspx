<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DemographicsPage.aspx.cs" Inherits="Pages_Survey_DemographicsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%--Customer Profile--%>
    <div class="form-check">
        <asp:CheckBox ID="CustomerProfileCheckBox" runat="server" CssClass="form-check-input" OnCheckedChanged="CustomerProfileCheckBox_CheckedChanged" AutoPostBack="true" />
        <asp:Label ID="CustomerProfileCheckBoxLabel" runat="server" AssociatedControlID="CustomerProfileCheckBox" CssClass="form-check-lable" Text="Customer Profile" Font-Bold="true" />
    </div>

    <br />

    <div id="CustomerProfileContent" runat="server">
        <div class="row">
            <asp:Label ID="GenderLabel" class="col-md-2 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="GenderDDL" CssClass="col-md-4 form-control" runat="server" DataSourceID="GenderObjectDataSource" DataTextField="genderDescription" 
                DataValueField="genderID" AppendDataBoundItems="true" >
                <asp:ListItem Value="" Text="Select Gender"/>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="GenderObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetGenderList" TypeName="FSOSS.System.BLL.GenderController"></asp:ObjectDataSource>
            <br />
        </div>
        <br />
        <div class="row">
            <asp:Label ID="AgeRangeLabel" class="col-md-2 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="AgeDDL" CssClass="col-md-4 form-control" runat="server" DataSourceID="AgeRangeObjectDataSource" DataTextField="ageRangeDescription" 
                DataValueField="ageRangeID"  AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select Age Range" />
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="AgeRangeObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAgeRangeList" TypeName="FSOSS.System.BLL.AgeRangeController"></asp:ObjectDataSource>
            <br />
        </div>
    </div>

    <br />
    <br />

    <%--Contact Requests--%>
    <div class="form-check">
        <asp:CheckBox ID="ContactRequestsCheckBox" runat="server" CssClass="form-check-input" OnCheckedChanged="ContactRequestsCheckBox_CheckedChanged" AutoPostBack="true" />
        <asp:Label ID="ContactRequestsCheckBoxLabel" runat="server" AssociatedControlID="ContactRequestsCheckBox" CssClass="form-check-lable"
            Text="If you have any meal or service concerns, please check the box and provide your <br/> phone number and room number so that we can contact you."
            Font-Bold="true" />
    </div>

    <br />

    <div id ="ContactRequestsContent" runat="server">
        <div class="row">
            <asp:Label CssClass="col-md-2 ml-md-5 my-2" runat="server" Text="Phone Number:"></asp:Label>
            <asp:TextBox CssClass="col-md-4 form-control" ID="PhoneTextBox" runat="server" placeholder="Enter phone number to be reached at"></asp:TextBox>
        </div>
        <br />
        <div class="row">
            <asp:Label CssClass="col-md-2 ml-md-5 my-2" runat="server" Text="Room Number:"></asp:Label>
            <asp:TextBox CssClass="col-md-4 form-control" ID="RoomTextBox" runat="server" placeholder="Enter room number e.g.001"></asp:TextBox>
        </div>
    </div>

    <%--Back to questions--%>
    <asp:Button CssClass="" ID="BackButton" runat="server" Text="Back" PostBackUrl="~/TakeSurvey.aspx" />

    <%--Submit Survey Button--%>
    <asp:Button CssClass="" ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />
</asp:Content>

