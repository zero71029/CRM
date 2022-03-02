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
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-lg-11 app" v-cloak>
                        <div class="row">&nbsp;</div>
                        <div class="row">
                            <div class="col-lg-6">
                                <el-date-picker v-model="inDay" type="daterange" align="right" unlink-panels
                                    range-separator="到" start-placeholder="開始日期" end-placeholder="結束日期"
                                    :picker-options="pickerOptions" value-format="yyyy-MM-dd">
                                </el-date-picker>
                                <input type="submit" value="送出" @click="selectCompany">


                                <table border="1">
                                    <tr style="border: 1px solid #333;"><td>總數 : {{list.length}}</td></tr>
                                    <tr v-for="(s, index) in list" :key="index">
                                        <td style="border: 1px solid #333;">{{s}}</td>
                                    </tr>
                                </table>

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

                },
                methods: {
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
                                this.list = response,
                                this.total = this.list.length
                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        })
                    }
                },
            })
        </script>



        </html>