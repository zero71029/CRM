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
                .calendar {
                    /* 按鈕顏色 */
                    background-color: #afe3d5;
                }
            </style>
        </head>


        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11 app">
                        <div class="row " v-cloak>
                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->
                                <el-calendar v-model='valueData' v-loading="loading">
                                    <!-- 这里使用的是 2.5 slot 语法，对于新项目请使用 2.6 slot 语法-->
                                    <template slot="dateCell" slot-scope="{date, data}">
                                        <p :class="data.isSelected ? 'is-selected' : ''">
                                            {{ data.day.split('-').slice(2).join('-') }} {{ data.isSelected ? '✔️' :
                                            ''}}
                                        </p>
                                        <div v-for="(s, index) in leave" :key="index">
                                            <div v-if="s.leaveday == data.day " draggable="true">
                                                <a :href="'${pageContext.request.contextPath}/Task/leave.jsp?id='+s.leaveid"
                                                    style="background-color: #FFFFAA;color: #000;margin: 3px;padding: 3px;display: inline-block;width: 100%;">
                                                    {{s.user}} &nbsp; <span style="float: right;">{{s.leaveName}}</span>
                                                </a>
                                            </div>
                                        </div>
                                        <div v-for="(s, index) in businessTrip" :key="index">
                                            <div v-if="s.tripday == data.day ">
                                                <a :href="'${pageContext.request.contextPath}/Task/businessTrip.jsp?id='+s.tripid"
                                                    style="background-color: #d9ecff;color: #000;margin: 3px;padding: 3px;display: inline-block;width: 100%">
                                                    {{s.schedule}} <span style="float: right;"> {{s.tripname}}</span>
                                                </a>
                                            </div>
                                        </div>

                                        <div v-for="(s, index) in calender" :key="index">
                                            <div v-if="s.day == data.day ">
                                                <a :href="'${pageContext.request.contextPath}/Task/addCalender.jsp?id='+s.calenderid"
                                                    style="background-color: rgb(103, 194, 58);color: #fff;margin: 3px;padding: 3px;display: inline-block;width: 100%">
                                                    {{s.name}} <span style="float: right;"> {{s.theme}}</span>
                                                </a>
                                            </div>
                                        </div>
                                    </template>
                                </el-calendar>
                                <a href="${pageContext.request.contextPath}/Task/addCalender.jsp">添加日誌</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        inday: "",
                        loading: false,
                        valueData: new Date(),
                        leave: [],
                        businessTrip: [],
                        calender:[],
                    }
                },
                created() {
                    this.inday = this.dateFormat('YYYY-mm-dd', this.valueData);
                    this.getLeave(this.inday);
                },
                mounted() {
                    this.$nextTick(() => {
                        // 点击上个月
                        let prevBtn = document.querySelector('.el-calendar__button-group .el-button-group>button:nth-child(1)');
                        prevBtn.addEventListener('click', () => {
                            console.info(this.valueData);
                            console.info(this.dateFormat('YYYY-mm-dd', this.valueData));
                            this.getLeave(this.dateFormat('YYYY-mm-dd', this.valueData));
                        })
                        // 点击今天
                        let currBtn = document.querySelector('.el-calendar__button-group .el-button-group>button:nth-child(2)');
                        currBtn.addEventListener('click', () => {
                            console.info(this.valueData);
                            console.info(this.dateFormat('YYYY-mm-dd', this.valueData));
                            this.getLeave(this.dateFormat('YYYY-mm-dd', this.valueData));
                        })
                        // 点击下个月
                        let nextBtn = document.querySelector('.el-calendar__button-group .el-button-group>button:nth-child(3)');
                        nextBtn.addEventListener('click', () => {
                            console.info(this.valueData);
                            console.info(this.dateFormat('YYYY-mm-dd', this.valueData));
                            this.getLeave(this.dateFormat('YYYY-mm-dd', this.valueData));
                        })
                    })
                },
                methods: {
                    //讀取資料
                    getLeave(mon) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/calendarInit/" + mon,//接受請求的Servlet地址
                            type: 'get',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                console.log(response.data);
                                if (response.code == 200) {
                                    this.leave = response.data.leave;
                                    this.businessTrip = response.data.businessTrip;
                                    this.calender= response.data.calender;
                                }
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
                    //切換上下月份..
                    changeMon(i) {
                        let myDate = new Date(this.inday)
                        myDate.setMonth(myDate.getMonth() + i);
                        this.inday = this.formatMon(myDate);
                        this.getLeave(this.inday);
                    },
                    dateFormat(fmt, date) {
                        let ret;
                        const opt = {
                            "Y+": date.getFullYear().toString(), // 年
                            "m+": (date.getMonth() + 1).toString(), // 月
                            "d+": date.getDate().toString(), // 日
                            "H+": date.getHours().toString(), // 时
                            "M+": date.getMinutes().toString(), // 分
                            "S+": date.getSeconds().toString() // 秒
                        };
                        for (let k in opt) {
                            ret = new RegExp("(" + k + ")").exec(fmt);
                            if (ret) {
                                fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
                            };
                        };
                        return fmt;
                    },


                },
            })
            $(".employee").show();
        </script>

        <style>
            .el-calendar-table .el-calendar-day {
                height: 100%;
                min-height: 100px;

            }
        </style>


        </html>