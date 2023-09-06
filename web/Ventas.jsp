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
        <br>
        <br>

        <div class="container">
            <h1>Ventas en Tiempo Real</h1>
            <div class="chart-container">
                <canvas id="real-time-chart"></canvas>
            </div>
            <div>
                <h2>Ventas por A�o</h2>
                <canvas id="yearly-chart"></canvas>
            </div>
            <div>
                <h2>Ventas por Mes</h2>
                <canvas id="monthly-chart"></canvas>
            </div>
            <div>
                <h2>Ventas Diarias</h2>
                <canvas id="daily-chart"></canvas>
            </div>
        </div>

        <script>
            function getRandomData() {
                return Math.floor(Math.random() * 100);
            }

            // Configuraci�n del gr�fico en tiempo real
            const ctx = document.getElementById('real-time-chart').getContext('2d');
            const realTimeChart = new Chart(ctx, {
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

            // Configuraci�n de gr�ficos de ventas por a�o, mes y d�a
            const yearlyCtx = document.getElementById('yearly-chart').getContext('2d');
            const yearlyChart = new Chart(yearlyCtx, {
                type: 'bar',
                data: {
                    labels: ['A�o 1', 'A�o 2', 'A�o 3', 'A�o 4', 'A�o 5'],
                    datasets: [{
                            label: 'Ventas por A�o',
                            data: [getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData()],
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            borderWidth: 1,
                        }],
                },
            });

            const monthlyCtx = document.getElementById('monthly-chart').getContext('2d');
            const monthlyChart = new Chart(monthlyCtx, {
                type: 'bar',
                data: {
                    labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                    datasets: [{
                            label: 'Ventas por Mes',
                            data: [getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData()],
                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                }
            });

            const dailyCtx = document.getElementById('daily-chart').getContext('2d');
            const dailyChart = new Chart(dailyCtx, {
                type: 'line',
                data: {
                    labels: ['D�a 1', 'D�a 2', 'D�a 3', 'D�a 4', 'D�a 5', 'D�a 6', 'D�a 7'],
                    datasets: [{
                            label: 'Ventas Diarias',
                            data: [getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData(), getRandomData()],
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 2,
                            fill: false
                        }]
                },
                options: {
                    scales: {
                        x: {
                            display: true,
                            title: {
                                display: true,
                                text: 'D�as'
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

            // Actualizaci�n del gr�fico en tiempo real cada segundo
            setInterval(() => {
                const now = new Date();
                const timeLabel = now.toLocaleTimeString();
                const newData = getRandomData();

                realTimeChart.data.labels.push(timeLabel);
                realTimeChart.data.datasets[0].data.push(newData);

                if (realTimeChart.data.labels.length > 10) {
                    realTimeChart.data.labels.shift();
                    realTimeChart.data.datasets[0].data.shift();
                }

                realTimeChart.update();
            }, 1000);
        </script>
    </body>
</html>
