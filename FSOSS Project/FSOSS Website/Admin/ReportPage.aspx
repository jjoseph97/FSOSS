<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportPage.aspx.cs" Inherits="Pages_AdministratorPages_ReportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
    </div>
     <div class="container">
           <ul class="nav nav-tabs">
            <li class="active"><a data-toggle="tab" href="#questionOne">Question One</a></li>
            <li><a data-toggle="tab" href="#questionTwo">Question Two</a></li>
            <li><a data-toggle="tab" href="#questionThree">Question Three</a></li>
            <li><a data-toggle="tab" href="#questionFour">Question Four</a></li>

        </ul>
    
          <div id="questionOne" class="tab-pane fade in active">

        <div id="questionOneAChart" style="height: 370px; width: 100%;"></div>
        
        <div id="questionOneBChart" style="height: 370px; width: 100%;"></div>
         
        <div id="questionOneCChart" style="height: 370px; width: 100%;"></div>
     
        <div id="questionOneDChart" style="height: 370px; width: 100%"></div>
        
        <div id="questionOneEChart" style="height: 370px; width: 100%;"></div>
              </div>

          <div id="questionTwo" class="tab-pane fade">

        <div id="questionTwoChart" style="height: 370px; width: 100%;"></div>
              </div>


         
          <div id="questionThree" class="tab-pane fade">
        <div id="questionThreeChart" style="height: 370px; width: 100%;"></div>
              </div>
             

         <div id="questionFour" class="tab-pane fade">
        <div id="questionFourChart" style="height: 370px; width: 100%;"></div>
             </div>

    
