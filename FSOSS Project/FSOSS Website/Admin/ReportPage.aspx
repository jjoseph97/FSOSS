<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ReportPage.aspx.cs" Inherits="Pages_AdministratorPages_ReportPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
<script type="text/javascript" src="../Scripts/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
    <div class="row">
        <div class="col-sm-12">
            <asp:Label ID="Alert" class="alert alert-success mb-2 card" runat="server" Visible="false"></asp:Label>
            <asp:Label ID="ErrorAlert" class="alert alert-danger mb-2 card" runat="server" Visible="false"></asp:Label>
        </div>
    </div>
    
        <div id="questionOneAChart" style="height: 370px; width: 100%;"></div>
    
        <div id="questionOneBChart" style="height: 370px; width: 100%;"></div>

        <div id="questionOneCChart" style="height: 370px; width: 100%;"></div>
    
        <div id="questionOneDChart" style="height: 370px; width: 100%;"></div>
   
        <div id="questionOneEChart" style="height: 370px; width: 100%;"></div>
  
        <div id="questionTwoChart" style="height: 370px; width: 100%;"></div>
   
        <div id="questionThreeChart" style="height: 370px; width: 100%;"></div>
    
        <div id="questionFourChart" style="height: 370px; width: 100%;"></div>
    
    
<script>
window.onload = function () {

var options = {
	title: {
        text: "The variety of food in your daily meals"
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
			{ y: 48.00, label: "Very good" },
			{ y: 22.00, label: "Good" },
			{ y: 15.37, label: "Fair" },
			{ y: 5.63, label: "Poor" },
			
		]
	}]
    };
$("#questionOneAChart").CanvasJSChart(options);

    }



</script>
</asp:Content>

