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


                .leave {
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
                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->
                                <p style="text-align: center;font-size: 48px;">請假單</p>
                                <div class="row ">
                                    <div class="col-md-2"></div>
                                    <div class="col-md-8 ">
                                        <form action="" method="post" id="leaveForm">
                                            <table class="table  table-bordered border border-dark">
                                                <tr>
                                                    <td>
                                                        <div class="mb-3 row">
                                                            <label for="inputUser" class="col-form-label">申請人:</label>
                                                            <div class="">
                                                                <input type="text" class="form-control" id="inputUser"
                                                                    v-model="user" name="user" max="90">
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="mb-3 row">
                                                            <label for="inputDepartment"
                                                                class=" col-form-label">部門:</label>
                                                            <div class="">
                                                                <input type="text" class="form-control"
                                                                    v-model="department" id="inputDepartment"
                                                                    name="department" maxlength="10">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="inLeave">假別:&nbsp;&nbsp;
                                                        <el-radio v-model="leaveName" label="病假"
                                                            @change="changeLeaveName">病假</el-radio>
                                                        <el-radio v-model="leaveName" label="事假"
                                                            @change="changeLeaveName">事假</el-radio>
                                                        <el-radio v-model="leaveName" label="特休"
                                                            @change="changeLeaveName">特休</el-radio>
                                                        <br><br>


                                                        <el-input @change="changeLeaveOther" placeholder="其他"
                                                            v-model="leaveOther" maxlength="80"></el-input>




                                                    </td>
                                                    <td>
                                                        <div class="mb-3 row">
                                                            <label for="inputAgent"
                                                                class=" col-form-label">職務代理人:</label>
                                                            <div class="">
                                                                <input type="text" class="form-control" id="inputAgent"
                                                                    name="agent" v-model="agent"
                                                                    style="margin-top: 6px;" maxlength="100">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">事由: <br>
                                                        <el-input type="textarea" :autosize="{ minRows: 3}"
                                                            name="reason" maxlength="500" show-word-limit id="inReason"
                                                            v-model="reason">
                                                        </el-input>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td colspan="2" id="leaveTime">請假時間: <br>
                                                        <el-date-picker v-model="startDay" name="startDay" type="date"
                                                            placeholder="起始日期" format="yyyy 年 MM 月 dd 日"
                                                            value-format="yyyy-MM-dd" @change="changeTime">
                                                        </el-date-picker>
                                                        &nbsp;
                                                        <select name="startTime" @change="changeTime"
                                                            v-model="startTime">
                                                            <option value="T01:00">01</option>
                                                            <option value="T02:00">02</option>
                                                            <option value="T03:00">03</option>
                                                            <option value="T04:00">04</option>
                                                            <option value="T05:00">05</option>
                                                            <option value="T06:00">06</option>
                                                            <option value="T07:00">07</option>
                                                            <option value="T08:00">08</option>
                                                            <option value="T09:00">09</option>
                                                            <option value="T10:00">10</option>
                                                            <option value="T11:00">11</option>
                                                            <option value="T12:00">12</option>
                                                            <option value="T13:00">13</option>
                                                            <option value="T14:00">14</option>
                                                            <option value="T15:00">15</option>
                                                            <option value="T16:00">16</option>
                                                            <option value="T17:00">17</option>
                                                            <option value="T18:00">18</option>
                                                            <option value="T19:00">19</option>
                                                            <option value="T20:00">20</option>
                                                            <option value="T21:00">21</option>
                                                            <option value="T22:00">22</option>
                                                            <option value="T23:00">23</option>
                                                            <option value="T24:00">24</option>
                                                        </select>時
                                                        <hr>
                                                        <el-date-picker v-model="endDay" name="endDay" type="date"
                                                            placeholder="結束日期" format="yyyy 年 MM 月 dd 日"
                                                            value-format="yyyy-MM-dd" @change="changeTime">
                                                        </el-date-picker>
                                                        &nbsp;
                                                        <select name="endTime" @change="changeTime" v-model="endTime">
                                                            <option value="T01:00">01</option>
                                                            <option value="T02:00">02</option>
                                                            <option value="T03:00">03</option>
                                                            <option value="T04:00">04</option>
                                                            <option value="T05:00">05</option>
                                                            <option value="T06:00">06</option>
                                                            <option value="T07:00">07</option>
                                                            <option value="T08:00">08</option>
                                                            <option value="T09:00">09</option>
                                                            <option value="T10:00">10</option>
                                                            <option value="T11:00">11</option>
                                                            <option value="T12:00">12</option>
                                                            <option value="T13:00">13</option>
                                                            <option value="T14:00">14</option>
                                                            <option value="T15:00">15</option>
                                                            <option value="T16:00">16</option>
                                                            <option value="T17:00">17</option>
                                                            <option value="T18:00">18</option>
                                                            <option value="T19:00">19</option>
                                                            <option value="T20:00">20</option>
                                                            <option value="T21:00">21</option>
                                                            <option value="T22:00">22</option>
                                                            <option value="T23:00">23</option>
                                                            <option value="T24:00">24</option>
                                                        </select>時
                                                        <span style="float: right;">共計:{{totalTime}}</span>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td>主管核准:<el-input v-model="director" name="director"></el-input>
                                                    </td>
                                                    <td>申請日期: <br>
                                                        <el-date-picker style="width: 100%;" type="date" name="applyDay"
                                                            v-model="applyDay" placeholder="选择日期"
                                                            format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd">
                                                        </el-date-picker>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">備註:核准後此單請教人事部保管</td>
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
                        reason: "",
                        startDay: "",
                        endDay: "",
                        director: "",
                        applyDay: "",
                        user: "${user.name}",
                        department: "${user.department}",
                        leaveName: [],
                        agent: "",
                        startTime: "T08:00",
                        endTime: "T17:00",
                        totalTime: "",
                        leaveOther: "",
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