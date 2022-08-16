<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="zh-TW">

    <head>
        <!-- bootstrap的CSS、JS樣式放這裡 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>

        <!-- <%-- jQuery放這裡 --%> -->
        <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css">

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>帳號申請</title>
    </head>

    <body>
        <div class="container-fluid">
            <br><br>
            <div class="row">
                <div class="col-lg-3 app"></div>
                <div class="col-lg-6 app">
                    <h3 style="text-align: center; color: red;">${error}</h3>
                    <button class="btn btn-primary"
                        onclick="javascript:location.href='${pageContext.request.contextPath}/system/AccountApplicationList.jsp'">返回上頁</button>
                    <form action="${pageContext.request.contextPath}/AccountApplication/save" method="post">

                        <input type="hidden" name="applicationid" value="${bean.applicationid}">

                        <input type="hidden" name="createtime" value="${bean.createtime}">
                        <table class="table table-striped text-center">
                            <tr>
                                <td colspan="2">新進⼈員E-Mail/NAS帳號申請表</td>

                            </tr>

                            <tr>
                                <td style="width: 180px;">到職⽇</td>
                                <td><input type="text" class="form-control arrivetime" name="arrivetime" value="${bean.arrivetime}"
                                    readonly></td>
                            </tr>
                            <tr>
                                <td>申請⼈ <span style="color: red;"> *</span></td>
                                <td><input type="text" class="form-control" name="admin" value="${bean.admin}"></td>
                            </tr>
                            <tr>
                                <td>護照英⽂名</td>
                                <td><input type="text" class="form-control" name="english" value="${bean.english}"></td>
                            </tr>
                            <tr>
                                <td>部⾨職位</td>
                                <td><input type="text" class="form-control" name="department"
                                        value="${bean.department}"></td>
                            </tr>
                            <tr>
                                <td>私⼈Email</td>
                                <td><input type="text" class="form-control" name="privateemail"
                                        value="${bean.privateemail}" placeholder="僅供寄送重要通知信使⽤，如驗證碼、密碼重設、"></td>
                            </tr>
                            <tr>
                                <td>ID名稱 <br>
                                    (英⽂字⺟可加數字)</td>
                                <td><input type="text" class="form-control" name="privateid" value="${bean.privateid}"
                                        placeholder="可使⽤有個⼈辨識度的名稱或英⽂姓名羅⾺拼⾳"></td>
                            </tr>
                            <tr>
                                <td>公司Email帳號 <br>
                                    (同上ID名稱可不填寫)</td>
                                <td><input type="text" class="form-control" name="email" value="${bean.email}">
                                    <p style="float: right;">@mail-jetec.com.tw</p>
                                </td>
                            </tr>

                        </table>
                        <button type="submit" class="btn btn-primary" style="width: 100%;">提交</button>

                    </form>
                </div>

            </div>
        </div>
        <script>
            // 日期UI
            $(".arrivetime").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: "yy-mm-dd"
            });
        </script>
    </body>

    </html>