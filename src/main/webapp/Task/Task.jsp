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
            /* ////// */
            .table tr td input,
            .table tr td select {
                border: 0px;
            }

            .table tr td .row {
                margin: 0px;
            }

            .table tr td,
            .table tr td .row div,
            .table tr td .row div textarea {

                padding: 0%;
            }

            [v-cloak] {
                display: none;
            }

            /* .el-input{
                margin: 0px -12px;
            } */
            .contentTextarea {
                border: 0px;
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
                        <div class="row ">
                            <div class="col-lg-12 text-center">
                                <h2>每⽇任務評估書</h2>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-8 ">
                                <el-form ref="form" :model="bean" label-width="80px"
                                    action="${pageContext.request.contextPath}/task/save" method="post">
                                    <input type="hidden" name="evaluateid" value="${bean.evaluateid}">
                                    <input type="hidden" name="">
                                    <input type="hidden" name="">

                                    <div class="row">
                                        <table class="table table-bordered">
                                            <tr>
                                                <td>部門</td>
                                                <td>
                                                    <el-input v-model="bean.department" maxlength="20"
                                                        name="department">
                                                    </el-input>
                                                </td>
                                                <td>姓名</td>
                                                <td>
                                                    <el-input v-model="bean.name" maxlength="20" name="name"></el-input>
                                                </td>
                                                <td>日期</td>
                                                <td style="width:220px ;">
                                                    <el-date-picker v-model="bean.evaluatedate" type="date"
                                                        placeholder="选择日期" name="evaluatedate">
                                                    </el-date-picker>
                                                </td>
                                            </tr>
                                            <tr class="text-center">
                                                <td>完成?<br>(自己<i class="bi bi-check"></i>)</td>
                                                <td colspan="3">任務</td>
                                                <td>重要度 <br>H,M,L</td>
                                                <td>期限/耗時</td>
                                            </tr>
                                            <tr v-for="(s, index) in taskList" :key="index">
                                                <input type="hidden" :name="'task['+index+'].taskid'"
                                                    v-model.trim="s.taskid">
                                                <input type="hidden" :name="'task['+index+'].taskdate'"
                                                    v-model.trim="s.taskdate">
                                                <td @click="clickFinish(index)">
                                                    <el-result icon="success" style="padding: 0px;"
                                                        v-show="s.finish == 'on'"></el-result>
                                                    <!-- 完成 -->
                                                    <input class="form-check-input" type="hidden" v-model.trim="s.finish"
                                                        :name="'task['+index+'].finish'">
                                                </td>
                                                <td colspan="3" style="height: auto;">
                                                    <!--任務內容  -->

                                                    <textarea style="overflow:hidden; width: 100%;" v-model.trim="s.content"  wrap="hard"
                                                        class="contentTextarea" @input="intextarea(index)" rows="3"
                                                        :id="'intextarea'+index"
                                                        :name="'task['+index+'].content'" maxlength="200"></textarea>


                                                </td>
                                                <td>
                                                    <!--  重要度-->
                                                    <select class="form-select" :name="'task['+index+'].important'"
                                                        v-model="s.important">
                                                        <option value="低">低
                                                        </option>
                                                        <option value="中">中
                                                        </option>
                                                        <option value="高">高
                                                        </option>
                                                    </select>
                                                </td>
                                                <td>
                                                    <!-- 耗時 -->
                                                    <input type="text" class="form-control"
                                                        :name="'task['+index+'].costtime'" v-model="s.costtime">
                                                </td>

                                            </tr>
                                            <tr>
                                                <td>
                                                    <el-button type="text" @click="addone">+添加+</el-button>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6"> 備註:
                                                    <div class="">
                                                        <el-input type="textarea" placeholder="本人專填" maxlength="500"
                                                            show-word-limit v-model="bean.remark" name="remark">
                                                        </el-input>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">
                                                    主管考評 (A,B,C,F): <br>
                                                    <div class="row">
                                                        <div class="col-lg-2">
                                                            <el-input type="textarea" placeholder="評分" maxlength="50"
                                                                v-model="bean.score" name="score"></el-input>
                                                        </div>
                                                        <div class="col-lg-10 ">
                                                            <el-input type="textarea" placeholder="主管專填:評語"
                                                                maxlength="200" show-word-limit
                                                                v-model="bean.assessment" name="assessment">
                                                            </el-input>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" @click="clickDirector"> 主管：<el-input
                                                        v-model="bean.director" maxlength="20" name="director">
                                                    </el-input>
                                                </td>
                                                <td colspan="2" @click="clickHR">HR:<el-input v-model="bean.hr"
                                                        maxlength="20" name="hr">
                                                    </el-input>
                                                </td>
                                                <td colspan="2">&nbsp;
                                                    <el-input v-model="bean.costtime" maxlength="20" name="costtime">
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
                            score: "",//評分
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