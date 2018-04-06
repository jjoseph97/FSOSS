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
    <canvas id="chartSampleQuestion1" height="400" width="400"></canvas>
    
<script>

    window.onload = function () {
        var ctx = document.getElementById('chartSampleQuestion1').getContext('2d');
        $.ajax({
            type: "POST",
            url: "ReportPage.aspx/GetDataViaPOCO",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var aData = response.d;
                var labelArray = [];
                var valueArray = [];
                $.each(aData, function (inx, val) {
                    var labelsObj = {};
                    var valueObj = {};
                    labelsObj.Text = val.Text;
                    obj.Value = val.Value;
                    labelArray.push(labelsObj);
                    valueArray.push(valueObj)
                });
                //var el = document.createElement('canvas');
                //$("#dvChart")[0].appendChild(el);
                //// Fix for IE 8.00
                //if ($.browser.msie && $.browser.version == "8.0") {
                //    G_vmlCanvasManager.initElement(el);
                //}
                ////var ctx = el.getContext('2d');

                var pieChart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            label: 'Question 1',
                            data: valueArray,
                            backgroundColor: 'rgba(75,192,192,0.4)',
                            borderColor: 'rgba(75,192,192,1)',
                        }]
                    },
                })
            },
            failure: function (response) {
                alert(response.d);
            },

            error: function (response) {
                alert(response.d);
            }

        });


    }
</script>
         
</asp:Content>

