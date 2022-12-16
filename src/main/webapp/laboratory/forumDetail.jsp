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

                .cell {
                    border: 1px solid #8e8e8e;
                    font-size: 20px;
                }

                .cellbackgroud {
                    background-color: #CCC;
                }

                .cellFrom {
                    border: 0px solid black;
                    /* width: 33%; */
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
                            <div class="col-md-12" v-loading="loading">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-12">{{bean}}</div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-2"></div>
                                    <div class="col-md-8">
                                        <input type="hidden" name="billboardid" value="${bean.billboardid}">
                                        <input type="hidden" name="user" value="${user.name}">
                                        <div class="row">
                                            <div class="col-md-9">
                                                <!-- 上一頁 -->
                                                <!-- <a href="#" onclick="self.location=document.referrer;" -->
                                                <a href="#" style="text-decoration: none;"
                                                    onclick="window.history.go(-1);">
                                                    <img src="${pageContext.request.contextPath}/img/Pre.png" alt="上一頁">
                                                </a>${bean.bgb.billboardgroup}>${bean.bgb.billboardoption}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12"
                                                style="background-color: #569b92; border: solid 1px #569b92; position: relative; color: white;font-size: 28px;">
                                                公佈欄
                                                <!-- 有登入才顯示 -->
                                                <c:if test='${not empty user}'>

                                                    <span style="position: absolute; right: 0%; top: 0%;">

                                                        <a :href="'${pageContext.request.contextPath}/laboratory/newForum.jsp?forumid='+forumid"> <img
                                                                src="${pageContext.request.contextPath}/img/ch.png"
                                                                v-show="bean.member== '${user.name}' || '${user.position}' == '系統' "
                                                                alt="修改" style="cursor: pointer;"
                                                                data-bs-toggle="tooltip" data-bs-placement="bottom"
                                                                title="修改"></a>


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
                                            <div class="col-md-2 cell position-relative cellbackgroud"
                                                style="font-size: 22px;">
                                                發佈者</div>
                                            <div class="col-md-10 cell">{{bean.member}}${bean.remark}</div>
                                        </div>


                                        <div class="row">

                                            <div class="col-md-2 cell position-relative cellbackgroud"
                                                style="font-size: 22px;">
                                                主題</div>
                                            <div class="col-md-10 cell" style="position: relative;">
                                                {{bean.name}}
                                                <span
                                                    style="color: #8e8e8e; position: absolute ;right: 0%;">{{bean.lastmodified}}</span>

                                            </div>
                                        </div>

                                        <div class="row">

                                            <div class="col-md-2 cell position-relative cellbackgroud"
                                                style="font-size: 22px;">
                                                內容</div>
                                            <div class="col-md-10 cell content" style="word-wrap:break-word;"
                                                v-html="content"></div>
                                        </div>


                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            $(".laboratory").show();
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        loading: false,
                        forumid: "",
                        bean: {},
                        content: "",

                    }
                },
                created() {
                    this.loading = true;
                    const url = new URL(window.location.href);
                    this.forumid = url.searchParams.get("forumid");
                    $.ajax({
                        url: '${pageContext.request.contextPath}/laboratory/getDetail?forumid=' + this.forumid,
                        type: 'get',
                        success: json => {
                            console.log(json);
                            if (json.code == 200) {
                                this.bean = json.data.bean;
                                this.content = json.data.content;
                            }
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });

                },
                mounted() {
                    this.loading = false;
                },
                methods: {
                    goChange() {

                    }

                },
            })

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
        </script>




        </html>