<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">
        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

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

                .CustomerOut {
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
                                    <div class="col-md-12">
                                        <div class="row ">
                                            <div class="col-md-2">
                                                <el-button type="primary" @click="search">搜索</el-button>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="outfile"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <br><br>
                                    <div class="row ">
                                        <!--  -->
                                        <div class="col-md-2">
                                            產業 <br>
                                            <el-date-picker v-model="indate" type="daterange" align="right"
                                                unlink-panels range-separator="到" start-placeholder="開始日期"
                                                end-placeholder="結束日期" :picker-options="pickerOptions"
                                                value-format="yyyy-MM-dd">
                                            </el-date-picker>

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
            $(".marketing").show();

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
            const SourceOptions = ['其他',
                <c:forEach varStatus="loop" begin="0" end="${library.size()-1}" items="${library}" var="s">
                    <c:if test='${s.librarygroup == "MarketSource"}'>
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
                        SourceAll: false,
                        Source: [],
                        SourceOptions: SourceOptions,
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
                        indate: [],

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
                    SourceCheckAllChange(val) {
                        this.Source = val ? SourceOptions : [];
                    },
                    SourceChange(value) {
                        let checkedCount = value.length;
                        this.SourceAll = checkedCount === this.SourceOptions.length;
                    },
                    search() {                     
                        if (this.indate == "") {
                            this.indate[0] = "";
                            this.indate[1] = "";
                        }
                        const data = JSON.stringify({
                            "industry": this.industry,
                            "producttype": this.producttype,
                            "Source": this.Source,
                            "start": this.indate[0],
                            "end": this.indate[1]
                        });
                        $.ajax({
                            url: "${pageContext.request.contextPath}/Marketing/SearchCustomerOut",
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