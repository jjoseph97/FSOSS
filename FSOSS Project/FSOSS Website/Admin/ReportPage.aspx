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
    
<script type="text/javascript">

    $(document).ready(function () {
        var ctx = document.getElementById("chartSampleQuestion1").getContext("2d");
        $.ajax({          
            url: 'ReportPage.aspx/GetDataListViaPOCO',
            type: 'POST',
            data: '{}',
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                var aData = $.parseJSON(response.d);
                var labelArray = [];
                var valueArray = [];
                $.each(aData, function (inx, val) {
                    labelArray.push(val.Text);
                    valueArray.push(val.Value);
                });
                var pieChart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: labelArray,
                        datasets: [{
                            backgroundColor: [
                                'rgb(255, 0, 0)',
                                'rgb(255, 255, 0)',
                                'rgb(0, 153, 0)',
                                'rgb(0, 0, 255)',
                                'rgb(255, 0, 255)',
                            ],
                            data: valueArray
                        }],
                      
                    },
                    options: {
                        responsive: true
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

