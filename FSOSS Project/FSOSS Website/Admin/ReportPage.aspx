<%@ Page Title="Report" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportPage.aspx.cs" Inherits="Pages_AdministratorPages_ReportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>


    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
    </div>
    <div class="row"> 
          <asp:Label ID="FilterDescription" CssClass="mx-auto h2" class="label label-primary"  runat="server"></asp:Label>
          <asp:Label ID="TotalNumberOfSubmittedSurvey" CssClass="mx-auto h4" class="label label-primary" runat="server"></asp:Label>
          <asp:Label ID="EmptyMessage" CssClass="mx-auto h4" class="label label-primary"  Visible="false" runat="server"></asp:Label>
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
                <div style="width:auto; height:auto; margin:auto; display:block">
                    <canvas id="Question1"></canvas>         
                </div>
        </div>
        <div class="tab-pane fade" id="question2" role="tabpanel" aria-labelledby="question2Tab">              
                <div style="width:auto; height:auto; margin:auto; display:block">
                     <canvas id="Question2"></canvas>
                 </div>
        </div>
        <div class="tab-pane fade" id="question3" role="tabpanel" aria-labelledby="question3Tab">              
                <div style="width:auto; height:auto; margin:auto; display:block">
                    <canvas id="Question3"></canvas>
                </div>
        </div>
        <div class="tab-pane fade" id="question4" role="tabpanel" aria-labelledby="question4Tab">              
                <div style="width:auto; height:auto; margin:auto; display:block">
                    <canvas id="Question4"></canvas>
                </div>
        </div>
        <div class="tab-pane fade" id="question5" role="tabpanel" aria-labelledby="question5Tab">              
                <div style="width:auto; height:auto; margin:auto; display:block">
                    <canvas id="Question5"></canvas>
                </div>
        </div>
        <div class="tab-pane fade" id="question6" role="tabpanel" aria-labelledby="question6Tab">              
                  <div style="width:auto; height:auto; margin:auto; display:block">
                     <canvas id="Question6"></canvas>
                   </div>
        </div>
         <div class="tab-pane fade" id="question7" role="tabpanel" aria-labelledby="question7Tab">             
                  <div style="width:auto; height:auto; margin:auto; display:block">
                     <canvas id="Question7"></canvas>
                   </div>
        </div>
         <div class="tab-pane fade" id="question8" role="tabpanel" aria-labelledby="question7Tab">             
                   <div style="width:auto; height:auto; margin:auto; display:block">
                     <canvas id="Question8"></canvas>
                   </div>
        </div>
    </div>
    </div>
    <div class="row" style="padding-top:50px">
         <asp:Button ID="Return" class="btn btn-primary btn-md btn-block" runat="server" Text="Back to View Reports Filter" OnClick="Return_Click" />
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
        var chart8 = document.getElementById("Question8").getContext("2d");
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                });
                if (valueArray.length > 0) {
                    var pieChart = new Chart(chart1, {
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
                                        $.each(valueArray, function(inx, val) {
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
                            tooltips: {
                                callbacks: {
                                    label: function (tooltipItem, data) {
                                         var dataset = data.datasets[tooltipItem.datasetIndex];                                       
                                         var currentValue = dataset.data[tooltipItem.index];
                                         return 'Total Response: ' + currentValue;
                                    },
                                    beforeLabel: function (tooltipItem, data){
                                        var dataset = data.datasets[tooltipItem.datasetIndex];                                       
                                        var currentValue = dataset.data[tooltipItem.index];
                                        var label = data.labels[tooltipItem.index];

                                        return 'Answer: '+ label;
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
                else
                {
                    var chartToHide = document.getElementById("chartContainers");
                        chartToHide.style.display = "block";
                        chartToHide.style.display = "none";
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
                });
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    title =  val.Title;
                    borderArray.push(val.BorderColor);
                });
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = val.Title;
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = val.Title;
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
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

        $.ajax({
            url: 'ReportPage.aspx/GetQuestionEightData',
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
                    title = val.Title;
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = val.Title;
                    colorArray.push(val.Color);
                    borderArray.push(val.BorderColor);
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
                var borderArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                    title = val.Title;
                    borderArray.push(val.BorderColor);
                    colorArray.push(val.Color);
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

