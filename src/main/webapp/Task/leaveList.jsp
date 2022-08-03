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
                tr{
                    background-color:#FFFFAA;
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
                                        <a href="">
                                            << </a>
                                                &nbsp;&nbsp;
                                                <el-date-picker v-model="inday" type="month" @change="changeTime">
                                                    &nbsp;&nbsp;
                                                </el-date-picker>
                                                <a href="">>></a>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-2"></div>
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
                                            <tr v-for="(s, index) in list" :key="index" >
                                                <td>{{s.leaveday}}</td>
                                                <td> {{s.department}}</td>
                                                <td> {{s.user}}</td>
                                                <td> {{s.leaveName}}</td>
                                                <td> {{s.remark}}</td>
                                            </tr>

                                        </table>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12">xxxxxxxx</div>
                                </div>
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
                        list: [],
                    }
                },
                created() {
                    const date = new Date();
                    let mon = (date.getMonth() + 1) + "";
                    this.inday = date.getFullYear() + "-" + mon.padStart(2, "0");
                    console.log(this.inday);
                    $.ajax({
                        url: "${pageContext.request.contextPath}/task/getLeave/" + this.inday,//接受請求的Servlet地址
                        type: 'get',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: response => {
                            if (response.code == 200) {                            
                                this.list = response.data;
                            }
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                methods: {
                    changeTime(){
                        console.log(this.inday);
                        let mon = (this.inday.getMonth() + 1) + "";
                        console.log(this.inday.getFullYear()+"-"+mon.padStart(2, "0"));
                        let d = new Date(this.inday)
                    }
                },
            })
        </script>




        </html>