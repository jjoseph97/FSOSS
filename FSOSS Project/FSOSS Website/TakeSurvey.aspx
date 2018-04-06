<%@ Page Title="Food Satisfaction Online Survey" MasterPageFile="~/Site.master" Language="C#" AutoEventWireup="true" CodeFile="TakeSurvey.aspx.cs" Inherits="Pages_Survey_TakeSurvey" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Food Satisfaction Online Survey</h1><br />
        </div>
    </div>

    <div class="row">
        <div class="col-md-12 text-right">
            <asp:Label ID="SiteName" runat="server"></asp:Label>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <asp:Label class="col-md-3 my-2" runat="server"><span class="card container h5 alert alert-danger">All fields with * are required.</span></asp:Label>
        </div>
    </div>

    <div class="col-md-12">

        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server"><span class="text-danger pl-2">*</span>Unit Number:</asp:Label>
            <asp:DropDownList ID="UnitDropDownList" CssClass="col-md-3 form-control" runat="server" DataSourceID="UnitsObjectDataSource" DataTextField="unitNumber" 
                DataValueField="unitID" AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select a Unit"/>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ErrorMessage="Please choose a unit" ControlToValidate="UnitDropDownList" runat="server" 
                                InitialValue="" Display="Dynamic" SetFocusOnError ="true" CssClass="text-danger pl-2"/>
            <asp:ObjectDataSource runat="server" ID="UnitsObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUnitListModified"
                TypeName="FSOSS.System.BLL.UnitController">
                <SelectParameters>
                    <asp:SessionParameter SessionField="siteID" Name="site_id" Type="Int32"></asp:SessionParameter>

                </SelectParameters>
            </asp:ObjectDataSource>
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server"><span class="text-danger pl-2">*</span>Participant Type:</asp:Label> 
            <asp:DropDownList ID="ParticipantTypeDropDownList" CssClass="col-md-3 form-control" runat="server" DataSourceID="ParticipantTypeObjectDataSource" 
                DataTextField="participantTypeDescription" DataValueField="participantTypeID"  AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select a Participant Type"/>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ErrorMessage="Please choose a participant type" ControlToValidate="ParticipantTypeDropDownList" runat="server" 
                                 InitialValue="" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger pl-2" />
            <asp:ObjectDataSource runat="server" ID="ParticipantTypeObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetParticipantTypeList" 
                TypeName="FSOSS.System.BLL.ParticipantController"></asp:ObjectDataSource>
        </div>
        <br />
        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server"><span class="text-danger pl-2">*</span>Meal Type:</asp:Label> 
            <asp:DropDownList ID="MealTypeDropDownList" CssClass="col-md-3 form-control" runat="server" DataSourceID="MealTypeObjectDataSource" DataTextField="mealName" 
                DataValueField="mealID" AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select a Meal Type"/>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ErrorMessage="Please choose a meal type" ControlToValidate="MealTypeDropDownList" runat="server" 
                                 InitialValue="" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger pl-2"/>
            <asp:ObjectDataSource runat="server" ID="MealTypeObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetMealList" 
                TypeName="FSOSS.System.BLL.MealController"></asp:ObjectDataSource>
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
                <asp:Label ID="Q1" runat="server" Font-Bold="true" />
            </div>
        </div>
        <br />
        <%--Q1A--%>
        <div class="row">
            <asp:Label ID="Q1A" class="col-md-4 ml-md-5 my-2" runat="server" /> 
            <asp:DropDownList ID="Q1AResponse" CssClass="col-md-4 form-control" runat="server" 
                DataSourceID="Q1AObjectDataSource" DataTextField="Text" DataValueField="Value" AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select..."/>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1AObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1AReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
            <asp:Label ID="testMsg" runat="server" />
        </div>
        <br />
        <%--Q1B--%>
        <div class="row">
            <asp:Label ID="Q1B" class="col-md-4 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="Q1BResponse" CssClass="col-md-4 form-control" runat="server" DataSourceID="Q1BObjectDataSource" DataTextField="Text" 
                DataValueField="Value" AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select..."/>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1BObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1BReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />
        <%--Q1C--%>
        <div class="row">
            <asp:Label ID="Q1C" class="col-md-4 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="Q1CResponse" CssClass="col-md-4 form-control" runat="server" DataSourceID="Q1CObjectDataSource" DataTextField="Text" 
                DataValueField="Value" AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select..."/>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1CObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1CReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />
        <%--Q1D--%>
        <div class="row">
            <asp:Label ID="Q1D" class="col-md-4 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="Q1DResponse" CssClass="col-md-4 form-control" runat="server" 
                DataSourceID="Q1DObjectDataSource" DataTextField="Text" DataValueField="Value" AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select..."/>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1DObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1DReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />
        <%--Q1E--%>
        <div class="row">
            <asp:Label ID="Q1E" class="col-md-4 ml-md-5 my-2" runat="server" />
            <asp:DropDownList ID="Q1EResponse" CssClass="col-md-4 form-control" runat="server" 
                DataSourceID="Q1EObjectDataSource" DataTextField="Text" DataValueField="Value" AppendDataBoundItems="true">
                <asp:ListItem Value="" Text="Select..."/>
            </asp:DropDownList>
            <asp:ObjectDataSource runat="server" ID="Q1EObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                SelectMethod="GetQuestion1EReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
        </div>
        <br />

        <%-- Question #2--%>
        <div class="row">
            <div class="col-md-12">
                <asp:Label ID="Q2" runat="server" Font-Bold="true" />
            </div>
            <br />
            <div class="col-md-12">
                <asp:DropDownList ID="Q2Response" CssClass="col-md-4 form-control my-2" runat="server" 
                    DataSourceID="Q2ResponseObjectDataSource" DataTextField="Text" DataValueField="Value" AppendDataBoundItems="true">
                    <asp:ListItem Value="" Text="Select..."/>
                </asp:DropDownList>
                <asp:ObjectDataSource runat="server" ID="Q2ResponseObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetQuestion2Reponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
            </div>
        </div>
        <br />

        <%-- Question #3--%>
        <div class="row">
            <div class="col-md-12">
                <asp:Label ID="Q3" runat="server" Font-Bold="true" />
                <p>(for example; food allergies, medical requirements, cultural preferences)</p>
            </div>
            <br />
            <div class="col-md-12">
                <asp:DropDownList ID="Q3Response" CssClass="col-md-4 form-control" runat="server" 
                    DataSourceID="Q3ResponseObjectDataSource" DataTextField="Text" DataValueField="Value" AppendDataBoundItems="true">
                    <asp:ListItem Value="" Text="Select..."/>
                </asp:DropDownList>
                <asp:ObjectDataSource runat="server" ID="Q3ResponseObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetQuestion3Reponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
            </div>
        </div>
        <br />

        <%-- Question #4--%>
        <div class="row">
            <div class="col-md-12">
                <span class="text-danger pl-2">*</span><asp:Label ID="Q4" runat="server" Font-Bold="true" />
            </div>
            <br />
            <div class="col-md-12 form-inline">
                <asp:DropDownList ID="Q4Response" CssClass="col-md-4 form-control my-2" runat="server" 
                    DataSourceID="Q4ResponseObjectDataSource" DataTextField="Text" DataValueField="Value" AppendDataBoundItems="true">
                    <asp:ListItem Value="" Text="Select..."/>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ErrorMessage="Please choose an option for Question 4" ControlToValidate="Q4Response" runat="server" 
                                 InitialValue="" Display="Dynamic" SetFocusOnError="true" CssClass="text-danger pl-2"/>
                <asp:ObjectDataSource runat="server" ID="Q4ResponseObjectDataSource" OldValuesParameterFormatString="original_{0}" 
                    SelectMethod="GetQuestion4Reponse" TypeName="FSOSS.System.BLL.QuestionSelectionController"></asp:ObjectDataSource>
                <br />
            </div>
        </div>
        <br />

        <%-- Question #5--%>
        <div class="row">
            <div class="col-md-12">
                <asp:Label ID="Q5" runat="server" Font-Bold="true" />
            </div>
            <br />
            <div class="col-md-12">
                <asp:TextBox ID="Question5" Height="100px" TextMode="MultiLine" runat="server" CssClass="col-md-4 form-control my-2"></asp:TextBox><br />
            </div>
        </div>

        <asp:Button CssClass="btn col-md-2" ID="NextButton" runat="server" Text="Next" OnClick="NextButton_Click" BackColor="#A6EBF7" />
        <%--<asp:Button ID="Button1" runat="server" Text="Next" PostBackUrl="~/Pages/Survey/DemographicsPage.aspx" OnClick="NextButton_Click"/>--%>
   </div>



</asp:Content>
