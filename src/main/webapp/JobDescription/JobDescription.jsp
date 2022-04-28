<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">

            <script src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
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
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-lg-11 app roe" v-cloak>
                        <br>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-8">

                                <el-button type="success" icon="el-icon-arrow-left" circle
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/JobDescription/JobDescriptionList.jsp'">
                                </el-button>
                                <el-button type="primary" icon="el-icon-edit" circle @click="save"></el-button>
                                <el-button type="warning" icon="el-icon-printer" circle @click="print">
                                </el-button>

                                <form action="" method="post" class="jobdescription">
                                    <input type="hidden" name="jobdescriptionid" v-model="bean.jobdescriptionid">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td></td>
                                            <td></td>
                                            <td class="text-end">
                                                <el-date-picker name="aaa" v-model="bean.aaa" type="date"
                                                    placeholder="選擇日期" format="yyyy-MM-dd" value-format="yyyy-MM-dd">
                                                </el-date-picker>
                                            </td>
                                        </tr>
                                        <tr style="border-bottom: 1px solid">
                                            <td colspan="2">
                                                <h2>⼯作職掌說明 </h2><br>
                                            </td>

                                            <td></td>
                                        </tr>

                                        <tr style="height: 40px;">
                                            <td>職務名稱: <input type="text" name="jobname" v-model.trim="bean.jobname"
                                                    style="float:right">
                                            </td>
                                            <td style="text-align: right;"> 姓名： <input type="text" name="admin"
                                                    v-model.trim="bean.admin"></td>
                                            <td style="text-align: right;">到職⽇:

                                                <el-date-picker name="arrivaldate" v-model="bean.arrivaldate"
                                                    type="date" placeholder="選擇日期" format="yyyy-MM-dd"
                                                    value-format="yyyy-MM-dd">
                                                </el-date-picker>


                                            </td>
                                        </tr>
                                        <tr style="height: 40px;">
                                            <td style="width: 300px;">部⾨：<input type="text" style="float:right"
                                                    name="department" v-model.trim="bean.department"></td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr style="height: 40px;">
                                            <td>直屬主管：<input type="text" style="float:right" name="director"
                                                    v-model.trim="bean.director">
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr style="height: 40px;">
                                            <td>輔導員：&nbsp;&nbsp;<input type="text" style="float:right" name="counselor"
                                                    v-model.trim="bean.counselor"> </td>
                                            <td></td>
                                            <td></td>
                                        </tr>

                                        <tr style="border-top: 1px solid black">
                                            <td colspan="3">⼯作內容</td>
                                        </tr>

                                        <tr style="margin-bottom: 300px;">
                                            <td colspan="3"><textarea style="width: 100%" rows="20" name="workcontent"
                                                    id="workcontent" v-model.trim="bean.workcontent" placeholder=" 
  ⽬的：資訊相關業務，維持公司資訊電腦網路等系統運作正常。網站相關業務，更新維護網站正常
  運作與功能開發。資料庫後台管理，維持資料庫後台正常運作與功能性開發，內部帳號密碼安全管
  理。
  - 維護公司電腦系統及軟體效能，維持其系統正常運作及除錯。
  - 網路系統維護，確保連線運作正常
  - 網站系統架構維護與更新
  - 網⾴資料更新
  - 網⾴或社群詢問搜集後轉業務處理
  - 內部帳號密碼管理
  - 協助出貨相關附/配件製作產出
  - 資料庫後台/網站開發與維護管理
  - 資訊設備管理"></textarea></td>

                                        </tr>
                                        <tr>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <tr style="border-top: 1px solid black">
                                            <td colspan="3">考核指標</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"> <textarea name="assessmentindicators"
                                                    v-model.trim="bean.assessmentindicators" style="width: 100%"
                                                    rows="10">⼯作效率，⼯作品質，服務精神，責任度，忠誠度，團隊精神，問題提出/改善，創意達成，主動性</textarea>
                                            </td>

                                        </tr>
                                    </table>
                                </form>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-8">

                            </div>
                        </div>







                    </div>
                </div>
            </div>
            <script>
                var vm = new Vue({
                    el: ".app",
                    data() {
                        return {
                            bean: {
                                aaa: new Date(),
                                jobdescriptionid: "",
                                jobname: "",
                                admin: "",
                                arrivaldate: "",
                                director: "",
                                counselor: "",
                                workcontent: "",
                                assessmentindicators: "",
                                department: ""
                            }
                        }
                    }, created() {
                        const url = new URL(location.href);
                        const id = url.searchParams.get("id");
                        if (id != null) {
                            $.ajax({
                                url: '${pageContext.request.contextPath}/JobDescription/init/' + id,
                                type: 'POST',
                                async: false,
                                cache: false,
                                success: (response => (

                                    this.bean = response.jobdescription

                                )),
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            })
                        }








                    }, methods: {
                        save() {

                            var isok = true;


                            if (this.bean.jobname == "") isok = false;
                            if (this.bean.admin == "") isok = false;
                            if (this.bean.arrivaldate == "") isok = false;
                            if (this.bean.director == "") isok = false;
                            if (this.bean.counselor == "") isok = false;
                            if (this.bean.workcontent == "") isok = false;
                            if (this.bean.assessmentindicators == "") isok = false;
                            if (this.bean.aaa == "") isok = false;
                            if (this.bean.department == "") isok = false;


                            if (isok) {



                                this.$confirm('確定儲存修改?', '提示', {
                                    confirmButtonText: '确定',
                                    cancelButtonText: '取消',
                                    type: 'warning'
                                }).then(() => {

                                    var formData = new FormData($(".jobdescription")[0]);
                                    $.ajax({
                                        url: '${pageContext.request.contextPath}/JobDescription/saveJobDescription',
                                        type: 'POST',
                                        data: formData,
                                        async: false,
                                        cache: false,
                                        contentType: false,
                                        processData: false,
                                        success: (response => (
                                            this.bean.jobdescriptionid = response,
                                            location.href = "${pageContext.request.contextPath}/JobDescription/JobDescription.jsp?id=" + response


                                        )),
                                        error: function (returndata) {
                                            console.log(returndata);
                                        }
                                    })



                                }).catch(() => {
                                    this.$message({
                                        type: 'info',
                                        message: '已取消'
                                    });
                                });

                            } else {
                                alert("有空格,不能儲存")
                            }
                        },
                        print() {
                            if (this.bean.jobdescriptionid) {
                                location.href = "${pageContext.request.contextPath}/JobDescription/print/" + this.bean.jobdescriptionid;
                            } else {
                                this.$message({
                                    message: '請先儲存',
                                    type: 'warning'
                                });
                            }



                        }
                    },

                }
                )                
            </script>



        </body>

        </html>