## chart.jsで時系列グラフ作成

最近のhtml5を使えば、グラフをブラウザに表示させ、interactiveに操作することができる。
そのためのライブラリも数々出てきているけれど、非常にシンプルで見た目もよく、動作も軽快なchart.jsを使ってみる。
[Chart.js](https://www.chartjs.org)

chart.jsのversion3以降はプラグインで時系列データを扱うモジュールを変えられるようになったらしい。
よく分からないままに、chart.jsのwebsiteに出ていたプラグインを導入してみることに。
そのまま表示するとデータの表示時刻がローカル時刻になってしまうが、tooltipFormatを指定したらインプットデータどおりに表示される。


[試しに作ったページ](https://satoshi-pes.github.io/memo/chartjs_example.html)

	<!DOCTYPE html>
    <head>
        <title>Document</title>

        <!-- chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/hammerjs@2.0.8/hammer.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom@1.1.1/dist/chartjs-plugin-zoom.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/moment@2.29.1/moment.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-moment@1.0.0/dist/chartjs-adapter-moment.min.js"></script>
    </head>

    <body>
        <!-- chart.js -->
        <canvas id="myChart"></canvas>

        <script>

            /* <block:config:0> */
            const config = {
                type: 'line',
                data: {
                    datasets: [{
                        label: 'My First Dataset',
                        data: [  { x: '2019-01-01T00:00:00', y: 1.07780903364e+08 },  { x: '2019-01-01T00:00:30', y: 1.07769888256e+08 },  { x: '2019-01-01T00:01:00', y: 1.07759115118e+08 },  { x: '2019-01-01T00:01:30', y: 1.07748585266e+08 },  { x: '2019-01-01T00:02:00', y: 1.07738298931e+08 },  { x: '2019-01-01T00:02:30', y: 1.07728256598e+08 },  { x: '2019-01-01T00:03:00', y: 1.07718459244e+08 } ],
                        fill: false,
                        borderColor: 'rgb(75, 192, 192)',
                        tension: 0.1
                    }]
                },
                options: {
                    scales: {
                        x: {
                            type: 'time',
                            time: {
                                //unit: 'year',
                                unit: 'minute',
                                //displayFormats: "YYYY/MM/DD h:m:s"
                                displayFormats: "HH:mm:ss",
                                tooltipFormat: "YYYY/MM/DD HH:mm:ss"
                            },
                        },
                    },

                    plugins: {
                        zoom: {
                            zoom: {
                                wheel: {
                                    enabled: true,
                                },
                                pinch: {
                                    enabled: true,
                                },
                                drag: {
                                    enabled: true,
                                },
                                mode: 'xy',
                            },
                            pan: {
                                enabled: true,
                                modifierKey: 'ctrl',
                                mode: 'xy',
                            }
                        }
                    },

                    transitions: {
                        zoom: {
                            animation: {
                                duration: 1000,
                                easing: 'easeOutCubic'
                            }
                        }
                    },
                }
            };

            /* </block:config> */

            var canvas = document.getElementById('myChart');
            var myChart = new Chart(
                canvas,
                config
            );

            function resetZoom() {
                myChart.resetZoom();
            }
        </script>

        <button onclick="resetZoom()">reset zoom</button>
    </body>
    </html>

### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
