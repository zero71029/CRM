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
                    <div class="col-md-11 app">
                        <div class="row " v-cloak>
                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->
                                <p style="text-align: center;font-size: 48px;">請假單 <span v-show="bean.del == 1" style="color: red;">(刪除)</span></p>
                                <div class="row ">
                                    <div class="col-md-2"></div>
                                    <div class="col-md-8 ">
                                        <form action="" method="post" id="leaveForm">
                                            <input type="hidden" v-model="bean.del" name="del">
                                            <input type="hidden" v-model="bean.uuid" name="uuid">
                                            <input type="hidden" v-model="bean.leaveid" name="leaveid">
                                            <table class="table  table-bordered border border-dark">
                                                <tr>
                                                    <td>
                                                        <div class="mb-3 row">
                                                            <label for="inputUser" class="col-form-label">申請人:</label>
                                                            <div class="">
                                                                <input type="text" class="form-control" id="inputUser"
                                                                    v-model="bean.user" name="user" max="90"
                                                                    list="browsers">
                                                                <datalist id="browsers">
                                                                    <c:forEach varStatus="loop" begin="0"
                                                                        end="${admin.size()-1}" items="${admin}"
                                                                        var="s">
                                                                        <option value="${s.name}">
                                                                        </option>
                                                                    </c:forEach>
                                                                </datalist>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="mb-3 row">
                                                            <label for="inputDepartment"
                                                                class=" col-form-label">部門:</label>
                                                            <div class="">
                                                                <select class="form-control" v-model="bean.department"
                                                                    id="inputDepartment" name="department">
                                                                    <option value="生產">
                                                                        生產</option>
                                                                    <option value="採購">
                                                                        採購</option>
                                                                    <option value="研發">
                                                                        研發</option>
                                                                    <option value="業務">
                                                                        業務</option>
                                                                    <option value="行銷">
                                                                        行銷</option>
                                                                    <option value="財務">
                                                                        財務</option>
                                                                    <option value="IT">
                                                                        IT</option>
                                                                    <option value="國貿">
                                                                        國貿</option>
                                                                </select>
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
                                                        <el-radio v-model="bean.leaveName" label="其他"
                                                            @change="changeLeaveName">其他</el-radio>
                                                        <br><br>
                                                        <el-input v-show="bean.leaveName =='其他'"
                                                            @change="changeLeaveOther" placeholder="其他"
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
                                                            value-format="yyyy-MM-dd" @input="changeTime">
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
                                                            value-format="yyyy-MM-dd" @input="changeTime">
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
                                                    <td @click="clickDirector">主管核准 &nbsp;:
                                                        &nbsp;&nbsp;<span>{{bean.director}}</span>
                                                        <el-result v-show="bean.director == ''" icon="info" title="點擊核准"
                                                            style="padding: 0px;"></el-result>
                                                        <el-result v-show="bean.director != ''" icon="success"
                                                            style="padding: 0px;"></el-result>
                                                        <input v-model="bean.director" name="director" type="hidden"
                                                            style="border: 0px;">
                                                    </td>
                                                    <td>申請日期: <br>
                                                        <el-date-picker style="width: 100%;" type="date" name="applyDay"
                                                            v-model="bean.applyday" placeholder="选择日期"
                                                            format="yyyy 年 MM 月 dd 日" value-format="yyyy-MM-dd">
                                                        </el-date-picker>
                                                    </td>
                                                </tr>
                                                <!-- <tr>
                                                    <td colspan="2">備註:核准後此單請教人事部保管</td>
                                                </tr> -->
                                            </table>
                                        </form>
                                        <p style="text-align: center;">
                                            <c:if test="${user.position == '主管'  || user.position == '系統'}">
                                                <el-button type="primary" v-show="bean.uuid != ''" @click="sumbitForm">
                                                    送出</el-button>
                                                <el-button type="danger" v-show="bean.uuid != ''" @click="delLeave">
                                                    刪除
                                                </el-button>
                                            </c:if>
                                            <el-button type="primary" v-show="bean.uuid == ''" @click="sumbitForm">送出
                                            </el-button>
                                        </p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-lg-11"></div>
                                    <div class="col-lg-1">
                                        <el-link type="primary" @click="dialogVisible = true">紀錄</el-link>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- <%-- 彈窗  修改紀錄--%> -->
                        <el-dialog title="修改紀錄" :visible.sync="dialogVisible" width="50%">
                            <el-table :data="changeMessageList" height="450">
                                <el-table-column property="name" label="姓名"></el-table-column>
                                <el-table-column property="filed" label="欄位"></el-table-column>
                                <el-table-column property="source" label="原本"></el-table-column>
                                <el-table-column property="after" label="修改後"></el-table-column>
                                <el-table-column property="createtime" label="日期" width="120"></el-table-column>
                            </el-table>
                        </el-dialog>
                    </div>

                </div>
            </div>
        </body>
        <script>
            const url = new URL(location.href);
            const id = url.searchParams.get("id");
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
                            leaveName: "",
                            leaveOther: "",
                            agent: "",
                            reason: "",
                            startDay: "",
                            endDay: "",
                            director: "",
                            uuid: "",                           
                            del:0,
                        },
                        dialogVisible: false,
                        changeMessageList:[],
                        oldBean:{},
                    }
                },
                created() {
                    //
                    const day = new Date();
                    const mm = (day.getMonth() + 1) + "";
                    const dd = day.getDate() + "";
                    this.bean.applyday = day.getFullYear() + "-" + mm.padStart(2, "0") + "-" + dd.padStart(2, "0");
                    //

                    if (id != "" && id != null) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/leave/" + id,
                            type: 'POST',
                            success: response => {
                                if (response.code == 200) {
                                    this.bean = response.data.bean;                               
                                    this.bean.leaveOther = this.bean.leaveName
                                    this.bean.startDay = response.data.bean.startday.substring(0, 10);
                                    this.bean.startTime = response.data.bean.startday.substring(10);
                                    this.bean.endDay = response.data.bean.endday.substring(0, 10);
                                    this.bean.endTime = response.data.bean.endday.substring(10);
                                    this.oldBean = Object.assign({}, this.bean);
                                    this.changeMessageList = response.data.changeMessageList;
                                    this.changeTime();

                                    if (this.bean.leaveName == '事假' || this.bean.leaveName == '病假' || this.bean.leaveName == '特休') {

                                    } else {
                                        this.bean.leaveOther = this.bean.leaveName;
                                        this.bean.leaveName = '其他';
                                    }
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
                    changeTime() {//
                        if (this.bean.startDay != undefined) {
                            if (this.bean.endDay != undefined) {
                                const day1 = new Date(this.bean.startDay + this.bean.startTime);
                                const day2 = new Date(this.bean.endDay + this.bean.endTime);
                                const difference = day2.getTime() - day1.getTime();
                                const days = parseInt(difference / (1000 * 3600 * 24));
                                const h = difference - (days * 1000 * 3600 * 24);
                                const hours = h / (1000 * 3600);
                                this.bean.totalTime = days + " 天 " + hours + " 時";
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
                        if (this.bean.leaveName == '其他' && this.bean.leaveOther == '') {
                            isok = false;
                            this.$message.error("其他需填寫");
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
                        if (isok) {
                            //如果不是新資料 就 紀錄修改
                            console.log(this.oldBean)
                            console.log(this.bean)
                            if (this.bean.uuid != "") {
                                var keys = Object.keys(this.bean);
                                var data = {};
                                var hasSave = false;
                                for (const iterator of keys) {
                                    if (this.bean[iterator] == this.oldBean[iterator]) {

                                    } else {
                                        data[iterator] = [this.bean[iterator], this.oldBean[iterator]];
                                        hasSave = true;
                                    }
                                }
                                if (hasSave) {
                                    axios
                                        .post('${pageContext.request.contextPath}/changeMessage/' + this.bean.uuid, data)
                                        .then(
                                            response => (
                                                console.log("response3")
                                            ))
                                } else {
                                    this.$message.error('沒有任何改變');
                                }
                            }
                            //
                            this.bean.startDay += this.bean.startTime;
                            this.bean.endDay += this.bean.endTime;
                            var data = new FormData(document.getElementById("leaveForm"));
                            data.append("startday", this.bean.startDay);
                            data.append("endday", this.bean.endDay);
                            data.append("leaveName", this.bean.leaveName);
                            data.append("applyday", this.bean.applyday);
                            data.append("totalTime", this.bean.totalTime);
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/saveLeave",
                                type: 'POST',
                                data: data,
                                async: false,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: response => {
                                    if (response.code == 200) {
                                        this.$alert(response.message, '申請成功', {
                                            confirmButtonText: '確定',
                                            callback: action => {
                                                location.href = "${pageContext.request.contextPath}/Task/leaveList.jsp";
                                            }
                                        });
                                    }
                                    if (response.code == 300) {
                                        this.$message.error(response.message);
                                    }
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        }
                    },

                    clickDirector() {
                        if ('${user.name}' == '') {
                            return '';
                        }
                        if ('${user.department}' != this.bean.department) {
                            return '';
                        }
                        if ('${user.position}' == '主管' || '${user.position}' == '系統') {
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/clickDirector?id=" + id,
                                type: 'POST',
                                success: response => {
                                    if (response.code == 200) {
                                        this.bean.director = response.data;
                                        this.$message.success(response.message);
                                    }
                                    if (response.code == 300) {
                                        this.$message.error(response.message);
                                    }
                                    location.href='${pageContext.request.contextPath}/Task/leave.jsp?id='+id;
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        }
                    },
                    delLeave() {
                        this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
                            confirmButtonText: '确定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(() => {
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/delLeave?uuid=" + this.bean.uuid,
                                type: 'POST',
                                success: response => {
                                    if (response.code == 200) {
                                        location.href = "${pageContext.request.contextPath}/Task/leaveList.jsp";
                                    }
                                    if (response.code == 300) {
                                        this.$message.error(response.message);
                                    }
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        }).catch(() => {
                            this.$message({
                                type: 'info',
                                message: '已取消删除'
                            });
                        });
                    },
                },
            })
        </script>




        </html>