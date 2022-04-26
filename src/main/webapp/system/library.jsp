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
                .item:hover {
                    background-color: #afe3d5;
                    cursor: pointer;
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
                    <div class="col-lg-11 app" v-cloak>
                        <div class="row">
                            <div class="col-md-12">
                                <!-- 上一頁 -->
                                <a href="${pageContext.request.contextPath}/system/libraryList.jsp"
                                    style="text-decoration: none;">
                                    <img src="${pageContext.request.contextPath}/img/Pre.png" alt="上一頁"
                                        style="width: 60px;height: 54px;">
                                </a>

                                </i>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-md-12 ">
                                <ul>
                                    <li v-for="(s,index) in list" key="index" :id="index">
                                        {{s.libraryoption}}&nbsp;&nbsp;&nbsp;&nbsp;
                                        <el-link @click="delLibrary(s.libraryid)" type="primary">remove</el-link>
                                    </li>
                                </ul>
                                <br><br>
                                <div class="input-group mb-3">
                                    <span class="input-group-text" id="inputGroup-sizing-sm">新增</span>
                                    <input type="text" class="form-control" v-model.trim="libraryoption" maxlength="19">
                                    <button class="btn btn-outline-secondary" type="button" id="button-addon2"
                                        @click="addLibrary">
                                        Button
                                    </button>
                                </div>
                                <el-button type="text" @click="record">紀錄</el-button>


                                <el-dialog title="紀錄" :visible.sync="recordVisible" width="30%">
                                    <el-table :data="recordList" style="width: 100%">
                                        <el-table-column prop="admin" label="修改人"></el-table-column>
                                        <el-table-column prop="action" label="動作"></el-table-column>
                                        <el-table-column prop="libraryoption" label="名稱"> </el-table-column>
                                        <el-table-column prop="aaa" label="時間"></el-table-column>
                                    </el-table>                                   
                                </el-dialog>
                            </div>
                        </div>
                    </div>
        </body>
        <script>
            $(".system").show();
            const url = new URL(location.href);

            const librarygroup = url.searchParams.get("librarygroup")
            console.log(librarygroup, "librarygroup");

            var vm = new Vue({
                el: ".app",
                data: {
                    recordVisible: false,//紀錄彈窗顯示
                    recordList: [],//紀錄列表
                    list: ["hhh"],
                    libraryoption: "",
                }, created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/system/getlibrary?librarygroup=' + librarygroup,
                        type: 'POST',
                        async: false,
                        cache: false,
                        success: response => {

                            this.list = response
                            console.log(this.list)
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    })
                }, methods: {
                    //刪除子項
                    delLibrary: function (libaryid) {
                        console.log(libaryid);
                        this.$confirm('此操作將永久刪除,是否繼續?', '提示', {
                            confirmButtonText: '確定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(() => {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/system/delLibrary/' + libaryid,
                                type: 'POST',
                                success: response => {
                                    this.list = response,
                                        this.$message({
                                            type: 'success',
                                            message: '删除成功!'
                                        });
                                },
                                error: function (returndata) {
                                    console.log(returndata),
                                        vm.$message({
                                            type: 'error',
                                            message: '删除失敗,請聯絡系統管理員'
                                        });
                                }
                            })


                        }).catch(() => {
                            this.$message({
                                type: 'info',
                                message: '已取消删除'
                            });
                        });
                    },
                    //新增子項
                    addLibrary() {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/system/addLibrary?librarygroup=' + librarygroup + "&libraryoption=" + this.libraryoption,
                            type: 'POST',
                            success: response => {
                                this.list = response,
                                    this.list = response,
                                    this.$message({
                                        type: 'success',
                                        message: '新增成功!'
                                    });
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        })
                    },
                    //查詢紀錄
                    record() {
                        this.recordVisible = true;
                        $.ajax({
                            url: '${pageContext.request.contextPath}/system/SetectLibraryRecord/' + librarygroup,
                            type: 'POST',
                            success: response => {
                                this.recordList = response 
                            },
                            error: function (returndata) {
                                console.log(returndata),
                                    vm.$message({
                                        type: 'error',
                                        message: '讀取紀錄失敗,請聯絡系統管理員'
                                    });
                            }
                        })

                    }
                }
            })
        </script>
        <script>

        </script>

        </html>