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
                    <div class="col-md-11 app" >
                        <div class="row " v-cloak>
                            <div class="col-md-2"></div>
                            <div class="col-md-10">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row ">
                                    <div class="col-md-8 ">
                                        <p style="text-align: center;font-size: 48px;">出差申請<span v-show="bean.del == 1" style="color: red;">(刪除)</span></p>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-9 ">
                                        <form action="" method="post" id="leaveForm">
                                            <input type="hidden" v-model="bean.del" name="del">
                                            <input type="hidden" v-model="bean.uuid" name="uuid">
                                            <input type="hidden" v-model="bean.tripid" name="tripid">
                                            <input type="hidden" name="director" v-model="bean.director">
                                            <span style="color: red;font-size: 20px;line-height: 40px;">新增行程 </span>
                                            排程人員：
                                            <!-- <c:if test="${empty param.id}">
                                                ${user.name}
                                            </c:if>
                                            <c:if test="${not empty param.id}">
                                                {{bean.schedule}}
                                            </c:if> -->
                                            <el-select v-model="bean.schedule" placeholder="" name="schedule">

                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                    items="${admin}" var="s">
                                                    <el-option label="${s.name}" value="${s.name}">
                                                    </el-option>
                                                </c:forEach>
                                            </el-select>
                                            <span style="float: right;">
                                                行程日期：
                                                <el-date-picker name="tripday" v-model="bean.tripday" type="date"
                                                    placeholder="行程日期" id="tripday">
                                                </el-date-picker>
                                                預估時間:
                                                <el-select v-model="bean.expected" name="expected">
                                                    <el-option label="半天" value="半天"></el-option>
                                                    <el-option label="1天" value="1天"></el-option>
                                                    <el-option label="2天" value="2天"></el-option>
                                                    <el-option label="3天" value="3天"></el-option>
                                                    <el-option label="4天" value="4天"></el-option>
                                                    <el-option label="5天" value="5天"></el-option>
                                                    <el-option label="6天" value="6天"></el-option>
                                                    <el-option label="7天" value="7天"></el-option>
                                                </el-select>
                                            </span>
                                            <br><br>
                                            主負責人<el-input v-model="bean.responsible1" name="responsible1"
                                                maxlength="100" style="width: auto;">
                                            </el-input>
                                            &nbsp;&nbsp;&nbsp;次負責人<el-input v-model="bean.responsible2"
                                                name="responsible2" maxlength="100" style="width: auto;">
                                            </el-input>
                                            &nbsp;&nbsp;&nbsp;協從人<el-input v-model="bean.responsible3"
                                                name="responsible3" maxlength="100" style="width: auto;">
                                            </el-input>
                                            &nbsp;&nbsp;&nbsp;
                                            <!-- 新增協從人 cooperator-->
                                            <el-button type="primary" icon="el-icon-edit" size="medium" circle
                                                @click="addCooperator">
                                            </el-button>
                                            <br><br>
                                            <div class="row">
                                                <div class="col-lg-4" v-for="(s, index) in bean.cooperator"
                                                    :key="index">
                                                    協從人<el-input v-model="s.name" :name="'cooperator['+index+'].name'"
                                                        maxlength="100" style="width: auto;">
                                                    </el-input>
                                                    <input type="hidden" :name="'cooperator['+index+'].tripid'"
                                                        v-model="bean.tripid">
                                                    <input type="hidden" :name="'cooperator['+index+'].id'"
                                                        v-model="s.id">

                                                </div>
                                            </div>
                                            <hr>
                                            <table class="table  table-bordered border border-dark">
                                                <tr>
                                                    <td>
                                                        行程目的
                                                    </td>
                                                    <td>
                                                        <input type="text" class="form-control" v-model="bean.tripname"
                                                            id="tripname" name="tripname" maxlength="10">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        行程類型
                                                    </td>
                                                    <td>
                                                        <select class="form-control" name="type" v-model="bean.type"
                                                            style="width: 40%;">
                                                            <option value="北上">北上</option>
                                                            <option value="中部">中部</option>
                                                            <option value="南下">南下</option>
                                                            <option value="其他">其他</option>
                                                        </select>
                                                    </td>
                                                </tr>


                                                <tr>
                                                    <td>
                                                        車輛
                                                    </td>
                                                    <td>
                                                        <el-input name="car1" v-model="bean.car1" maxlength="20"
                                                            list="car" style="width: 40%; margin: 5px;">
                                                        </el-input>
                                                        <el-input name="car2" v-model="bean.car2" maxlength="20"
                                                            list="car" style="width: 40%;margin: 5px;">
                                                        </el-input>
                                                        <datalist id="car">
                                                            <option value="無">無</option>
                                                            <option value="2311-WJ">2311-WJ</option>
                                                            <option value="2311-P6">2311-P6</option>
                                                        </datalist>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        行程內容
                                                    </td>
                                                    <td>
                                                        <el-input name="content" id="content" type="textarea"
                                                            placeholder="請输入内容" v-model="bean.content" maxlength="900"
                                                            :autosize="{ minRows: 4}" show-word-limit>
                                                        </el-input>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>主管核准</td>
                                                    <td @click="clickDirector">
                                                        <span>{{bean.director}}</span>
                                                        <el-result v-show="bean.director == ''" icon="info" title="點擊核准"
                                                            style="padding: 0px;"></el-result>
                                                        <el-result v-show="bean.director != ''" icon="success"
                                                            style="padding: 0px;"></el-result>
                                                    </td>
                                                </tr>
                                            </table>
                                        </form>
                                        <p style="text-align: center;">
                                            <el-button  type="primary" @click="sumbitForm">
                                                送出出差單</el-button>


                                            <c:if test="${user.position == '主管'  || user.position == '系統'}">

                                                <el-button type="danger" v-show="bean.tripid != ''" @click="delLeave">
                                                    刪除
                                                </el-button>
                                            </c:if>


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
                </div>ㄡ
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
                        schedule: "${user.name}",
                        bean: {
                            tripid: "",
                            director: "",
                            type: "北上",
                            tripday: "",
                            expected: "",
                            content: "",
                            tripname: "",
                            responsible1: "${user.name}",
                            cooperator: [],
                            del: 0,
                            uuid: "",
                        },
                        oldBean: {},
                        dialogVisible:false,
                        changeMessageList:[],
                    }
                },
                created() {
                    if (id != "" && id != null) {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/BusinessTrip/" + id,
                            type: 'POST',
                            success: response => {
                                if (response.code == 200) {
                                    this.bean = response.data.bean;
                                    this.changeMessageList =response.data.changeMessageList;
                                    this.oldBean = Object.assign({}, this.bean);
                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                },
                methods: {
                    sumbitForm() {
                        let isok = true;
                        if (this.bean.tripday == "") {
                            isok = false;
                            this.$message.error("行程日期為空");
                            $("#tripday").css("border", "1px solid red");
                        }
                        if (this.bean.expected == "") {
                            isok = false;
                            this.$message.error("預計時間為空");
                            $("#expected").css("border", "1px solid red");
                        }
                        if (!(this.bean.content != "")) {
                            isok = false;
                            this.$message.error("行程內容為空");
                            $("#content").css("border", "1px solid red");
                        }
                        if (this.bean.tripname == "") {
                            isok = false;
                            this.$message.error("行程目的為空");
                            $("#tripname").css("border", "1px solid red");
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
                                                location.href = "${pageContext.request.contextPath}/Task/businessTrip.jsp?id=" + response.data;
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
                    clickDirector() {
                        if ('${user.name}' == '') {
                            return '';
                        }
                        if ('${user.position}' == '主管' || '${user.position}' == '系統') {
                            $.ajax({
                                url: "${pageContext.request.contextPath}/task/clickTripDirector?id=" + id,
                                type: 'POST',
                                success: response => {
                                    if (response.code == 200) {
                                        this.bean.director = response.data;
                                        this.$message.success(response.message);
                                    }
                                    if (response.code == 300) {
                                        this.$message.error(response.message);
                                    }
                                    location.href='${pageContext.request.contextPath}/Task/businessTrip.jsp?id='+id;
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
                                url: "${pageContext.request.contextPath}/task/delTripLeave?id=" + id,
                                type: 'POST',
                                success: response => {
                                    if (response.code == 200) {
                                        location.href = "${pageContext.request.contextPath}/Task/businessTripList.jsp";
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
                    addCooperator() {
                        this.bean.cooperator.push({ name: "" });
                    }
                },
            })
        </script>




        </html>