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
            <title>業務接案</title>
            <style>
                .app {
                    background-color: #eee;
                }

                [v-cloak] {
                    display: none;
                }
                .BusinessCase {
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
                            <div class="col-md-12"><br>
                                <!-- 日期選擇器 -->
                                <el-date-picker v-model="inDay" type="daterange" align="right" unlink-panels
                                    range-separator="到" start-placeholder="開始日期" end-placeholder="結束日期"
                                    :picker-options="pickerOptions" value-format="yyyy-MM-dd">
                                </el-date-picker>
                                <input type="submit" value="送出" @click="selectCompany">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-12" v-for="(s, index) in list" :key="index">
                                        <br><br>
                                        <h5>{{s.name}} 接案數:{{s.接案數}}</h5>
                                        
                                        <div class="row ">
                                            <div class="col-md-4">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <table
                                                            class="table table-bordered align-middle border border-dark">
                                                            <tr>
                                                                <td rowspan="2"> <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=1&receives=3'+ddd+s.name" target="_blank" >成功數:{{s.成功數}}  ({{zero(s.成功數,s.接案數) }}%)</a>    </td>
                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=1&receives=1'+ddd+s.name" target="_blank" >領取成功:{{s.領取成功}}  ({{ zero(s.領取成功,s.接案數) }}%)</a></td>
                                                            </tr>
                                                            <tr>

                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=1&receives=2'+ddd+s.name" target="_blank" >分配成功:{{s.分配成功}}  ({{ zero(s.分配成功,s.接案數) }}%)</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="2"><a  :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=2&receives=3'+ddd+s.name" target="_blank" >失敗數:{{s.失敗數}}  ({{ zero(s.失敗數,s.接案數)  }}%)</a>
                                                                </td>
                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=2&receives=1'+ddd+s.name" target="_blank" >領取失敗:{{s.領取失敗}}  ({{ zero(s.領取失敗,s.接案數)  }}%)</a></td>
                                                            </tr>
                                                            <tr>

                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=2&receives=2'+ddd+s.name" target="_blank" >分配失敗:{{s.分配失敗}}  ({{ zero(s.分配失敗,s.接案數)  }}%)</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="2"><a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=3&receives=3'+ddd+s.name" target="_blank" >未結案:{{s.未結案}}  ({{ zero(s.未結案,s.接案數) }}%)</a>
                                                                </td>
                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=3&receives=1'+ddd+s.name" target="_blank" >領取未結案:{{s.領取未結案}}  ({{  zero(s.領取未結案,s.接案數)   }}%)</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=3&receives=2'+ddd+s.name" target="_blank" >分配未結案:{{s.分配未結案}}  ({{ zero(s.分配未結案,s.接案數)   }}%)</a></td>
                                                            </tr>

                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <table
                                                            class="table table-bordered align-middle border border-dark">
                                                            <tr>
                                                                <td rowspan="3"><a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=4&receives=1'+ddd+s.name" target="_blank" >領取數:{{s.領取數}}  ({{ zero(s.領取數,s.接案數)   }}%)</a>
                                                                </td>
                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=1&receives=1'+ddd+s.name" target="_blank" >領取成功:{{s.領取成功}}  ({{ zero(s.領取成功,s.接案數)   }}%)</a></td>
                                                            </tr>
                                                            <tr>

                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=2&receives=1'+ddd+s.name" target="_blank" > 領取失敗:{{s.領取失敗}}  ({{ zero(s.領取失敗,s.接案數)   }}%)</a></td>
                                                            </tr>
                                                            <tr>

                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=3&receives=1'+ddd+s.name" target="_blank" >領取未結案:{{s.領取未結案}}  ({{ zero(s.領取未結案,s.接案數)   }}%)</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td rowspan="3"><a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=4&receives=2'+ddd+s.name" target="_blank" >分配數:{{s.分配數}}  ({{ zero(s.分配數,s.接案數)   }}%)</a>
                                                                </td>
                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=1&receives=2'+ddd+s.name" target="_blank" >分配成功:{{s.分配成功}}  ({{ zero(s.分配成功,s.接案數)   }}%)</a></td>
                                                            </tr>
                                                            <tr>
                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=2&receives=2'+ddd+s.name" target="_blank" >分配失敗:{{s.分配失敗}}  ({{ zero(s.分配失敗,s.接案數)   }}%)</a></td>

                                                            </tr>
                                                            <tr>

                                                                <td            > <a :href="'${pageContext.request.contextPath}/statistic/BusinessDetail.jsp?state=3&receives=2'+ddd+s.name" target="_blank" >分配未結案:{{s.分配未結案}}  ({{ zero(s.分配未結案,s.接案數)   }}%)</a></td>
                                                            </tr>

                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
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
                        inDay: [],
                        ddd:"&startDay=&endDay=&user=",
                        list: [],
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
                        url: '${pageContext.request.contextPath}/statistic/BusinessCase?startDay=&endDay=',
                        type: 'POST',
                        async: false,
                        cache: false,
                        success: response => {
                            this.list = response;

                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                methods: {
                    selectCompany() {
                        if (this.inDay == "") {//沒輸入日期
                            this.inDay[0] = "";
                            this.inDay[1] = "";
                        }
                        $.ajax({
                            url: '${pageContext.request.contextPath}/statistic/BusinessCase?startDay=' + this.inDay[0] + '&endDay=' + this.inDay[1],
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: response => {
                                this.list = response;

                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                        this.ddd = '&startDay=' + this.inDay[0] + '&endDay=' + this.inDay[1] +'&user=';
                    },
                    zero(v1,v2){
                     return   parseInt(v1*100/v2);
                     
                    }
                },
            })
        </script>




        </html>