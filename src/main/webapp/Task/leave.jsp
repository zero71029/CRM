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
                                                                    v-model="bean.user" name="user" max="90">
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="mb-3 row">
                                                            <label for="inputDepartment"
                                                                class=" col-form-label">部門:</label>
                                                            <div class="">
                                                                <input type="text" class="form-control"
                                                                    v-model="bean.department" id="inputDepartment"
                                                                    name="department" maxlength="10">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td id="inLeave">假別:&nbsp;&nbsp;
                                                        <el-radio v-model="bean.leaveName" label="病假"
                                                            @change="changeLeaveName">病假</el-radio>
                                                        <el-radio v-model="bean.leaveName" label="事假"
                                                            @change="changeLeaveName">事假</el-radio>
                                                        <el-radio v-model="bean.leaveName" label="特休"
                                                            @change="changeLeaveName">特休</el-radio>
                                                        <br><br>
                                                        <el-input @change="changeLeaveOther" placeholder="其他"
                                                            v-model="bean.leaveOther" maxlength="80"></el-input>

                                                    </td>
                                                    <td>
                                                        <div class="mb-3 row">
                                                            <label for="inputAgent"
                                                                class=" col-form-label">職務代理人:</label>
                                                            <div class="">
                                                                <input type="text" class="form-control" id="inputAgent"
                                                                    name="agent" v-model="bean.agent"
                                                                    style="margin-top: 6px;" maxlength="100">
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">事由: <br>
                                                        <el-input type="textarea" :autosize="{ minRows: 3}"
                                                            name="reason" maxlength="500" show-word-limit id="inReason"
                                                            v-model="bean.reason">
                                                        </el-input>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td colspan="2" id="leaveTime">請假時間: <br>
                                                        <el-date-picker v-model="bean.startDay" name="startDay"
                                                            type="date" placeholder="起始日期" format="yyyy 年 MM 月 dd 日"
                                                            value-format="yyyy-MM-dd" @change="changeTime">
                                                        </el-date-picker>
                                                        &nbsp;
                                                        <select name="startTime" @change="changeTime"
                                                            v-model="bean.startTime">
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
                                                        <el-date-picker v-model="bean.endDay" name="endDay" type="date"
                                                            placeholder="結束日期" format="yyyy 年 MM 月 dd 日"
                                                            value-format="yyyy-MM-dd" @change="changeTime">
                                                        </el-date-picker>
                                                        &nbsp;
                                                        <select name="endTime" @change="changeTime"
                                                            v-model="bean.endTime">
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
                                                        <span style="float: right;">共計:{{bean.totalTime}}</span>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td>主管核准:<el-input v-model="bean.director" name="director">
                                                        </el-input>
                                                    </td>
                                                    <td>申請日期: <br>
                                                        <el-date-picker style="width: 100%;" type="date" name="applyDay"
                                                            v-model="bean.applyday" placeholder="选择日期"
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
                                            
                                            <c:if test="${empty param.id}">
                                                <el-button type="primary" @click="sumbitForm">送出請假單</el-button>
                                            </c:if>
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
                        bean: {
                            user: "${user.name}",
                            department: "${user.department}",
                            startTime: "T08:00",
                            endTime: "T17:00",
                            leaveName:"" , 
                            leaveOther:"",
                            agent:"",
                            reason:"",
                            startDay:"",
                            endDay:""
                        },
                    }
                },
                created() {
                    //
                    const day = new Date();
                    const mm = (day.getMonth() + 1) + "";
                    const dd = day.getDate() + "";
                    this.bean.applyday = day.getFullYear() + "-" + mm.padStart(2, "0") + "-" + dd.padStart(2, "0");
                    //
                    const url = new URL(location.href);
                    const id = url.searchParams.get("id");
                    if (id != "" && id != null) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/leave/" + id,
                            type: 'POST',
                            success: response => {
                                if (response.code == 200) {
                                    this.bean = response.data;
                                    this.bean.leaveOther = this.bean.leaveName
                                    this.bean.startDay = response.data.startday.substring(0, 10);
                                    this.bean.startTime = response.data.startday.substring(10);
                                    this.bean.endDay = response.data.endday.substring(0, 10);
                                    this.bean.endTime = response.data.endday.substring(10);
                                    this.changeTime();

                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                },
                methods: {
                    changeLeaveOther() {
                        this.bean.leaveName = this.bean.leaveOther;
                    },
                    changeLeaveName() {
                        this.bean.leaveOther = "";
                    },
                    changeTime() {
                        if (this.bean.startDay != undefined) {
                            if (this.bean.endDay != undefined) {
                                const day1 = new Date(this.bean.startDay + this.bean.startTime);
                                const day2 = new Date(this.bean.endDay + this.bean.endTime);
                                const difference = day2.getTime() - day1.getTime();
                                const days = parseInt(difference / (1000 * 3600 * 24));
                                const h = difference - (days * 1000 * 3600 * 24);
                                const hours = h / (1000 * 3600);
                                this.bean.totalTime = days + " 天 " + hours + " 時";
                                console.log("this.bean.totalTime", this.bean.totalTime);
                                this.$forceUpdate();
                            }
                        };
                    },
                    sumbitForm() {
                        let isok = true;
                        if (this.bean.user == "") {
                            isok = false;
                            this.$message.error("申請人為空");
                            $("#inputUser").css("border", "1px solid red");
                        }
                        if (this.bean.department == "") {
                            isok = false;
                            this.$message.error("部門為空");
                            $("#inputDepartment").css("border", "1px solid red");
                        }
                        if (!(this.bean.leaveName != "" || this.bean.leaveOther != "")) {
                            isok = false;
                            this.$message.error("假別為空");
                            $("#inLeave").css("border", "1px solid red");
                        }
                        if (this.bean.agent == "") {
                            isok = false;
                            this.$message.error("職務代理人為空");
                            $("#inputAgent").css("border", "1px solid red");
                        }
                        if (this.bean.reason == "") {
                            isok = false;
                            this.$message.error("事由為空");
                            $("#inReason").css("border", "1px solid red");
                        }
                        if (this.bean.startDay == "" || this.bean.endDay == "") {
                            isok = false;
                            this.$message.error("請假時間為空");
                            $("#leaveTime").css("border", "1px solid red");
                        }
                        console.log("this.applyday", this.bean.applyday);
                        if (isok) {
                            this.bean.startDay += this.bean.startTime;
                            this.bean.endDay += this.bean.endTime;
                            var data = new FormData(document.getElementById("leaveForm"));
                            data.append("startday", this.bean.startDay);
                            data.append("endday", this.bean.endDay);
                            data.append("leaveName", this.bean.leaveName);
                            data.append("applyday", this.bean.applyday);
                            data.append("totalTime", this.bean.totalTime);
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
                                                location.href = "${pageContext.request.contextPath}/Task/leaveList.jsp";
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