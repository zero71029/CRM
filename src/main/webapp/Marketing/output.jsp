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
                                        <!--  -->
                                        <div class="col-md-2">
                                            產業 <br>
                                            <el-checkbox v-model="checkAll" @change="industryCheckAllChange">全选
                                            </el-checkbox>
                                            <div style="margin: 15px 0;"></div>
                                            <el-checkbox-group v-model="industry" @change="industryChange">
                                                <!-- <el-checkbox  label="尚未處理" :key="尚未處理">
                                                    尚未處理</el-checkbox> -->
                                                <div class="row " v-for="city in cities" :key="city">
                                                    <el-checkbox :label="city">
                                                        {{city}}</el-checkbox>
                                                </div>
                                            </el-checkbox-group>
                                        </div>
                                        <!--  -->
                                        <div class="col-md-2">
                                            詢問過 <br>
                                            <el-checkbox v-model="producttypeAll" @change="producttypeCheckAllChange">全选
                                            </el-checkbox>
                                            <div style="margin: 15px 0;"></div>
                                            <el-checkbox-group v-model="producttype" @change="producttypeChange">
                                                <div class="row " v-for="p in products" :key="p">
                                                    <el-checkbox :label="p">
                                                        {{p}}</el-checkbox>
                                                </div>
                                            </el-checkbox-group>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row ">
                                <div class="col-md-12 ">
                                    <hr>
                                    <div class="outfile"> xxxxxxxx</div>
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




            const cityOptions = ['尚未分類',
                <c:forEach varStatus="loop" begin="0" end="${library.size()-1}" items="${library}" var="s">
                    <c:if test='${s.librarygroup == "MarketType"}'>
                        '${s.libraryoption}',
                    </c:if>
                </c:forEach>
            ];
            const productOptions = [
                <c:forEach varStatus="loop" begin="0" end="${library.size()-1}" items="${library}" var="s">
                    <c:if test='${s.librarygroup == "producttype"}'>
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
                        producttypeAll: false,
                        producttype: [],
                        products: productOptions,

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
                    producttypeCheckAllChange(val) {
                        this.producttype = val ? productOptions : [];
                    },
                    producttypeChange(value) {
                        let checkedCount = value.length;
                        this.producttypeAll = checkedCount === this.products.length;
                    },
                    search() {
                        const data = JSON.stringify({ "industry": this.industry, "producttype": this.producttype });
                        $.ajax({
                            url: "${pageContext.request.contextPath}/Marketing/search",
                            // dataType: 'json',
                            type: 'POST',
                            contentType: "application/json; charset=UTF-8",
                            data: data,
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: response => (
                                console.log(response, "response"),
                                $(".outfile").empty(),
                                $(".outfile").append("<a href='${pageContext.request.contextPath}/file/" + response + "' >" + response + "</a>"),
                                this.$message({
                                    message: '輸出成功',
                                    type: 'success'
                                })
                            ),
                            error: function (returndata) {
                                console.log("錯誤");
                                console.log(returndata);
                            }
                    });
                    }
                },
            })
        </script>

        </html>