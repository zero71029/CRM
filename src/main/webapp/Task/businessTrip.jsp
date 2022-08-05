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
                                            <input type="hidden" name="schedule" value="${user.name}"
                                                placeholder="排程人員">
                                            <span style="color: red;font-size: 20px;">新增行程 </span> 排程人員： ${user.name}

                                            <span style="float: right;">
                                                行程日期：
                                                <el-date-picker v-model="tripDay" type="date" placeholder="行程日期">
                                                </el-date-picker>
                                                預估時間:
                                                <el-input v-model="expected" maxlength="100" style="width: auto;">
                                                </el-input>
                                            </span>
                                            <br><br>
                                            負責人員1<el-input v-model="expected" maxlength="100" style="width: auto;">
                                            </el-input>
                                            負責人員2<el-input v-model="expected" maxlength="100" style="width: auto;">
                                            </el-input>
                                            負責人員3<el-input v-model="expected" maxlength="100" style="width: auto;">
                                            </el-input>


                                            <hr>
                                            <table class="table  table-bordered border border-dark">
                                                <tr>
                                                    <td>
                                                        行程目的
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" id="inputDepartment"
                                                            name="department" maxlength="10">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        行程類型
                                                    </td>
                                                    <td>
                                                        <select name="" id="">
                                                            <option value="">北上</option>
                                                            <option value="">中部</option>
                                                            <option value="">南下</option>
                                                            <option value="">其他</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        行程內容
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" id="inputDepartment"
                                                            name="department" maxlength="10">
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
                        tripDay: "",//行程日期
                        expected: "",//預計時間







                    }
                },
                created() {
                    let day = new Date();
                    this.applyDay = day.getFullYear() + "-" + (day.getMonth() + 1) + "-" + day.getDay();
                },
                methods: {
                    changeLeaveOther() {
                        this.leaveName = this.leaveOther;
                    },
                    changeLeaveName() {
                        this.leaveOther = "";
                    },
                    changeTime() {
                        if (this.startDay == "") return;
                        if (this.endDay == "") return;
                        const day1 = new Date(this.startDay + this.startTime);
                        const day2 = new Date(this.endDay + this.endTime);
                        const difference = day2.getTime() - day1.getTime();
                        const days = parseInt(difference / (1000 * 3600 * 24));
                        const h = difference - (days * 1000 * 3600 * 24);
                        const hours = h / (1000 * 3600);
                        this.totalTime = days + " 天 " + hours + " 時";
                    },
                    sumbitForm() {
                        let isok = true;
                        if (this.user == "") {
                            isok = false;
                            this.$message.error("申請人為空");
                            $("#inputUser").css("border", "1px solid red");
                        }
                        if (this.department == "") {
                            isok = false;
                            this.$message.error("部門為空");
                            $("#inputDepartment").css("border", "1px solid red");
                        }
                        if (!(this.leaveName != "" || this.leaveOther != "")) {
                            isok = false;
                            this.$message.error("假別為空");
                            $("#inLeave").css("border", "1px solid red");
                        }
                        if (this.agent == "") {
                            isok = false;
                            this.$message.error("職務代理人為空");
                            $("#inputAgent").css("border", "1px solid red");
                        }
                        if (this.reason == "") {
                            isok = false;
                            this.$message.error("事由為空");
                            $("#inReason").css("border", "1px solid red");
                        }
                        if (this.startDay == "" || this.endDay == "") {
                            isok = false;
                            this.$message.error("請假時間為空");
                            $("#leaveTime").css("border", "1px solid red");
                        }
                        console.log("this.applyday", this.applyDay);
                        if (isok) {
                            this.startDay += this.startTime;
                            this.endDay += this.endTime;
                            var data = new FormData(document.getElementById("leaveForm"));
                            data.append("startday", this.startDay);
                            data.append("endday", this.endDay);
                            data.append("leaveName", this.leaveName);
                            data.append("applyday", this.applyDay);
                            data.append("totalTime", this.totalTime);
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/saveLeave",//接受請求的Servlet地址
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