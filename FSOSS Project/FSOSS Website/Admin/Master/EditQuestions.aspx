<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditQuestions.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_EditQuestions" %>

<script runat="server">

    protected void UpdateButton_Click(object sender, EventArgs e)
    {

    }
</script>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-12">
            <h1 class="card container py-2 page-header">Edit Survey Questions & Responses</h1>
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
                <asp:Button ID="QuestionUpdate" runat="server" Text="Update" OnClick="QuestionUpdate_Click" />
            </div>
        </div>

        <div id="Div1" runat="server" class="row">
            <div class="col-md-12">
                <h1 id="h1" runat="server"></h1>
                <p>Response Options:</p>
                <asp:HiddenField ID="ResponseID" runat="server" />
                <asp:ListView ID="QuestionResponses" runat="server" DataSourceID="QResponsesObjectDataSource" >
                    <AlternatingItemTemplate>
                        <tr style="background-color: #FFF8DC;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("ResponseId") %>' runat="server" ID="IdLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Text") %>' runat="server" ID="TextLabel" /></td>
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr style="background-color: #008A8C; color: #FFFFFF;">
                            <td style="display:none;">
                                <asp:TextBox Text='<%# Bind("ResponseId") %>' runat="server" ID="IdTextBox" /></td>
                            <td>
                                <asp:TextBox Text='<%# Bind("Text") %>' runat="server" ID="TextTextBox" /></td>
                            <td style="display:none;">
                                <asp:TextBox Text='<%# Bind("Value") %>' runat="server" ID="ValueTextBox" /></td>
                            <td>
                                <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" Visible="true" />
                                <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <ItemTemplate>
                        <tr style="background-color: #DCDCDC; color: #000000;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("ResponseId") %>' runat="server" ID="IdLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Text") %>' runat="server" ID="TextLabel" /></td>
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                        <tr runat="server" style="background-color: #DCDCDC; color: #000000;">
                                            <%--<th runat="server">Id</th>--%>
                                            <th runat="server">Reponses</th>
                                            <th runat="server"></th>
                                            <%--<th runat="server">Value</th>--%>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                            <%--<tr runat="server">
                                <td runat="server" style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                    <asp:DataPager runat="server" ID="DataPager2">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>--%>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("ResponseId") %>' runat="server" ID="IdLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Text") %>' runat="server" ID="TextLabel" /></td>
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel" /></td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" /></td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:ObjectDataSource runat="server" ID="QResponsesObjectDataSource" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetQuestionResponses"
                    TypeName="FSOSS.System.BLL.QuestionSelectionController"
                    UpdateMethod="UpdateQuestionResponses">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="QuestionID" PropertyName="Value" Name="questionid" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="QuestionID" PropertyName="Value" Name="questionid" Type="Int32"></asp:ControlParameter>
                        <asp:Parameter Name="ResponseId" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="Text" Type="String"></asp:Parameter>
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </div>

            <%--<asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />--%>
        </div>
    </div>
</asp:Content>

