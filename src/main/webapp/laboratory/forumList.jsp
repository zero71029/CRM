<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">

            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>實驗室公佈欄</title>
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
                            <div class="col-md-12" v-loading="loading">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-12">
                                        <!-- <%-- 抬頭按鈕--%> -->
                                        <c:if
                                            test='${ user.position == "系統" ||user.position == "總經理" || user.permit.indexOf("實驗室") >= 0}'>
                                            <div class="row">
                                                <div class="btn-group" role="group">
                                                    <input type="checkbox" class="btn-check" id="btncheck1"
                                                        autocomplete="off"
                                                        onclick="javascript:location.href='${pageContext.request.contextPath}/laboratory/newForum.jsp'">
                                                    <label class="btn btn-outline-primary state1"
                                                        for="btncheck1">新增</label>
                                                    <c:if test="${user.position == '主管' || user.position == '系統' }">
                                                        <label class="btn btn-outline-primary state2" for="btncheck2"
                                                            @click="delforum">刪除</label>
                                                        <!-- <label class="btn btn-outline-primary" for="btncheck3"
                                                        onclick="">圖書館</label> -->
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>
                                        <!-- <%-- 抬頭按鈕結束--%> -->
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12 text-center">
                                        <!-- 導覽列 -->
                                        <!-- <nav class="navbar navbar-expand-lg navbar-light bg-light"
                                            style="text-align: left;">
                                            <div class="container-fluid">
                                                <a class="navbar-brand"
                                                    href="${pageContext.request.contextPath}/">實驗室公佈欄</a>
                                                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                                    data-bs-target="#navbarSupportedContent"
                                                    aria-controls="navbarSupportedContent" aria-expanded="false"
                                                    aria-label="Toggle navigation">
                                                    <span class="navbar-toggler-icon"></span>
                                                </button>

                                                <div class="collapse navbar-collapse " id="navbarSupportedContent">
                                                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
                                                        <li class="nav-item dropdown">
                                                            <a class="nav-link dropdown-toggle" href="#"
                                                                id="navbarDropdown" role="button"
                                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                                一般公告
                                                            </a>
                                                            <ul class="dropdown-menu " aria-labelledby="navbarDropdown"
                                                                style="text-align: left;">
                                                                <li><a class="dropdown-item"
                                                                        href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">s.billboardoption</a>
                                                                </li>
                                                                <c:forEach varStatus="loop" begin="0"
                                                                    end="${billboardgroup.size()-1}"
                                                                    items="${billboardgroup}" var="s">
                                                                    <c:if test='${s.billboardgroup == "一般公告"}'>
                                                                        <li><a class="dropdown-item"
                                                                                href="${pageContext.request.contextPath}/selectBillboardGroup/${s.billboardgroupid}">${s.billboardoption}</a>
                                                                        </li>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </ul>
                                                        </li>
                                                    </ul>
                                                  
                                                    <form class="d-flex" method="post"
                                                        action="${pageContext.request.contextPath}/selectBillboard">
                                                        <input class="form-control me-2" type="search"
                                                            placeholder="主題 or 發佈者" aria-label="Search" name="search">
                                                        <button class="btn btn-outline-success"
                                                            type="submit">Search</button>
                                                    </form>
                                                </div>
                                            </div>
                                        </nav> -->
                                        <!-- 導覽列結束 -->
                                    </div>
                                </div>
                                <!-- 中間身體 -->
                                <div class="row ">
                                    <div class="col-md-12">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr style="text-align:center">
                                                    <th style="width: 50px;">勾選</th>
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
                                            <!-- 列表 -->
                                            <tbody>

                                                <tr style="Cursor: pointer ;vertical-align: middle;"
                                                    v-for="(s, index) in list" :key="index">
                                                    <td>
                                                        <!-- 勾選 -->

                                                        <input type="checkbox" :value="s.forumid" v-model="delList">



                                                    </td>
                                                    <td>
                                                        <!--置頂圖片  -->

                                                        <img src='${pageContext.request.contextPath}/img/TTT.png'
                                                            alt='置頂' v-show="s.top>0">

                                                        <span style="color: red;">${s.top }</span>
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

                                                        <!-- 標提 -->
                                                        <a
                                                            :href="'${pageContext.request.contextPath}/laboratory/forumDetail.jsp?forumid='+s.forumid">
                                                            {{s.name}}
                                                        </a>

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
                                                    <td style="text-align: center;">{{s.member}}${s.remark}<br>
                                                        {{s.time}}
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
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-12 text-center">
                                        <!-- 分頁 -->
                                        <el-pagination @size-change="handleSizeChange"
                                            @current-change="handleCurrentChange" :current-page="currentPage"
                                            :page-sizes="[10, 20, 30, 40]" :pageSize="10"
                                            layout="total, sizes, prev, pager, next, jumper" :total="total">
                                        </el-pagination>
                                        <!-- 分頁結束 -->
                                    </div>
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
                        delList: [],//刪除列表
                        loading: false,
                        currentPage: 1,//當前頁面
                        total: 400,//
                        pageSize: 10,
                        list: [
                        ],
                    }
                },
                created() {
                    this.loading = true;
                    const url = new URL(window.location.href);
                    this.currentPage = url.searchParams.get("page");
                    this.pageSize = url.searchParams.get("size");
                    $.ajax({
                        url: '${pageContext.request.contextPath}/laboratory/getList?page=' + this.currentPage + "&size=" + this.pageSize,
                        type: 'get',
                        success: json => {
                            console.log(json);
                            if (json.code == 200) {
                                this.list = json.data.list;
                                this.total = json.data.total;
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
                    handleSelect(key, keyPath) {
                        console.log(key, keyPath);
                    },
                    handleSizeChange() {

                    },
                    handleCurrentChange() {

                    },
                    delforum() {
                        console.log(this.delList);
                        if (confirm("警告 ! 確定修改?")) {
                            var parm = "";
                            for (var a = 0; a < this.delList.length; a++) {
                                parm += "forumid=" + this.delList[a];
                                if (a < this.delList.length - 1) parm += "&";
                            }
                            console.log(parm);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/laboratory/delforum',
                                type: 'post',
                                data: parm,
                                success: json => {
                                    console.log(json);
                                    if (json.code == 200) {
                                        location.reload();
                                    }
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        }
                    },
                },
            })
        </script>

        </html>