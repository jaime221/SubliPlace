<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard en Tiempo Real</title>
    <!-- Incluye los archivos de Chart.js y estilos CSS si es necesario -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
    <style>
        .container {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }

        .chart-container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
         <jsp:include page="Layout.jsp" />
    <div class="container">
        <h1>Ventas en Tiempo Real</h1>
        <div class="chart-container">
            <canvas id="real-time-chart"></canvas>
        </div>
    </div>
    
    <script>
        
        function getRandomData() {
            return Math.floor(Math.random() * 100);
        }

        // Configuración del gráfico en tiempo real
        const ctx = document.getElementById('real-time-chart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [],
                datasets: [{
                    label: 'Datos en Tiempo Real',
                    data: [],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: false,
                }],
            },
            options: {
                scales: {
                    x: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Tiempo'
                        }
                    },
                    y: {
                        display: true,
                        title: {
                            display: true,
                            text: 'Valor'
                        }
                    }
                }
            }
        });

        // Actualización del gráfico cada segundo
        setInterval(() => {
            const now = new Date();
            const timeLabel = now.toLocaleTimeString();
            const newData = getRandomData();

            chart.data.labels.push(timeLabel);
            chart.data.datasets[0].data.push(newData);

            if (chart.data.labels.length > 10) {
                chart.data.labels.shift();
                chart.data.datasets[0].data.shift();
            }

            chart.update();
        }, 1000);
    </script>
</body>
</html>
