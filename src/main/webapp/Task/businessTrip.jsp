<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>
                [v-cloak] {
                    display: none;
                }

                .app {
                    background-color: #e4f3ef;
                }

                input {
                    background-color: #e4f3ef !important;
                }

                select {
                    background-color: #e4f3ef !important;
                }

                textarea {
                    background-color: #e4f3ef !important;
                }

                .el-input__count {
                    background-color: #e4f3ef !important;
                }


                .businessTrip {
                    /* 按鈕顏色 */
                    background-color: #afe3d5;
                }

                table {
                    font-size: 20px;
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
                        <div class="row ">
                            <div class="col-md-2"></div>
                            <div class="col-md-10">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-8 ">
                                        <p style="text-align: center;font-size: 48px;">出差申請</p>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-8 ">
                                        <form action="" method="post" id="leaveForm">
                                          
                                      
                                            <input type="hidden" name="schedule" value="${user.name}" id="schedule"
                                                placeholder="排程人員">
                                            <span style="color: red;font-size: 20px;line-height: 40px;">新增行程 </span>
                                            排程人員： ${user.name}

                                            <span style="float: right;">
                                                行程日期：
                                                <el-date-picker name="tripDay" v-model="tripDay" type="date"
                                                    placeholder="行程日期" id="tripDay">
                                                </el-date-picker>
                                                預估時間:
                                                <el-input v-model="expected" name="expected" maxlength="100"
                                                    style="width: auto;" id="expected">
                                                </el-input>
                                            </span>
                                            <br><br>
                                            負責人員1<el-input v-model="responsible1" name="responsible1" maxlength="100"
                                                style="width: auto;">
                                            </el-input>
                                            &nbsp;&nbsp;&nbsp;負責人員2<el-input v-model="responsible2" name="responsible2"
                                                maxlength="100" style="width: auto;">
                                            </el-input>
                                            &nbsp;&nbsp;&nbsp;負責人員3<el-input v-model="responsible3" name="responsible3"
                                                maxlength="100" style="width: auto;">
                                            </el-input>


                                            <hr>
                                            <table class="table  table-bordered border border-dark">
                                                <tr>
                                                    <td>
                                                        行程目的
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" v-model="tripName"
                                                            id="tripName" name="tripName" maxlength="10">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        行程類型
                                                    </td>
                                                    <td>
                                                        <select name="type">
                                                            <option value="北上">北上</option>
                                                            <option value="中部">中部</option>
                                                            <option value="南下">南下</option>
                                                            <option value="其他">其他</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        行程內容
                                                    </td>
                                                    <td>
                                                        <el-input name="content" id="content" type="textarea"
                                                            placeholder="請输入内容" v-model="content" maxlength="900"
                                                            :autosize="{ minRows: 4}" show-word-limit>
                                                        </el-input>
                                                    </td>
                                                </tr>
                                            </table>
                                        </form>
                                        <p style="text-align: center;">
                                            <el-button type="primary" @click="sumbitForm">送出請假單</el-button>
                                        </p>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            $(".employee").show();
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        tripidL:"",
                        tripDay: "",//行程日期
                        expected: "",//預計時間
                        content: "",//行程內容
                        type: "",//行程類型
                        tripName: "",//行程目的
                        responsible1: "",//負責人員
                        responsible2: "",//負責人員
                        responsible3: "",//負責人員
                        schedule: "${user.name}",
                    }
                },
                created() {

                },
                methods: {
                    sumbitForm() {
                        let isok = true;
                        if (this.tripDay == "") {
                            isok = false;
                            this.$message.error("行程日期為空");
                            $("#tripDay").css("border", "1px solid red");
                        }
                        if (this.expected == "") {
                            isok = false;
                            this.$message.error("預計時間為空");
                            $("#expected").css("border", "1px solid red");
                        }
                        if (!(this.content != "")) {
                            isok = false;
                            this.$message.error("行程內容為空");
                            $("#content").css("border", "1px solid red");
                        }
                        if (this.tripName == "") {
                            isok = false;
                            this.$message.error("行程目的為空");
                            $("#tripName").css("border", "1px solid red");
                        }
                        if (isok) {
                            var data = new FormData(document.getElementById("leaveForm"));
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/saveBusinessTrip",//接受請求的Servlet地址
                                type: 'POST',
                                data: data,
                                async: false,//同步請求
                                cache: false,//不快取頁面
                                contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                                processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                                success: response => {
                                    if (response.code == 200) {
                                        this.$alert(response.message, '申請成功', {
                                            confirmButtonText: '確定',
                                            callback: action => {
                                                this.$message({
                                                    type: 'info',
                                                    message: `action: ${action}`
                                                });
                                            }
                                        });
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