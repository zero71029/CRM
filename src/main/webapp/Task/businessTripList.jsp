<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">

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

                tr {
                    background-color: #d9ecff;
                    color: #1e89f5;
                }

                .businessTrip {
                    /* 按鈕顏色 */
                    background-color: #afe3d5;
                }

                .expired {
                    background-color: #d9ecff;
                    color: red;
                }

                .el-month-table tr {
                    background-color: #FFF;
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
                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-12 text-center">
                                        <p>&nbsp;</p>
                                        <el-button type="text" @click="changeMon(-1)"> ❮❮</el-button>
                                        &nbsp;&nbsp;
                                        <el-date-picker v-model="inday" type="month" @change="changeTime">
                                        </el-date-picker>
                                        &nbsp;&nbsp;
                                        <el-button type="text" @click="changeMon(1)">❯❯</el-button>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-1">
                                        <a href="${pageContext.request.contextPath}/Task/businessTrip.jsp">出差申請</a>
                                        <br><br>
                                        <a
                                            :href="'${pageContext.request.contextPath}/Task/calendar.jsp?inday='+inday">月歷</a>
                                    </div>
                                    <div class="col-md-8" v-loading="loading" element-loading-text="拼命加载中"
                                        element-loading-spinner="el-icon-loading"
                                        element-loading-background="rgba(0, 0, 0, 0.8)">
                                        <p>&nbsp;</p>
                                        <table class="table table-bordered border border-dark border-2 ">
                                            <tr class="text-center">
                                                <td>日期</td>
                                                <td>預計時間</td>
                                                <td>排程人員</td>
                                                <td>負責人員</td>
                                                <td>行程目的</td>
                                                <td>操作</td>
                                            </tr>
                                            <tr v-for="(s, index) in list" :key="index" :class="{expired:s.isExpired}">
                                                <td> {{s.tripday}}</td>
                                                <td> {{s.expected}}</td>
                                                <td> {{s.schedule}}</td>
                                                <td> {{s.responsible1}} &nbsp; {{s.responsible2}} &nbsp;
                                                    {{s.responsible3}}</td>
                                                <td> {{s.tripname}}</td>
                                                <td><a :href="'${pageContext.request.contextPath}/Task/businessTrip.jsp?id='+s.tripid"
                                                        target="_blank">細節</a></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="block">
                                            <el-date-picker v-model="value2" type="monthrange" align="right"
                                                value-format="yyyy-MM-dd" unlink-panels range-separator="至"
                                                start-placeholder="開始月份" end-placeholder="結束月份"
                                                :picker-options="pickerOptions">
                                            </el-date-picker>
                                        </div>
                                        <input type="text" placeholder="車號" list="car" v-model="car">
                                        <button @click="searchCar">搜索</button>
                                        <datalist id="car">
                                            <option value="2311-WJ">2311-WJ</option>
                                            <option value="2311-P6">2311-P6</option>
                                        </datalist>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>

            $(".employee").show();
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        inday: "",
                        list: [],
                        pickerOptions: {
                            shortcuts: [{
                                text: '本月',
                                onClick(picker) {
                                    picker.$emit('pick', [new Date(new Date().getFullYear(), new Date().getMonth()), new Date()]);
                                }
                            }, {
                                text: '今年至今',
                                onClick(picker) {
                                    const end = new Date();
                                    const start = new Date(new Date().getFullYear(), 0);
                                    picker.$emit('pick', [start, end]);
                                }
                            }, {
                                text: '最近六个月',
                                onClick(picker) {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setMonth(start.getMonth() - 6);
                                    picker.$emit('pick', [start, end]);
                                }
                            }]
                        },
                        value2: '',
                        car: "",
                        loading: true,
                    }
                },
                created() {
                    this.inday = this.formatMon(new Date());
                    this.getLeave(this.inday);
                },
                methods: {
                    //切換月份 日期選擇器
                    changeTime() {
                        this.getLeave(this.formatMon(this.inday));
                    },
                    //讀取資料
                    getLeave(mon) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/BusinessTripList/" + mon,//接受請求的Servlet地址
                            type: 'get',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                if (response.code == 200) {
                                    this.list = response.data;
                                    this.list.forEach(element => {
                                        let d = new Date(element.tripday);
                                        d.setDate(d.getDate() + 1);
                                        if (d.getTime() >= new Date().getTime()) {
                                            console.log(element.tripday)
                                            element.isExpired = true;
                                        } else {
                                            element.isExpired = false;
                                        }

                                    });
                                }
                                this.loading = false;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    //格式化日期
                    formatMon(myDate) {
                        let mon = (myDate.getMonth() + 1) + "";
                        return myDate.getFullYear() + "-" + mon.padStart(2, "0");
                    },
                    //切換上下月份
                    changeMon(i) {
                        let myDate = new Date(this.inday)
                        myDate.setMonth(myDate.getMonth() + i);
                        this.inday = this.formatMon(myDate);
                        this.getLeave(this.inday);
                    },
                    //搜索車號 
                    searchCar() {
                        this.loading = true;
                        if (this.car == "") {
                            this.$message.error("輸入車號")
                        } else {
                            let data = "car=" + this.car + "&start=" + this.value2[0] + "&end=" + this.value2[1];
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/searchCar",
                                type: 'post',
                                data: data,
                                async: false,
                                cache: false,
                                success: response => {
                                    console.log("TripList ", response.data);
                                    if (response.code == 200) {
                                        this.list = response.data;
                                        this.list.forEach(element => {
                                            let d = new Date(element.tripday);
                                            d.setDate(d.getDate() + 1);
                                            if (d.getTime() >= new Date().getTime()) {
                                                console.log(element.tripday)
                                                element.isExpired = true;
                                            } else {
                                                element.isExpired = false;
                                            }
                                        });
                                    }
                                    this.loading = false;
                                },
                                error: function (returndata) {
                                    this.$message.error("發生錯誤")
                                    console.log(returndata);
                                }
                            });
                        }
                    }
                },
            })
        </script>




        </html>