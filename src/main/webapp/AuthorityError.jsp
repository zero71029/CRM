<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <title>${user.mail.size() > 0 ? ddd:CRM}</title>

        </head>



        <style>
            .body {
                background-color: white;
                width: 100%;
            }
        </style>

        <body>
            <!-- <%-- 插入側邊欄--%> -->
            <jsp:include page="/Sidebar.jsp"></jsp:include>
            <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->

            <div class="col-lg-11">
                <div class="row ">
                    <div class="col-lg-11">
                        <!-- 導覽列 -->
                        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="text-align: left;">
                            <div class="container-fluid">
                                <a class="navbar-brand" href="${pageContext.request.contextPath}/">管理討論平台</a>
                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                    aria-expanded="false" aria-label="Toggle navigation">
                                    <span class="navbar-toggler-icon"></span>
                                </button>

                                <div class="collapse navbar-collapse " id="navbarSupportedContent">
                                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                一般公告
                                            </a>
                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                style="text-align: left;">
                                                <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}"
                                                    items="${billboardgroup}" var="s">
                                                    <c:if test='${s.billboardgroup == "一般公告"}'>
                                                        <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                業務
                                            </a>
                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                style="text-align: left;">
                                                <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}"
                                                    items="${billboardgroup}" var="s">
                                                    <c:if test='${s.billboardgroup == "業務"}'>
                                                        <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                採購
                                            </a>
                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                style="text-align: left;">
                                                <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}"
                                                    items="${billboardgroup}" var="s">
                                                    <c:if test='${s.billboardgroup == "採購"}'>
                                                        <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                生產
                                            </a>
                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                style="text-align: left;">
                                                <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}"
                                                    items="${billboardgroup}" var="s">
                                                    <c:if test='${s.billboardgroup == "生產"}'>
                                                        <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>

                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                研發
                                            </a>
                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                style="text-align: left;">
                                                <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}"
                                                    items="${billboardgroup}" var="s">
                                                    <c:if test='${s.billboardgroup == "研發"}'>
                                                        <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                財務
                                            </a>
                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                style="text-align: left;">
                                                <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}"
                                                    items="${billboardgroup}" var="s">
                                                    <c:if test='${s.billboardgroup == "財務"}'>
                                                        <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                        <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                行銷
                                            </a>
                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                style="text-align: left;">
                                                <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}"
                                                    items="${billboardgroup}" var="s">
                                                    <c:if test='${s.billboardgroup == "行銷"}'>
                                                        <li><a class="dropdown-item"
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </ul>
                                    <!-- 小鈴鐺 -->
                                    <c:if test="${not empty user}">
                                        <div style="position: relative; cursor: pointer;" onclick="sh()">
                                            <img src="${pageContext.request.contextPath}/img/bell.png" alt="未讀">
                                        </div>
                                        <div style=" color: red;  font-weight:bold; cursor: pointer;">
                                            <!-- @ -->
                                            <script>var b = 0;</script>
                                            <c:if test="${not empty user.advice}">
                                                <c:forEach varStatus="loop" begin="0" end="${user.advice.size()-1}"
                                                    items="${user.advice}" var="ad">
                                                    <script>
                                                        var a = ${ ad.reply };
                                                        b += a;
                                                    </script>
                                                </c:forEach>
                                                <span onclick="sh()" class="aaa"></span>
                                            </c:if>


                                            <!-- 未讀 -->
                                            <c:if test="${not empty user.mail}">
                                                <span onclick="showUnread()">未讀:${user.mail.size()}</span>
                                            </c:if>
                                        </div>


                                        <c:if test="${not empty user.advice}">

                                            <script>if (b > 0) $(".aaa").append("@:" + b + "/");</script>
                                        </c:if>
                                    </c:if>
                                    <!-- search -->
                                    <form class="d-flex" method="post"
                                        action="${pageContext.request.contextPath}/selectBillboard">
                                        <input class="form-control me-2" type="search" placeholder="主題 or 發佈者"
                                            aria-label="Search" name="search">
                                        <button class="btn btn-outline-success" type="submit">Search</button>
                                    </form>

                                </div>
                            </div>
                        </nav>
                        <!-- 導覽列/////////////////////////////////////////// -->
                    </div>
                </div>
                <div class="row ">
                    <h1>抱歉,沒有權限</h1>
                </div>
            </div>
            </div>
            </div>
        </body>
        <script>
            window.setTimeout(function () {
                location.href = '${pageContext.request.contextPath}/';
            }, 60000);
        </script>

        </html>