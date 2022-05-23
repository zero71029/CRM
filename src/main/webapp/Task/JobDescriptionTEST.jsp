<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">           
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">
            <title>每⽇任務</title>
        </head>
        <style>

            [v-cloak] {
                display: none;
            }

        </style>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-10 app" v-cloak>
                        <!-- <%-- 中間主體--%> -->
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-8 ">
                                <el-form ref="form" :model="bean" label-width="80px"
                                    action="${pageContext.request.contextPath}/task/save" method="post">
                                    <input type="hidden" name="evaluateid" value="${bean.evaluateid}">
                                    <input type="hidden" name="">
                                    <input type="hidden" name="">
                                    <div class="row">
                                        <table class="table table-borderless ">
                                            <tr>
                                                <td colspan="5" > <h1>⼯作職掌說明</h1> </td><td>2022年2⽉17⽇ 星期四</td>
                                            </tr>
                                            <tr>
                                                <td colspan="6"><hr></td>
                                            </tr>
                                            <tr>
                                                <td>職務</td>
                                                <td >
                                                    <el-input v-model="bean.department" maxlength="20" style="font-size: 20px;"
                                                        name="department">
                                                    </el-input>
                                                </td>
                                                <td>姓名</td>
                                                <td>
                                                    <el-input v-model="bean.name" maxlength="20" name="name" style="font-size: 20px;"></el-input>
                                                </td>
                                                <td>到職⽇：
                                                </td>
                                                <td style="width:220px ;">
                                                    <el-date-picker v-model="bean.evaluatedate" type="date" style="font-size: 20px;"
                                                        placeholder="选择日期" name="evaluatedate">
                                                    </el-date-picker>
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td>部門 :</td>
                                                <td colspan="5"><el-input v-model="bean.name" maxlength="20" name="name" style="font-size: 20px;"></el-input></td>
                                            </tr>

                                            <tr>
                                                <td>直屬主管 :</td>
                                                <td colspan="5"><el-input v-model="bean.name" maxlength="20" name="name" style="font-size: 20px;"></el-input></td>
                                            </tr>
                                            <tr>
                                                <td>輔導員 :</td>
                                                <td colspan="5"><el-input v-model="bean.name" maxlength="20" name="name" style="font-size: 20px;"></el-input></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6"><hr></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    ⼯作內容
                                                    <el-input type="textarea" placeholder="⼯作內容" maxlength="500" rows="10"
                                                    show-word-limit v-model="bean.remark" name="remark">
                                                </el-input>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="6"><hr></td>
                                            </tr>

                                            <tr>
                                                <td colspan="6">
                                                    考核指標
                                                    <el-input type="textarea" placeholder="考核指標" maxlength="500"
                                                    show-word-limit v-model="bean.remark" name="remark">
                                                </el-input>
                                                </td>
                                            </tr>



                                        </table>
                                    </div>
                                    <div class="row">
                                        <button type="submit" class="btn btn-primary">送出</button>
                                    </div>

                                </el-form>
                            </div>
                            <div class="col-lg-2"><el-button  class="el-icon-printer" @click="printTable"></el-button></i></div>
                        </div>
                        <!-- 中間主體結束 -->
                    </div>
                </div>
            </div>
        </body>
        <script>
            const vm = new Vue({
                el: ".app",
                data() {
                    return {
                        value2: "",
                        bean: {
                            evaluateid: "",	//id
                            department: "${user.department}",//部門
                            name: "${user.name}",//姓名
                            evaluatedate: new Date(),//日期
                            remark: "",//備註
                            score: "A",//評分
                            assessment: "",//評語
                            director: "", //主管
                            hr: "",//人事
                            createtime: "",
                            costtime: "",
                        },
                        oldBean: {},
                        taskList: [
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                            { content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" },
                        ],
                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/task/init/${bean.evaluateid}',//接受請求的Servlet地址
                        type: 'get',
                        success: (response => (
                            this.bean = response.bean,
                            this.taskList = response.taskList,
                            this.value2 = this.bean.evaluatedate,
                            this.addList(),
                            console.log(response.taskList, "taskList"),
                            console.log(this.value2)
                        )),
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                watch: {
                    value2: {
                        handler(newValue, oldValue) {
                            this.bean.evaluatedate = newValue;
                        }
                    }
                },
                methods: {//點擊完成
                    clickFinish: function (index) {
                        console.log(this.taskList);
                        if (this.taskList[index].finish == "on") {
                            this.taskList[index].finish = "";
                        } else {
                            this.taskList[index].finish = "on";
                        }
                    },
                    clickDirector: function () {//點擊主管
                        this.bean.director = "${user.name}";
                    },
                    clickHR: function () {//點擊主管
                        this.bean.hr = "${user.name}";
                    },
                    addList: function () {//補滿15行
                        if (this.taskList.length < 15) {
                            for (var i = this.taskList.length; i < 15; i++)
                                this.taskList.push({ content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" })
                        }

                    },
                    addone: function () {//添加1行
                        this.taskList.push({ content: "", costtime: "", createtime: "", evaluateid: "", finish: "", important: "", taskdate: "", taskid: "" })
                    },
                    intextarea: function (index) {//調整textarea高度
                        console.log(index)
                        var textarea = document.querySelector('#intextarea' + index);
                        // console.log(textarea.scrollHeight);

                        textarea.style.height = textarea.scrollHeight + 'px';
                    },
                    printTable:function(){
                        location.href="${pageContext.request.contextPath}/task/print/${bean.evaluateid}";
                    }
                },
                // mounted() {
                //     for (var i = 0; i < this.taskList.length; i++) {
                //         this.taskList[i].content += " ";
                //         this.taskList[i].content.trim();
                //         this.intextarea(i);
                //     }
                // },
            })

        </script>
        <style>
            tr td textarea {
                height: 100%;
            }

            .el-textarea {
                padding: 0px;
            }

            .el-result__icon svg {
                width: 30px;
                height: 30px;
            }
        </style>

        </html>