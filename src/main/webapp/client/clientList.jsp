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
                .clientbar {
                    /* 按鈕顏色 */
                    background-color: #afe3d5;
                }

                .item:hover {
                    background-color: #afe3d5;
                }

                [v-cloak] {
                    display: none;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->

                    <div class="col-md-11 app" v-cloak>
                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/client/client.jsp'">
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

                            <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                <input type="text" class="form-control" placeholder=" 名稱  or 統編 or   電話" name="name"
                                    v-model="inName">
                                <button class="btn btn-outline-secondary" type="submit" id="selectClient"
                                    @click="selectClient">搜索</button>
                            </div>

                        </div>
                        <!-- <%-- 中間主體--%> -->
                        <table class="Table table-striped orderTable">
                            <tr>
                                <td><input type="checkbox" id="activity" @change="clickAll"></td>
                                <td>編號</td>
                                <td>客戶名稱</td>
                                <td>統編</td>
                                <td>負責人</td>
                                <td>類別</td>
                                <td>電話</td>
                                <td>產業</td>
                                <td></td>
                            </tr>
                            <tr class="item" v-for="(s, index) in list" :key="index">
                                <td><input type="checkbox" :value="s.clientid" name="mak" @change="clickmak"></td>
                                <td>
                                    {{s.clientid}}</td>
                                <td>
                                    <a :href="'${pageContext.request.contextPath}/CRM/client/' +s.clientid"
                                        target="_blank">{{s.name}}</a>
                                </td>
                                <td>
                                    {{s.uniformnumber}}</td>
                                <td>
                                    {{s.user}}</td>
                                <td>
                                    {{s.sort}}</td>
                                <td>
                                    {{s.phone}}</td>
                                <td>
                                    {{s.industry}}</td>

                                <td>
                                    <a @click="detail(s.clientid)" href="#">細節</a>
                                </td>
                            </tr>
                        </table>
                        <!-- 分頁 -->
                        <div class="block text-center" key="2">
                            <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage"
                                :page-size="40" layout=" prev, pager, next" :total="total">
                            </el-pagination>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            $(".client").show();
            // 勾選單項

            $("input[type=checkbox][name=mak]").change(function () {
                var $all = $("input[name=mak]");
                var $zx = $("input[name=mak]:checked");
                $("#activity").prop("checked", $zx.length == $all.length);
            });
            // 勾選全部
            $("#activity").change(function () {
                var $all = $("input[name=mak]");
                $all.prop("checked", this.checked);
            });
            //  刪除按鈕
            function sta() {
                var $zx = $("input[name=mak]:checked");
                console.log($zx);
                if ($zx.length == 0) {
                    alert("須勾選要刪除項目");
                } else {
                    if (confirm("警告 ! 確定刪除?")) {
                        var parm = "";
                        for (var a = 0; a < $zx.length; a++) {
                            parm += "id=" + $($zx[a]).val();
                            if (a < $zx.length - 1) parm += "&";
                        }
                        console.log(parm);
                        $.ajax({
                            url: '${pageContext.request.contextPath}/CRM/delClient',//接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            success: function (json) {
                                alert(json.message);
                                window.location.href = "${pageContext.request.contextPath}/client/clientList.jsp";
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                }
            }
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        inName: "",//搜索用
                        list: [],
                        currentPage: 1,//當前分頁
                        total: 20,//全部幾筆
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/CRM/init?pag=1',
                        type: 'POST',
                        async: false,
                        cache: false,
                        success: (response => {
                            this.list = response.data.list;
                            this.total = response.data.todayTotal;
                            console.log(this.list)
                        }),
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                methods: {
                    //進入細節
                    detail(id) {
                        location.href = '${pageContext.request.contextPath}/CRM/client/' + id
                    },
                    //點擊分頁
                    handleCurrentChange(val) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/CRM/init?pag=' + val,
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: (response => {
                                this.list = response.data.list;
                                this.total = response.data.todayTotal;
                                console.log(this.list)
                            }),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },//搜索
                    selectClient: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/CRM/selectclientResponseBody/' + this.inName,
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: (response => {
                                this.list = response.data,
                                    this.total = 20
                            }),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }, // 勾選全部
                    clickAll: function () {
                        var $all = $("input[name=mak]");
                        $all.prop("checked", $("#activity").prop("checked"));
                    },
                    // 勾選單項   
                    clickmak: function () {
                        var $all = $("input[name=mak]");
                        var $zx = $("input[name=mak]:checked");
                        $("#activity").prop("checked", $zx.length == $all.length);
                    }
                },
            })






        </script>


        </html>