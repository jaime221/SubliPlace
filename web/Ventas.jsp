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
                <h2>Ventas por Año</h2>
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

            // Configuración del gráfico en tiempo real
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

            // Configuración de gráficos de ventas por año, mes y día
            const yearlyCtx = document.getElementById('yearly-chart').getContext('2d');
            const yearlyChart = new Chart(yearlyCtx, {
                type: 'bar',
                data: {
                    labels: ['Año 1', 'Año 2', 'Año 3', 'Año 4', 'Año 5'],
                    datasets: [{
                            label: 'Ventas por Año',
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
                    labels: ['Día 1', 'Día 2', 'Día 3', 'Día 4', 'Día 5', 'Día 6', 'Día 7'],
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
                                text: 'Días'
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

            // Actualización del gráfico en tiempo real cada segundo
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
