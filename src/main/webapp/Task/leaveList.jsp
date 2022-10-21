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

                tr {
                    background-color: #FFFFAA;
                }

                .leave {
                    /* 按鈕顏色 */
                    background-color: #afe3d5;
                }

                .el-month-table tr {
                    background-color: #FFF;
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
                            <!--  -->
                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-12 text-center">
                                        <p>&nbsp;</p>
                                        <el-button type="text" @click="changeMon(-1)"> ❮❮</el-button>
                                        &nbsp;&nbsp;
                                        <el-date-picker v-model="inday" type="month" @change="changeTime">
                                        </el-date-picker>
                                        &nbsp;&nbsp;
                                        <el-button type="text" @click="changeMon(1)">❯❯</el-button>

                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-1">
                                        <c:if test="${user.position == '主管' || user.position == '系統' }">
                                            <a href="${pageContext.request.contextPath}/Task/leave.jsp">請假申請</a>
                                        </c:if><br><br>
                                        <a
                                            :href="'${pageContext.request.contextPath}/Task/calendar.jsp?inday='+inday">月歷</a>
                                    </div>
                                    <div class="col-md-8" v-loading="loading" element-loading-text="拼命加载中"
                                        element-loading-spinner="el-icon-loading">
                                        <p>&nbsp;</p>
                                        <table class="table table-bordered border border-dark border-2">
                                            <tr class="text-center">
                                                <td>日期</td>
                                                <td>部門</td>
                                                <td>姓名</td>
                                                <td>假別</td>
                                                <td>備註</td>
                                            </tr>
                                            <tr v-for="(s, index) in list" :key="index">
                                                <td>{{s.leaveday}}</td>
                                                <td> {{s.department}}</td>
                                                <td> {{s.user}}</td>
                                                <td> {{s.leaveName}}</td>
                                                <td><a
                                                        :href="'${pageContext.request.contextPath}/Task/leave.jsp?id='+s.leaveid">{{s.remark}}</a>

                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="block">
                                            <el-date-picker v-model="value2" type="monthrange" align="right"
                                                value-format="yyyy-MM-dd" unlink-panels range-separator="至"
                                                start-placeholder="開始月份" end-placeholder="結束月份"
                                                :picker-options="pickerOptions">
                                            </el-date-picker>
                                        </div>
                                        <input type="text" placeholder="人員" list="person" v-model="person">
                                        <button @click="searchPerson">搜索</button>
                                        <datalist id="person">
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                items="${admin}" var="s">
                                                <option value="${s.name}">
                                                </option>
                                            </c:forEach>
                                        </datalist>
                                    </div>
                                </div>
                                <!-- . -->
                                <div class="row ">
                                    <div class="col-md-12"></div>
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
                        inday: "",
                        list: [],
                        pickerOptions: {
                            shortcuts: [{
                                text: '本月',
                                onClick(picker) {
                                    picker.$emit('pick', [new Date(new Date().getFullYear(), new Date().getMonth()), new Date()]);
                                }
                            }, {
                                text: '今年至今',
                                onClick(picker) {
                                    const end = new Date();
                                    const start = new Date(new Date().getFullYear(), 0);
                                    picker.$emit('pick', [start, end]);
                                }
                            }, {
                                text: '最近六个月',
                                onClick(picker) {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setMonth(start.getMonth() - 6);
                                    picker.$emit('pick', [start, end]);
                                }
                            }]
                        },
                        value2: '',
                        car: "",
                        loading: true,
                        person: "",
                    }
                },
                created() {
                    this.inday = this.formatMon(new Date());
                    this.getLeave(this.inday);
                },
                methods: {
                    //切換月份 日期選擇器
                    changeTime() {
                        this.getLeave(this.formatMon(this.inday));
                    },
                    //讀取資料
                    getLeave(mon) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/getLeave/" + mon,
                            type: 'get',
                            async: false,
                            cache: false,
                            success: response => {
                                console.log(response.data);
                                if (response.code == 200) {
                                    this.list = response.data;
                                }
                                this.loading = false;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    //格式化日期
                    formatMon(myDate) {
                        let mon = (myDate.getMonth() + 1) + "";
                        return myDate.getFullYear() + "-" + mon.padStart(2, "0");
                    },
                    //切換上下月份
                    changeMon(i) {
                        let myDate = new Date(this.inday)
                        myDate.setMonth(myDate.getMonth() + i);
                        this.inday = this.formatMon(myDate);
                        this.getLeave(this.inday);
                    },
                    //搜索人員
                    searchPerson() {
                        this.loading = true;
                        if (this.person == "") {
                            this.$message.error("輸入人員");
                        } else {
                            let data = "person=" + this.person + "&start=" + this.value2[0] + "&end=" + this.value2[1];
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/searchLeaveByPerson",
                                type: 'post',
                                data: data,
                                async: false,
                                cache: false,
                                success: response => {
                                    console.log("TripList ", response.data);
                                    if (response.code == 200) {
                                        this.list = response.data;
                                    }
                                    this.loading = false;
                                },
                                error: function (returndata) {
                                    this.$message.error("發生錯誤")
                                    console.log(returndata);
                                }
                            });
                        }
                    }
                },
            })
        </script>




        </html>