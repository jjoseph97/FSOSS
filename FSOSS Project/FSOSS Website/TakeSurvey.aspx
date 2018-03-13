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
            <asp:DropDownList ID="UnitNumber" CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem Value="">Select a Unit</asp:ListItem>
                <asp:ListItem Value="8E">8E</asp:ListItem>
                <asp:ListItem Value="7E">7E</asp:ListItem>
                <asp:ListItem Value="7W">7W</asp:ListItem>
                <asp:ListItem Value="6E">6E</asp:ListItem>
                <asp:ListItem Value="6W">6W</asp:ListItem>
                <asp:ListItem Value="5E">5E</asp:ListItem>
                <asp:ListItem Value="5W">5W</asp:ListItem>
                <asp:ListItem Value="3E">3E</asp:ListItem>
                <asp:ListItem Value="3N">3N</asp:ListItem>
                <asp:ListItem Value="ED">ED</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Participant Type"></asp:Label> 
            <asp:DropDownList ID="ParticipantType" CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem Value="">Select a Participant</asp:ListItem>
                <asp:ListItem Value="PT">Patient</asp:ListItem>
                <asp:ListItem Value="NPT">Non-Patient</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Meal Type"></asp:Label> 
            <asp:DropDownList ID="MealType" CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem Value="">Select a Meal</asp:ListItem>
                <asp:ListItem Value="BF">Breakfast</asp:ListItem>
                <asp:ListItem Value="LN">Lunch</asp:ListItem>
                <asp:ListItem Value="DN">Dinner</asp:ListItem>
                <asp:ListItem Value="SN">Snacks</asp:ListItem>
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
        <%--Q1A--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The variety of food in your daily meals"></asp:Label> 
            <asp:DropDownList ID="Q1A" CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem Value="">Select...</asp:ListItem>
                <asp:ListItem Value="VG">Very Good</asp:ListItem>
                <asp:ListItem Value="G">Good</asp:ListItem>
                <asp:ListItem Value="F">Fair</asp:ListItem>
                <asp:ListItem Value="P">Poor</asp:ListItem>
                <asp:ListItem Value="DKNO">Don't Know/No Opinion</asp:ListItem>
            </asp:DropDownList><br />
            <asp:Label ID="testMsg" runat="server" />
        </div>
        <br />

        <%--Q1B--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The taste and flavor of your meals"></asp:Label> 
            <asp:DropDownList ID="Q1B" CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem Value="">Select...</asp:ListItem>
                <asp:ListItem Value="VG">Very Good</asp:ListItem>
                <asp:ListItem Value="G">Good</asp:ListItem>
                <asp:ListItem Value="F">Fair</asp:ListItem>
                <asp:ListItem Value="P">Poor</asp:ListItem>
                <asp:ListItem Value="DKNO">Don't Know/No Opinion</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />

        <%--Q1C--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The temperature of your hot food"></asp:Label> 
            <asp:DropDownList ID="Q1C" CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem Value="">Select...</asp:ListItem>
                <asp:ListItem Value="VG">Very Good</asp:ListItem>
                <asp:ListItem Value="G">Good</asp:ListItem>
                <asp:ListItem Value="F">Fair</asp:ListItem>
                <asp:ListItem Value="P">Poor</asp:ListItem>
                <asp:ListItem Value="DKNO">Don't Know/No Opinion</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />

        <%--Q1D--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The overall appearance of your meal"></asp:Label> 
            <asp:DropDownList ID="Q1D" CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem Value="">Select...</asp:ListItem>
                <asp:ListItem Value="VG">Very Good</asp:ListItem>
                <asp:ListItem Value="G">Good</asp:ListItem>
                <asp:ListItem Value="F">Fair</asp:ListItem>
                <asp:ListItem Value="P">Poor</asp:ListItem>
                <asp:ListItem Value="DKNO">Don't Know/No Opinion</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />

        <%--Q1E--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The helpfulness of the staff who deliver your meals"></asp:Label> 
            <asp:DropDownList ID="Q1E" CssClass="col-md-4 form-control" runat="server">
                <asp:ListItem Value="">Select...</asp:ListItem>
                <asp:ListItem Value="VG">Very Good</asp:ListItem>
                <asp:ListItem Value="G">Good</asp:ListItem>
                <asp:ListItem Value="F">Fair</asp:ListItem>
                <asp:ListItem Value="P">Poor</asp:ListItem>
                <asp:ListItem Value="DKNO">Don't Know/No Opinion</asp:ListItem>
            </asp:DropDownList><br />
        </div>
        <br />

       <%-- Question #2--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>2. How satisfied are you with the portion sizes of your meals?</b></p>
            </div>
            <div class="col-md-12">
                <asp:DropDownList ID="Q2" CssClass="col-md-4 form-control" runat="server">
                    <asp:ListItem>Select...</asp:ListItem>
                    <asp:ListItem>Portion sizes are too small</asp:ListItem>
                    <asp:ListItem>Portion sizes are just right</asp:ListItem>
                    <asp:ListItem>Portion sizes are too large</asp:ListItem>
                </asp:DropDownList><br />
            </div>
        </div>

         <%-- Question #3--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>3. Do your meals take into account your specific diet requirements?</b></p>
                <p>(for example; food allergies, medical requirements, cultural preferences)</p>
            </div>
            <div class="col-md-12">
                <asp:DropDownList ID="Q3" CssClass="col-md-4 form-control" runat="server">
                    <asp:ListItem>Select...</asp:ListItem>
                    <asp:ListItem>Always</asp:ListItem>
                    <asp:ListItem>Usually</asp:ListItem>
                    <asp:ListItem>Occasionally</asp:ListItem>
                    <asp:ListItem>Never</asp:ListItem>
                    <asp:ListItem>I do not have any specific dietary requirements</asp:ListItem>
                </asp:DropDownList><br />
            </div>
        </div>

         <%-- Question #4--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>4. Overall, how would you rate your meal experience?</b></p>
            </div>
            <div class="col-md-12 form-inline">
                <asp:DropDownList ID="Q4" CssClass="col-md-4 form-control" runat="server">
                    <asp:ListItem Value="">Select...</asp:ListItem>
                    <asp:ListItem Value="5">Very Good</asp:ListItem>
                    <asp:ListItem Value="4">Good</asp:ListItem>
                    <asp:ListItem Value="3">Fair</asp:ListItem>
                    <asp:ListItem Value="2">Poor</asp:ListItem>
                    <asp:ListItem Value="1">Very Poor</asp:ListItem>
                    <asp:ListItem Value="0">Terrible</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="Message" runat="server" CssClass="col-md-6" />
                <br />
            </div>
        </div>

          <%-- Question #5--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>5. Is there anything else you would like to share about your meal experience?</b></p>
            </div>
            <div class="col-md-12">
                <asp:TextBox ID="Q5" Height="100px" runat="server" CssClass="col-md-4 form-control"></asp:TextBox><br />
            </div>
        </div>

        <asp:Button ID="NextButton" runat="server" Text="Next" OnClick="NextButton_Click"/>
        <%--<asp:Button ID="Button1" runat="server" Text="Next" PostBackUrl="~/Pages/Survey/DemographicsPage.aspx" OnClick="NextButton_Click"/>--%>
   </div>



</asp:Content>
