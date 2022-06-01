<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
                                    <div class="col-md-12">
                                        <div class="row ">
                                            <div class="col-md-12">
                                                <el-button type="primary" @click="search">搜索</el-button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-md-1">
                                            產業 <br>
                                            <el-checkbox v-model="checkAll" @change="industryCheckAllChange">全选
                                            </el-checkbox>
                                            <div style="margin: 15px 0;"></div>
                                            <el-checkbox-group v-model="industry" @change="industryChange">
                                                <el-checkbox v-for="city in cities" :label="city" :key="city">
                                                    {{city}}</el-checkbox>
                                            </el-checkbox-group>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row ">
                                <div class="col-md-12">
                                    <hr>
                                    xxxxxxxx
                                    <hr>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>










        </body>
        <script>
            // for (var a = 0; a < $zx.length; a++) {
            //     parm += "id=" + $($zx[a]).val();
            //     if (a < $zx.length - 1) parm += "&";
            // }




            const cityOptions = [
                <c:forEach varStatus="loop" begin="0" end="${library.size()-1}" items="${library}" var="s">
                    <c:if test='${s.librarygroup == "MarketType"}'>
                        '${s.libraryoption}',
                    </c:if>
                </c:forEach>
            ];
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        checkAll: false,
                        industry: [],
                        cities: cityOptions,
                        isIndeterminate: true,
                        list: [],

                    }
                },
                created() {

                },
                methods: {
                    industryCheckAllChange(val) {
                        this.industry = val ? cityOptions : [];
                        this.isIndeterminate = false;
                    },
                    industryChange(value) {
                        let checkedCount = value.length;
                        this.checkAll = checkedCount === this.cities.length;
                        this.isIndeterminate = checkedCount > 0 && checkedCount < this.cities.length;
                    },
                    search() {
const data =JSON.stringify( { "industry": this.industry });
$.ajax({
    url: "${pageContext.request.contextPath}/Marketing/search",
    dataType: 'json',
    type: 'POST',
    contentType: "application/json; charset=UTF-8",
    data: data,
    async: false,//同步請求
    cache: false,//不快取頁面
    success: (response => (
        console.log(response, "response")
    )),
    error: function (returndata) {
        console.log(returndata);
    }
});
                    }
                },
            })
        </script>

        </html>