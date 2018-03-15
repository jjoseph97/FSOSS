<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditQuestions.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_EditQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Edit Survey Questions</h1>
            <br />
        </div>
    </div>

    <div class="col-md-12">

        <div class="row">
            <asp:Label class="col-md-3 my-2" runat="server" Text="Select a Survey Question"></asp:Label>
            <asp:DropDownList ID="QuestionDDL" CssClass="col-md-3 form-control" runat="server">
                <asp:ListItem Value="">Select...</asp:ListItem>
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
                <asp:TextBox ID="DescriptionTextBox" Width="100%" TextMode="MultiLine" runat="server" />
                <asp:Button ID="UpdateButton" runat="server" Text="Update" />
            </div>
        </div>

        <div id="Div1" runat="server" class="row">
            <div class="col-md-12">
                <h1 id="h1" runat="server"></h1>
                <p>Response Options:</p>
                <asp:HiddenField ID="ResponseID" runat="server" />
                <asp:GridView ID="ResponseGridView" runat="server" AutoGenerateColumns="False" DataSourceID="ResponseObjectDataSource">
                    <Columns>
                        <asp:BoundField DataField="Text" HeaderText="Text" SortExpression="Text"></asp:BoundField>
                        <asp:BoundField DataField="Value" HeaderText="Value" SortExpression="Value"></asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource runat="server" ID="ResponseObjectDataSource" OldValuesParameterFormatString="original_{0}" SelectMethod="GetQuestionReponse" TypeName="FSOSS.System.BLL.QuestionSelectionController">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="QuestionID" PropertyName="Value" Name="question_id" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
    </div>
</asp:Content>

