<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportPage.aspx.cs" Inherits="Pages_AdministratorPages_ReportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
    </div>
    <div class="row"> 
          <asp:Label ID="FilterDescription" CssClass="mx-auto h2" class="label label-primary"  runat="server"></asp:Label>
          <asp:Label ID="TotalNumberOfSubmittedSurvey" CssClass="mx-auto h4" class="label label-primary" runat="server"></asp:Label>
    </div>
    
    <div>
        <ul class="nav nav-tabs">
            <li class="active"><a href="#question1Tab" data-toggle="tab">Question 1</a> </li>
            <li><a href="#question6Tab" data-toggle="tab">Question 9</a> </li>
            <li><a href="#question6Tab" data-toggle="tab">Question 10</a> </li>
        </ul>
    </div>
    <div class="tab-content">
        <div class="tab-pane-fade" id="question1Tab">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
             <ContentTemplate>
                <div style="width:1000px; height:600px">
                    <canvas id="Question1"></canvas>         
                </div>
                <div style="width:1000px; height:600px">
                    <canvas id="Question2"></canvas>
                </div>
                <div style="width:1000px; height:600px">
                    <canvas id="Question3"></canvas>
                </div>
                <div style="width:1000px; height:600px">
                    <canvas id="Question4"></canvas>
                </div>
                <div style="width:1000px; height:600px">
                    <canvas id="Question5"></canvas>
                </div>
              </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <div class="tab-pane-fade" id="question6Tab">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>              
                   <div style="width:1000px; height:600px">
                     <canvas id="Question6"></canvas>
                   </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
         <div class="tab-pane-fade" id="question7Tab">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>              
                   <div style="width:1000px; height:600px">
                     <canvas id="Question7"></canvas>
                   </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
   

       
<script type="text/javascript">

    $(document).ready(function () {
        var chart1 = document.getElementById("Question1").getContext("2d");
        var chart2 = document.getElementById("Question2").getContext("2d");
        var chart3 = document.getElementById("Question3").getContext("2d");
        var chart4 = document.getElementById("Question4").getContext("2d");
        var chart5 = document.getElementById("Question5").getContext("2d");
        var chart6 = document.getElementById("Question6").getContext("2d");
        var chart7 = document.getElementById("Question7").getContext("2d");
        $.ajax({          
            url: 'ReportPage.aspx/GetQuestionTwoData',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    title = 'Question 1A: ' + val.Title;
                });
                
                var pieChart = new Chart(chart1, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray
                        }],
                      
                    },
                    options: {
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 18,
                            fontColor: "#111"
                        },
                    }
                });
            
            },
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },

            
            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });

        $.ajax({
            url: 'ReportPage.aspx/GetQuestionThreeData',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    title = 'Question 1B: ' + val.Title;
                });

                var pieChart = new Chart(chart2, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray
                        }],

                    },
                    options: {
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 18,
                            fontColor: "#111"
                        },
                    }
                });

            },
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },
            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });
        $.ajax({
            url: 'ReportPage.aspx/GetQuestionFourData',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    title = 'Question 1C: ' + val.Title;
                });

                var pieChart = new Chart(chart3, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray
                        }],

                    },
                    options: {
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 18,
                            fontColor: "#111"
                        },
                    }
                });

            },
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },
            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });
        $.ajax({
            url: 'ReportPage.aspx/GetQuestionFiveData',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = 'Question 1D: ' + val.Title;
                    colorArray.push(val.Color);
                });

                var pieChart = new Chart(chart4, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray
                        }],

                    },
                    options: {
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 18,
                            fontColor: "#111"
                        },
                    }
                });

            },
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },
            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });

        $.ajax({
            url: 'ReportPage.aspx/GetQuestionSixData',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var valueArray = [];
                var colorArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = 'Question 1E: ' + val.Title;
                    colorArray.push(val.Color);
                });

                var pieChart = new Chart(chart5, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray
                        }],

                    },
                    options: {
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 18,
                            fontColor: "#111"
                        },
                    }
                });

            },
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },
            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });

        $.ajax({
            url: 'ReportPage.aspx/GetQuestionNineData',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var valueArray = [];
                var colorArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = 'Question 9: ' + val.Title;
                    colorArray.push(val.Color);
                });

                var pieChart = new Chart(chart6, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray
                        }],

                    },
                    options: {
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 18,
                            fontColor: "#111"
                        },
                    }
                });

            },
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },
            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });

        $.ajax({
            url: 'ReportPage.aspx/GetQuestionTenData',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var valueArray = [];
                var colorArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = 'Question 10: ' + val.Title;
                    colorArray.push(val.Color);
                });

                var pieChart = new Chart(chart7, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray
                        }],

                    },
                    options: {
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 18,
                            fontColor: "#111"
                        },
                    }
                });

            },
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },


            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });

    });
</script>
         
</asp:Content>

