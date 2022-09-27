<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>
                [v-cloak] {
                    display: none;
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
                                <p>&nbsp;</p>
                                <div class="row ">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-4">
                                        <div class="row" style="text-align: center;">
                                            <div class="col-md-12  text-white"
                                                style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;background-color: #67C23A;">
                                                日誌<br>
                                            </div>
                                        </div>
                                        <div class="row"
                                            style="border: 1px solid #b4bccc;border-radius: 0 0 5px 5px  ; ">

                                            <el-form ref="form" :model="form" label-width="80px" label-position="left">
                                                <input type="hidden" name="calenderid" v-model="form.calenderid">
                                                <input type="hidden" name="name" v-model="form.name">
                                                <br>
                                                <el-form-item label="主題">
                                                    <el-input v-model="form.theme" name="theme"></el-input>
                                                </el-form-item>
                                                <el-form-item label="日期">
                                                    <el-date-picker type="date" placeholder="选择日期" v-model="form.day"
                                                        style="width: 100%;" name="day"></el-date-picker>
                                                </el-form-item>
                                                <el-form-item label="細節">
                                                    <el-input type="textarea" v-model="form.detail" name="detail"
                                                        maxlength="1000" :autosize="{ minRows: 5}" show-word-limit>
                                                    </el-input>
                                                </el-form-item>
                                                <el-form-item v-show="form.calenderid == ''">
                                                    <el-button type="primary" @click="onSubmit">立即創建</el-button>
                                                </el-form-item>
                                            </el-form>                             
                                        </div>
                                    </div>
                                    <div class="col-md-4"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        form: {
                            calenderid: '${param.id}',
                            theme: "",
                            day: new Date(),
                            detail: "",
                            name: "${user.name}",
                        }
                    }
                },
                created() {
                    console.log(this.form.calenderid);
                    if (this.form.calenderid != "") {
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/getCalender?id=${param.id}",
                            type: 'get',                   
                            success: response => {
                                console.log(response.data);
                                if (response.code == 200) {                            
                                    this.form = response.data;
                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                },
                methods: {
                    onSubmit() {
                        let formData = new FormData(document.getElementsByTagName('form')[0]);
                        $.ajax({
                            url: "${pageContext.request.contextPath}/task/addCalender/",
                            type: 'post',
                            data: formData,
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: response => {
                                console.log(response.data);
                                if (response.code == 200) {
                                    console.log(response.message);
                                    location.href='${pageContext.request.contextPath}/Task/calendar.jsp'
                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    dateFormat(fmt, date) {
                        let ret;
                        const opt = {
                            "Y+": date.getFullYear().toString(), // 年
                            "m+": (date.getMonth() + 1).toString(), // 月
                            "d+": date.getDate().toString(), // 日
                            "H+": date.getHours().toString(), // 时
                            "M+": date.getMinutes().toString(), // 分
                            "S+": date.getSeconds().toString() // 秒
                        };
                        for (let k in opt) {
                            ret = new RegExp("(" + k + ")").exec(fmt);
                            if (ret) {
                                fmt = fmt.replace(ret[1], (ret[1].length == 1) ? (opt[k]) : (opt[k].padStart(ret[1].length, "0")))
                            };
                        };
                        return fmt;
                    },
                },
            })
            $(".employee").show();
        </script>




        </html>