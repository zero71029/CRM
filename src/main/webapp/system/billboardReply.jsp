<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <title>CRM客戶管理系統</title>
        </head>
        <style>
            div {
                /* border: 1px solid black; */
            }

            .cell {
                border: 1px solid #8e8e8e;
                font-size: 16px;
            }

            .cellbackgroud {
                background-color: #CCC;
            }

            .cellFrom {
                border: 0px solid black;
                /* width: 33%; */
            }

            .error {
                color: red;
            }
        </style>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-lg-11">
                        <div class="row ">
                            <div class="col-md-8">
                                <!-- <%-- 中間主體--%> -->
                                <br>
                                <br>
                                <form action="" method="post" id="myform" style="line-height: 2rem;" class="row g-3"
                                    novalidate c>
                                    <div class="col-md-1"></div>
                                    <div class="col-md-11">
                                        <input type="hidden" name="billboardid" value="${bean.billboardid}">
                                        <input type="hidden" name="user" value="${user.name}">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <!-- 上一頁 -->
                                                <!-- <a href="#" onclick="self.location=document.referrer;" -->
                                                <a href="#"
                                                    onclick="location.href='${pageContext.request.contextPath}/billboard?pag=1&sort=lastmodified';"
                                                    style="text-decoration: none;">
                                                    <img src="${pageContext.request.contextPath}/img/Pre.png" alt="上一頁">
                                                </a>${bean.bgb.billboardgroup}>${bean.bgb.billboardoption}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-9"
                                                style="background-color: #569b92; border: solid 1px #569b92; position: relative; color: white;font-size: 14px;">
                                                討論區
                                                <!-- 有登入才顯示 -->
                                                <c:if test='${not empty user}'>

                                                    <span style="position: absolute; right: 0%; top: 0%;">

                                                        <c:if test='${bean.user == user.name}'>
                                                            <img src="${pageContext.request.contextPath}/img/ch.png"
                                                                alt="修改"
                                                                onclick="location.href='${pageContext.request.contextPath}/system/billboard/${bean.billboardid}'"
                                                                style="cursor: pointer;" data-bs-toggle="tooltip"
                                                                data-bs-placement="bottom" title="修改">
                                                        </c:if>
                                                        <img src="${pageContext.request.contextPath}/img/copy.png"
                                                            alt="複製" onclick="cop()" style="cursor: pointer;"
                                                            data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                            title="複製">


                                                        <img src="${pageContext.request.contextPath}/img/未釘選-01.png"
                                                            alt="未釘選" onclick="tops()" style="cursor: pointer;"
                                                            data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                            title="追蹤" id="topImg">
                                                        <c:if test='${not empty user.top}'>
                                                            <c:forEach varStatus="loop" begin="0"
                                                                end="${user.top.size()-1}" items="${user.top}"
                                                                var="top">
                                                                <script>
                                                                    var billboardid = ${ top.billboardid };
                                                                    if (billboardid == ${ bean.billboardid }) {
                                                                        $("#topImg").attr("src", "${pageContext.request.contextPath}/img/CCC.png");
                                                                        $("#topImg").attr("title", "取消追蹤");
                                                                    }

                                                                </script>
                                                            </c:forEach>
                                                        </c:if>

                                                        <!-- 有資料才顯示 -->
                                                        <c:set var="i" value="false"></c:set>
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${user.advice.size()}" items="${user.advice}"
                                                            var="advice">
                                                            <!-- 已讀迴圈 -->
                                                            <!-- 登入者  有被@   i == ture -->
                                                            <c:if test="${bean.billboardid == advice.billboardid}">
                                                                <c:set var="i" value="ture"></c:set>
                                                            </c:if>
                                                        </c:forEach>

                                                        <c:set var="m" value="false"></c:set>
                                                        <c:forEach varStatus="loop" begin="0" end="${user.mail.size()}"
                                                            items="${user.mail}" var="mail">
                                                            <!-- 已讀迴圈 -->
                                                            <!-- 登入者  有mail     i == ture -->
                                                            <c:if test="${bean.billboardid == mail.billboardid}">
                                                                <c:set var="m" value="ture"></c:set>
                                                            </c:if>
                                                        </c:forEach>

                                                        <!--  已讀 才顯示 -->
                                                        <c:if test='${m != "ture" }'>

                                                            <img src="${pageContext.request.contextPath}/img/unread.png"
                                                                alt="已讀" data-bs-toggle="tooltip"
                                                                data-bs-placement="bottom" title="已讀">
                                                        </c:if>
                                                        <c:if test='${m == "ture"}'>
                                                            <a
                                                                href="javascript:read(${bean.billboardid},${user.adminid})"><img
                                                                    src="${pageContext.request.contextPath}/img/read.png"
                                                                    alt="已讀點擊" data-bs-toggle="tooltip"
                                                                    data-bs-placement="bottom" title="已讀點擊"></a>
                                                        </c:if>
                                                    </span>
                                                </c:if>

                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-md-1 cell position-relative cellbackgroud"
                                                style="font-size: 14px;">
                                                發佈者</div>
                                            <div class="col-md-8 cell">${bean.user}${bean.remark}</div>
                                        </div>


                                        <div class="row">

                                            <div class="col-md-1 cell position-relative cellbackgroud"
                                                style="font-size: 14px;">
                                                主題</div>
                                            <div class="col-md-8 cell" style="position: relative;">
                                                ${bean.theme}
                                                <span
                                                    style="color: #8e8e8e; position: absolute ;right: 0%;">${bean.lastmodified}</span>

                                            </div>
                                        </div>

                                        <div class="row">

                                            <div class="col-md-1 cell position-relative cellbackgroud"
                                                style="font-size: 14px;">
                                                內容</div>
                                            <div class="col-md-8 cell content" style="word-wrap:break-word;">
                                                ${bean.content}
                                            </div>
                                        </div>
                                        <div class="row">

                                            <div class="col-md-1 cell position-relative cellbackgroud"
                                                style="font-size: 14px;">
                                                標記</div>
                                            <div class="col-md-8 cell content" style="word-wrap:break-word;">&nbsp;
                                                <c:if test="${not empty bean.advice}">
                                                    <c:forEach varStatus="loop" begin="0" end="${bean.advice.size()-1}"
                                                        items="${bean.advice}" var="ad">
                                                        <span class="ad${ad.adviceto}"> ${ad.formname}</span>
                                                        &nbsp;&nbsp;&nbsp;
                                                    </c:forEach>
                                                </c:if>




                                            </div>
                                        </div>

                                    </div>
                                </form>


                                <!-- 回覆內容 -->
                                <style>
                                    .replyA a {
                                        font-size: 14px;
                                        color: #569b92;
                                        text-decoration: none;
                                    }

                                    .replyImg img {
                                        width: 100px;
                                    }
                                </style>
                                <div class="row replyImg">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-11">
                                        <c:if test="${not empty reply}">
                                            <c:forEach varStatus="loop" begin="0" end="${reply.size()-1}"
                                                items="${reply}" var="s">
                                                <div class="row">
                                                    <div class="col-md-9" style=" padding: 0%;">
                                                        <hr style="color: #569b92; opacity: 1;">
                                                    </div>
                                                </div>

                                                <div class="row" style="min-height: 70px;">
                                                    <div class="col-md-1" style="color: #569b92;">
                                                        ${s.name}</div>
                                                    <div class="col-md-8"
                                                        style="position: relative; word-wrap:break-word;">
                                                        ${s.content}
                                                        <c:if test="${s.name == user.name}">
                                                            <form
                                                                action="${pageContext.request.contextPath}/replyChange"
                                                                class="replyText showText${s.replyid}" method="post">
                                                                <textarea name="content" id="" style="width: 100%;"
                                                                    rows="3" maxlength="950">${s.content}</textarea>
                                                                <input type="hidden" name="replyid"
                                                                    value="${s.replyid}">
                                                                <input type="hidden" name="billboardid"
                                                                    value="${s.billboardid}">
                                                                <input type="hidden" name="name" value="${s.name}">
                                                                <button type="submit"
                                                                    style="width: 100%; background-color: #569b92;"
                                                                    class="btn ">修改</button>
                                                            </form>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- 留言的控制 -->
                                                <div class="row replyA" style="font-size: 12;">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-5 "
                                                        style="position: relative; word-wrap:break-word;color: #8e8e8e; ">
                                                        ${s.lastmodified}
                                                    </div>
                                                    <div class="col-md-3 ccc" style="text-align: right;">
                                                        <c:if test="${s.name == user.name}">
                                                            <a
                                                                href="javascript:advice('${s.replyid}')">@</a>&nbsp;&nbsp;&nbsp;
                                                            <a
                                                                href="javascript:replyChange('${s.replyid}')">修改</a>&nbsp;&nbsp;&nbsp;
                                                            <a
                                                                href="javascript:if(confirm('確定刪除'))location.href='${pageContext.request.contextPath}/replyRemove/${s.replyid}'">刪除</a>&nbsp;&nbsp;&nbsp;
                                                        </c:if>
                                                        <c:if test="${not empty user}">
                                                            <a href="javascript:showReplyText('${s.replyid}');">回覆</a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <!-- 留言的附件 -->
                                                <c:if test="${not empty s.file}">
                                                    <c:forEach varStatus="loop" begin="0" end="${s.file.size()-1}"
                                                        items="${s.file}" var="file">
                                                        <div class="row">
                                                            <div class="col-md-1" style="color: #569b92;">
                                                                附件</div>
                                                            <div class="col-md-5 ">
                                                                <a href="${pageContext.request.contextPath}/file/${file.url}"
                                                                    target="_blank">${file.name}</a>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:if>

                                                <!-- 評論 -->
                                                <c:if test="${not empty s.reply}">
                                                    <c:forEach varStatus="loop" begin="0" end="${s.reply.size()-1}"
                                                        items="${s.reply}" var="reply">
                                                        <div class="row">
                                                            <div class="col-md-1"></div>
                                                            <div class="col-md-8 ">
                                                                <div class="row replyA">
                                                                    <hr>
                                                                    <div class="col-md-2 " style="color: #569b92;">
                                                                        ${reply.name}
                                                                    </div>
                                                                    <div class="col-md-7" style="word-wrap:break-word;">
                                                                        ${reply.content}
                                                                    </div>
                                                                    <div class="col-md-3 ">
                                                                        ${reply.lastmodified} <c:if
                                                                            test="${reply.name == user.name}">
                                                                            <a
                                                                                href="javascript:removeReplyreply('${reply.id}')">刪</a>
                                                                        </c:if>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${not empty user}">
                                                    <form action="${pageContext.request.contextPath}/saveReplyreply"
                                                        method="post">
                                                        <div class="row replyreply show${s.replyid}">
                                                            <div class="col-md-1 "></div>
                                                            <div class="col-md-8 ccc">
                                                                <input type="hidden" name="replyid"
                                                                    value="${s.replyid}">
                                                                <input type="hidden" name="name" value="${user.name}">
                                                                <input type="hidden" name="billboardid"
                                                                    value="${bean.billboardid}">
                                                                <div class="input-group mb-3">
                                                                    <input type="text" class="form-control"
                                                                        name="content" placeholder=""
                                                                        aria-label="Recipient's username"
                                                                        aria-describedby="button-addon2" required
                                                                        maxlength="950"
                                                                        style="background-color: #E8e8e8; border: 1px solid #ccc;">
                                                                    <button class="btn  btn-primary" type="submit"
                                                                        id="button-addon2 ">回覆</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                </div>

                                <c:if test="${not empty user}">
                                    <form action="${pageContext.request.contextPath}/saveReply/${uuid}" method="post"
                                        id="formReply" class="row g-3 needs-validation">
                                        <!-- 回覆輸入 -->
                                        <div class="col-md-1"></div>
                                        <div class="col-md-11">
                                            <div class="row">
                                                <div class="col-md-8"
                                                    style="background-color: #569b92; border: solid 1px #569b92;color: white;">
                                                    回覆
                                                </div>
                                                <div class="col-md-1"
                                                    style="background-color: #569b92; border: solid 1px #569b92;color: white;text-align: right;">
                                                    <a href="javascript:upfileToggle()" style="color: white;"
                                                        title="附件">₪</a>
                                                </div>
                                                <div class="col-md-2 ff upDiv">
                                                    <!-- 上傳 -->


                                                    <!--  -->
                                                </div>
                                            </div>
                                            <div class="row fileDiv">
                                                <!-- 後來新增 附件 的地方-->


                                                <!--  -->
                                            </div>
                                            <input type="hidden" name="billboardid" value="${bean.billboardid}">
                                            <input type="hidden" name="name" value="${user.name}">
                                            <div class="row">
                                                <div class="col-md-1 cell cellbackgroud">留言</div>
                                                <div class="col-md-8 cell " style="padding: 0%;">
                                                    <textarea class="" name="content" style="width: 100%; " rows="5"
                                                        required id="replycontent" placeholder=""
                                                        maxlength="950"></textarea>
                                                </div>

                                            </div>
                                            <div class="row">

                                                <div class="col-md-9" style="padding: 0%;">
                                                    <button type="submit"
                                                        style="width: 100%;background-color: #08604f; color: white;"
                                                        class="btn ">留言</button>
                                                </div>
                                            </div>


                                        </div>

                                    </form>

                                </c:if>
                                <br><br>
                                <div class="row"></div>



                            </div>

                            <div class="col-md-4">
                                <br><br><br>

                                <br>
                                <!-- 附件 -->
                                <c:if test="${not empty bean.file}">
                                    <div class="row">
                                        <div class="col-lg-7 cell"
                                            style="background-color : #569b92 ;text-align: center;">附件
                                        </div>
                                    </div>
                                    <c:forEach varStatus="loop" begin="0" end="${bean.file.size()-1}"
                                        items="${bean.file}" var="s">
                                        <c:set var="url" value="${pageContext.request.contextPath}/file/${s.url}">
                                        </c:set>
                                        <div class="row" draggable="true"
                                            ondragstart="event.dataTransfer.setData('text/plain', '<img width=100% src=${url} onerror=errorOne()>')">
                                            <div class="col-md-2 cell position-relative cellbackgroud">附件</div>
                                            <div class="col-lg-5 cell" style="word-wrap: break-word;"><a target="_blank"
                                                    href="${pageContext.request.contextPath}/file/${s.url}">${s.name}</a>
                                            </div>

                                        </div>
                                    </c:forEach>
                                </c:if>
                                <!-- 新訊息 -->
                                <br><br>
                                <!-- <c:if test="${not empty news}">
                            <c:forEach varStatus="loop" begin="0" end="${news.size()-1}" items="${news}" var="s">
                                <a style="color: #08604f; opacity: 100%; text-decoration: none;"
                                    href="${pageContext.request.contextPath}/billboardReply/${s.billboardid}">
                                    <div class="row">

                                        <div class="col-lg-5 "
                                            style="border-bottom: 1px solid black; position: relative; word-wrap:break-word;">
                                            ${s.theme}
                                        </div>
                                        <div class="col-lg-2 " style="border-bottom: 1px solid black;"><img
                                                src="${pageContext.request.contextPath}/img/news.png" alt="取消已讀"></div>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:if> -->
                                <!-- @表單 -->
                                <c:if test="${not empty admin}">
                                    <form class="row"
                                        action="${pageContext.request.contextPath}/saveReplyAdvice/91585f7f09b94d8782eda2820a6170f0"
                                        method="post" id="replyAdvice">
                                        <input type="hidden" name="billboardid" value="${bean.billboardid}">
                                        <div class="col-lg-11 advice" style="border: #08604f 1px solid; padding: 0%;">
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="all">全部: </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group1">生產: </div>
                                            <!-- admin 迴圈 -->
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '生產'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group1" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>
                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group2">採購:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '採購'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group2" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;">國貿:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '國貿'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group2" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group3">研發:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '研發'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group3" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group4">業務:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '業務'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group4" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group5">行銷:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '行銷'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group5" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>

                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group6">財務:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '財務'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group6" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group7">IT:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == 'IT'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group7" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group7">總經理:</div>
                                            <div class="row">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '總經理'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group7" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                            </div>
                                            <div class="row" style="margin: 0%;">
                                                <button type="button" onclick="saveReplyAdvice()"> 標記</button>
                                            </div>
                                        </div>

                                        <input type="hidden" name="adviceto" value="0">
                                    </form>
                                    <script>

                                        var $all = $("input[name='adviceto']");
                                        var $group1 = $(".group1");
                                        var $group2 = $(".group2");
                                        var $group3 = $(".group3");
                                        var $group4 = $(".group4");
                                        var $group5 = $(".group5");
                                        var $group6 = $(".group6");
                                        var $group7 = $(".group7");
                                        // 勾選單項
                                        $("input[name='adviceto']").change(function () {
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $(".group1").change(function () {
                                            var $zx = $(".group1:checked");
                                            $("#group1").prop("checked", $zx.length == $group1.length);
                                        });
                                        $(".group2").change(function () {
                                            var $zx = $(".group2:checked");
                                            $("#group2").prop("checked", $zx.length == $group2.length);
                                        });
                                        $(".group3").change(function () {
                                            var $zx = $(".group3:checked");
                                            $("#group3").prop("checked", $zx.length == $group3.length);
                                        });
                                        $(".group4").change(function () {
                                            var $zx = $(".group4:checked");
                                            $("#group4").prop("checked", $zx.length == $group4.length);
                                        });
                                        $(".group5").change(function () {
                                            var $zx = $(".group5:checked");
                                            $("#group5").prop("checked", $zx.length == $group5.length);
                                        });
                                        $(".group6").change(function () {
                                            var $zx = $(".group6:checked");
                                            $("#group6").prop("checked", $zx.length == $group6.length);
                                        });
                                        $(".group7").change(function () {
                                            var $zx = $(".group7:checked");
                                            $("#group7").prop("checked", $zx.length == $group7.length);
                                        });
                                        // 勾選全部
                                        $("#all").change(function () {
                                            $("input[type='checkbox']").prop("checked", this.checked);
                                        });
                                        $("#group1").change(function () {
                                            $group1.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group2").change(function () {
                                            $group2.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group3").change(function () {
                                            $group3.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group4").change(function () {
                                            $group4.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group5").change(function () {
                                            $group5.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group6").change(function () {
                                            $group6.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group7").change(function () {
                                            $group7.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                    </script>
                                </c:if>
                                <!-- @表單 /////////////////////////////////////////////////////////////////-->

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 驗證UI -->
            <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
            <script>
                //顯示reply@標註
                var Replyid;
                function advice(replyid) {
                    Replyid = replyid;
                    $(".advice").toggle();
                    $.ajax({
                        url: '${pageContext.request.contextPath}/replyAdvice/' + replyid,//接受請求的Servlet地址
                        type: 'POST',
                        // data: formdata,
                        // async: false,//同步請求
                        // cache: false,//不快取頁面
                        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (json) {
                            $("input[name='adviceto']").prop("checked", false);
                            for (var man of json) {
                                $("input[type='checkbox'][value='" + man.adviceto + "']").prop("checked", true);

                            }



                        },
                        error: function (returndata) {
                            alert("錯誤  請聯絡資訊人員");
                            console.log(returndata);
                        }
                    });
                }
                $(".advice").hide();
                $('.replyText').hide();
                $('.replyreply').hide();
                $(".ff").hide();
                // 留言附件 切換
                function upfileToggle() {
                    $(".ff").toggle();
                }




                //儲存@標註                
                function saveReplyAdvice() {
                    var formData = new FormData($("#replyAdvice")[0]);
                    console.log(formData.getAll('adviceto'));
                    $(".advice").toggle();
                    console.log('${pageContext.request.contextPath}/saveReplyAdvice/' + Replyid);
                    $.ajax({
                        url: '${pageContext.request.contextPath}/saveReplyAdvice/' + Replyid,//接受請求的Servlet地址
                        type: 'POST',
                        data: formData,
                        // async: false,//同步請求
                        // cache: false,//不快取頁面
                        contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (json) {
                            alert(json);




                        },
                        error: function (returndata) {
                            alert("錯誤  請聯絡資訊人員");
                            console.log(returndata);
                        }
                    });
                }


                function showReplyText(replyid) {
                    $('.show' + replyid).toggle();
                }

                function unread(billboardid, adminid) {
                    alert("取消已讀");
                    location.href = '${pageContext.request.contextPath}/ReRead/' + billboardid + '/' + adminid;

                }


                //複製網址
                function cop() {
                    const value = location.href;
                    const el = document.createElement('textarea');
                    el.value = value;
                    document.body.appendChild(el);
                    el.select();
                    document.execCommand('copy');
                    document.body.removeChild(el);
                    alert("複製成功");
                }
                //點擊置頂
                function tops() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/top/${bean.billboardid}/${user.adminid}',//接受請求的Servlet地址
                        type: 'POST',
                        // data: formdata,
                        // async: false,//同步請求
                        // cache: false,//不快取頁面
                        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (json) {
                            alert(json);
                            location.href = "${pageContext.request.contextPath}/billboardReply/${bean.billboardid}";
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });

                }
                //讀取錯誤 縮小img
                function errorOne(id) {
                    console.log('first image load error!');
                    $(".content img").attr("width", "50px");
                }
                //修改留言
                function replyChange(replyid) {
                    $('.showText' + replyid).toggle();
                }

                $(".dialog").dialog({
                    autoOpen: false,
                    position: {
                        at: "right bottom"
                    }

                });
                //刪除留言的留言
                function removeReplyreply(replyid) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/removeReplyreply/' + replyid,//接受請求的Servlet地址
                        type: 'POST',
                        // data: formdata,
                        // async: false,//同步請求
                        // cache: false,//不快取頁面
                        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (json) {
                            alert(json);
                            location.href = "${pageContext.request.contextPath}/billboardReply/${bean.billboardid}";
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                }

                //已讀按鈕
                function read(billboardid, username) {
                    console.log(username);
                    $.ajax({
                        url: '${pageContext.request.contextPath}/read/' + billboardid + '/' + username,//接受請求的Servlet地址
                        type: 'POST',
                        // data: formdata,
                        // async: false,//同步請求
                        // cache: false,//不快取頁面
                        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (json) {
                            alert(json);
                            location.href = "${pageContext.request.contextPath}/billboardReply/" + billboardid;
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                }
                //上傳型錄

                upfile = function (i) {
                    var formData = new FormData($(".uppdf")[0]);
                    console.log(formData.values());
                    $.ajax({
                        url: '${pageContext.request.contextPath}/upFileToReply/${uuid}',//接受請求的Servlet地址
                        type: 'POST',
                        data: formData,
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (url) {
                            alert(url);
                            selectFile();
                        },
                        error: function (returndata) {
                            console.log(returndata);

                        }

                    });
                }
                //要求附件
                function selectFile() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/selectReplyFile/${uuid}',//接受請求的Servlet地址
                        type: 'POST',
                        // data: formData,
                        // async: false,//同步請求
                        // cache: false,//不快取頁面
                        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (json) {

                            $(".fileDiv").empty();
                            for (var f of json) {
                                var url = "${pageContext.request.contextPath}/file/" + f.url;
                                $(".fileDiv").append('<div class="col-md-1 cell cellbackgroud">附件</div>' +
                                    '<div class="col-md-6" style="word-wrap: break-word;border-bottom:  1px solid #8e8e8e;"> <a target="_blank" draggable="true" ondragstart="event.dataTransfer.setData(`text/plain`, `<img src=' + url + ' onerror=errorOne()>`)" href="${pageContext.request.contextPath}/file/' + f.url + '">' + f.name + '</a></div>' +
                                    '<div class="col-md-2" style="text-align: right;border-right:  1px solid #8e8e8e;;border-bottom:  1px solid #8e8e8e;"><a  href="javascript:removeReplyFile(`' + f.replyfileid + '`)">remove</a></div>' +
                                    '<div class="col-md-3"></div>');
                            }
                            $(".upDiv").empty();
                            $(".upDiv").append('<form class="row uppdf" action="" method="post" enctype="multipart/form-data">' +
                                '<input type="file" name="file1" onchange="upfile(0);" class="fileInput" value="" /></form>');
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                }
                selectFile();
                //刪除附件
                function removeReplyFile(a) {
                    console.log(a);
                    $.ajax({
                        url: '${pageContext.request.contextPath}/removeReplyFile/' + a,//接受請求的Servlet地址
                        type: 'POST',
                        // data: formData,
                        // async: false,//同步請求
                        // cache: false,//不快取頁面
                        // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                        // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                        success: function (json) {
                            console.log("刪除附件");
                            console.log('${uuid}');
                            console.log(json);
                            selectFile();
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                }

                //儲存內容 預防刷新
                $('#replycontent').on('input', function (e) {
                    localStorage.setItem('replycontent', e.target.value)
                })
                $('#replycontent').val(localStorage.getItem('replycontent'));


                $(function () {
                    // 日期UI
                    $(".contacttime").datepicker({
                        changeMonth: true,
                        changeYear: true,
                        dateFormat: "yy-mm-dd"
                    });


                    // 密碼驗證
                    jQuery.validator.setDefaults({
                        submitHandler: function () {
                            localStorage.removeItem("replycontent");
                            if (confirm("提交確認")) form.submit();
                        }
                    });
                    $.extend($.validator.messages, {
                        required: "這是必填字段",
                        email: "請输入有效的電子郵件地址",
                        url: "请输入有效的网址",
                        date: "请输入有效的日期",
                        dateISO: "请输入有效的日期 (YYYY-MM-DD)",
                        number: "请输入有效的数字",
                        digits: "只能输入数字",
                        creditcard: "请输入有效的信用卡号码",
                        equalTo: "你的输入不相同",
                        extension: "请输入有效的后缀",
                        maxlength: $.validator.format("最多可以输入 {0} 个字符"),
                        minlength: $.validator.format("最少要输入 {0} 个字符"),
                        rangelength: $.validator.format("请输入长度在 {0} 到 {1} 之间的字符串"),
                        range: $.validator.format("请输入范围在 {0} 到 {1} 之间的数值"),
                        max: $.validator.format("请输入不大于 {0} 的数值"),
                        min: $.validator.format("请输入不小于 {0} 的数值")
                    });
                    $("#formReply").validate({
                        rules: {
                            // password: "required",
                            // password_again: {
                            //     equalTo: "#password"
                            // }
                        }
                    });

                });
            </script>
            <input type="hidden" name="myInput" class="myInput">
            </div>
            </div>
            <!-- tiny 所見即所得-->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.7.6/tinymce.min.js"></script>
            <!-- <script src="${pageContext.request.contextPath}/tinymce/js/tinymce/tinymce.min.js"></script> -->
            <script>
                tinymce.init({
                    language: 'zh_TW',
                    language_url: '${pageContext.request.contextPath}/tinymce/langs/zh_TW.js',
                    selector: '#replycontent',
                    height: '200',
                    menubar: false,
                });
            </script>

        </body>

        </html>