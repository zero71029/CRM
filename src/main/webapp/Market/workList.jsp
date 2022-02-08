<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">

            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
            <!-- 引入element-ui组件库 -->
            <script src="https://unpkg.com/element-ui/lib/index.js"></script>


            <style>
                .workbar {
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
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/work.jsp'">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>

                                <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                <label class="btn btn-outline-primary state2" for="btncheck2" onclick="sta()">刪除</label>
                                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck3">XXX</label>


                                <input type="checkbox" class="btn-check" id="btncheck4" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck4"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/work/closed'">XXX</label>
                            </div>
                        </div>
                        <!-- <%-- 抬頭搜索--%> -->
                        <div class="col-lg-5">
                            <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                <input type="text" class="form-control" placeholder=" 主題  or 客戶 or 聯絡人or 負責人"
                                    v-model="selectIn" aria-label="Recipient's username" @keyup.enter="selectWork"
                                    aria-describedby="button-addon2" name="name">
                                <button class="btn btn-outline-secondary" type="button" @click="selectWork"
                                    id="selectProduct">搜索</button>
                            </div>
                        </div>
                        <!-- <%-- 中間表格--%> -->
                        <table class="Table table-striped orderTable">
                            <tr>
                                <td><input type="checkbox" id="activity"></td>
                                <td>主題</td>
                                <td>到期日</td>
                                <td>負責人</td>
                                <td>重要性</td>
                                <td>狀態</td>
                            </tr>
                            <tr class="item" v-for="(s, index) in list" :key="index">
                                <td><input type="checkbox" value="s.workid" name="mak"></td>
                                <td @click="detail(s.workid)">
                                    {{s.name}}</td>
                                <td @click="detail(s.workid)">
                                    {{s.endtime}}</td>
                                <td @click="detail(s.workid)">
                                    {{s.user}}</td>
                                <td @click="detail(s.workid)">
                                    {{s.important}}</td>
                                <td @click="detail(s.workid)">
                                    {{s.state}}</td>

                            </tr>

                        </table>



                        <!-- 分頁 -->
                        <div class="block text-center">
                            <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage1"
                                :page-size="20" layout="  prev, pager, next" :total="total">
                            </el-pagination>
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
                        console.log(parm);
                        $.ajax({
                            url: '${pageContext.request.contextPath}/work/delWork',//接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/Market/workList.jsp";
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
                el: '.app',
                data() {
                    return {
                        currentPage1: 1,//當前分頁
                        total: 1,//所有筆數
                        list: [],
                        selectIn: ""//搜索框
                    }
                },
                created() {
                    axios
                        .get('${pageContext.request.contextPath}/work/workList?pag=1')//銷售機會列表
                        .then(response => (
                            this.list = response.data.list,
                            this.total = response.data.total,
                            console.log(response.data),
                            console.log(response.data.list),
                            console.log(response.data.total)


                        ))
                        .catch(function (error) {
                            console.log(error);
                        });

                },
                methods: {
                    detail: function (workid) {//進入細節
                        location.href = '${pageContext.request.contextPath}/work/detail/' + workid
                    },
                    handleCurrentChange(val) {//點擊分頁
                        if (this.selectIn == "") {
                            axios
                                .get('${pageContext.request.contextPath}/work/workList?pag=' + val)
                                .then(response => (
                                    this.list = response.data.list,
                                    this.total = response.data.total
                                ))
                                .catch(function (error) {
                                    console.log(error);
                                });
                        } else {
                            axios
                                .get('${pageContext.request.contextPath}/work/selectWork?name=' + this.selectIn + "&pag=" + val)
                                .then(response => (
                                    this.list = response.data
                                ))
                                .catch(function (error) {
                                    console.log(error);
                                });
                        }
                    },
                    selectWork: function () {//搜索框                    
                        axios
                            .get('${pageContext.request.contextPath}/work/selectWork?name=' + this.selectIn + "&pag=1")
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


        </html>