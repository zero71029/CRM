<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <title>每⽇任務評估書</title>
            <style>
                .taskbar {
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
                        <br>
                        <c:if test="${user.position== '主管' || user.position== '系統'}">
                            <el-tag v-for="(s, index) in userList" :key="index" @click="search(s)"
                            style="cursor: pointer; margin-right: 10px;">{{s}}</el-tag>      
                            <hr>
                        </c:if>

                        
                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Task/Task.jsp'">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>
                                <c:if test="${user.position== '主管' || user.position== '系統'}">
                                    <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                    <label class="btn btn-outline-primary state2" for="btncheck2"
                                        onclick="sta()">刪除</label>
                                    <label @click="searchBox = true" class="btn btn-outline-primary state2">搜索</label>
                                </c:if>

                            </div>
                        </div>
                        <!-- <%-- 中間表格--%> -->
                        <table class="Table table-striped orderTable">
                            <tr>
                                <td><input type="checkbox" id="activity"></td>
                                <td>日期</td>
                                <td>姓名</td>
                            </tr>
                            <tr class="item" v-for="(s, index) in list" :key="index">
                                <td><input type="checkbox" :value="s.evaluateid" name="mak" @change="changeMak"></td>
                                <td @click="detail(s.evaluateid)" style="cursor: pointer;">
                                    {{s.evaluatedate}}</td>
                                <td @click="detail(s.evaluateid)" style="cursor: pointer;">
                                    {{s.name}}</td>
                            </tr>
                        </table>
                        <!-- 分頁 -->
                        <div class="block text-center">
                            <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage1"
                                :page-size="20" layout="  prev, pager, next" :total="total">
                            </el-pagination>
                        </div>
                        <!-- 滑塊 -->
                        <el-drawer title="搜索" :visible.sync="searchBox" direction="rtl" size="30%">
                            <el-button type="primary" v-for="(s, index) in userList" :key="index" @click="search(s)"
                                size="small">
                                {{s}}</el-button>
                        </el-drawer>







                    </div>
                </div>
            </div>
        </body>
        <script>
            const vm = new Vue({
                el: '.app',
                data() {
                    return {
                        currentPage1: 1,//當前分頁
                        total: 1,//所有筆數
                        list: [],
                        selectIn: "",//搜索框
                        searchBox: false,//滑塊顯示
                        userList: ""//
                    }
                },
                created() {
                    if ("${user.position}" == "主管" || "${user.position}" == "系統") {
                        var url = '${pageContext.request.contextPath}/task/directorTaskList?pag=1';
                    } else {
                        var url = '${pageContext.request.contextPath}/task/taskList?pag=1&name=${user.name}';
                    }
                    axios
                        .get(url)//銷售機會列表
                        .then(response => (
                            this.list = response.data.list,
                            this.total = response.data.total,
                            this.userList = response.data.userList

                        ))
                        .catch(function (error) {
                            console.log(error);
                        });
                },
                methods: {
                    detail: function (evaluateid) {//進入細節
                        location.href = '${pageContext.request.contextPath}/task/detail/' + evaluateid
                    },
                    handleCurrentChange(val) {//點擊分頁
                        if ("${user.position}" == "主管" || "${user.position}" == "系統") {
                            var url = '${pageContext.request.contextPath}/task/directorTaskList?pag=' + val;
                        } else {
                            var url = '${pageContext.request.contextPath}/task/taskList?pag=' + val + '&name=${user.name}';
                        }
                        if (this.selectIn == "") {
                            axios
                                .get(url)
                                .then(response => (
                                    this.list = response.data.list,
                                    this.total = response.data.total
                                ))
                                .catch(function (error) {
                                    console.log(error);
                                });
                        } else {
                            axios
                                .get('${pageContext.request.contextPath}/task/selecttask?name=' + this.selectIn + "&pag=" + val)
                                .then(response => (
                                    this.list = response.data
                                ))
                                .catch(function (error) {
                                    console.log(error);
                                });
                        }
                    },
                    changeMak() {// 勾選單項                       
                        var $all = $("input[name=mak]");
                        var $zx = $("input[name=mak]:checked");
                        $("#activity").prop("checked", $zx.length == $all.length);
                    }, search(s) {
                        this.selectIn = s;
                        axios
                            .get('${pageContext.request.contextPath}/task/taskList?name=' + this.selectIn + "&pag=1")
                            .then(response => (
                                this.list = response.data.list,
                                this.total = response.data.total
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    }
                },

            })
        </script>
        <script>
            // 勾選全部            
            $("#activity").change(function () {
                var $all = $("input[name=mak]");
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
                            url: '${pageContext.request.contextPath}/task/delTask',//接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/Task/TaskList.jsp";
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                }
            }
            $(".employee").show();
        </script>

        </html>