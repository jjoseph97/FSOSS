<%@ Page Title="Food Satisfaction Online Survey" MasterPageFile="~/Site.master" Language="C#" AutoEventWireup="true" CodeFile="TakeSurvey.aspx.cs" Inherits="Pages_Survey_TakeSurvey" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Food Satisfaction Online Survey</h1><br />
        </div>
    </div>

    <div class="col-md-12">

        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Unit Number"></asp:Label>
            <asp:DropDownList CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem>Select Unit e.g.7W</asp:ListItem>
                <asp:ListItem>8E</asp:ListItem>
                <asp:ListItem>7E</asp:ListItem>
                <asp:ListItem>7W</asp:ListItem>
                <asp:ListItem>6E</asp:ListItem>
                <asp:ListItem>6W</asp:ListItem>
                <asp:ListItem>5E</asp:ListItem>
                <asp:ListItem>5W</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Participant Type"></asp:Label> 
            <asp:DropDownList CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem>Select Type</asp:ListItem>
                <asp:ListItem>Patient</asp:ListItem>
                <asp:ListItem>Non-Patient</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Meal Type"></asp:Label> 
            <asp:DropDownList CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem>Select Meal</asp:ListItem>
                <asp:ListItem>Breakfast</asp:ListItem>
                <asp:ListItem>Lunch</asp:ListItem>
                <asp:ListItem>Dinner</asp:ListItem>
                <asp:ListItem>Snacks</asp:ListItem>
            </asp:DropDownList><br /><br />
        </div>
        <br />
           
        <div class="row">
            <div class="col-md-12">
                <h2>Please tell us about your meal experience</h2>
            </div>
        </div>
        <br />

        <%--Question #1--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>1. During this hospital stay, how would you describe the following features of your meals?</b></p>
            </div>
        </div>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The variety of food in your daily meals"></asp:Label> 
            <asp:DropDownList CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem>Select Meal</asp:ListItem>
                <asp:ListItem>Breakfast</asp:ListItem>
                <asp:ListItem>Lunch</asp:ListItem>
                <asp:ListItem>Dinner</asp:ListItem>
                <asp:ListItem>Snacks</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-4 ml-5 my-2" runat="server" Text="The taste and flavor of your meals"></asp:Label> 
            <asp:DropDownList CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem>Select Meal</asp:ListItem>
                <asp:ListItem>Breakfast</asp:ListItem>
                <asp:ListItem>Lunch</asp:ListItem>
                <asp:ListItem>Dinner</asp:ListItem>
                <asp:ListItem>Snacks</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-4 ml-5 my-2" runat="server" Text="The temperature of your hot food"></asp:Label> 
            <asp:DropDownList CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem>Select Meal</asp:ListItem>
                <asp:ListItem>Breakfast</asp:ListItem>
                <asp:ListItem>Lunch</asp:ListItem>
                <asp:ListItem>Dinner</asp:ListItem>
                <asp:ListItem>Snacks</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-4 ml-5 my-2" runat="server" Text="The overall appearance of your meal"></asp:Label> 
            <asp:DropDownList CssClass="col-md-4 form-control" runat="server"></asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-4 ml-5 my-2" runat="server" Text="The helpfulness of the staff who deliver your meals"></asp:Label> 
            <asp:DropDownList CssClass="col-md-4 form-control" runat="server"></asp:DropDownList><br />
        </div>
        <br />

       <%-- Question #2--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>2. How satisfied are you with the portion sizes of your meals?</b></p>
            </div>
            <div class="col-md-12">
                <asp:DropDownList CssClass="col-md-4 form-control" runat="server"></asp:DropDownList><br />
            </div>
        </div>

         <%-- Question #3--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>3. Do your meals take into account your specific diet requirements?</b></p>
                <p>(for example; food allergies, medical requirements, cultural preferences)</p>
            </div>
            <div class="col-md-12">
                <asp:DropDownList CssClass="col-md-4 form-control" runat="server"></asp:DropDownList><br />
            </div>
        </div>

         <%-- Question #4--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>4. Overall, how would you rate your meal experience?</b></p>
            </div>
            <div class="col-md-12">
                <asp:DropDownList CssClass="col-md-4 form-control" runat="server"></asp:DropDownList><br />
            </div>
        </div>

          <%-- Question #5--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>5. Is there anything else you would like to share about your meal experience?</b></p>
            </div>
            <div class="col-md-12">
                <asp:TextBox ID="Question5" Height="100px" runat="server" CssClass="col-md-4 form-control"></asp:TextBox><br />
            </div>
        </div>

        <asp:Button ID="NextButton" runat="server" Text="Next" PostBackUrl="~/Pages/Survey/DemographicsPage.aspx" />
   </div>



</asp:Content>
