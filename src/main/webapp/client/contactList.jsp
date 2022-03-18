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
                .contactbar {
                    background-color: #afe3d5;
                }

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
                    <div class="col-md-11 app">
                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/client/contact.jsp'">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>

                                <c:if test="${user.position == '主管' || user.position == '系統'}">
                                    <label class="btn btn-outline-primary state2" for="btncheck2"
                                        onclick="sta()">刪除</label>
                                </c:if>

                                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck3" onclick="">XXX</label>
                            </div>
                        </div> <!-- <%-- 抬頭搜索--%> -->
                        <div class="col-lg-5">
                            <form action="${pageContext.request.contextPath}/CRM/selectContact" method="post">
                                <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                    <input type="text" class="form-control" placeholder=" 名稱  or 公司 or 電話 or 手機"
                                        aria-label="Recipient's username" aria-describedby="button-addon2" name="name">
                                    <button class="btn btn-outline-secondary" type="submit"
                                        id="selectProduct">搜索</button>
                                </div>
                            </form>
                        </div>
                        <!-- <%-- 中間主體--%> -->
                        <table class="Table table-striped orderTable">
                            <tr>
                                <td><input type="checkbox" id="activity" @change="changeActivity"></td>
                                <td>編號</td>
                                <td>聯絡人名稱</td>
                                <td>公司</td>
                                <td>職務</td>
                                <td>電話</td>
                                <td>手機</td>
                                <td>部門</td>
                                <td>負責人</td>
                            </tr>
                            <tr class="item" v-for="(s, index) in list" :key="index">
                                <td><input type="checkbox" :value="s.contactid" name="mak" @change="clickmak"></td>
                                <td @click="contact(s.contactid)">
                                    {{s.contactid}}</td>
                                <td @click="contact(s.contactid)">
                                    {{s.name}}</td>
                                <td @click="contact(s.contactid)">
                                    {{s.company}}</td>
                                <td @click="contact(s.contactid)">
                                    {{s.jobtitle}}</td>
                                <td @click="contact(s.contactid)">
                                    {{s.phone}}</td>
                                <td @click="contact(s.contactid)">
                                    {{s.moblie}}</td>
                                <td @click="contact(s.contactid)">
                                    {{s.department}}</td>
                                <td @click="contact(s.contactid)">
                                    {{s.user}}</td>
                            </tr>

                        </table>
                        <!-- 分頁 -->
                        <div class="block text-center" key="2">
                            <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage"
                                :page-size="20" layout="  prev, pager, next" :total="total">
                            </el-pagination>
                        </div>

                    </div>
                </div>
            </div>
        </body>
        <script>
            $(".client").show();

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
                            url: '${pageContext.request.contextPath}/CRM/delcontact',
                            type: 'POST',
                            data: parm,
                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/client/contactList.jsp";
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                }
            }
        </script>
        <script>
            const vm = new Vue({
                el: ".app",
                data() {
                    return {
                        list: [],
                        total: "",//全部多少筆
                        currentPage: "",//當前頁面
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/contact/ContactListInit?pag=1',
                        type: 'post',
                        async: false,
                        cache: false,
                        success: response => {
                            this.list = response.list,
                                this.total = response.total
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                    console.log(this.list);
                },

                methods: {
                    //進入細節
                    contact(contactid) {
                        location.href = '${pageContext.request.contextPath}/CRM/contact/' + contactid;
                    },
                    //分頁切換
                    handleCurrentChange() {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/contact/ContactListInit?pag=' + this.currentPage,
                            type: 'post',
                            async: false,
                            cache: false,
                            success: response => {
                                this.list = response.list,
                                    this.total = response.total
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    //勾選全部
                    changeActivity: function () {
                        var $all = $("input[name=mak]");
                        $all.prop("checked", $("#activity").prop("checked"));
                    },
                    // 勾選單項   
                    clickmak: function () {
                        var $all = $("input[name=mak]");
                        var $zx = $("input[name=mak]:checked");
                        $("#activity").prop("checked", $zx.length == $all.length);
                    },
                },
            })
        </script>
        </html>