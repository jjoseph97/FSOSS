<%@ Page Title="Edit Survey Questions & Responses" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="EditQuestions.aspx.cs" Inherits="Pages_AdministratorPages_MasterAdministratorPages_EditQuestions" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row">
        <div class="col-md-12">
             <h1 class="card container py-2 h4" style="font-weight:bold;">Edit Survey Questions & Responses</h1>
        </div>
    </div>
    <div class="col-sm-12 px-0">
            <uc1:MessageUserControl runat="server" class="alert alert-danger mb-2 card" ID="MessageUserControl" />
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card container mb-2">
                <div class="row container mx-auto px-0">
                    <asp:Label class="col-sm-4 my-2 text-center text-sm-left" style="font-weight:bold;font-size:large; line-height:38px;" runat="server" Text="Select a Question to Edit"></asp:Label>
                    <asp:DropDownList ID="QuestionDDL" CssClass="col-sm-3 form-control my-2" runat="server">
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
                    <asp:Button ID="ViewButton" class="col-sm-2 offset-sm-3 my-2 btn btn-info" runat="server" Text="View" OnClick="ViewButton_Click" />
                    <div class="col-sm-12">
                        <asp:Label ID="Message" runat="server" />
                    </div>
                </div>
            </div>
            <%-- EDIT AREA --%>
            <div id="editQuestion" runat="server" class="card container my-2">
                <div class="row">
                    <div class="col-md-12">
                        <h1 id="headerText" fontsize="15px" runat="server"></h1>
                        <%--<p>Description:</p>--%>
                        <asp:HiddenField ID="QuestionID" runat="server" />
                        <asp:TextBox ID="DescriptionTextBox" CssClass="form-control"  Width="100%" TextMode="MultiLine" runat="server" />
                        <asp:Button ID="QuestionUpdate"  class="col-sm-2 offset-sm-10 my-2 btn btn-success" runat="server" Text="Update" OnClick="QuestionUpdate_Click" />
                    </div>
                </div>
            </div>
            <div id="editResponse" runat="server" class="card container my-2">
                <asp:HiddenField ID="ResponseID" runat="server" />
                <asp:ListView ID="QuestionResponses" runat="server" DataSourceID="QResponsesObjectDataSource" >
                    <AlternatingItemTemplate>
                        <tr class="fsoss-listview-alternate">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("ResponseId") %>' runat="server" ID="IdLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Text") %>' runat="server" CssClass="pl-3" ID="TextLabel" />
                            </td>
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel" />
                            </td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" />
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EditItemTemplate>
                        <tr class="listview-header">
                            <td style="display:none;">
                                <asp:TextBox Text='<%# Bind("ResponseId") %>' runat="server" ID="IdTextBox" />
                            </td>
                            <td>
                                <asp:TextBox Text='<%# Bind("Text") %>' runat="server" CssClass="pl-3 col-12" ID="TextTextBox" />
                            </td>
                            <td style="display:none;">
                                <asp:TextBox Text='<%# Bind("Value") %>' runat="server" ID="ValueTextBox" />
                            </td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Update" Text="Update" ID="UpdateButton" Visible="true" />
                                <asp:Button runat="server" CssClass="btn btn btn-danger mx-3 my-1" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
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
                        <tr class="fsoss-listview-itemtemplate">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("ResponseId") %>' runat="server" ID="IdLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Text") %>' runat="server" CssClass="pl-3" ID="TextLabel" />
                            </td>
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel" />
                            </td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" />
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <table runat="server" style="width: 100%;" class="mt-2 mb-2">
                            <tr runat="server">
                                <td runat="server">
                                    <table runat="server" id="itemPlaceholderContainer" class="listview-header" style="border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; width:100%; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                        <tr runat="server">
                                            <%--<th runat="server">Id</th>--%>
                                            <th runat="server" class="w-80 p-3">Response Options</th>
                                            <th runat="server" class="w-20 p-3">Edit Responses</th>
                                            <%--<th runat="server">Value</th>--%>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <SelectedItemTemplate>
                        <tr style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("ResponseId") %>' runat="server" ID="IdLabel" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("Text") %>' runat="server" ID="TextLabel" />
                            </td>
                            <td style="display:none;">
                                <asp:Label Text='<%# Eval("Value") %>' runat="server" ID="ValueLabel" />
                            </td>
                            <td>
                                <asp:Button runat="server" CssClass="btn btn btn-success mx-3 my-1" CommandName="Edit" Text="Edit" ID="EditButton" />
                            </td>
                        </tr>
                    </SelectedItemTemplate>
                </asp:ListView>
                <asp:ObjectDataSource runat="server" ID="QResponsesObjectDataSource" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetQuestionResponses"
                    TypeName="FSOSS.System.BLL.QuestionSelectionController"
                    UpdateMethod="UpdateQuestionResponses"
                    OnUpdated="CheckForException"
                    OnDeleted="CheckForException">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="QuestionID" PropertyName="Value" Name="questionid" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:ControlParameter ControlID="QuestionID" PropertyName="Value" Name="questionid" Type="Int32"></asp:ControlParameter>
                        <asp:Parameter Name="ResponseId" Type="Int32"></asp:Parameter>
                        <asp:Parameter Name="Text" Type="String"></asp:Parameter>
                        <asp:ControlParameter ControlID="QuestionDDL" PropertyName="SelectedItem.Text" Name="strQuestion" Type="String" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
            </div>
        </div>
     </div>
</asp:Content>

