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

                .laboratory {
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
                                <div class="row ">
                                    <div class="col-md-12 text-center">
                                        <div class="collapse navbar-collapse " id="navbarSupportedContent">
                                            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        一般公告
                                                    </a>
                                                    <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                        style="text-align: left;">
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${billboardgroup.size()-1}" items="${billboardgroup}"
                                                            var="s">
                                                            <c:if test='${s.billboardgroup == "一般公告"}'>
                                                                <li><a class="dropdown-item"
                                                                        href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                                </li>
                                                            </c:if>
                                                        </c:forEach>
                                                    </ul>
                                                </li>

 
                                            <!-- search -->
                                            <form class="d-flex" method="post"
                                                action="${pageContext.request.contextPath}/selectBillboard">
                                                <input class="form-control me-2" type="search" placeholder="主題 or 發佈者"
                                                    aria-label="Search" name="search">
                                                <button class="btn btn-outline-success" type="submit">Search</button>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12">操作列表 新增 刪除 圖書館</div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12">資料</div>
                                    <div class="col-md-12 text-center">
                                        <el-pagination @size-change="handleSizeChange"
                                            @current-change="handleCurrentChange" :current-page="currentPage"
                                            :page-sizes="[10, 20, 30, 40]" :pageSize="10"
                                            layout="total, sizes, prev, pager, next, jumper" :total="total">
                                        </el-pagination>
                                    </div>
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
                        currentPage: 1,
                        total: 400,
                        pageSize: 10,
                        activeIndex: '1',
                    }
                },
                created() {

                },
                methods: {
                    handleSelect(key, keyPath) {
                        console.log(key, keyPath);
                    },
                    handleSizeChange() {

                    },
                    handleCurrentChange() {

                    }
                },
            })
        </script>




        </html>