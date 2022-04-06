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
        [v-cloak] {
            display: none;
        }

        .app {
            background-color: #e4f3ef;
        }
    </style>
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <!-- <%-- 插入側邊欄--%> -->
        <jsp:include page="/Sidebar.jsp"></jsp:include>
        <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
        <div class="col-lg-11 app" v-cloak>
            <div class="row">
                <div class="col-lg-12">
                    <div id="initpage" style="width: 100%;height:300px;"></div>
                </div>

            </div>
            <div class="row">&nbsp;</div>
            <div class="row">
                <div class="col-lg-4">
                    <el-button type="text" @click="SubmitBosVisible=true">提交主管 {{SubmitBos.length}}
                    </el-button>
                    <el-button type="text" @click="CallBosVisible=true">延長請求 {{CallBos.length}}
                    </el-button>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <el-date-picker v-model="inDay" type="daterange" align="right" unlink-panels
                                    range-separator="到" start-placeholder="開始日期" end-placeholder="結束日期"
                                    :picker-options="pickerOptions" value-format="yyyy-MM-dd">
                    </el-date-picker>
                    <input type="submit" value="送出" @click="selectCompany">
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div id="main" style="width: 400px;height:400px;"></div>
                </div>
                <div class="col-lg-4">
                    <div id="myChart" style="width: 400px;height:400px;"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div id="producttype" style="width: 100%;height:800px;"></div>
                </div>
            </div>
            <!-- 提交主管 彈窗-->
            <c:if test="${user.position == '主管' || user.position == '系統'}">
                <el-dialog title="提交主管" :visible.sync="SubmitBosVisible"
                           :default-sort="{prop: 'aaa', order: 'descending'}">
                    <el-table :data="SubmitBos" @row-click="clickEndCast">
                        <el-table-column property="client" label="公司"></el-table-column>
                        <el-table-column property="message" label="描述"></el-table-column>
                        <el-table-column property="aaa" label="創建日期" sortable></el-table-column>
                    </el-table>
                </el-dialog>
            </c:if>
            <br><br><br><br><br>
            <!-- 延長請求 彈窗-->
            <c:if test="${user.position == '主管' || user.position == '系統'}">
                <el-dialog title="延長請求" :visible.sync="CallBosVisible"
                           :default-sort="{prop: 'aaa', order: 'descending'}">
                    <el-table :data="CallBos" @row-click="clickEndCast">
                        <el-table-column property="client" label="公司"></el-table-column>
                        <el-table-column property="message" label="描述"></el-table-column>
                        <el-table-column property="aaa" label="創建日期" sortable></el-table-column>
                    </el-table>
                </el-dialog>
            </c:if>


        </div>
    </div>
</div>
</body>

