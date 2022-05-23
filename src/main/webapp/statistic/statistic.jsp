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
                                <el-button type="text" @click="SubmitBosVisible=true">提交主管
                                    {{SubmitBos.length+PotentialSubmitBos.length}}
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


                            <div class="col-lg-4">
                                <c:if test="${user.position == '系統' }">
                                    <div id="BusinessState" style="height:400px;"></div>
                                </c:if>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                                <el-switch v-model="ProductSwitch" v-show="producttype != ''" active-text="精簡"
                                    inactive-text="原始">
                                </el-switch>
                                <div id="producttype" style="width: 100%;height:800px;"></div>
                            </div>
                        </div>

                        <div class="row" v-if="MaxNumCompany.length > 0">
                            <div class="col-lg-4">

                                案件最多的公司
                                <el-table :data="MaxNumCompany" style="width: 100%">
                                    <el-table-column  label="公司">
                                        <template slot-scope="scope">
                                            <a :href="'${pageContext.request.contextPath}/CRM/client/'+scope.row.clientid" target="_blank">{{scope.row.company}}</a>
                                        </template>
                                    </el-table-column>
                                    <el-table-column prop="num" label="數量">
                                    </el-table-column>

                                </el-table>
                            </div>

                            <div class="col-lg-4">
                                成功案件最多的公司
                                <el-table :data="SuccessMaxNumCompany" style="width: 100%">
                                    <el-table-column  label="公司">
                                        <template slot-scope="scope">
                                            <a :href="'${pageContext.request.contextPath}/CRM/client/'+scope.row.clientid" target="_blank">{{scope.row.company}}</a>
                                        </template>
                                    </el-table-column>
                                    <el-table-column prop="num" label="數量">
                                    </el-table-column>

                                </el-table>
                            </div>
                            <div class="col-lg-4">
                                失敗案件最多的公司
                                <el-table :data="FailMaxNumCompany" style="width: 100%">


                                    <el-table-column  label="公司">
                                        <template slot-scope="scope">
                                            <a :href="'${pageContext.request.contextPath}/CRM/client/'+scope.row.clientid" target="_blank">{{scope.row.company}}</a>
                                        </template>
                                    </el-table-column>
                                    <el-table-column prop="num" label="數量">
                                    </el-table-column>

                                </el-table>
                            </div>
                        </div>



                        <!-- 提交主管 彈窗-->
                        <c:if test="${user.position == '主管' || user.position == '系統'}">
                            <el-dialog title="提交主管" :visible.sync="SubmitBosVisible"
                                :default-sort="{prop: 'aaa', order: 'descending'}">
                                <el-table :data="SubmitBos" @row-click="clickEndCast">
                                    <el-table-column property="client" label="銷售機會"></el-table-column>
                                    <el-table-column property="message" label="描述"></el-table-column>
                                    <el-table-column property="aaa" label="創建日期" sortable></el-table-column>
                                </el-table>
                                <hr>
                                <el-table :data="PotentialSubmitBos" @row-click="clickPotential">
                                    <el-table-column property="company" label="潛在客戶"></el-table-column>
                                    <el-table-column property="remark" label="詢問"></el-table-column>
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
            $(".statistic").show();

            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        FailMaxNumCompany: [],//失敗案件最多的公司
                        SuccessMaxNumCompany: [],//成功案件最多的公司
                        MaxNumCompany: [],//案件最多的公司
                        ProductSwitch: false,//商品開關
                        BusinessState: [],//業務成功失敗
                        SubmitBos: [],//提交主管
                        SubmitBosVisible: false,//提交主管彈窗
                        PotentialSubmitBos: [],//提交主管by淺在顧客
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
                            this.PotentialSubmitBos = response.potential,
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
                }, watch: {
                    ProductSwitch: {
                        handler(newValue) {
                            console.log(newValue);
                            if (newValue) {
                                console.log("*****商品種類精簡*****");
                                var list = [];

                                //轉換格式 list =[{name:ddd,value:111},....]
                                var keys = Object.keys(this.producttype);
                                for (k of keys) {
                                    list.push({ name: k, value: this.producttype[k] });
                                }

                                var Vehicles = list;
                                var list = [];
                                var pressure = 0;
                                var 氣象儀器 = 0;
                                var 氣體 = 0;
                                var 流量 = 0;
                                var 液位 = 0;
                                var 溫濕 = 0;
                                for (const x of Vehicles) {
                                    if (x.name.includes("壓力")) {
                                        pressure = pressure + x.value;
                                    }
                                    if (x.name.includes("氣象儀器")) {
                                        氣象儀器 = 氣象儀器 + x.value;
                                    }
                                    if (x.name.includes("氣體")) {
                                        氣體 = 氣體 + x.value;
                                    }
                                    if (x.name.includes("流量")) {
                                        流量 = 流量 + x.value;
                                    }
                                    if (x.name.includes("液位")) {
                                        液位 = 液位 + x.value;
                                    }
                                    if (x.name.includes("溫濕")) {
                                        溫濕 = 溫濕 + x.value;
                                    }

                                }

                                if (溫濕 > 0)
                                    list.push({ name: "溫濕", value: 溫濕 });
                                if (this.producttype['溫控器-TOHO'] + this.producttype['溫控器-其他'] > 0)
                                    list.push({ name: "溫控器", value: this.producttype['溫控器-TOHO'] + this.producttype['溫控器-其他'] });
                                if (液位 > 0)
                                    list.push({ name: "液位/料位", value: 液位 });
                                if (流量 > 0)
                                    list.push({ name: "流量", value: 流量 });
                                if (氣體 > 0)
                                    list.push({ name: "氣體", value: 氣體 });
                                if (氣象儀器 > 0)
                                    list.push({ name: "氣象儀器", value: 氣象儀器 });
                                if (pressure > 0)
                                    list.push({ name: "壓力", value: pressure });
                                if (this.producttype['其它'] > 0)
                                    list.push({ name: "其他", value: this.producttype['其它'] });
                                if (this.producttype['大型顯示器'] > 0)
                                    list.push({ name: "大型顯示器", value: this.producttype['大型顯示器'] });
                                if (this.producttype['差壓'] > 0)
                                    list.push({ name: "差壓", value: this.producttype['差壓'] });
                                if (this.producttype['感溫線棒'] > 0)
                                    list.push({ name: "感溫線棒", value: this.producttype['感溫線棒'] });
                                if (this.producttype['水質相關'] > 0)
                                    list.push({ name: "水質相關", value: this.producttype['水質相關'] });
                                if (this.producttype['溫度貼紙'] > 0)
                                    list.push({ name: "溫度貼紙", value: this.producttype['溫度貼紙'] });
                                if (this.producttype['無線傳輸'] > 0)
                                    list.push({ name: "無線傳輸", value: this.producttype['無線傳輸'] });
                                if (this.producttype['空氣品質'] > 0)
                                    list.push({ name: "空氣品質", value: this.producttype['空氣品質'] });
                                if (this.producttype['紅外線'] > 0)
                                    list.push({ name: "紅外線", value: this.producttype['紅外線'] });
                                if (this.producttype['編碼器/電位計'] > 0)
                                    list.push({ name: "編碼器/電位計", value: this.producttype['編碼器/電位計'] });
                                if (this.producttype['能源管理控制'] > 0)
                                    list.push({ name: "能源管理控制", value: this.producttype['能源管理控制'] });
                                if (this.producttype['記錄器'] > 0)
                                    list.push({ name: "記錄器", value: this.producttype['記錄器'] });
                                if (this.producttype['資料收集器-JETEC'] + this.producttype['資料收集器-其他'] > 0)
                                    list.push({ name: "資料收集器", value: this.producttype['資料收集器-JETEC'] + this.producttype['資料收集器-其他'] });
                                //排序
                                var Vehicles = list;
                                Vehicles = Vehicles.sort(function (a, b) {
                                    return a.value > b.value ? 1 : -1;
                                });
                                console.log(Vehicles, "排序後");
                                var nameList = [];
                                var valueList = [];
                                for (const p of Vehicles) {
                                    nameList.push(p.name);
                                    valueList.push(p.value);
                                }

                                this.BarChart(nameList, valueList, 'producttype', '商品種類精簡');

                                console.log(list);

                                console.log("*****商品種類精簡結束*****");
                            } else {
                                console.log("*****商品種類*****");
                                console.log(this.producttype, "商品種類");
                                var list = [];

                                //轉換格式 list =[{name:ddd,value:111},....]
                                var keys = Object.keys(this.producttype);
                                for (k of keys) {
                                    list.push({ name: k, value: this.producttype[k] });
                                }
                                //排序
                                var Vehicles = list;
                                Vehicles = Vehicles.sort(function (a, b) {
                                    return a.value > b.value ? 1 : -1;
                                });
                                console.log(Vehicles, "排序後");
                                var nameList = [];
                                var valueList = [];
                                for (const p of Vehicles) {
                                    nameList.push(p.name);
                                    valueList.push(p.value);
                                }
                                this.BarChart(nameList, valueList, 'producttype', '商品種類');
                                console.log("***********商品種類結束**********");

                            }




                        }
                    }
                },
                methods: {
                    //點彈窗裡的 銷售機會 項目
                    clickEndCast: function (row, column, event) {
                        window.open('${pageContext.request.contextPath}/Market/Market/' + row.marketid);

                    },//點彈窗裡的 潛在客戶 項目
                    clickPotential: function (row, column, event) {
                        window.open('${pageContext.request.contextPath}/Market/potentialcustomer/' + row.customerid);
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
                                this.BusinessState = response.BusinessState,
                                this.MaxNumCompany = response.MaxNumCompany,
                                this.SuccessMaxNumCompany = response.SuccessMaxNumCompany,
                                this.FailMaxNumCompany = response.FailMaxNumCompany,
                                console.log("案件最多", response.MaxNumCompany),
                                console.log(response, "response")
                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        })
                        this.CompanyNumEcharts();
                        this.AdminCastEcharts();
                        console.log("*****商品種類*****");
                        console.log(this.producttype, "商品種類");
                        var list = [];

                        //轉換格式 list =[{name:ddd,value:111},....]
                        var keys = Object.keys(this.producttype);
                        for (k of keys) {
                            list.push({ name: k, value: this.producttype[k] });
                        }
                        //排序
                        var Vehicles = list;
                        Vehicles = Vehicles.sort(function (a, b) {
                            return a.value > b.value ? 1 : -1;
                        });
                        console.log(Vehicles, "排序後");
                        var nameList = [];
                        var valueList = [];
                        for (const p of Vehicles) {
                            nameList.push(p.name);
                            valueList.push(p.value);
                        }
                        this.BarChart(nameList, valueList, 'producttype', '商品種類');
                        console.log("***********商品種類結束**********");

                        console.log("*****業務成功失敗*****");
                        console.log(this.BusinessState);
                        keys = Object.keys(this.BusinessState);
                        var source = [];
                        list = [['業務', '成功結案', '失敗結案']];
                        for (const k of keys) {
                            if (this.BusinessState[k][0] > 0 || this.BusinessState[k][1] > 0) {
                                source.push(k, this.BusinessState[k][0], this.BusinessState[k][1]);
                                list.push(source);
                                source = [];
                            }

                        }

                        console.log(list);
                        this.datase(list);


                        console.log("*****業務成功失敗結束*****");


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
                                obj.push({ value: this.AdminCastNum[i], name: i + "[" + this.AdminCastNum[i] + "]" });
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
                                // inverse: true,
                                type: 'category',
                                data: x
                            },
                            series: [
                                {
                                    // realtimeSort: true,
                                    name: '數量',
                                    type: 'bar',
                                    data: y
                                }
                            ]
                        };
                        option && myChart.setOption(option);
                    },
                    //最简单的数据集
                    datase(source) {
                        var app = {};
                        var chartDom = document.getElementById('BusinessState');
                        var myChart = echarts.init(chartDom);
                        var option;

                        option = {
                            legend: {},
                            tooltip: {},
                            dataset: {
                                source: source
                            },
                            xAxis: { type: 'category' },
                            yAxis: {},
                            // Declare several bar series, each will be mapped
                            // to a column of dataset.source by default.
                            series: [{ type: 'bar' }, { type: 'bar' }]
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