<script>
window.onload = function () {

    var options = new CanvasJS.Chart("questionOneAChart", {
	title: {
        text: "1A. The variety of food in your daily meals"
	},
	subtitles: [{
		text: "For "
	}],
	animationEnabled: true,
	data: [{
		type: "pie",
		startAngle: 40,
		toolTipContent: "<b>{label}</b>: {y}%",
		showInLegend: "true",
		legendText: "{label}",
		indexLabelFontSize: 16,
		indexLabel: "{label} - {y}%",
		dataPoints: [
			{ y: 45.00, label: "Very good" },
			{ y: 22.00, label: "Good" },
			{ y: 15.37, label: "Fair" },
            { y: 5.63, label: "Poor" },
            { y: 3.00, label: "Don't Know/No Opinion" },
            
			
		]
	}]
    });
    options.render();

    

    var ChartB = new CanvasJS.Chart("questionOneBChart", 
        {
        title: {
            text: "1B. The taste and flavor of your meals"
        },
        subtitles: [{
            text: "For "
        }],
        animationEnabled: true,
        data: [{
            type: "pie",
            startAngle: 40,
            toolTipContent: "<b>{label}</b>: {y}%",
            showInLegend: "true",
            legendText: "{label}",
            indexLabelFontSize: 16,
            indexLabel: "{label} - {y}%",
            dataPoints: [
                { y: 30.00, label: "Very good" },
                { y: 37.00, label: "Good" },
                { y: 15.37, label: "Fair" },
                { y: 5.63, label: "Poor" },
                { y: 3.00, label: "Don't Know/No Opinion" },

            ]
        }]
    });
    ChartB.render();


    var ChartC = new CanvasJS.Chart("questionOneCChart",
        {
            title: {
                text: "1C. The temperature of your hot food"
            },
            subtitles: [{
                text: "For "
            }],
            animationEnabled: true,
            data: [{
                type: "pie",
                startAngle: 40,
                toolTipContent: "<b>{label}</b>: {y}%",
                showInLegend: "true",
                legendText: "{label}",
                indexLabelFontSize: 16,
                indexLabel: "{label} - {y}%",
                dataPoints: [
                    { y: 20.00, label: "Very good" },
                    { y: 50.00, label: "Good" },
                    { y: 12.37, label: "Fair" },
                    { y: 5.63, label: "Poor" },
                    { y: 4.00, label: "Don't Know/No Opinion" },

                ]
            }]
        });
    ChartC.render();



    var ChartD = new CanvasJS.Chart("questionOneDChart",
        {
            title: {
                text: "1D. The overall appearance of your meal"
            },
            subtitles: [{
                text: "For "
            }],
            animationEnabled: true,
            data: [{
                type: "pie",
                startAngle: 40,
                toolTipContent: "<b>{label}</b>: {y}%",
                showInLegend: "true",
                legendText: "{label}",
                indexLabelFontSize: 16,
                indexLabel: "{label} - {y}%",
                dataPoints: [
                    { y: 50.70, label: "Very good" },
                    { y: 20.00, label: "Good" },
                    { y: 13.50, label: "Fair" },
                    { y: 13.50, label: "Poor" },
                    { y: 2.30, label: "Don't Know/No Opinion" },

                ]
            }]
        });
    ChartD.render();

    var ChartE = new CanvasJS.Chart("questionOneEChart",
        {
            title: {
                text: "1E. The helpfulness of the staff who deliver your meals"
            },
            subtitles: [{
                text: "For "
            }],
            animationEnabled: true,
            data: [{
                type: "pie",
                startAngle: 40,
                toolTipContent: "<b>{label}</b>: {y}%",
                showInLegend: "true",
                legendText: "{label}",
                indexLabelFontSize: 16,
                indexLabel: "{label} - {y}%",
                dataPoints: [
                    { y: 70.25, label: "Very good" },
                    { y: 10.25, label: "Good" },
                    { y: 14.5, label: "Fair" },
                    { y: 3.40, label: "Poor" },
                    { y: 1.60, label: "Don't Know/No Opinion" },

                ]
            }]
        });
    ChartE.render();




    var chartTwo = new CanvasJS.Chart("questionTwoChart",
        {
            title: {
                text: "2. How satisfied are you with the portion sizes of your meals?"
            },
            subtitles: [{
                text: "For "
            }],
            animationEnabled: true,
            data: [{
                type: "pie",
                startAngle: 40,
                toolTipContent: "<b>{label}</b>: {y}%",
                showInLegend: "true",
                legendText: "{label}",
                indexLabelFontSize: 16,
                indexLabel: "{label} - {y}%",
                dataPoints: [
                    { y: 20.00, label: "Portion sizes are too small" },
                    { y: 60.00, label: "Portion sizes are just right" },
                    { y: 40.00, label: "Portion sizes are too large" },
                 

                ]
            }]
        });
    chartTwo.render();



    var chartThree = new CanvasJS.Chart("questionThreeChart",
        {
            title: {
                text: "3 .Do your meals take into account your specific diet requirements?"
            },
            subtitles: [{
                text: "For "
            }],
            animationEnabled: true,
            data: [{
                type: "pie",
                startAngle: 40,
                toolTipContent: "<b>{label}</b>: {y}%",
                showInLegend: "true",
                legendText: "{label}",
                indexLabelFontSize: 16,
                indexLabel: "{label} - {y}%",
                dataPoints: [
                    { y: 90.00, label: "Always" },
                    { y: 7.50, label: "Usually" },
                    { y: 1.63, label: "Occasionally" },
                    { y: 0.62, label: "Never" },
                    { y: 0.25, label: "I do not have any specific dietary requirements" },


                ]
            }]
        });
    chartThree.render();

    var chartFour = new CanvasJS.Chart("questionFourChart",
        {
            title: {
                text: "4. Overall, how would you rate your meal experience?"
            },
            subtitles: [{
                text: "For "
            }],
            animationEnabled: true,
            data: [{
                type: "pie",
                startAngle: 40,
                toolTipContent: "<b>{label}</b>: {y}%",
                showInLegend: "true",
                legendText: "{label}",
                indexLabelFontSize: 16,
                indexLabel: "{label} - {y}%",
                dataPoints: [
                    { y: 35.00, label: "Very Good" },
                    { y: 35.00, label: "Good" },
                    { y: 11.11, label: "Fair" },
                    { y: 10.50, label: "Poor" },
                    { y: 8.40, label: "Very Poor" },


                ]
            }]
        });
    chartFour.render();

 }


</script>
             </div>
         </div>
</asp:Content>

