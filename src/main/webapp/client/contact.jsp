<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">



            <title>CRM客戶管理系統</title>
        </head>
        <style>
            
            .contactbar { /* 按鈕顏色 */
                background-color: #afe3d5;
            }

            .cell {
                border: 0px solid black;
                border-bottom: 1px solid black;


            }

            .cellFrom {
                border: 0px solid black;
                /* width: 33%; */
            }

            .btn a {
                text-decoration: none;
                text-align: center;
                background-color: #BBB;
                display: block;
            }

            .log {
                text-align: center;
                background-color: rgb(36, 101, 164);
                color: white;
                border-radius: 5px 5px 0 0;
            }

            .error {
                color: red;
            }
        </style>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- 台灣縣市二聯式選單 -->
                    <script src="${pageContext.request.contextPath}/js/jquery.twzipcode.min.js"></script>
                    <!-- 驗證UI -->
                    <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->

                    <div class="col-md-11">
                        <!-- <%-- 中間主體--%> -->
                        <br>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <h3>聯絡人</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-1 btn">
                                <a href="javascript:history.back()"
                                    style="text-decoration: none;text-align: center;background-color: #569b92;display: block;color: #FFF;">＜</a>
                            </div>


                        </div>
                        <br>
                        <form action="${pageContext.request.contextPath}/CRM/SaveContact" method="post" id="myform"
                            class="basefrom g-3 ">
                            <div class="row">
                                <input type="hidden" name="contactid" value="${bean.contactid}">
                                <input type="hidden" name="clientid" value="${bean.clientid}">

                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4 log">聯絡人資訊</div>
                                    <div class="col-md-2"></div>
                                    <div class="col-md-3 log">其它資訊</div>

                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">聯絡人名稱*</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="name"
                                            value="${bean.name}" maxlength="20" required>
                                    </div>
                                    <div class="col-md-2"></div>
                                    <div class="col-md-1 cell">負責人*</div>
                                    <div class="col-md-2 cell FormPadding">
                                        <select name="user" class="form-select cellFrom"
                                            aria-label="Default select example">
                                            <option value="無" ${bean.user=="無" ?"selected":null}>無</option>
                                            <c:if test="${not empty admin}">
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                    items="${admin}" var="s">
                                                    <option value="${s.name}" ${bean.user==s.name ?"selected":null}>
                                                        ${s.name}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">

                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">公司名稱</div>
                                    <div class="col-md-3 cell FormPadding "
                                        style="background-color: #ccc; line-height: 35px;" onclick="showclient()">
                                        <a href="${pageContext.request.contextPath}/CRM/client/${bean.client.clientid}"
                                            target="_blank" class="clientName">${bean.client.name}</a>
                                        <input type="hidden" name='clientid' value="${bean.client.clientid}">
                                        <input type="hidden" name='company' value="${bean.client.name}">
                                    </div>


                                    <div class="col-md-2"></div>
                                    <div class="col-md-1 cell">聯絡人編號</div>
                                    <div class="col-md-2 cell">${bean.contactid}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">職務</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class="form-control cellFrom" name="jobtitle"
                                            value="${bean.jobtitle}" maxlength="20">
                                    </div>
                                    <div class="col-md-2"></div>
                                    <div class="col-md-1 cell">上次聯絡時間</div>
                                    <div class="col-md-2 cell FormPadding">
                                        <input type="text" class="form-control cellFrom contacttime" name="contacttime"
                                            value="${bean.contacttime}" maxlength="20" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">Email</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="email"
                                            value="${bean.email}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">電話</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <div class="input-group ppp">
                                            <input type="text" class="form-control ppp" name="phone" value="${bean.phone}"
                                                 maxlength="20">
                                            <span class="input-group-text">-</span>
                                            <input type="text" class="form-control" name="extension" value="${bean.extension}"
                                                 maxlength="10" placeholder="分機">
                                        </div>
                                        <!-- <input type="text" class=" form-control cellFrom" name="phone"
                                            value="${bean.phone}" maxlength="20"> -->
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">手機</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="moblie"
                                            value="${bean.moblie}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">Line</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="line"
                                            value="${bean.line}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <br><br>
                                    <div class="col-md-1">&nbsp;</div>
                                </div>


                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1"></div>
                                    <div class="col-md-3">
                                        <div class="row" id="twzipcode"></div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">地址</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="address"
                                            value="${bean.address}" maxlength="20">
                                    </div>
                                </div>






                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">部門</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="department"
                                            value="${bean.department}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">直屬主管</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="director"
                                            value="${bean.director}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">傳真</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="fax" value="${bean.fax}"
                                            maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">備註</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <textarea name="remark" class="col-md-9" id="message" maxlength="450"
                                            style="width: 100%; ">${bean.remark}</textarea>
                                    </div>
                                </div>





                                <!--  -->
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1"></div>
                                    <div class="col-md-3 FormPadding">
                                        <button type="submit" style="width: 100%;" class="btn btn-primary">送出</button>
                                    </div>
                                </div>



                            </div>
                        </form>


                        <!-- ///////////////////////////////////////////////////////////////////////////// -->

                    </div>


                    <!-- 客戶彈窗 -->
                    <div class="clientwork" title="客戶">
                        <!-- <%-- 抬頭搜索--%> -->
                        <div class="col-lg-5">
                            <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                <input type="text" class="form-control selectclient"
                                    placeholder=" 名稱  or 統編 or 負責人or 電話" aria-label="Recipient's username"
                                    aria-describedby="button-addon2">
                                <button class="btn btn-outline-secondary " type="submit"
                                    onclick="selectclient()">搜索</button>
                            </div>
                        </div>

                        <table class="Table table-striped clientTable">
                            <tr>
                                <td>客戶名稱</td>
                                <td>統編</td>
                                <td>負責人</td>
                                <td>電話</td>
                                <td>產業</td>
                            </tr>
                            <c:if test="${not empty clientList}">
                                <c:forEach varStatus="loop" begin="0" end="${clientList.size()-1}" items="${clientList}"
                                    var="s">
                                    <tr class="item" onclick="clickClient('${s.name}',${s.clientid})"
                                        style="cursor: pointer;">
                                        <td> ${s.name}</td>
                                        <td> ${s.uniformnumber}</td>
                                        <td> ${s.user}</td>
                                        <td> ${s.phone}</td>
                                        <td> ${s.industry}</td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>
                    <!-- 客戶彈窗/// -->
                </div>
            </div>
        </body>
        <script>

            $(".client").show();
            // 日期UI
            $(function () {
                $(".contacttime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight + 'px' });
                    }
                });
                // 密碼驗證
                jQuery.validator.setDefaults({
                    submitHandler: function () {
                        if (confirm("提交確認")) form.submit();
                    }
                });
                $.extend($.validator.messages, {
                    required: "這是必填字段",
                    email: "請输入有效的電子郵件地址",
                    url: "请输入有效的网址",
                    date: "请输入有效的日期",
                    dateISO: "请输入有效的日期 (YYYY-MM-DD)",
                    number: "请输入有效的数字",
                    digits: "只能输入数字",
                    creditcard: "请输入有效的信用卡号码",
                    equalTo: "你的输入不相同",
                    extension: "请输入有效的后缀",
                    maxlength: $.validator.format("最多可以输入 {0} 个字符"),
                    minlength: $.validator.format("最少要输入 {0} 个字符"),
                    rangelength: $.validator.format("请输入长度在 {0} 到 {1} 之间的字符串"),
                    range: $.validator.format("请输入范围在 {0} 到 {1} 之间的数值"),
                    max: $.validator.format("请输入不大于 {0} 的数值"),
                    min: $.validator.format("请输入不小于 {0} 的数值")
                });
                $("#myform").validate();
            });
            // 地區ui
            $("#twzipcode").twzipcode({
                countySel: "${bean.city}",
                districtSel: "${bean.town}",
                "zipcodeIntoDistrict": true,
                // "css": ["city form-control", "town form-control"],
                "countyName": "city", // 指定城市 select name
                "districtName": "town", // 指定地區 select name
                "zipcodeName": "postal" // 指定號碼 select name
            });

            function showclient() {
                $('.clientwork').dialog("open");
            }
            $(".clientwork").dialog({
                autoOpen: false,
                position: {
                    at: "top+300"
                },
                width: 1000,
                height: 300
            });
            if ("${message}" == "儲存成功") {
                alert("儲存成功");
                location.href = "${pageContext.request.contextPath}/CRM/contact/${bean.contactid}";
            }
            //點選客戶後
            function clickClient(name, id) {
                $(".clientName").text(name);
                $(".clientName").attr("href", "${pageContext.request.contextPath}/CRM/client/" + id);
                $("input[name='clientid']").val(id);
                $("input[name='company']").val(name);
                $('.clientwork').dialog("close");
                $.ajax({
                    url: '${pageContext.request.contextPath}/work/selectContact/' + name,//接受請求的Servlet地址
                    type: 'POST',
                    success: function (list) {
                        $("select[name='contactid']").empty();
                        for (var bean of list) {
                            $("select[name='contactid']").append('<option value="' + bean.contactid + '" selected>' + bean.name + '</option>');
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
            init();
            function init() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/work/clientList',//接受請求的Servlet地址
                    type: 'POST',
                    async: false,//同步請求
                    cache: false,//不快取頁面
                    success: function (list) {
                        $(".clientTable").empty();
                        $(".clientTable").append("<tr><td>客戶名稱</td> <td>統編</td><td>負責人</td> <td>電話</td> <td>產業</td></tr>");
                        for (var bean of list) {
                            $(".clientTable").append('<tr class="item" onclick="clickClient(`' + bean.name + '`,' + bean.clientid + ')" style="cursor: pointer;">' +
                                '<td> ' + bean.name + '</td><td>' + bean.uniformnumber + ' </td><td> ' + bean.user + '</td><td> ' + bean.phone + '</td><td>' + bean.industry + ' </td></tr>');
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
            //搜索客戶
            function selectclient() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/work/selectclient/' + $('.selectclient').val(),//接受請求的Servlet地址
                    type: 'POST',
                    success: function (list) {
                        $(".clientTable").empty();
                        $(".clientTable").append("<tr><td>客戶名稱</td> <td>統編</td><td>負責人</td> <td>電話</td> <td>產業</td></tr>");
                        for (var bean of list) {
                            $(".clientTable").append('<tr class="item" onclick="clickClient(`' + bean.name + '`,' + bean.clientid + ')" style="cursor: pointer;">' +
                                '<td> ' + bean.name + '</td><td>' + bean.uniformnumber + ' </td><td> ' + bean.user + '</td><td> ' + bean.phone + '</td><td>' + bean.industry + ' </td></tr>');
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }

        </script>

        </html>