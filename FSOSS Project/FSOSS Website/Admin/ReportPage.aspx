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
    <div class="row">
        <div id="questionOneAChart" style="height: 370px; width: 100%;"></div>
    </div>
    <div class="row">
        <div id="questionOneBChart" style="height: 370px; width: 100%;"></div>
    </div>
    <div class="row">
        <div id="questionOneCChart" style="height: 370px; width: 100%;"></div>
    </div>
    <div class ="row">
        <div id="questionOneDChart" style="height: 370px; width: 100%;"></div>
    </div>
    <div class="row" >
        <div id="questionOneEChart" style="height: 370px; width: 100%;"></div>
    </div>
     <div class="row" >
        <div id="questionTwoChart" style="height: 370px; width: 100%;"></div>
    </div>
     <div class="row" >
        <div id="questionThreeChart" style="height: 370px; width: 100%;"></div>
    </div>
     <div class="row" >
        <div id="questionFourChart" style="height: 370px; width: 100%;"></div>
    </div>
    
<script>
window.onload = function () {

var options = {
	title: {
		text: "Report For "
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
			{ y: 48.36, label: "Windows 7" },
			{ y: 26.85, label: "Windows 10" },
			{ y: 1.49, label: "Windows 8" },
			{ y: 6.98, label: "Windows XP" },
			{ y: 6.53, label: "Windows 8.1" },
			{ y: 2.45, label: "Linux" },
			{ y: 3.32, label: "Mac OS X 10.12" },
			{ y: 4.03, label: "Others" }
		]
	}]
    };
$("#questionOneAChart").CanvasJSChart(options);

}
</script>
</asp:Content>

