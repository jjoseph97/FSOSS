<%@ Page Title="Food Satisfaction Online Survey" MasterPageFile="~/Site.master" Language="C#" AutoEventWireup="true" CodeFile="TakeSurvey.aspx.cs" Inherits="Pages_Survey_TakeSurvey" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Food Satisfaction Online Survey</h1><br />
        </div>
    </div>

    <div class="col-md-12">

        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Unit Number:"></asp:Label>
            <asp:DropDownList ID="UnitDropDownList" CssClass="col-md-3 form-control" runat="server" DataSourceID="UnitsObjectDataSource" DataTextField="unitNumber" DataValueField="unitID">
            </asp:DropDownList>

            <asp:ObjectDataSource runat="server" ID="UnitsObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUnitList" TypeName="FSOSS.System.BLL.UnitController">
                <SelectParameters>
                    <asp:ControlParameter ControlID="UnitDropDownList" PropertyName="SelectedValue" Name="site_id" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Participant Type:"></asp:Label> 
            <asp:DropDownList ID="ParticipantTypeDropDownList" CssClass="col-md-3 form-control" runat="server" DataSourceID="ParticipantTypeObjectDataSource" DataTextField="participantTypeDescription" DataValueField="participantTypeID"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="ParticipantTypeObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetParticipantTypeList" TypeName="FSOSS.System.BLL.ParticipantController"></asp:ObjectDataSource>
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Meal Type:"></asp:Label> 
            <asp:DropDownList ID="MealTypeDropDownList" CssClass="col-md-3 form-control" runat="server" DataSourceID="MealTypeObjectDataSource" DataTextField="mealName" DataValueField="mealID"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="MealTypeObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetMealList" TypeName="FSOSS.System.BLL.MealController"></asp:ObjectDataSource>
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
            <asp:DropDownList ID="Q1AResponse" CssClass="col-md-4 form-control" runat="server" 
                DataSourceID="Q1AObjectDataSource" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1AObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1AReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
            <asp:Label ID="testMsg" runat="server" />
        </div>
        <br />

        <%--Q1B--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The taste and flavor of your meals"></asp:Label> 
            <asp:DropDownList ID="Q1BResponse" CssClass="col-md-4 form-control" runat="server" DataSourceID="Q1BObjectDataSource" DataTextField="Text" 
                DataValueField="Value"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1BObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1BReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />

        <%--Q1C--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The temperature of your hot food"></asp:Label> 
            <asp:DropDownList ID="Q1CResponse" CssClass="col-md-4 form-control" runat="server" DataSourceID="Q1CObjectDataSource" DataTextField="Text" 
                DataValueField="Value"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1CObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1CReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />

        <%--Q1D--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The overall appearance of your meal"></asp:Label> 
            <asp:DropDownList ID="Q1DResponse" CssClass="col-md-4 form-control" runat="server" 
                DataSourceID="Q1DObjectDataSource" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1DObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1DReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />

        <%--Q1E--%>
        <div class="row">
            <asp:Label class="col-md-4 ml-md-5 my-2" runat="server" Text="The helpfulness of the staff who deliver your meals"></asp:Label> 
            <asp:DropDownList ID="Q1EResponse" CssClass="col-md-4 form-control" runat="server" 
                DataSourceID="Q1EObjectDataSource" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1EObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1EReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />

        <%-- Question #2--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>2. How satisfied are you with the portion sizes of your meals?</b></p>
            </div>
            <div class="col-md-12">
                <asp:DropDownList ID="Q2Response" CssClass="col-md-4 form-control" runat="server" DataSourceID="Q2ResponseObjectDataSource" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
                <asp:ObjectDataSource runat="server" ID="Q2ResponseObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetQuestion2Reponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
            </div>
        </div>
        <br />

        <%-- Question #3--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>3. Do your meals take into account your specific diet requirements?</b></p>
                <p>(for example; food allergies, medical requirements, cultural preferences)</p>
            </div>
            <div class="col-md-12">
                <asp:DropDownList ID="Q3Response" CssClass="col-md-4 form-control" runat="server" DataSourceID="Q3ResponseObjectDataSource" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
                <asp:ObjectDataSource runat="server" ID="Q3ResponseObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetQuestion3Reponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
            </div>
        </div>
        <br />

        <%-- Question #4--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>4. Overall, how would you rate your meal experience?</b></p>
            </div>
            <div class="col-md-12 form-inline">
                <asp:DropDownList ID="Q4Response" CssClass="col-md-4 form-control" runat="server" DataSourceID="Q4ResponseObjectDataSource" DataTextField="Text" DataValueField="Value"></asp:DropDownList>
                <asp:ObjectDataSource runat="server" ID="Q4ResponseObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetQuestion4Reponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
                <asp:Label ID="Message" runat="server" CssClass="col-md-6" />
                <br />
            </div>
        </div>
        <br />

        <%-- Question #5--%>
        <div class="row">
            <div class="col-md-12">
                <p><b>5. Is there anything else you would like to share about your meal experience?</b></p>
            </div>
            <div class="col-md-12">
                <asp:TextBox ID="Q5" Height="100px" runat="server" CssClass="col-md-4 form-control"></asp:TextBox><br />
            </div>
        </div>

        <asp:Button CssClass="btn col-md-2" ID="NextButton" runat="server" Text="Next" OnClick="NextButton_Click" BackColor="#A6EBF7" />
        <%--<asp:Button ID="Button1" runat="server" Text="Next" PostBackUrl="~/Pages/Survey/DemographicsPage.aspx" OnClick="NextButton_Click"/>--%>
   </div>



</asp:Content>
