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
        </head>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-10">
                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="newMessage()">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新留言</label>

                                <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                <label class="btn btn-outline-primary state2" for="btncheck2"
                                    onclick="inquire()">查詢</label>

                                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck3" onclick="reply()">已回覆</label>
                            </div>
                        </div>
                        <!-- <%-- 中間主體--%> -->
                        <!-- 多級側邊欄 -->
                        <!-- <link href="${pageContext.request.contextPath}/css/iconfont.css" rel="stylesheet"> -->
                        <link href="${pageContext.request.contextPath}/css/nav.css" rel="stylesheet">
                        <script type="text/javascript" src="${pageContext.request.contextPath}/js/nav.js"></script>
                        <div class="nav"
                            style="z-index: 9999;background-color: #62A5A1;color: white; position: relative;">
                            <div class="nav-top">
                                <div id="mini" style="border-bottom:1px solid rgba(255,255,255,.1)"><img
                                        src="${pageContext.request.contextPath}/img/mini.png"></div>
                            </div>
                            <ul>
                                <li class="nav-item">
                                    <a href="javascript:;"><i class="my-icon nav-icon icon_1"></i><span>營銷模塊</span><i
                                            class="my-icon nav-more"></i></a>
                                    <ul>
                                        <li><a href="javascript:;"><span>网站设置</span></a></li>
                                        <li><a href="javascript:;"><span>友情链接</span></a></li>
                                        <li><a href="javascript:;"><span>分类管理</span></a></li>
                                        <li><a href="javascript:;"><span>系统日志</span></a></li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="javascript:;"><i class="my-icon nav-icon icon_2"></i><span>文章管理</span><i
                                            class="my-icon nav-more"></i></a>
                                    <ul>
                                        <li><a href="javascript:;"><span>站内新闻</span></a></li>
                                        <li><a href="javascript:;"><span>站内公告</span></a></li>
                                        <li><a href="javascript:;"><span>登录日志</span></a></li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="javascript:;"><i class="my-icon nav-icon icon_3"></i><span>订单管理</span><i
                                            class="my-icon nav-more"></i></a>
                                    <ul>
                                        <li><a href="javascript:;"><span>订单列表</span></a></li>
                                        <li><a href="javascript:;"><span>打个酱油</span></a></li>
                                        <li><a href="javascript:;"><span>也打酱油</span></a></li>
                                    </ul>
                                </li>
                            </ul>
                        </div>




                    </div>
                </div>
            </div>
        </body>

        <script>
            // 看細節
            function mess(messid) {
                window.location.href = "${pageContext.request.contextPath}/backstage/mess/" + messid;
            }
            //切換回覆狀態
            function reply() {
                window.location.href = "${pageContext.request.contextPath}/backstage/messList?state=2";
            }
            function newMessage() {
                window.location.href = "${pageContext.request.contextPath}/backstage/messList?state=1";
            }
        </script>

        </html>