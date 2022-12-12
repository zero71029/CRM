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
                    <div class="col-md-11 app" v-cloak>
                        <div class="row ">
                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-12">                       
                                        <el-button type="success" plain @click="ClearCache" size="small" style="margin: 10px;">清空緩存</el-button>
                                    </div>
                                    <hr>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12">
                                        <div v-for="(s, index) in CacheList" :key="index">
                                         [{{index}}]   {{s}}
                                        </div>
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
                        CacheList:[],
                    }
                },
                created() {
                    $.ajax({
                            url: '${pageContext.request.contextPath}/zero/outCache',
                            type: 'get',
                            success: response => {
                                this.CacheList = response;                              
                            },
                            error: function (returndata) {
                                console.log(returndata.responseJSON.message);
                            }
                        });
                },
                methods: {
                    ClearCache(){
                        $.ajax({
                            url: '${pageContext.request.contextPath}/zero/ClearCache',
                            type: 'get',
                            success: response => {
                                this.$message.success(response); 
                                this.CacheList = [];
                            },
                            error: function (returndata) {
                                console.log(returndata.responseJSON.message);
                            }
                        });
                    }
                },
            })
        </script>
        </html>