<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">

            <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>

            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-lg-11 app">
                        <div class="row">&nbsp;</div>
                        <div class="row">
                            <div class="col-lg-6">
                                <el-date-picker v-model="inDay" type="daterange" align="right" unlink-panels
                                    range-separator="到" start-placeholder="開始日期" end-placeholder="結束日期"
                                    :picker-options="pickerOptions" value-format="yyyy-MM-dd">
                                </el-date-picker>
                                <input type="submit" value="送出" @click="selectCompany">
                                <table border="1">
                                    <tr style="border: 1px solid #333;">
                                        <td>總數 : {{list.length}}</td>
                                    </tr>
                                    <tr v-for="(s, index) in list" :key="index">
                                        <td style="border: 1px solid #333;">{{s}}</td>
                                    </tr>
                                </table>

                            </div>
                            <div class="col-lg-6">
                                <canvas id="myChart" width="400" height="400"></canvas>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            window.onload = function () {

                const ctx = document.getElementById('myChart').getContext('2d');
                var chartDom = document.getElementById('myChart');
                var myChart = echarts.init(chartDom);
                var option;
                option = {
                    xAxis: {
                        type: 'category',
                        data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            data: [820, 932, 901, 934, 1290, 1330, 1320],
                            type: 'line',
                            smooth: true
                        }
                    ]
                };
                option && myChart.setOption(option);
            }

        </script>



        </html>