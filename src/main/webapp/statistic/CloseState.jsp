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
                    <div class="col-md-11 app" v-cloak>
                        <div class="row ">
                            <div class="col-md-12 text-center">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-4 "></div>
                                    <div class="col-md-4 ">
                                        <div id="pie" style="width: 400px;height:300px;"></div>
                                    </div>
                                </div>
                                <!-- 日期選擇器 -->
                                <div class="row" v-show="v">
                                    <div class="col-lg-4">
                                        <el-date-picker v-model="inDay" type="daterange" align="right" unlink-panels
                                            range-separator="到" start-placeholder="開始日期" end-placeholder="結束日期"
                                            :picker-options="pickerOptions" value-format="yyyy-MM-dd">
                                        </el-date-picker>
                                        <input type="submit" value="送出" @click="BelieveInLight">
                                    </div>
                                </div>

                                <div class="row ">
                                    <div class="col-md-4">
                                        <div id="other" style="width: 100%;height:300px;"> </div>
                                        <el-table :data="other" style="width: 100%"
                                            :default-sort="{prop: 'stage', order: 'ascending'}">
                                            <el-table-column label="公司">
                                                <template slot-scope="scope">
                                                    <a :href="'${pageContext.request.contextPath}/Market/Market/'+scope.row.marketid"
                                                        target="_blank"> {{scope.row.client}}</a>
                                                </template>
                                            </el-table-column>
                                            <el-table-column prop="stage" label="狀態" sortable>
                                            </el-table-column>

                                        </el-table>
                                    </div>
                                    <div class="col-md-4">
                                        <div id="success" style="width: 100%;height:300px;"> </div>
                                        <el-table :data="success" style="width: 100%">
                                            <el-table-column label="公司">
                                                <template slot-scope="scope">
                                                    <a :href="'${pageContext.request.contextPath}/Market/Market/'+scope.row.marketid"
                                                        target="_blank"> {{scope.row.client}}</a>
                                                </template>
                                            </el-table-column>

                                            <el-table-column prop="aaa" label="日期">
                                            </el-table-column>

                                        </el-table>
                                    </div>
                                    <div class="col-md-4">

                                        <div id="fail" style="width: 100%;height:300px;"> </div>
                                        <el-table :data="fail" style="width: 100%"
                                            :default-sort="{prop: 'closereason', order: 'descending'}">
                                            <el-table-column label="公司">
                                                <template slot-scope="scope">
                                                    <a :href="'${pageContext.request.contextPath}/Market/Market/'+scope.row.marketid"
                                                        target="_blank"> {{scope.row.client}}</a>
                                                </template>
                                            </el-table-column>
                                            <el-table-column prop="closereason" label="結案理由" sortable>
                                            </el-table-column>
                                        </el-table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            $(".statistic").show();
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        DayNum: 7,
                        v: true,
                        success: [],
                        fail: [],
                        other: [],
                        oldfail: [],
                        oldother: [],
                        oldsuccess: [],
                        inDay: "",
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
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/statistic/CloseState2?from=&to=',
                        type: 'POST',
                        async: false,
                        cache: false,
                        success: response => {
                            this.fail = response.fail;
                            this.success = response.success;
                            this.other = response.other;
                            this.oldfail = response.fail;
                            this.oldother = response.other;
                            this.oldsuccess = response.success;;

                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                mounted() {
                    this.pie();
                    this.OtherPie();
                    this.SuccessPie();
                    this.FailPie();

                },
                methods: {
                    //圓餅圖
                    pie: function () {
                        var obj = [];
                        obj.push({ value: this.success.length, name: "成功結案" + this.success.length });
                        obj.push({ value: this.fail.length, name: "失敗結案" + this.fail.length });
                        obj.push({ value: this.other.length, name: "未結案" + this.other.length });

                        var chartDom = document.getElementById('pie');
                        var myChart = echarts.init(chartDom);
                        var option;
                        option = {
                            title: {
                                text: '總共案件' + (this.success.length + this.fail.length + this.other.length),
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
                    OtherPie() {
                        let 內部詢價中 = 0;
                        let 尚未處理 = 0;
                        let 已報價 = 0;
                        let 提交主管 = 0;
                        this.other.forEach(e => {
                            if (e.stage == "內部詢價中") 內部詢價中++
                            if (e.stage == "尚未處理") 尚未處理++
                            if (e.stage == "已報價") 已報價++
                            if (e.stage == "提交主管") 提交主管++
                        });
                        var obj = [];
                        obj.push({ value: 已報價, name: "已報價" + 已報價, url: "已報價" });
                        obj.push({ value: 內部詢價中, name: "內部詢價中" + 內部詢價中, url: "內部詢價中" });
                        obj.push({ value: 尚未處理, name: "尚未處理" + 尚未處理, url: "尚未處理" });
                        obj.push({ value: 提交主管, name: "提交主管" + 提交主管, url: "提交主管" });
                        var chartDom = document.getElementById('other');
                        var myChart = echarts.init(chartDom);
                        var option;
                        option = {
                            title: {
                                text: '未結案' + + this.other.length + "筆",
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
                        myChart.on('click', function (params) {
                            console.log(params.data.url);
                            vm.other = [];
                            vm.oldother.forEach(e => {
                                if (e.stage == params.data.url) vm.other.push(e);
                            })
                        });
                    },
                    //成功結案
                    SuccessPie() {
                        var obj = [];
                        var set = new Set();
                        //取出業務
                        this.success.forEach(e => {
                            set.add(e.user);
                        });
                        //統計數量
                        set.forEach(user => {
                            let i = 0
                            this.success.forEach(e => {
                                if (user == e.user) i++;
                            });
                            obj.push({ value: i, name: user + i, url: user });
                        });

                        var chartDom = document.getElementById('success');
                        var myChart = echarts.init(chartDom);
                        var option;
                        option = {
                            title: {
                                text: '成功結案' + + this.success.length + "筆",
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
                        myChart.on('click', function (params) {
                            vm.success = [];
                            vm.oldsuccess.forEach(e => {
                                if (e.user == params.data.url) vm.success.push(e);
                            })
                        });
                    },
                    //失敗結案
                    FailPie() {
                        var obj = [];
                        var set = new Set();
                        //取出業務
                        this.fail.forEach(e => {
                            set.add(e.closereason);
                        });
                        //統計數量
                        set.forEach(closereason => {

                            let i = 0
                            this.fail.forEach(e => {
                                if (closereason == e.closereason) i++;
                            });
                            obj.push({ value: i, name: closereason + i, url: closereason });
                        });
                        var chartDom = document.getElementById('fail');
                        var myChart = echarts.init(chartDom);
                        var option;
                        option = {
                            title: {
                                text: '失敗結案' + + this.fail.length + "筆",
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
                        // 处理点击事件并且...
                        myChart.on('click', function (params) {

                            vm.fail = [];
                            vm.oldfail.forEach(e => {
                                if (e.closereason == params.data.url) vm.fail.push(e);
                            })
                        });
                    }, BelieveInLight() {//送出搜索

                        //計算相差幾天
                        const day1 = new Date(this.inDay[0]);
                        const day2 = new Date(this.inDay[1]);
                        const difference = Math.abs(day2 - day1);
                        this.DayNum = difference / (1000 * 3600 * 24);
                        //送出搜索
                        $.ajax({
                            url: '${pageContext.request.contextPath}/statistic/CloseState2?from=' + this.inDay[0] + '&to=' + this.inDay[1],
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: response => {
                                this.fail = response.fail;
                                this.success = response.success;
                                this.other = response.other;
                                this.oldfail = response.fail;
                                this.oldother = response.other;
                                this.oldsuccess = response.success;;
                                this.pie();
                                this.OtherPie();
                                this.SuccessPie();
                                this.FailPie();

                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                    }
                },
            })

        </script>




        </html>