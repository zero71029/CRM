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
                                <table style="width: 100%;">
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td class="text-end">
                                            ${bean.aaa}
                                        </td>
                                    </tr>
                                    <tr style="border-bottom: 1px solid">
                                        <td colspan="2">
                                            <h2>⼯作職掌說明 </h2><br>
                                        </td>

                                        <td></td>
                                    </tr>

                                    <tr style="height: 40px;">
                                        <td>職務名稱:  ${bean.jobname}</td>
                                        <td style="text-align: right;"> 姓名：  ${bean.admin}</td>
                                        <td style="text-align: right;">到職⽇: ${bean.arrivaldate}</td>
                                    </tr>
                                    <tr style="height: 40px;">
                                        <td style="width: 300px;">部⾨： ${bean.department}</td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr style="height: 40px;">
                                        <td>直屬主管： ${bean.director}
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr style="height: 40px;">
                                        <td>輔導員：${bean.counselor} </td>
                                        <td></td>
                                        <td></td>
                                    </tr>

                                    <tr style="border-top: 1px solid black">
                                        <td colspan="3">⼯作內容</td>
                                    </tr>

                                    <tr style="margin-bottom: 300px;min-height: 300px;">
                                        <td colspan="3" >
                                            ${bean.workcontent}</td>

                                    </tr>
                                    <tr>
                                        <td colspan="3">&nbsp;</td>
                                    </tr>
                                    <tr style="border-top: 1px solid black">
                                        <td colspan="3">考核指標</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">${bean.assessmentindicators}  
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




        </html>