<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>帳號申請</title>
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">


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

                                <label class="btn btn-outline-primary state1"
                                    onclick="javascript:window.open('${pageContext.request.contextPath}/system/AccountApplication.jsp')">新增</label>

                                <c:if test="${user.position == '主管' || user.position == '系統'}">
                                    <label class="btn btn-outline-primary state2" onclick="sta()">刪除</label>
                                </c:if>
                            </div>
                        </div>
                        <!-- <%-- 中間表格--%> -->
                        <table class="Table table-striped orderTable">
                            <tr>
                                <td></td>
                                <td>申請⼈</td>
                                <td>⽇期</td>
                            </tr>
                            <tr class="item" v-for="(s, index) in list" :key="index">
                                <td><input type="checkbox" :value="s.applicationid" name="mak" @change="clickmak"></td>
                                <td @click="detail(s.applicationid)">
                                    {{s.admin}}</td>
                                <td @click="detail(s.applicationid)">
                                    {{s.createtime}}</td>
                            </tr>
                        </table>



                        <!-- 分頁 -->
                        <!-- <div class="block text-center">
                            <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage1"
                                :page-size="20" layout="  prev, pager, next" :total="total">
                            </el-pagination>
                        </div> -->





                    </div>
                </div>
            </div>
        </body>
        <script>

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
                            url: '${pageContext.request.contextPath}/AccountApplication/del',//接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/system/AccountApplicationList.jsp";
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
                    $.ajax({
                        url: '${pageContext.request.contextPath}/AccountApplication/ListInit?pag=1',
                        type: 'POST',
                        async: false,
                        cache: false,
                        success: response => {
                           if(response.code == 200){
                            this.list = response.data;
                           }
                            

                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    })
                },
                methods: {
                    detail: function (applicationid) {//進入細節
                        location.href = '${pageContext.request.contextPath}/AccountApplication/detail/' + applicationid + '?mess='
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
                    },
                    clickmak: function () {// 勾選單項    
                        var $all = $("input[name=mak]");
                        var $zx = $("input[name=mak]:checked");
                        $("#activity").prop("checked", $zx.length == $all.length);
                    }
                },

            })
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
        </script>


        </html>