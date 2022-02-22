<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
             <!-- bootstrap的CSS、JS樣式放這裡  -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">

            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">
            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.js"></script>           
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
            <!-- 引入element-ui组件库 -->
            <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>



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
            [v-cloak] {
                display: none;
            }

            /* .el-input{
                margin: 0px -12px;
            } */
            .contentTextarea {
                border: 0px;
            }
            .el-textarea {
                padding: 0px;
            }

            .el-result__icon svg {
                width: 30px;
                height: 30px;
            }
        </style>

        <body>
            <div class="container-fluid app">
                <div class="row ">
                    <div class="col-lg-12 text-center">
                        <h1>每⽇任務評估書</h1>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-3"></div>
                    <div class="col-lg-6 ">
                        <el-form ref="form" :model="bean" label-width="80px"
                            action="${pageContext.request.contextPath}/task/save" method="post">  
                            <div class="row">
                                <table class="table table-bordered" >
                                    <tr  >
                                        <td>部門</td>
                                        <td>
                                            {{bean.department}}
                                        </td>
                                        <td>姓名</td>
                                        <td>
                                            {{bean.name}}
                                        </td>
                                        <td>日期</td>
                                        <td style="width:200px ;">
                                            {{bean.evaluatedate}}
                                        </td>
                                    </tr>
                                    <tr class="text-center">
                                        <td>完成?<br>(自己<i class="bi bi-check"></i>)</td>
                                        <td colspan="3" >任務</td>
                                        <td>重要度 <br>H,M,L</td>
                                        <td>期限/耗時</td>
                                    </tr>
                                    <tr v-for="(s, index) in taskList" :key="index"  >                                         
                                        <td >
                                            <el-result icon="success" style="padding: 0px;" v-show="s.finish == 'on'">
                                            </el-result>
                                            <!-- 完成 -->                                            

                                        </td>
                                        <td colspan="3" style="height: auto;"class="text-break">
                                            <!--任務內容  -->
                                            {{s.content}}
                                        </td>
                                        <td>
                                            <!--  重要度-->
                                            {{s.important}}

                                        </td>
                                        <td>
                                            <!-- 耗時 -->
                                            {{s.costtime}}
                                        </td>

                                    </tr>

                                    <tr>
                                        <td colspan="6" class="text-break"> 備註:
                                            
                                                {{bean.remark}}

                                            
                                        </td>
                                    </tr>
                                    <tr class="text-break">
                                        <td colspan="6">
                                            主管考評 (A,B,C,F): <br>
                                            <div class="row">
                                                <div class="col-lg-2 text-wrap">
                                                    {{bean.score}}
     
                                                </div>
                                                <div class="col-lg-10 text-wrap">
                                                    {{bean.assessment}}

                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"  class="text-break"> 主管：<br>
                                            {{bean.director}}
                                            
      
                                        </td>
                                        <td colspan="2" >HR: <br>
                                            
                                            {{bean.hr}}
                                            
         
                                        </td>
                                        <td colspan="2">&nbsp;<br>
                                            {{bean.costtime}}
                                        </td>
                                    </tr>
                                </table>
                            </div>


                        </el-form>
                    </div>
                    
                </div>
                <!-- 中間主體結束 -->
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
                            department: "",//部門
                            name: "",//姓名
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
                            console.log(response.taskList, "taskList"),
                            console.log(this.value2)
                        )),
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
             })
        </script>
        </html>