<script>


    var vm = new Vue({
        el: ".app",
        data() {
            return {
                SubmitBos: [],//提交主管
                SubmitBosVisible: false,//提交主管彈窗
                CallBos: [],//延長通知
                CallBosVisible: false,//延長通知彈窗
                CompanyNumList: [],//每天公司數量
                producttype: [],//商品種類
                AdminCastNum: [],//業務案件數量
                list: [],
                inDay: [],
                pickerOptions: {
                    shortcuts: [
                        {
                            text: '今天',
                            onClick(picker) {
                                const end = new Date();
                                const start = new Date();
                                start.setTime(start.getTime());
                                picker.$emit('pick', [start, end]);
                            }
                        }, {
                            text: '最近一周',
                            onClick(picker) {
                                const end = new Date();
                                const start = new Date();
                                start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                                picker.$emit('pick', [start, end]);
                            }
                        }, {
                            text: '最近一個月',
                            onClick(picker) {
                                const end = new Date();
                                const start = new Date();
                                start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                                picker.$emit('pick', [start, end]);
                            }
                        }, {
                            text: '最近三個月',
                            onClick(picker) {
                                const end = new Date();
                                const start = new Date();
                                start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                                picker.$emit('pick', [start, end]);
                            }
                        }]
                },
            }
        }, created() {
            $.ajax({
                url: '${pageContext.request.contextPath}/statistic/init',
                type: 'POST',
                async: false,
                cache: false,
                success: (response => (
                    this.SubmitBos = response.SubmitBos,
                        this.CallBos = response.CallBos,
                        this.CompanyNumList = response.CompanyNumList,
                        this.AdminCastNum = response.AdminCastNum,
                        console.log(response, "init")

                )),
                error: function (returndata) {
                    console.log(returndata);
                }
            })


        },
        mounted() {

            var list = [];
            var keys = Object.keys(this.CompanyNumList);
            keys.sort();
            for (const i of keys) {
                var BBB = this.CompanyNumList[i];
                list.push(BBB.length);
            }
            this.Histogram(keys, list, 'initpage', '每日案件數');
        },
        methods: {
            //點彈窗裡的項目
            clickEndCast: function (row, column, event) {
                window.open('${pageContext.request.contextPath}/Market/Market/' + row.marketid);

            },
            //搜索公司數量
            selectCompany: function () {
                if (this.inDay == "") {//沒輸入日期
                    this.inDay[0] = "";
                    this.inDay[1] = "";
                }
                $.ajax({
                    url: '${pageContext.request.contextPath}/statistic/selectCompany?from=' + this.inDay[0] + "&to=" + this.inDay[1],
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: (response => (
                        this.list = response.companyNum,
                            this.CompanyNumList = response.CompanyNumList,
                            this.total = this.list.length,
                            this.AdminCastNum = response.AdminCastNum,
                            this.producttype = response.producttype,
                            console.log(response, "response")
                    )),
                    error: function (returndata) {
                        console.log(returndata);
                    }
                })
                this.CompanyNumEcharts();
                this.AdminCastEcharts();

                console.log(this.producttype, "商品種類");
                var list = [];
                //
                // var Vehicles = [this.producttype
                // ];
                // Vehicles = Vehicles.sort(function (a, b) {
                //     return a[1] > b[1] ? 1 : -1;
                // });
                //
                // console.log(Vehicles[0],"Vehicles");


                var keys = Object.keys(this.producttype);

                for (const i of keys) {
                    var BBB = this.producttype[i];
                    list.push(BBB);
                }
                this.BarChart(keys, list, 'producttype', '商品種類');
            },
            //每天公司數量圖
            CompanyNumEcharts: function () {
                var list = [];
                var keys = Object.keys(this.CompanyNumList);
                keys.sort();
                for (const i of keys) {
                    var BBB = this.CompanyNumList[i];
                    list.push(BBB.length);
                }
                var chartDom = document.getElementById('myChart');
                var myChart = echarts.init(chartDom);
                var option;
                option = {
                    title: {
                        text: '每天案件數量',
                        left: 'center'
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        data: keys
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [
                        {
                            data: list,
                            type: 'line',
                            areaStyle: {}
                        }
                    ]
                };
                option && myChart.setOption(option);

            },
            //業務案件數量圖
            AdminCastEcharts: function () {
                console.log(this.AdminCastNum, "this.AdminCastNum");
                var obj = [];
                var keys = Object.keys(this.AdminCastNum);
                for (const i of keys) {
                    if (this.AdminCastNum[i] > 0)
                        obj.push({value: this.AdminCastNum[i], name: i + "[" + this.AdminCastNum[i] + "]"});
                }
                console.log(obj, "obj");
                var chartDom = document.getElementById('main');
                var myChart = echarts.init(chartDom);
                var option;
                option = {
                    title: {
                        text: '業務案件數量',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    series: [
                        {
                            type: 'pie',
                            radius: '50%',
                            data: obj,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };

                option && myChart.setOption(option);

            },
            formatter: function (params) {
                var relVal = params[0].name;
                for (var i = 0, l = params.length; i < l; i++) {
                    relVal += '<br/>' + params[i].marker + params[i].seriesName + ' : ' + params[i].value.toLocaleString() + "K";
                }
                return relVal;
            },
            //柱狀圖
            Histogram(x, y, id, title) {//柱狀圖
                var chartDom = document.getElementById(id);
                var myChart = echarts.init(chartDom);
                var option;
                option = {
                    title: {
                        text: title,
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'category',
                        data: x
                    },
                    yAxis: {
                        type: 'value',
                        name: '案件量'
                    },
                    series: [
                        {
                            data: y,
                            type: 'bar'
                        }
                    ]
                };
                option && myChart.setOption(option);
                myChart.resize();
            },
            //条形图
            BarChart(x, y, id, title) {
                var chartDom = document.getElementById(id);
                var myChart = echarts.init(chartDom);
                var option;

                option = {
                    title: {
                        text: title
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    legend: {},
                    grid: {
                        left: '3%',
                        right: '4%',
                        bottom: '3%',
                        containLabel: true
                    },
                    xAxis: {
                        type: 'value',
                        boundaryGap: [0, 0.1]
                    },
                    yAxis: {
                        inverse: true,
                        type: 'category',
                        data: x
                    },
                    series: [
                        {
                            realtimeSort: true,
                            name: '2011',
                            type: 'bar',
                            data: y
                        }
                    ]
                };

                option && myChart.setOption(option);
            }


        },
    })
</script>

<style>
    .col-lg-6 .el-col .box-card {
        width: 400px;
        height: 400px;
    }
</style>


</html>