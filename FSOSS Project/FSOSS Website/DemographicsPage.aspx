<%@ Page Title="Demographics" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="DemographicsPage.aspx.cs" Inherits="Pages_Survey_DemographicsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%--Customer Profile--%>
    <div class="form-check">
        <asp:CheckBox ID="CustomerProfileCheckBox" runat="server" CssClass="form-check-input" OnCheckedChanged="CustomerProfileCheckBox_CheckedChanged" 
            AutoPostBack="true" />
        <asp:Label ID="CustomerProfileCheckBoxLabel" runat="server" AssociatedControlID="CustomerProfileCheckBox" CssClass="form-check-lable" 
            Text="Customer Profile" Font-Bold="true" />
        <br />
        <asp:Label ID="CustomerProfileOptional" runat="server" Text="(Please check the box to create a customer Profile. This is optional but helps us to <br/> understand our customers' needs)" />  
    </div>

    <br />

    <div id="CustomerProfileContent" runat="server">
        <div class="row">
            <asp:Label ID="GenderLabel" class="col-md-2 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="GenderDDL" CssClass="col-md-4 form-control" runat="server" DataSourceID="GenderObjectDataSource" 
                DataTextField="genderDescription" 
                DataValueField="genderID" />
            <asp:ObjectDataSource runat="server" ID="GenderObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetGenderList" TypeName="FSOSS.System.BLL.GenderController"></asp:ObjectDataSource>
            <br />
        </div>
        <br />
        <div class="row">
            <asp:Label ID="AgeRangeLabel" class="col-md-2 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="AgeDDL" CssClass="col-md-4 form-control" runat="server" DataSourceID="AgeRangeObjectDataSource" 
                DataTextField="ageRangeDescription" 
                DataValueField="ageRangeID" />
            <asp:ObjectDataSource runat="server" ID="AgeRangeObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetAgeRangeList" TypeName="FSOSS.System.BLL.AgeRangeController"></asp:ObjectDataSource>
            <br />
        </div>
    </div>

    <br />
    <br />

    <%--Contact Requests--%>
    <%--Customer Profile--%>
    <div class="form-check">
        <asp:CheckBox ID="ContactRequestsCheckBox" runat="server" CssClass="form-check-input" OnCheckedChanged="ContactRequestsCheckBox_CheckedChanged" 
            AutoPostBack="true" />
        <asp:Label ID="ContactRequestsCheckBoxLabel" runat="server" AssociatedControlID="ContactRequestsCheckBox" CssClass="form-check-lable"
            Text="If you have any meal or service concerns, please check the box and provide your <br/> phone number and room number so that we can contact you."
            Font-Bold="true" />
    </div>
    <br />
    <%--Contact Phone and Room Number--%>
    <div id ="ContactRequestsContent" runat="server">
        <div class="row">
            <asp:Label CssClass="col-md-2 ml-md-5 my-2" runat="server" Text="Phone Number:"></asp:Label>
            <asp:TextBox CssClass="col-md-4 form-control" ID="PhoneTextBox" runat="server" AutoComplete="off" placeholder="Enter phone number e.g. 7801234567"></asp:TextBox>
            
            <%--Validation check for phone number--%>
            <asp:Label ID="PhoneNumber" runat="server" Text="Please enter a 10 digit phone number" CssClass="text-danger pl-2" Visible="false" />
        </div>
        <br />
        <div class="row">
            <asp:Label CssClass="col-md-2 ml-md-5 my-2" runat="server" Text="Room Number:"></asp:Label>
            <asp:TextBox CssClass="col-md-4 form-control" ID="RoomTextBox" runat="server" AutoComplete="off" placeholder="Enter room number"></asp:TextBox>
            <asp:Label ID="RoomNumber" runat="server" Text="Please enter a proper room number" CssClass="text-danger pl-2" Visible="false" />
        </div>
    </div>

    <div class="col-md-12">
        <%--Back to questions--%>
        <asp:Button CssClass="btn col-md-2 my-5 mr-5" ID="BackButton" runat="server" Text="Back" OnClick="BackButton_Click"/>

        <%--Submit Survey Button--%>
       <asp:Button CssClass="btn col-md-2 my-5 offset-md-2 fsoss-lightblue" ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" CausesValidation="true"/>
      
    </div>
</asp:Content>

