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
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/newAdmin.jsp'">
                                        <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>

                                        <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                        <label class="btn btn-outline-primary state2" for="btncheck2"
                                            onclick="sta()">刪除</label>

                                        <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                        <label class="btn btn-outline-primary" for="btncheck3" onclick="">XXX</label>
                                    </div>
                                </div> <!-- <%-- 抬頭搜索--%> -->
                                <div class="col-lg-5">
                                    <form action="${pageContext.request.contextPath}/CRM/selectAdmin" method="post">
                                        <!-- <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                    <input type="text" class="form-control" placeholder=" 客戶名稱 or 公司 or 負責人 "
                                        aria-label="Recipient's username" aria-describedby="button-addon2" name="name">
                                    <button class="btn btn-outline-secondary" type="submit"
                                        id="selectProduct">搜索</button>
                                </div> -->
                                    </form>
                                </div>

                                <!-- <%-- 中間主體--%> -->
                                <table class="Table table-striped orderTable">
                                    <tr>
                                        <td><input type="checkbox" id="activity"></td>

                                        <td>名稱</td>
                                        <td><a href="javascript:so('department')">部門</a>
                                        </td>
                                        <td><a href="javascript:so('position')">職稱</a>
                                        <td>電話</td>
                                        <td><a
                                                href="${pageContext.request.contextPath}/system/adminList/dutyDay">到職日</a>
                                        <td>在職狀態</td>
                                    </tr>
                                    <c:if test="${not empty list}">
                                        <c:forEach varStatus="loop" begin="0" end="${list.size()-1}" items="${list}"
                                            var="s">
                                            <tr class="item">
                                                <td><input type="checkbox" value="${s.adminid}" name="mak"></td>

                                                <td class="admin${loop.index}"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/adminDetail/${s.adminid}'">
                                                    ${s.name}</td>
                                                <td class="department${loop.index}"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/adminDetail/${s.adminid}'">
                                                    ${s.department}</td>
                                                <td class="position${loop.index}"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/adminDetail/${s.adminid}'">
                                                    ${s.position}</td>

                                                <td
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/adminDetail/${s.adminid}'">
                                                    ${s.phone}</td>
                                                <td class="dutyDay${loop.index}"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/adminDetail/${s.adminid}'">
                                                    ${s.dutyDay}</td>
                                                <td
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/system/adminDetail/${s.adminid}'">
                                                    ${s.state}</td>
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
                            url: '${pageContext.request.contextPath}/system/delAdmin',//接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/system/adminList/adminid";
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                }
            }

            // <td><a href="${pageContext.request.contextPath}/system/adminList/department">部門</a>

            function so(men) {
                console.log("sss");
                console.log($("." + men + "0").text().trim());
                location.href = "${pageContext.request.contextPath}/system/adminList/" + men + "/" + $("." + men + "0").text().trim();
            }


        </script>


        </html>