<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">

            <!-- bootstrap的CSS、JS樣式放這裡  -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css">
            <!-- <%-- jQuery放這裡 --%> -->
            <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>
                .item:hover {
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
                    <div class="col-lg-11">
                        <div class="row ">
                            <div class="col-md-11">
                                <!-- <%-- 抬頭按鈕--%> -->
                                <div class="row">
                                    <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                        <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/system/billboard'">
                                        <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>

                                        <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                        <label class="btn btn-outline-primary state2" for="btncheck2"
                                            onclick="sta()">刪除</label>

                                        <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                        <label class="btn btn-outline-primary" for="btncheck3"
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/system/OffShelf'">封存訊息</label>
                                    </div>
                                </div>


                                <div class="row">
                                    <!-- 分頁 -->
                                    <c:if test="${not empty param.pag}">
                                        <div class="col-lg-3">
                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination">
                                                    <!-- 首頁 -->
                                                    <c:if test="${param.pag > 1}">
                                                        <li class="page-item"><a class="page-link"
                                                                href="${pageContext.request.contextPath}/system/billboardList?pag=1">首頁</a>
                                                        </li>
                                                        <li class="page-item"><a class="page-link"
                                                                href="${pageContext.request.contextPath}/system/billboardList?pag=${param.pag<=1?1:param.pag-1}">←</a>
                                                        </li>
                                                    </c:if>

                                                    <!-- 如果 pag < 2   ,    pag> max-2 -->
                                                    <c:forEach varStatus="loop"
                                                        begin="${param.pag-2 <1 ? 1:param.pag-2}"
                                                        end="${param.pag+2 >TotalPages ? TotalPages :param.pag+2}">
                                                        <li
                                                            class='page-item      ${param.pag == loop.index ? "active ":""}         '>
                                                            <a class="page-link"
                                                                href="${pageContext.request.contextPath}/system/billboardList?pag=${loop.index}">${loop.index}</a>
                                                        </li>

                                                    </c:forEach>

                                                    <c:if test="${param.pag != TotalPages}">
                                                        <li class="page-item"><a class="page-link"
                                                                href='${pageContext.request.contextPath}/system/billboardList?pag=${param.pag >= TotalPages?TotalPages: param.pag+1}'>→</a>
                                                        </li>
                                                        <li class="page-item"><a class="page-link"
                                                                href='${pageContext.request.contextPath}/system/billboardList?pag=${TotalPages}'>尾頁</a>
                                                        </li>
                                                    </c:if>
                                                </ul>
                                            </nav>
                                        </div>
                                    </c:if>
                                    <!-- 分頁 ////////////////////-->
                                    <!-- <%-- 抬頭搜索--%> -->
                                    <div class="col-lg-3" style="padding: 0%;">
                                        <form action="${pageContext.request.contextPath}/system/selectBillboard"
                                            method="post">
                                            <div class="input-group mb-3" style="width: 95%; ">
                                                <input type="text" class="form-control" placeholder="主題 or 發佈者 "
                                                    aria-label="Recipient's username" aria-describedby="button-addon2"
                                                    name="search">
                                                <button class="btn btn-outline-secondary" type="submit"
                                                    id="selectProduct">搜索</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="col-lg-1" style="padding: 0%;">
                                        <form action="${pageContext.request.contextPath}/system/selectBillboard"
                                            method="post">
                                            <div class="input-group mb-3">
                                                <input type="hidden" class="form-control" value="${user.name}"
                                                    aria-label="Recipient's username" aria-describedby="button-addon2"
                                                    name="search">
                                                <button class="btn btn-outline-secondary" type="submit"
                                                    id="selectProduct">我的發文</button>
                                            </div>
                                        </form>
                                    </div>






                                </div>
                                <!-- <%-- 中間主體--%> -->


                                <table class="Table table-striped orderTable">
                                    <tr>
                                        <td><input type="checkbox" id="activity"></td>
                                        <td>編號</td>
                                        <td></td>
                                        <td>主題</td>
                                        <td>發佈者</td>
                                        <td>狀態</td>
                                        <td>日期</td>
                                    </tr>
                                    <c:if test="${not empty list}">
                                        <c:forEach varStatus="loop" begin="0" end="${list.size()-1}" items="${list}"
                                            var="s">
                                            <tr class="item">
                                                <!--checkbox  -->
                                                <td><input type="checkbox" value="${s.billboardid}" name="mak"></td>
                                                <!--編號  -->
                                                <td style="cursor: pointer;"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/billboard/${s.billboardid}'">
                                                    ${s.billboardid}</td>
                                                <!-- 置頂 -->
                                                <td style="color: red;cursor: pointer;"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/billboard/${s.billboardid}'">
                                                    ${s.top}</td>
                                                <td style="cursor: pointer;"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/billboard/${s.billboardid}'">
                                                    <!-- 如果 .......就是 個人置頂 -->
                                                    <c:if test="${not empty user.top}">
                                                        <c:forEach varStatus="loop" begin="0" end="${user.top.size()-1}"
                                                            items="${user.top}" var="top">
                                                            <span style="color: red;">
                                                                <c:if test="${top.billboardid == s.billboardid}">
                                                                    <img src="${pageContext.request.contextPath}/img/topA.png"
                                                                        alt="">
                                                                </c:if>
                                                            </span>
                                                        </c:forEach>
                                                    </c:if>
                                                    <!-- 個人置頂/////////////////////////////////// -->
                                                    <!--  主題-->
                                                    ${s.theme}
                                                    <!-- 有附件 -->
                                                    <span style="color: #569b92;"> ${empty s.file?"":"📎"}</span>
                                                </td>
                                                <td> ${s.user}</td>
                                                <td> ${s.state}</td>
                                                <td> ${s.createtime}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            $(".system").show();
            // 勾選單項
            var $all = $("input[name=mak]");
            $("input[type=checkbox][name=mak]").change(function () {
                var $zx = $("input[name=mak]:checked");
                $("#activity").prop("checked", $zx.length == $all.length);
            });
            // 勾選全部
            $("#activity").change(function () {
                $all.prop("checked", this.checked);
            });
            //  刪除按鈕
            function sta() {

                var $zx = $("input[name=mak]:checked");
                if ($zx.length == 0) {
                    alert("須勾選要刪除項目");
                } else {
                    if (confirm("警告 ! 確定修改?")) {
                        var parm = "";
                        for (var a = 0; a < $zx.length; a++) {
                            parm += "id=" + $($zx[a]).val();
                            if (a < $zx.length - 1) parm += "&";
                        }
                        console.log(parm);
                        $.ajax({
                            url: '${pageContext.request.contextPath}/system/delBillboard',//接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/system/billboardList?pag=1";
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                }

            }

        </script>


        </html>