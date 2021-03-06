﻿<%@ Page Title="Report Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportPage.aspx.cs" Inherits="Pages_AdministratorPages_ReportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <%-- Plugins use for displaying chart using ChartJS. For more details, visit https://www.chartjs.org/ --%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
    <%-- Plugins use to implement jquery for displaying chart. For more details, visit https://code.jquery.com/ --%>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <%-- Plugin use to  display percentage inside the chart. For more details, visit https://chartjs-plugin-datalabels.netlify.com/ --%>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
    </div>
    <div class="row">
        <asp:Label ID="FilterDescription" CssClass="mx-auto h2 text-center" class="label label-primary" runat="server"></asp:Label>
        <asp:Label ID="TotalNumberOfSubmittedSurvey" CssClass="mx-auto h4" class="label label-primary" runat="server"></asp:Label>
        <asp:Label ID="EmptyMessage" CssClass="mx-auto h4" class="label label-primary" Visible="false" runat="server"></asp:Label>
    </div>

    <div id="chartContainers">
        <ul class="nav nav-pills nav-fill nav-justified" id="myTab" role="tablist">
            <li class="nav-item">
                <a id="question1Tab" href="#question1" class="nav-link active" role="tab" aria-selected="true" data-toggle="pill">Variety</a> </li>
            <li class="nav-item">
                <a id="question2Tab" href="#question2" class="nav-link" aria-selected="false" role="tab" data-toggle="pill">Taste</a> </li>
            <li class="nav-item">
                <a id="question3Tab" href="#question3" class="nav-link" aria-selected="false" role="tab" data-toggle="pill">Temperature</a> </li>
            <li class="nav-item">
                <a id="question4Tab" href="#question4" class="nav-link" aria-selected="false" role="tab" data-toggle="pill">Appearance</a> </li>
            <li class="nav-item">
                <a id="question5Tab" href="#question5" class="nav-link" aria-selected="false" role="tab" data-toggle="pill">Service</a> </li>
            <li class="nav-item">
                <a id="question6Tab" href="#question6" class="nav-link" aria-selected="false" role="tab" data-toggle="pill">Portion Size</a> </li>
            <li class="nav-item">
                <a id="question7Tab" href="#question7" class="nav-link" aria-selected="false" role="tab" data-toggle="pill">Special Diet</a> </li>
            <li class="nav-item">
                <a id="question8Tab" href="#question8" class="nav-link" aria-selected="false" role="tab" data-toggle="pill">Overall</a>
            </li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="question1" role="tabpanel" aria-labelledby="question1Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question1"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question1Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <div class="row">
                    <asp:Label ID="GenericInformationLabel1" runat="server" Text="** No response means that the participant did not select any option from the choice"></asp:Label>
                </div>
            </div>
            <div class="tab-pane fade" id="question2" role="tabpanel" aria-labelledby="question2Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question2"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question2Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                 <div class="row">
                    <asp:Label ID="GenericInformationLabel2" runat="server" Text="** No response means that the participant did not select any option from the choice"></asp:Label>
                </div>
            </div>
            <div class="tab-pane fade" id="question3" role="tabpanel" aria-labelledby="question3Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question3"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question3Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                 <div class="row">
                    <asp:Label ID="GenericInformationLabel3" runat="server" Text="** No response means that the participant did not select any option from the choice"></asp:Label>
                </div>
            </div>
            <div class="tab-pane fade" id="question4" role="tabpanel" aria-labelledby="question4Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question4"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question4Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                 <div class="row">
                    <asp:Label ID="GenericInformationLabel4" runat="server" Text="** No response means that the participant did not select any option from the choice"></asp:Label>
                </div>
            </div>
            <div class="tab-pane fade" id="question5" role="tabpanel" aria-labelledby="question5Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question5"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question5Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                 <div class="row">
                    <asp:Label ID="GenericInformationLabel5" runat="server" Text="** No response means that the participant did not select any option from the choice"></asp:Label>
                </div>
            </div>
            <div class="tab-pane fade" id="question6" role="tabpanel" aria-labelledby="question6Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question6"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question6Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                 <div class="row">
                    <asp:Label ID="GenericInformationLabel6" runat="server" Text="** No response means that the participant did not select any option from the choice"></asp:Label>
                </div>
            </div>
            <div class="tab-pane fade" id="question7" role="tabpanel" aria-labelledby="question7Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question7"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question7Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                 <div class="row">
                    <asp:Label ID="GenericInformationLabel7" runat="server" Text="** No response means that the participant did not select any option from the choice"></asp:Label>
                </div>
            </div>
            <div class="tab-pane fade" id="question8" role="tabpanel" aria-labelledby="question7Tab">
                <div style="width: auto; height: auto; margin: auto; display: block; padding-top: 10px">
                    <canvas id="Question8"></canvas>
                </div>
                <div class="row" style="padding-top: 25px; padding-left: 0px; padding-right: 0px; padding-bottom: 0px; margin: auto; width: auto;">
                    <table id="Question8Table" class="table table-striped table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Answer</th>
                                <th scope="col">Response Count</th>
                                <th scope="col">Percentage</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="row" style="padding-top: 25px">
            <asp:Label ID="SurveyLabel" CssClass="mx-auto h5" class="label label-primary" runat="server"></asp:Label>
        </div>
    </div>
    <div class="row" style="padding-top: 25px">
        <asp:Button ID="Return" class="btn btn-primary btn-md btn-block" runat="server" Text="Back to Reports Filter" OnClick="Return_Click" />
    </div>





    <script type="text/javascript">
        // Setup onload method for javascript
        $(document).ready(function () {
            //Initialize all chart canvases
            var chart1 = document.getElementById("Question1").getContext("2d");
            var chart2 = document.getElementById("Question2").getContext("2d");
            var chart3 = document.getElementById("Question3").getContext("2d");
            var chart4 = document.getElementById("Question4").getContext("2d");
            var chart5 = document.getElementById("Question5").getContext("2d");
            var chart6 = document.getElementById("Question6").getContext("2d");
            var chart7 = document.getElementById("Question7").getContext("2d");
            var chart8 = document.getElementById("Question8").getContext("2d");
            // Loading JSON Data with JQuery for Question 1 The variety of food in your daily meals
            $.ajax({
                // URL containing the webmethod that returns the JSON Object
                url: 'ReportPage.aspx/GetChartData',
                // Type of call 
                type: 'POST',
                // Parameter indicating what chartId to be display
                data: "{'chartId':1}",
                // Setup the content type of the method
                contentType: 'application/json; charset=utf-8',
                // Initialize the returning data type
                dataType: 'json',
                // If call is success
                success: function (response) {
                    // Initialize required variables for displaying chart
                    var aData = []
                    // Parse the JSON Data and set it to an object list
                    var aData = $.parseJSON(response.d);
                    var labelArray = [];
                    var title;
                    var colorArray = [];
                    var valueArray = [];
                    var borderArray = [];
                    var totalSurveys = 0;
                    // Check if there is any survey submitted with the given parameter
                    if (!$.isEmptyObject(aData)) {
                        // Loop through the list to get the total number of survey submitted
                        $.each(aData, function (inx, val) {
                            totalSurveys = totalSurveys + Number(val.Value);
                        });
                        // Loop through the json object
                        $.each(aData, function (inx, val) {
                            // parse the value and assigned to the list 
                            labelArray.push(val.Text);
                            valueArray.push(val.Value);
                            colorArray.push(val.Color);
                            borderArray.push(val.BorderColor);
                            title = val.Title;
                            // Setup markup for table
                            var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                            // append the martkup to the table
                            $("#Question1Table").append(markup);
                        });
                        // Display the total survey count in the survey label
                        $('#<%= SurveyLabel.ClientID %>').text("Total Surveys: " + totalSurveys + " submitted surveys");
                    // Initialize chart to display
                        var pieChart = new Chart(chart1, { 
                    // Setup mapped the data to be display in chart
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: colorArray,
                            data: valueArray,
                            borderColor: borderArray,
                            borderWidth: 3
                        }],

                    },
                    // Setup options for to customize chart displays
                    options: {
                        plugins: {
                            datalabels: {
                                anchor: "center",
                                font: {
                                    size: 20,
                                },
                                formatter: function (value, context) {
                                    var total = 0;
                                    $.each(valueArray, function (inx, val) {
                                        total = total + val;
                                    });
                                    var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                    return percentage + "%";
                                }
                            }
                        },
                        responsive: true,
                        title: {
                            display: true,
                            position: "top",
                            text: title,
                            fontSize: 20,
                            fontColor: "#111"
                        },
                        legend: {
                            labels: {
                                fontSize: 18
                            },

                        },
                        animation: {
                            animateScale: true,
                            animateRotate: true
                        },
                        // Setup tooltip to display the total response, anser, and percentage on the hover segment
                        tooltips: {
                            callbacks: {
                                label: function (tooltipItem, data) {
                                    var dataset = data.datasets[tooltipItem.datasetIndex];
                                    var currentValue = dataset.data[tooltipItem.index];
                                    return 'Total Response: ' + currentValue;
                                },
                                beforeLabel: function (tooltipItem, data) {
                                    var dataset = data.datasets[tooltipItem.datasetIndex];
                                    var currentValue = dataset.data[tooltipItem.index];
                                    var label = data.labels[tooltipItem.index];

                                    return 'Answer: ' + label;
                                },
                                afterLabel: function (tooltipItem, data) {
                                    var dataset = data.datasets[tooltipItem.datasetIndex];
                                    var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                        return previousValue + currentValue;
                                    });
                                    var currentValue = dataset.data[tooltipItem.index];
                                    var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                    return 'Percentage: (' + percentage + '%)';
                                }
                            },
                            backgroundColor: '#C0C0C0',
                            titleFontSize: 18,
                            titleFontColor: '#0066ff',
                            bodyFontColor: '#000',
                            bodyFontSize: 18,
                            displayColors: false
                        }
                    }
                });
                }
                // Hide the chart container div if there is no submitted survey to display
                else {
                    var chartToHide = document.getElementById("chartContainers");
                    chartToHide.style.display = "block";
                    chartToHide.style.display = "none";
                }


                },
            // Display the error in console
            failure: function (response) {
                alert(response.d);
                console.log(response.d);
            },

            // Instantiate xhr, errorType and the exception to be display in console if an error occur
            error: function (xhr, errorType, exception) {
                var responseText;
                responseText = jQuery.parseJSON(xhr.responseText);
                console.log(responseText.ExceptionType + responseText.StackTrace + responseText.Message + errorType + exception);
            }

        });
            // Loading JSON Data with JQuery for Question 2 The taste of your meals
            // The logic is identical to displaying Question 1 chart with the only difference of chartId parameter
            $.ajax({

            url: 'ReportPage.aspx/GetChartData',
            type: 'POST',
            data: "{'chartId':2}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                var borderArray = [];
                var totalSurveys = 0;
                $.each(aData, function (inx, val) {
                    totalSurveys = totalSurveys + Number(val.Value);
                });
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                    var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                    $("#Question2Table").append(markup);
                });
                $('#<%= SurveyLabel.ClientID %>').text("Total Surveys: " + totalSurveys + " submitted surveys");
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart2, {
                        type: 'pie',
                        data: {
                            labels: labelArray,
                            datasets: [{
                                backgroundColor: colorArray,
                                data: valueArray,
                                borderColor: borderArray,
                                borderWidth: 3
                            }],

                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: "center",
                                    font: {
                                        size: 20,
                                    },
                                    formatter: function (value, context) {
                                        var total = 0;
                                        $.each(valueArray, function (inx, val) {
                                            total = total + val;
                                        });
                                        var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                        return percentage + "%";
                                    }
                                }
                            },
                            responsive: true,
                            title: {
                                display: true,
                                position: "top",
                                text: title,
                                fontSize: 20,
                                fontColor: "#111"
                            },
                            legend: {
                                labels: {
                                    fontSize: 18
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: ' + label;
                                    },
                                    afterLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                            return previousValue + currentValue;
                                        });
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                        return 'Percentage: (' + percentage + '%)';
                                    }
                                },
                                backgroundColor: '#C0C0C0',
                                titleFontSize: 18,
                                titleFontColor: '#0066ff',
                                bodyFontColor: '#000',
                                bodyFontSize: 18,
                                displayColors: false
                            }
                        }


                    });
                }
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
        // Loading JSON Data with JQuery for Question 3 The temperature of your hot food
        // The logic is identical to displaying Question 1 chart with the only difference of chartId parameter
        $.ajax({
            url: 'ReportPage.aspx/GetChartData',
            type: 'POST',
            data: "{'chartId':3}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                var borderArray = [];
                var totalSurveys = 0;
                $.each(aData, function (inx, val) {
                    totalSurveys = totalSurveys + Number(val.Value);
                });
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                    var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                    $("#Question3Table").append(markup);
                });
                $('#<%= SurveyLabel.ClientID %>').text("Total Surveys: " + totalSurveys + " submitted surveys");
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart3, {
                        type: 'pie',
                        data: {
                            labels: labelArray,
                            datasets: [{
                                backgroundColor: colorArray,
                                data: valueArray,
                                borderColor: borderArray
                            }],

                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: "center",
                                    font: {
                                        size: 20,
                                    },
                                    formatter: function (value, context) {
                                        var total = 0;
                                        $.each(valueArray, function (inx, val) {
                                            total = total + val;
                                        });
                                        var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                        return percentage + "%";
                                    }
                                }
                            },
                            responsive: true,
                            title: {
                                display: true,
                                position: "top",
                                text: title,
                                fontSize: 20,
                                fontColor: "#111"
                            },
                            legend: {
                                labels: {
                                    fontSize: 18
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: ' + label;
                                    },
                                    afterLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                            return previousValue + currentValue;
                                        });
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                        return 'Percentage: (' + percentage + '%)';
                                    }
                                },
                                backgroundColor: '#C0C0C0',
                                titleFontSize: 18,
                                titleFontColor: '#0066ff',
                                bodyFontColor: '#000',
                                bodyFontSize: 18,
                                displayColors: false
                            }
                        }
                    });
                }
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
        // Loading JSON Data with JQuery for Question 4 The overall appearance of your meal
        // The logic is identical to displaying Question 1 chart with the only difference of chartId parameter
        $.ajax({
            url: 'ReportPage.aspx/GetChartData',
            type: 'POST',
            data: "{'chartId':4}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                var borderArray = [];
                var totalSurveys = 0;
                $.each(aData, function (inx, val) {
                    totalSurveys = totalSurveys + Number(val.Value);
                });
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                    var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                    $("#Question4Table").append(markup);
                });
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart4, {
                        type: 'pie',
                        data: {
                            labels: labelArray,
                            datasets: [{
                                backgroundColor: colorArray,
                                data: valueArray,
                                borderColor: borderArray
                            }],

                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: "center",
                                    font: {
                                        size: 20,
                                    },
                                    formatter: function (value, context) {
                                        var total = 0;
                                        $.each(valueArray, function (inx, val) {
                                            total = total + val;
                                        });
                                        var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                        return percentage + "%";
                                    }
                                }
                            },
                            responsive: true,
                            title: {
                                display: true,
                                position: "top",
                                text: title,
                                fontSize: 20,
                                fontColor: "#111"
                            },
                            legend: {
                                labels: {
                                    fontSize: 18
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: ' + label;
                                    },
                                    afterLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                            return previousValue + currentValue;
                                        });
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                        return 'Percentage: (' + percentage + '%)';
                                    }
                                },
                                backgroundColor: '#C0C0C0',
                                titleFontSize: 18,
                                titleFontColor: '#0066ff',
                                bodyFontColor: '#000',
                                bodyFontSize: 18,
                                displayColors: false
                            }
                        }
                    });
                }
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
        // Loading JSON Data with JQuery for Question 5 The helpfulness of the staff who deliver your meals
        // The logic is identical to displaying Question 1 chart with the only difference of chartId parameter
        $.ajax({
            url: 'ReportPage.aspx/GetChartData',
            type: 'POST',
            data: "{'chartId':5}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var valueArray = [];
                var colorArray = [];
                var borderArray = [];
                var totalSurveys = 0;
                $.each(aData, function (inx, val) {
                    totalSurveys = totalSurveys + Number(val.Value);
                });
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                    var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                    $("#Question5Table").append(markup);
                });
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart5, {
                        type: 'pie',
                        data: {
                            labels: labelArray,
                            datasets: [{
                                backgroundColor: colorArray,
                                data: valueArray,
                                borderColor: borderArray,
                                borderWidth: 3
                            }],

                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: "center",
                                    font: {
                                        size: 20,
                                    },
                                    formatter: function (value, context) {
                                        var total = 0;
                                        $.each(valueArray, function (inx, val) {
                                            total = total + val;
                                        });
                                        var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                        return percentage + "%";
                                    }
                                }
                            },
                            responsive: true,
                            title: {
                                display: true,
                                position: "top",
                                text: title,
                                fontSize: 20,
                                fontColor: "#111"
                            },
                            legend: {
                                labels: {
                                    fontSize: 18
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: ' + label;
                                    },
                                    afterLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                            return previousValue + currentValue;
                                        });
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                        return 'Percentage: (' + percentage + '%)';
                                    }
                                },
                                backgroundColor: '#C0C0C0',
                                titleFontSize: 18,
                                titleFontColor: '#0066ff',
                                bodyFontColor: '#000',
                                bodyFontSize: 18,
                                displayColors: false
                            }
                        }
                    });
                }
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
        // Loading JSON Data with JQuery for Question 6 How satisfied are you with the portion of your size meals?
        // The logic is identical to displaying Question 1 chart with the only difference of chartId parameter
        $.ajax({
            url: 'ReportPage.aspx/GetChartData',
            type: 'POST',
            data: "{'chartId':6}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var colorArray = [];
                var valueArray = [];
                var borderArray = [];
                var totalSurveys = 0;
                $.each(aData, function (inx, val) {
                    totalSurveys = totalSurveys + Number(val.Value);
                });
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                    var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                    $("#Question6Table").append(markup);
                });
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart6, {
                        type: 'pie',
                        data: {
                            labels: labelArray,
                            datasets: [{
                                backgroundColor: colorArray,
                                data: valueArray,
                                borderColor: borderArray,
                                borderWidth: 3
                            }],

                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: "center",
                                    font: {
                                        size: 20,
                                    },
                                    formatter: function (value, context) {
                                        var total = 0;
                                        $.each(valueArray, function (inx, val) {
                                            total = total + val;
                                        });
                                        var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                        return percentage + "%";
                                    }
                                }
                            },
                            responsive: true,
                            title: {
                                display: true,
                                position: "top",
                                text: title,
                                fontSize: 20,
                                fontColor: "#111"
                            },
                            legend: {
                                labels: {
                                    fontSize: 18
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: ' + label;
                                    },
                                    afterLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                            return previousValue + currentValue;
                                        });
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                        return 'Percentage: (' + percentage + '%)';
                                    }
                                },
                                backgroundColor: '#C0C0C0',
                                titleFontSize: 18,
                                titleFontColor: '#0066ff',
                                bodyFontColor: '#000',
                                bodyFontSize: 18,
                                displayColors: false
                            }
                        }


                    });
                }
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
        // Loading JSON Data with JQuery for Question 7 Do your meals take into account with your specific dietary requirements
        // The logic is identical to displaying Question 1 chart with the only difference of chartId parameter
        $.ajax({
            url: 'ReportPage.aspx/GetChartData',
            type: 'POST',
            data: "{'chartId':7}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var valueArray = [];
                var colorArray = [];
                var borderArray = [];
                var totalSurveys = 0;
                $.each(aData, function (inx, val) {
                    totalSurveys = totalSurveys + Number(val.Value);
                });
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                    var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                    $("#Question7Table").append(markup);
                });
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart7, {
                        type: 'pie',
                        data: {
                            labels: labelArray,
                            datasets: [{
                                backgroundColor: colorArray,
                                data: valueArray,
                                borderColor: borderArray,
                                borderWidth: 3
                            }],

                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: "center",
                                    font: {
                                        size: 20,
                                    },
                                    formatter: function (value, context) {
                                        var total = 0;
                                        $.each(valueArray, function (inx, val) {
                                            total = total + val;
                                        });
                                        var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                        return percentage + "%";
                                    }
                                }
                            },
                            responsive: true,
                            title: {
                                display: true,
                                position: "top",
                                text: title,
                                fontSize: 20,
                                fontColor: "#111"
                            },
                            legend: {
                                labels: {
                                    fontSize: 18
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: ' + label;
                                    },
                                    afterLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                            return previousValue + currentValue;
                                        });
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                        return 'Percentage: (' + percentage + '%)';
                                    }
                                },
                                backgroundColor: '#C0C0C0',
                                titleFontSize: 18,
                                titleFontColor: '#0066ff',
                                bodyFontColor: '#000',
                                bodyFontSize: 18,
                                displayColors: false
                            }
                        }
                    });
                }
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
        // Loading JSON Data with JQuery for Question 8 Overall how would you rate your meal experience
        // The logic is identical to displaying Question 1 chart with the only difference of chartId parameter
        $.ajax({
            url: 'ReportPage.aspx/GetChartData',
            type: 'POST',
            data: "{'chartId':8}",
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var title;
                var valueArray = [];
                var colorArray = [];
                var borderArray = [];
                var totalSurveys = 0;
                $.each(aData, function (inx, val) {
                    totalSurveys = totalSurveys + Number(val.Value);
                });
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                    var markup = "<tr><td>" + val.Text + "</td><td>" + val.Value + "</td><td>" + Math.floor(((Number(val.Value) / totalSurveys) * 100) + 0.5) + "%" + "</td></tr>";
                    $("#Question8Table").append(markup);
                });
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart8, {
                        type: 'pie',
                        data: {
                            labels: labelArray,
                            datasets: [{
                                backgroundColor: colorArray,
                                data: valueArray,
                                borderColor: borderArray,
                                borderWidth: 3
                            }],

                        },
                        options: {
                            plugins: {
                                datalabels: {
                                    anchor: "center",
                                    font: {
                                        size: 20,
                                    },
                                    formatter: function (value, context) {
                                        var total = 0;
                                        $.each(valueArray, function (inx, val) {
                                            total = total + val;
                                        });
                                        var percentage = Math.floor(((Number(value) / total) * 100) + 0.5);
                                        return percentage + "%";
                                    }
                                }
                            },
                            responsive: true,
                            title: {
                                display: true,
                                position: "top",
                                text: title,
                                fontSize: 20,
                                fontColor: "#111"
                            },
                            legend: {
                                labels: {
                                    fontSize: 18
                                }
                            },
                            animation: {
                                animateScale: true,
                                animateRotate: true
                            },
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: ' + label;
                                    },
                                    afterLabel: function (tooltipItem, data) {
                                        var dataset = data.datasets[tooltipItem.datasetIndex];
                                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                                            return previousValue + currentValue;
                                        });
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                                        return 'Percentage: (' + percentage + '%)';
                                    }
                                },
                                backgroundColor: '#C0C0C0',
                                titleFontSize: 18,
                                titleFontColor: '#0066ff',
                                bodyFontColor: '#000',
                                bodyFontSize: 18,
                                displayColors: false
                            }
                        }
                    });
                }
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

