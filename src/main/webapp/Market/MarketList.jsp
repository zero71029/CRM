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
                    <div class="col-md-11">
                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market.jsp'">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>

                                <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                <label class="btn btn-outline-primary state2" for="btncheck2" onclick="sta()">刪除</label>
                                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck3"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/MarketList'">處理中</label>

                                <input type="checkbox" class="btn-check" id="btncheck4" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck4"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/CloseMarket'">結案</label>
                            </div>
                        </div>
                        <!-- <%-- 抬頭搜索--%> -->
                        <div class="row ">
                            <div class="col-lg-5">
                                <form action="${pageContext.request.contextPath}/Market/selectMarket" method="post">
                                    <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                        <input type="text" class="form-control" placeholder=" 名稱  or 客戶 or 聯絡人or 負責人"
                                            aria-label="Recipient's username" aria-describedby="button-addon2"
                                            name="name">
                                        <button class="btn btn-outline-secondary" type="submit"
                                            id="selectProduct">搜索</button>
                                    </div>
                                </form>
                            </div>
                            <div class="col-lg-6 ">
                                <button class="btn btn-primary me-md-2" type="button" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">搜索</button>
                            </div>
                            <div class="col-lg-6 "></div>
                        </div>

                        <!-- <%-- 中間主體--%> -->



                        <table class="Table table-striped orderTable">
                            <tr>
                                <td><input type="checkbox" id="activity"></td>
                                <td>名稱</td>
                                <td>客戶</td>
                                <td>負責人</td>
                                <td>類型</td>
                                <td>階段</td>
                                <td>機率</td>
                                <td>開始時間</td>
                                <td>終止時間</td>
                            </tr>
                            <c:if test="${not empty list}">
                                <c:forEach varStatus="loop" begin="0" end="${list.size()-1}" items="${list}" var="s">
                                    <tr class="item">
                                        <td><input type="checkbox" value="${s.marketid}" name="mak"></td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.name}</td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.client}</td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.user}</td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.type}</td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.stage}</td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.clinch}</td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.createtime}</td>
                                        <td
                                            onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                            ${s.endtime}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>

                    </div>
                </div>
            </div>
            <!-- 滑塊 -->
            <div class="offcanvas offcanvas-end show" tabindex="0" id="offcanvasRight"
                aria-labelledby="offcanvasRightLabel" style="width: 300px;">
                <div class="offcanvas-header">
                    <h5 id="offcanvasRightLabel">搜索</h5>
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                        aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <div class="accordion accordion-flush" id="accordionFlushExample">
                        <!-- 負責人 -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingOne">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseOne" aria-expanded="false"
                                    aria-controls="flush-collapseOne">
                                    負責人
                                </button>
                            </h2>
                            <div id="flush-collapseOne" class="accordion-collapse collapse"
                                aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    <ul class=" ">
                                        <c:if test="${not empty admin}">
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                items="${admin}" var="s">
                                                <li><a class=""
                                                        href="${pageContext.request.contextPath}/Market/selectMarket/${s.name}">${s.name}</a>
                                                </li>
                                            </c:forEach>
                                        </c:if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- 建立日期 -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingTwo">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseTwo" aria-expanded="false"
                                    aria-controls="flush-collapseTwo">
                                    建立日期
                                </button>
                            </h2>
                            <div id="flush-collapseTwo" class="accordion-collapse collapse"
                                aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    <form action="${pageContext.request.contextPath}/Market/selectDate" method="post">
                                        <input type="text" class="form-control" id="from" name="from" readonly required>
                                        到
                                        <input type="text" class="form-control" id="to" name="to" required readonly>
                                        <input type="submit" value="送出">
                                    </form>
                                </div>
                            </div>
                            <script>
                                $(function () {
                                    $("#from").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: "yy-mm-dd"
                                    });
                                    $("#to").datepicker({
                                        changeMonth: true,
                                        changeYear: true,
                                        dateFormat: "yy-mm-dd"
                                    });
                                });
                            </script>
                        </div>
                        <!-- 機會名稱-->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#flush-collapseThree" aria-expanded="false"
                                    aria-controls="flush-collapseThree">
                                    機會名稱
                                </button>
                            </h2>
                            <div id="flush-collapseThree" class="accordion-collapse collapse"
                                aria-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    <form action="${pageContext.request.contextPath}/Market/selectMarket" method="post">
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" placeholder=""
                                                aria-label="Recipient's username" aria-describedby="button-addon2"
                                                name="name">
                                            <button class="btn btn-outline-secondary" type="submit"
                                                id="selectProduct">搜索</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!--  客戶-->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#i4" aria-expanded="false" aria-controls="flush-collapseThree">
                                    客戶
                                </button>
                            </h2>
                            <div id="i4" class="accordion-collapse collapse" aria-labelledby="flush-headingThree"
                                data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    <form action="${pageContext.request.contextPath}/Market/selectMarket" method="post">
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" placeholder=""
                                                aria-label="Recipient's username" aria-describedby="button-addon2"
                                                name="name" list="company">
                                            <button class="btn btn-outline-secondary" type="submit"
                                                id="selectProduct">搜索</button>
                                            <datalist id="company">
                                                <c:if test="${not empty client}">
                                                    <c:forEach varStatus="loop" begin="0" end="${client.size()-1}"
                                                        items="${client}" var="s">
                                                        <option value="${s.name}">
                                                    </c:forEach>
                                                </c:if>
                                            </datalist>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- 狀態-->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#i5" aria-expanded="false" aria-controls="flush-collapseThree">
                                    狀態
                                </button>
                            </h2>
                            <div id="i5" class="accordion-collapse collapse" aria-labelledby="flush-headingThree"
                                data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    <ul class=" ">
                                        <li><a href="${pageContext.request.contextPath}/Market/selectStage/尚未處理">尚未處理</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Market/selectStage/需求確認">需求確認</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Market/selectStage/聯繫中">聯繫中</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Market/selectStage/處理中">處理中</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Market/selectStage/已報價">已報價</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Market/selectStage/成功結案">成功結案</a></li>
                                        <li><a href="${pageContext.request.contextPath}/Market/selectStage/失敗結案">失敗結案</a></li>

                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!--  聯絡人-->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#i6" aria-expanded="false" aria-controls="flush-collapseThree">
                                   聯絡人
                                </button>
                            </h2>
                            <div id="i6" class="accordion-collapse collapse" aria-labelledby="flush-headingThree"
                                data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    <form action="${pageContext.request.contextPath}/Market/selectMarket" method="post">
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" placeholder=""
                                                aria-label="Recipient's username" aria-describedby="button-addon2"
                                                name="name">
                                            <button class="btn btn-outline-secondary" type="submit"
                                                id="selectProduct">搜索</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!--  XXXXX-->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#i7" aria-expanded="false" aria-controls="flush-collapseThree">
                                    XXXXX
                                </button>
                            </h2>
                            <div id="i7" class="accordion-collapse collapse" aria-labelledby="flush-headingThree"
                                data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    ke itf how this would look in a real-world application.
                                </div>
                            </div>
                        </div>
                        <!--  XXXXX-->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingThree">
                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#i8" aria-expanded="false" aria-controls="flush-collapseThree">
                                    XXXXX
                                </button>
                            </h2>
                            <div id="i8" class="accordion-collapse collapse" aria-labelledby="flush-headingThree"
                                data-bs-parent="#accordionFlushExample">
                                <div class="accordion-body">
                                    ke itf how this would look in a real-world application.
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </body>
        <script>
            $(".market").show();
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
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/delMarket', //接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/Market/MarketList";
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