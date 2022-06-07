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
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">

        </head>



        <style>
            tr td span a {
                color: #777;
                font-size: 0.9rem;
                text-decoration: none;
            }

            .body {
                background-color: white;
                width: 100%;
            }
        </style>

        <body>

            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-lg-11 app">

                        <div class="row ">
                            <div class="col-lg-11">
                                <!-- 導覽列 -->
                                <nav class="navbar navbar-expand-lg navbar-light bg-light" style="text-align: left;">
                                    <div class="container-fluid">
                                        <a class="navbar-brand" href="${pageContext.request.contextPath}/">管理討論平台</a>
                                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                            data-bs-target="#navbarSupportedContent"
                                            aria-controls="navbarSupportedContent" aria-expanded="false"
                                            aria-label="Toggle navigation">
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
                                                <li class="nav-item dropdown">
                                                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                                                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                        業務
                                                    </a>
                                                    <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                        style="text-align: left;">
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${billboardgroup.size()-1}" items="${billboardgroup}"
                                                            var="s">
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
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${billboardgroup.size()-1}" items="${billboardgroup}"
                                                            var="s">
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
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${billboardgroup.size()-1}" items="${billboardgroup}"
                                                            var="s">
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
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${billboardgroup.size()-1}" items="${billboardgroup}"
                                                            var="s">
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
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${billboardgroup.size()-1}" items="${billboardgroup}"
                                                            var="s">
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
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${billboardgroup.size()-1}" items="${billboardgroup}"
                                                            var="s">
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
                                                <div style="position: relative; cursor: pointer;"
                                                    @click="unreadVisible = true">
                                                    <img src="${pageContext.request.contextPath}/img/bell.png" alt="未讀">
                                                </div>
                                                <div style=" color: red;  font-weight:bold; cursor: pointer;">
                                                    <!-- @ -->
                                                    <script>var b = 0;</script>
                                                    <c:if test="${not empty user.advice}">
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${user.advice.size()-1}" items="${user.advice}"
                                                            var="ad">
                                                            <script>
                                                                var a = ${ ad.reply };
                                                                b += a;
                                                            </script>
                                                        </c:forEach>
                                                        <span @click="unreadVisible = true" class="aaa"></span>
                                                    </c:if>
                                                    <!-- 未讀 -->
                                                    <c:if test="${not empty user.mail}">
                                                        <span
                                                            @click="unreadVisible = true">未讀:${user.mail.size()}</span>
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
                            <div class="col-lg-8">
                                <!-- <%-- 中間主體--%> -->
                                <h1 style="color: red;">${param.mess=="1"?"權限不夠":""}</h1>
                                <h1 style="color: red;">${param.mess=="2"?"須先登入":""}</h1>
                                <h1 style="color: red;">${param.mess=="3"?"授權碼過期":""}</h1>
                                <table class="table table-hover">
                                    <thead>
                                        <tr style="text-align:center">
                                            <th scope="col-lg" style="width: 700px;">主題</th>
                                            <th scope="col-lg">發布時間</th>
                                            <th scope="col-lg">
                                                <c:if test="${not empty param.sort}">
                                                    <a
                                                        href="${pageContext.request.contextPath}/billboard?pag=${param.pag==''?'1':param.pag}&sort=${param.sort == 'lastmodified'?'reply.lastmodified':'lastmodified'}">最後回覆時間</a>${param.sort
                                                    == 'reply.lastmodified'?'▼':''}
                                                </c:if>
                                                <c:if test="${empty param.sort}">
                                                    最後回覆時間
                                                </c:if>
                                            </th>
                                            <th scope="col-lg">回應</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:if test="${not empty list}">
                                            <c:forEach varStatus="loop" begin="0" end="${list.size()-1}" items="${list}"
                                                var="s">
                                                <tr style="Cursor: pointer ;vertical-align: middle;"
                                                    onclick="location.href='${pageContext.request.contextPath}/billboard/Reply/${s.billboardid}'">
                                                    <!-- //////////////////////////////////////////////////// -->
                                                    <td>
                                                        <!--置頂圖片  -->
                                                        <c:set var="img"
                                                            value="<img src='${pageContext.request.contextPath}/img/TTT.png' alt='置頂'>">
                                                        </c:set>
                                                        <span style="color: red;">${s.top == "置頂"?img:""}</span>
                                                        <!-- 如果 .......就是 個人置頂 -->
                                                        <c:if test="${not empty user.top}">
                                                            <c:forEach varStatus="loop" begin="0"
                                                                end="${user.top.size()-1}" items="${user.top}"
                                                                var="top">
                                                                <span style="color: red;">
                                                                    <c:if test="${top.billboardid == s.billboardid}">
                                                                        <img src="${pageContext.request.contextPath}/img/topA.png"
                                                                            alt="">
                                                                    </c:if>
                                                                </span>
                                                            </c:forEach>
                                                        </c:if>
                                                        <!-- 分群-->


                                                        <span style="color: #777;font-size: 0.9rem;" class="group">
                                                            <c:if test='${s.billtowngroup == "生產"}'>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/selectBillboardGroup/01dasgregrehvbcvddd生產">${s.billtowngroup}</a>
                                                            </c:if>
                                                            <c:if test='${s.billtowngroup == "研發"}'>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/selectBillboardGroup/01dasgregrehvbcvaaa研發">${s.billtowngroup}</a>
                                                            </c:if>
                                                            <c:if test='${s.billtowngroup == "財務"}'>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/selectBillboardGroup/01dasgregrehvbcvaaa財務">${s.billtowngroup}</a>
                                                            </c:if>
                                                            <c:if test='${s.billtowngroup == "業務"}'>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/selectBillboardGroup/01dasgregrehvbcvbbb業務">${s.billtowngroup}</a>
                                                            </c:if>
                                                            <c:if test='${s.billtowngroup == "行銷"}'>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/selectBillboardGroup/01dasgregrehvbcvccc行銷">${s.billtowngroup}</a>
                                                            </c:if>
                                                            <c:if test='${s.billtowngroup == "採購"}'>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/selectBillboardGroup/01dasgregrehvbcvfggg採購">${s.billtowngroup}</a>
                                                            </c:if>
                                                            <c:if test='${s.billtowngroup == "一般公告"}'>
                                                                <a
                                                                    href="${pageContext.request.contextPath}/selectBillboardGroup/01dasgregrehvbcv一般公告">${s.billtowngroup}</a>
                                                            </c:if>
                                                            →
                                                            <a
                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.bgb.billboardoption}</a>
                                                            &nbsp;
                                                        </span>




                                                        <!-- 如果 mail.billboardid = 留言id 就是未讀 -->
                                                        <c:if test="${not empty user.mail}">
                                                            <c:forEach varStatus="loop" begin="0"
                                                                end="${user.mail.size()-1}" items="${user.mail}"
                                                                var="mail">
                                                                <span style="color: red;">
                                                                    ${mail.billboardid == s.billboardid? mail.reply:""}
                                                                    ${mail.billboardid == s.billboardid? "未讀":""}</span>
                                                            </c:forEach>
                                                        </c:if>
                                                        <!-- 標提 -->
                                                        ${s.theme}
                                                        <span style="color: #777;">

                                                            <!-- 如果 .......就是被@ -->
                                                            <c:if test="${not empty user.advice}">
                                                                <c:forEach varStatus="loop" begin="0"
                                                                    end="${user.advice.size()-1}" items="${user.advice}"
                                                                    var="advice">
                                                                    ${advice.billboardid == s.billboardid? "您已被標註":""}
                                                                </c:forEach>
                                                            </c:if>
                                                        </span>
                                                        <!-- 有附件 -->
                                                        <span style="color: #569b92;"> ${empty s.file?"":"📎"}</span>
                                                    </td>
                                                    <!-- //////////////////////////////////////////////////////////////// -->
                                                    <!-- 發布時間 -->
                                                    <td style="text-align: center;">${s.user}${s.remark}<br>
                                                        ${s.lastmodified}
                                                    </td>
                                                    <!-- 最後回覆時間 -->
                                                    <td style="text-align: center;">
                                                        ${s.reply[0].name}
                                                        <br>${s.reply[0].lastmodified}
                                                        ${reply}
                                                    </td>
                                                    <!-- 回應 -->
                                                    <td style="text-align: center;">${s.reply.size()}</td>
                                                </tr>

                                            </c:forEach>
                                        </c:if>

                                    </tbody>
                                </table>

                            </div>

                            <div class="col-lg-3 ">
                                <!-- 分頁 -->
                                <c:if test="${not empty param.pag}">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination">

                                            <!-- 首頁 -->
                                            <c:if test="${param.pag > 1}">
                                                <li class="page-item"><a class="page-link"
                                                        href="${pageContext.request.contextPath}/billboard?pag=1&sort=${param.sort}">首頁</a>
                                                </li>
                                                <li class="page-item"><a class="page-link"
                                                        href="${pageContext.request.contextPath}/billboard?pag=${param.pag<=1?1:param.pag-1}&sort=${param.sort}">←</a>
                                                </li>
                                            </c:if>

                                            <!-- 如果 pag < 2   ,    pag> max-2 -->
                                            <c:forEach varStatus="loop" begin="${param.pag-2 <1 ? 1:param.pag-2}"
                                                end="${param.pag+2 >TotalPages ? TotalPages :param.pag+2}">
                                                <li
                                                    class='page-item      ${param.pag == loop.index ? "active ":""}         '>
                                                    <a class="page-link"
                                                        href="${pageContext.request.contextPath}/billboard?pag=${loop.index}&sort=${param.sort}">${loop.index}</a>
                                                </li>

                                            </c:forEach>

                                            <c:if test="${param.pag != TotalPages}">
                                                <li class="page-item"><a class="page-link"
                                                        href='${pageContext.request.contextPath}/billboard?pag=${param.pag >= TotalPages?TotalPages: param.pag+1}&sort=${param.sort}'>→</a>
                                                </li>
                                                <li class="page-item"><a class="page-link"
                                                        href='${pageContext.request.contextPath}/billboard?pag=${TotalPages}&sort=${param.sort}'>尾頁</a>
                                                </li>
                                            </c:if>
                                        </ul>
                                    </nav>
                                </c:if>

                                <!-- 分頁 ＿////////////////////-->
                                <!-- 彈窗 -->


                                <el-dialog title="未讀" :visible.sync="unreadVisible">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">日期</th>
                                                <th colspan="2" scope="col">主題</th>
                                                <th scope="col">Handle</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="(s, index) in unread" :key="index">
                                                <th scope="row" @click="gobillboard(s.billboardid)"
                                                    style="cursor: pointer;">{{s.lastmodified}}</th>
                                                <td colspan="2" @click="gobillboard(s.billboardid)"
                                                    style="cursor: pointer;">
                                                    <el-popover placement="top-start" width="200" trigger="hover">
                                                        <div v-html="s.content"></div>
                                                        <span slot="reference">{{s.theme}}</span>
                                                    </el-popover>
                                                </td>
                                                <td>
                                                    <el-link type="primary" @click="read(s.billboardid)"><i
                                                            class="bi bi-hand-thumbs-up"></i> </el-link>
                                                </td>
                                            </tr>
                                            <tr v-for="(s, index) in advice" :key="index">
                                                <th scope="row" @click="gobillboard(s.billboardid)"
                                                    style="cursor: pointer;">{{s.lastmodified}}</th>
                                                <td colspan="2" @click="gobillboard(s.billboardid)"
                                                    style="cursor: pointer;">


                                                    <el-popover placement="top-start" trigger="hover">
                                                        <div v-html="s.content"></div>
                                                        <span slot="reference">{{s.theme}}</span>
                                                    </el-popover>

                                                </td>
                                                <td>
                                                    <el-link type="primary" @click="read(s.billboardid)"><i
                                                            class="bi bi-hand-thumbs-up"></i> </el-link>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </el-dialog>







                                <!-- <c:if test="${not empty unread}">
                                    <c:forEach varStatus="loop" begin="0" end="${unread.size()}" items="${unread}"
                                        var="unread">
                                        <div class="unread a${unread.billboardid}" title="未讀">
                                            <a href='${pageContext.request.contextPath}/billboardReply/${unread.billboardid}'
                                                style="color:red">${unread.theme}</a>
                                            <i class="bi bi-hand-thumbs-up" style="float: right;cursor: pointer;"
                                                onclick="read('${unread.billboardid}')"></i>
                                            <p>${unread.content} </p>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${not empty advice}">
                                    <c:forEach varStatus="loop" begin="0" end="${advice.size()}" items="${advice}"
                                        var="advice">
                                        <div class="dialog ${advice.billboardid}" title="@">
                                            <a href='${pageContext.request.contextPath}/billboardReply/${advice.billboardid}'
                                                style="color:red">${advice.theme}</a>
                                            <i class="bi bi-hand-thumbs-up" style="float: right;cursor: pointer;"
                                                onclick="read('${advice.billboardid}')"></i>
                                            <p>${advice.content}</p>
                                        </div>
                                    </c:forEach>
                                </c:if> -->




                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script>
                const vm = new Vue({
                    el: '.app',
                    data() {
                        return {
                            unread: [],
                            advice: [],
                            unreadVisible: false
                        }
                    },
                    mounted() {
                        console.log("請求未讀資料");
                        $.ajax({
                            url: '${pageContext.request.contextPath}/init',
                            type: 'get',
                            success: json => {
                                this.unread = json.unread,
                                this.advice = json.advice
                            },
                            error: function (returndata) {
                                console.log(returndata.responseJSON.message);

                            }
                        });
                    },
                    methods: {
                        read(billboardid) {
                            console.log("ddddd");
                            $.ajax({
                                url: '${pageContext.request.contextPath}/read/' + billboardid + '/${user.adminid}',
                                type: 'get',
                                async: false,
                                cache: false,
                                success: json => {
                                    if (json == "找不到資料") {
                                        this.$message({
                                            message: json,
                                            type: 'warning'
                                        });
                                    } else {
                                        this.$message({
                                            message: json,
                                            type: 'success'
                                        });
                                    }
                                },
                                error: function (returndata) {
                                    console.log(returndata.responseJSON.message);

                                }
                            });
                            var old = this.unread;
                            this.unread = [];
                            for (const s of old) {
                                if (s.billboardid != billboardid) {
                                    this.unread.push(s);
                                }
                            }
                            old = this.advice;
                            this.advice = [];
                            for (const s of old) {
                                if (s.billboardid != billboardid) {
                                    this.advice.push(s);
                                }
                            }
                        },
                        gobillboard: function (billboardid) {
                            window.open("${pageContext.request.contextPath}/billboard/Reply/" + billboardid);
                            var old = this.unread;
                            this.unread = [];
                            for (const s of old) {
                                if (s.billboardid != billboardid) {
                                    this.unread.push(s);
                                }
                            }
                            old = this.advice;
                            this.advice = [];
                            for (const s of old) {
                                if (s.billboardid != billboardid) {
                                    this.advice.push(s);
                                }
                            }
                        }
                    }
                })
            </script>

        </body>

        </html>