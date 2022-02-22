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
            .row .divpadd {
                padding: 0%;
            }

            .divborder {

                border: 1px solid black;
            }

            [v-cloak] {
                display: none;
            }

            /* .el-input{
                margin: 0px -12px;
            } */
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
                                    <input type="hidden" name="task[0].taskid" value="${bean.task[0].taskid}">
                                    <input type="hidden" name="task[1].taskid" value="${bean.task[1].taskid}">
                                    <input type="hidden" name="task[2].taskid" value="${bean.task[2].taskid}">
                                    <input type="hidden" name="task[3].taskid" value="${bean.task[3].taskid}">
                                    <input type="hidden" name="task[4].taskid" value="${bean.task[4].taskid}">
                                    <input type="hidden" name="task[5].taskid" value="${bean.task[5].taskid}">
                                    <input type="hidden" name="task[6].taskid" value="${bean.task[6].taskid}">
                                    <input type="hidden" name="task[7].taskid" value="${bean.task[7].taskid}">
                                    <input type="hidden" name="task[8].taskid" value="${bean.task[8].taskid}">
                                    <input type="hidden" name="task[9].taskid" value="${bean.task[9].taskid}">
                                    <input type="hidden" name="task[10].taskid" value="${bean.task[10].taskid}">
                                    <input type="hidden" name="task[11].taskid" value="${bean.task[11].taskid}">
                                    <input type="hidden" name="task[12].taskid" value="${bean.task[12].taskid}">
                                    <input type="hidden" name="task[13].taskid" value="${bean.task[13].taskid}">
                                    <input type="hidden" name="task[14].taskid" value="${bean.task[14].taskid}">
                                    <input type="hidden" name="task[15].taskid" value="${bean.task[15].taskid}">
                                    <input type="hidden" name="task[0].taskdate" value="${bean.task[0].taskdate}">
                                    <input type="hidden" name="task[1].taskdate" value="${bean.task[1].taskdate}">
                                    <input type="hidden" name="task[2].taskdate" value="${bean.task[2].taskdate}">
                                    <input type="hidden" name="task[3].taskdate" value="${bean.task[3].taskdate}">
                                    <input type="hidden" name="task[4].taskdate" value="${bean.task[4].taskdate}">
                                    <input type="hidden" name="task[5].taskdate" value="${bean.task[5].taskdate}">
                                    <input type="hidden" name="task[6].taskdate" value="${bean.task[6].taskdate}">
                                    <input type="hidden" name="task[7].taskdate" value="${bean.task[7].taskdate}">
                                    <input type="hidden" name="task[8].taskdate" value="${bean.task[8].taskdate}">
                                    <input type="hidden" name="task[9].taskdate" value="${bean.task[9].taskdate}">
                                    <input type="hidden" name="task[10].taskdate" value="${bean.task[10].taskdate}">
                                    <input type="hidden" name="task[11].taskdate" value="${bean.task[11].taskdate}">
                                    <input type="hidden" name="task[12].taskdate" value="${bean.task[12].taskdate}">
                                    <input type="hidden" name="task[13].taskdate" value="${bean.task[13].taskdate}">
                                    <input type="hidden" name="task[14].taskdate" value="${bean.task[14].taskdate}">
                                    <input type="hidden" name="task[15].taskdate" value="${bean.task[15].taskdate}">
                                    <input type="hidden" name="">
                                    <input type="hidden" name="">















                                    <div class="row">
                                        <div class="col-lg-1 divborder">部門</div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <el-input v-model="bean.department" maxlength="20" name="department">
                                            </el-input>
                                        </div>
                                        <div class="col-lg-1 divborder">姓名</div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <el-input v-model="bean.name" maxlength="20" name="name"></el-input>
                                        </div>
                                        <div class="col-lg-1 divborder">日期</div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <el-date-picker v-model="bean.evaluatedate" type="date" placeholder="选择日期"
                                                name="evaluatedate">
                                            </el-date-picker>

                                            <!-- <el-input v-model="bean.evaluatedate" maxlength="20" name="evaluatedate">
                                            </el-input> -->
                                        </div>
                                    </div>

                                    <div class="row text-center">
                                        <div class="col-lg-1 divborder">完成?<br>(自己<i class="bi bi-check"></i>)</div>
                                        <div class="col-lg-7 divborder ">任務</div>
                                        <div class="col-lg-1 divborder">重要度 <br>H,M,L</div>
                                        <div class="col-lg-3 divborder">期限/耗時</div>

                                    </div>



                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[0].finish"
                                                value="1" ${bean.task[0].finish=="1" ? "checked" :"" }>
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[0].content"
                                                value="${bean.task[0].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[0].important">
                                                <option value="低" ${bean.task[0].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[0].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[0].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->


                                            <input type="text" class="form-control" name="task[0].costtime"
                                                value="${bean.task[0].costtime}">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[1].finish"
                                                value="1" ${bean.task[1].finish=="1" ? "checked" :"" }>
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[1].content"
                                                value="${bean.task[1].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[1].important">
                                                <option value="低" ${bean.task[1].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[1].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[1].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[1].costtime"
                                                value="${bean.task[1].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[2].finish"
                                                value="1" ${bean.task[2].finish=="1" ? "checked" :"" }
                                                value="${bean.task[2].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[2].content"
                                                value="${bean.task[2].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[2].important">
                                                <option value="低" ${bean.task[2].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[2].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[2].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[2].costtime"
                                                value="${bean.task[2].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[3].finish"
                                                value="1" ${bean.task[3].finish=="1" ? "checked" :"" }
                                                value="${bean.task[3].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[3].content"
                                                value="${bean.task[3].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[3].important">
                                                <option value="低" ${bean.task[3].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[3].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[3].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[3].costtime"
                                                value="${bean.task[3].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[4].finish"
                                                value="1" ${bean.task[4].finish=="1" ? "checked" :"" }
                                                value="${bean.task[4].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[4].content"
                                                value="${bean.task[4].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[4].important">
                                                <option value="低" ${bean.task[4].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[4].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[4].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[4].costtime"
                                                value="${bean.task[4].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[5].finish"
                                                value="1" ${bean.task[5].finish=="1" ? "checked" :"" }
                                                value="${bean.task[5].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[5].content"
                                                value="${bean.task[5].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[5].important">
                                                <option value="低" ${bean.task[5].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[5].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[5].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[5].costtime"
                                                value="${bean.task[5].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[6].finish"
                                                value="1" ${bean.task[6].finish=="1" ? "checked" :"" }
                                                value="${bean.task[6].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[6].content"
                                                value="${bean.task[6].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[6].important">
                                                <option value="低" ${bean.task[6].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[6].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[6].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[6].costtime"
                                                value="${bean.task[6].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[7].finish"
                                                value="1" ${bean.task[7].finish=="1" ? "checked" :"" }
                                                value="${bean.task[7].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[7].content"
                                                value="${bean.task[7].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[7].important">
                                                <option value="低" ${bean.task[7].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[7].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[7].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[7].costtime"
                                                value="${bean.task[7].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[8].finish"
                                                value="1" ${bean.task[8].finish=="1" ? "checked" :"" }
                                                value="${bean.task[8].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[8].content"
                                                value="${bean.task[8].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[8].important">
                                                <option value="低" ${bean.task[8].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[8].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[8].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[8].costtime"
                                                value="${bean.task[8].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[9].finish"
                                                value="1" ${bean.task[9].finish=="1" ? "checked" :"" }
                                                value="${bean.task[9].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[9].content"
                                                value="${bean.task[9].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[9].important">
                                                <option value="低" ${bean.task[9].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[9].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[9].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[9].costtime"
                                                value="${bean.task[9].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[10].finish"
                                                value="1" ${bean.task[10].finish=="1" ? "checked" :"" }
                                                value="${bean.task[10].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[10].content"
                                                value="${bean.task[10].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[10].important">
                                                <option value="低" ${bean.task[10].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[10].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[10].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[10].costtime"
                                                value="${bean.task[10].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[11].finish"
                                                value="1" ${bean.task[11].finish=="1" ? "checked" :"" }
                                                value="${bean.task[11].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[11].content"
                                                value="${bean.task[11].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[11].important">
                                                <option value="低" ${bean.task[11].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[11].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[11].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[11].costtime"
                                                value="${bean.task[11].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[12].finish"
                                                value="1" ${bean.task[12].finish=="1" ? "checked" :"" }
                                                value="${bean.task[12].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[12].content"
                                                value="${bean.task[12].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[12].important">
                                                <option value="低" ${bean.task[12].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[12].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[12].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[12].costtime"
                                                value="${bean.task[12].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[13].finish"
                                                value="1" ${bean.task[13].finish=="1" ? "checked" :"" }
                                                value="${bean.task[13].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[13].content"
                                                value="${bean.task[13].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[13].important">
                                                <option value="低" ${bean.task[13].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[13].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[13].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[13].costtime"
                                                value="${bean.task[13].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[14].finish"
                                                value="1" ${bean.task[14].finish=="1" ? "checked" :"" }
                                                value="${bean.task[14].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[14].content"
                                                value="${bean.task[14].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[14].important">
                                                <option value="低" ${bean.task[14].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[14].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[14].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[14].costtime"
                                                value="${bean.task[14].costtime}">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 divborder divpadd text-center">
                                            <!-- 完成 -->
                                            <input class="form-check-input" type="checkbox" name="task[15].finish"
                                                value="1" ${bean.task[15].finish=="1" ? "checked" :"" }
                                                value="${bean.task[15].finish}">
                                        </div>
                                        <div class="col-lg-7 divborder divpadd">
                                            <!--任務內容  -->
                                            <input type="text" class="form-control" name="task[15].content"
                                                value="${bean.task[15].content}">
                                        </div>
                                        <div class="col-lg-1 divborder divpadd">
                                            <!--  重要度-->
                                            <select class="form-select" name="task[15].important">
                                                <option value="低" ${bean.task[15].important=="低" ? "selected" :"" }>低
                                                </option>
                                                <option value="中" ${bean.task[15].important=="中" ? "selected" :"" }>中
                                                </option>
                                                <option value="高" ${bean.task[15].important=="高" ? "selected" :"" }>高
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd">
                                            <!-- 耗時 -->
                                            <input type="text" class="form-control" name="task[15].costtime"
                                                value="${bean.task[15].costtime}">
                                        </div>
                                    </div>

                                    <div class="row divborder divpadd">
                                        備註:
                                        <div class="col-lg-12 divpadd">
                                            <el-input type="textarea" placeholder="本人專填" maxlength="500" show-word-limit
                                                v-model="bean.remark" name="remark">
                                            </el-input>
                                        </div>
                                    </div>
                                    <div class="row divborder  ">
                                        <div class="row">主管考評 (A,B,C,F): </div>
                                        <div class="row">
                                            <div class="col-lg-1 divpadd">
                                                <el-input type="textarea" placeholder="評分" maxlength="50"
                                                    v-model="bean.score" name="score"></el-input>
                                            </div>

                                            <div class="col-lg-11 divpadd">
                                                <el-input type="textarea" placeholder="主管專填:評語" maxlength="200"
                                                    show-word-limit v-model="bean.assessment" name="assessment">
                                                </el-input>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4 divborder divpadd">
                                            主管：<el-input v-model="bean.director" maxlength="20" name="director">
                                            </el-input>
                                        </div>
                                        <div class="col-lg-5 divborder divpadd">
                                            HR:<el-input v-model="bean.hr" maxlength="20" name="hr"></el-input>
                                        </div>
                                        <div class="col-lg-3 divborder divpadd"> &nbsp;
                                            <el-input v-model="bean.costtime" maxlength="20" name="costtime"></el-input>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <button type="submit" class="btn btn-primary">送出</button>
                                    </div>

                                </el-form>
                            </div>
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
                            console.log(response.taskList),
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
                }
            })

        </script>
        <style>

        </style>

        </html>