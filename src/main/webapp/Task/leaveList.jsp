<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                    background-color: #FFFFAA;
                }

                .leave {
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
                                    <div class="col-md-2">
                                        <c:if test="${user.position != '職員' || user.position != '新'}">
                                            <a href="${pageContext.request.contextPath}/Task/leave.jsp">請假申請</a>
                                        </c:if>
                                    </div>
                                    <div class="col-md-8">
                                        <p>&nbsp;</p>
                                        <table class="table table-bordered border border-dark border-2">
                                            <tr class="text-center">
                                                <td>日期</td>
                                                <td>部門</td>
                                                <td>姓名</td>
                                                <td>假別</td>
                                                <td>備註</td>

                                            </tr>
                                            <tr v-for="(s, index) in list" :key="index">
                                                <td>{{s.leaveday}}</td>
                                                <td> {{s.department}}</td>
                                                <td> {{s.user}}</td>
                                                <td> {{s.leaveName}}</td>
                                                <td><a
                                                        :href="'${pageContext.request.contextPath}/Task/leave.jsp?id='+s.leaveid">{{s.remark}}</a>
                                                </td>
                                            </tr>

                                        </table>
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
                            url: "${pageContext.request.contextPath}/task/getLeave/" + mon,//接受請求的Servlet地址
                            type: 'get',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => {
                                console.log(response.data);
                                if (response.code == 200) {
                                    this.list = response.data; 
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
                    //切換上下月份
                    changeMon(i) {
                        let myDate = new Date(this.inday)
                        myDate.setMonth(myDate.getMonth() + i);
                        this.inday = this.formatMon(myDate);
                        this.getLeave(this.inday);
                    },
                },

            })
        </script>




        </html>