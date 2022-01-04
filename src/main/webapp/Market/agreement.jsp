<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">

            <!-- bootstrap的CSS、JS樣式放這裡  -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css">
            <!-- <%-- jQuery放這裡 --%> -->
            <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
            <!-- <%-- jQueryUI放這裡 --%> -->
            <link rel="stylesheet"
                href="${pageContext.request.contextPath}/jquery-ui-192/css/base/jquery-ui-1.9.2.custom.css">
            <script src="${pageContext.request.contextPath}/jquery-ui-192/js/jquery-ui-1.9.2.custom.js"></script>
            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <!-- 台灣縣市二聯式選單 -->
            <script src="${pageContext.request.contextPath}/js/jquery.twzipcode.min.js"></script>
            <!-- 驗證UI -->
            <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
            <title>CRM客戶管理系統</title>
        </head>
        <style>
            .cell {
                border: 0px solid black;
                border-bottom: 1px solid black;
                /* margin-bottom: 5px; */

            }

            .cellFrom {
                border: 0px solid black;
                /* width: 33%; */
            }

            .cellbackground {
                background-color: #BBB;
                border-bottom: 1px solid black;
            }

            .btn a {
                text-decoration: none;
                text-align: center;
                background-color: #BBB;
                display: block;
            }

            .log {
                text-align: center;
                background-color: rgb(102, 102, 102);
                color: white;
                border-radius: 5px 5px 0 0;
            }

            .error {
                color: red;
            }

            .contact {
                margin: 10px 0;
            }

            .contact:hover {
                background-color: rgb(234, 169, 48);
            }
        </style>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->

                    <div class="col-md-10">
                        <!-- <%-- 中間主體--%> -->
                        <br>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <h3>合約</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-1 btn">
                                <a href="javascript:history.back()"
                                    style="text-decoration: none;text-align: center;background-color: #BBB;display: block;">＜</a>
                            </div>

                            <div class="col-md-1 btn">
                                <a href="javascript:"
                                    style="text-decoration: none;text-align: center;background-color: #BBB;display: block;">..</a>
                            </div>

                        </div>
                        <br>
                        <form action="${pageContext.request.contextPath}/CRM/SaveAgreement" method="post" id="myform"
                            class="basefrom g-3 ">
                            <div class="row">
                                <input type="hidden" name="agreementid" value="${bean.agreementid}">


                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-6 log">基本資訊</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">客戶*</div>
                                    <div class="col-md-5 cell">
                                        <input type="text" class="form-control cellFrom client" name="company"
                                            list="company" value="${bean.company}" maxlength="20" required>
                                        <datalist id="company">
                                            <c:if test="${not empty client}">
                                                <c:forEach varStatus="loop" begin="0" end="${client.size()-1}"
                                                    items="${client}" var="s">
                                                    <option value="${s.name}">
                                                </c:forEach>
                                            </c:if>
                                        </datalist>
                                    </div>
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">負責人*</div>
                                    <div class="col-md-2 cell">
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
                                    <div class="col-md-1 cellbackground">電話</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom" name="phone"
                                            value="${bean.phone}" maxlength="20">
                                    </div>
                                    <div class="col-md-1 cellbackground">聯絡人</div>
                                    <div class="col-md-2 cell">
                                        <select name="contactname" class="form-select cellFrom contactname"
                                            aria-label="Default select example">
                                            <option value="">無</option>
                                            <c:if test="${not empty contact}">
                                                <c:forEach varStatus="loop" begin="0" end="${contact.size()-1}"
                                                    items="${contact}" var="s">
                                                    <option value="${s.name}" ${bean.contactname==s.name
                                                        ?"selected":null}>
                                                        ${s.name}</option>
                                                </c:forEach>
                                            </c:if>
                                            <option value="new" onclick="AAA()">新增</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">合約編號</div>
                                    <div class="col-md-2 cell">${bean.agreementid}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">Email</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom" name="email"
                                            value="${bean.email}" maxlength="50">
                                    </div>
                                    <div class="col-md-1 cellbackground">聯絡人手機</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom contactmoblie"
                                            name="contactmoblie" value="${bean.contactmoblie}" maxlength="20">
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">傳真</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom" name="fax" value="${bean.fax}"
                                            maxlength="20">
                                    </div>
                                    <div class="col-md-1 cell cellbackground">聯絡人職務</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom contactjobtitle"
                                            name="contactjobtitle" value="${bean.contactjobtitle}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground ">起始日</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom createtime" name="createtime"
                                            value="${bean.createtime}" maxlength="20" readonly>
                                    </div>
                                    <div class="col-md-1 cell cellbackground">終止日</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom endtime" name="endtime"
                                            value="${bean.endtime}" maxlength="20" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1">&nbsp;</div>
                                    <div class="col-md-8"></div>
                                </div>
                                <br><br>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-6 log">地址</div>
                                </div>

                                <div class="row">
                                    <div class="col-md-1">&nbsp;</div>
                                    <div class="col-md-1 cellbackground">地址</div>
                                    <div class="col-md-2 cell" id="twzipcode"></div>
                                    <div class="col-md-3 cell">
                                        <input type="text" class=" form-control cellFrom contactjobtitle" name="address"
                                            value="${bean.address}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1">&nbsp;</div>
                                    <div class="col-md-8"></div>
                                </div>
                                <br><br>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-6 log">合約內容</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell" style="background-color: #BBB;">特殊條款</div>
                                    <div class="col-md-5 cell"> <textarea name="specialterms" class="col-md-9"
                                            id="specialterms" maxlength="450"
                                            style="width: 100%; ">${bean.specialterms}</textarea></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell" style="background-color: #BBB;">描述</div>
                                    <div class="col-md-5 cell"> <textarea name="agreementdescribe" class="col-md-9"
                                            id="agreementdescribe" maxlength="450"
                                            style="width: 100%; ">${bean.agreementdescribe}</textarea></div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1">&nbsp;</div>
                                    <div class="col-md-8"></div>
                                </div>
                                <br><br>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-6 log">簽約資訊</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">客戶簽約人</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom" name="agreementname"
                                            value="${bean.agreementname}" maxlength="50">
                                    </div>
                                    <div class="col-md-1 cellbackground">公司簽約人</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom " name="companyname"
                                            value="${bean.companyname}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">客戶簽約人職稱</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom" name="agreementjobtitle"
                                            value="${bean.agreementjobtitle}" maxlength="50">
                                    </div>
                                    <div class="col-md-1 cellbackground">公司簽約人職稱</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom " name="companyjobtitle"
                                            value="${bean.companyjobtitle}" maxlength="20">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cellbackground">客戶簽約日期</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom agreementtime"
                                            name="agreementtime" value="${bean.agreementtime}" maxlength="50" readonly>
                                    </div>
                                    <div class="col-md-1 cellbackground">公司簽約日期</div>
                                    <div class="col-md-2 cell">
                                        <input type="text" class=" form-control cellFrom companytime" name="companytime"
                                            value="${bean.companytime}" maxlength="20" readonly>
                                    </div>
                                </div>

                            </div>




                            <br>


                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-6">
                                    <button type="submit" style="width: 100%;" class="btn btn-primary"
                                        onclick="">新增/修改</button>
                                </div>
                            </div>

                            <br><br><br>


                            <!-- ////////////////////////////////////////////////////////////////// -->
                    </div>
                    </form>
                </div>
            </div>
        </body>


        <!-- //轉資料給javascript -->
        <script>
            var contactmoblie = new Object;
            var contactjobtitle = new Object;
        </script>
        <c:if test="${not empty contact}">
            <c:forEach varStatus="loop" begin="0" end="${contact.size()-1}" items="${contact}" var="s">

                <script>
                    contactmoblie['${s.name}'] = "${s.moblie}";
                    contactjobtitle['${s.name}'] = "${s.jobtitle}";
                </script>
            </c:forEach>
        </c:if>


        <script>
            // 地區ui
            $("#twzipcode").twzipcode({
                countySel: "${bean.city}",
                districtSel: "${bean.postal}",
                "zipcodeIntoDistrict": true,
                // "css": ["city form-control", "town form-control"],
                "countyName": "city", // 指定城市 select name
                "districtName": "town", // 指定地區 select name
                "zipcodeName": "postal" // 指定號碼 select name
            });

            $(".market").show();

            $(function () {
                // 日期UI
                $(".createtime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight + 'px' });
                    }
                });
                $(".endtime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight - 210 + 'px' });
                    }
                });
                $(".agreementtime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight + 'px' });
                    }
                });
                $(".companytime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight - 210 + 'px' });
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
            //聯絡人改變 一起改變電話
            $('.contactname').on('change', function () {
                var name = $(this).val();
                if (name == "new") window.location.href = "${pageContext.request.contextPath}/client/contact.jsp";
                $('.contactmoblie').val(contactmoblie[name]);
                $('.contactjobtitle').val(contactjobtitle[name]);

            });
            //改變各戶端後  一起改變聯絡人
            $(".client").on('change', function () {
                console.log($("input[name='company']").val());
                $.ajax({
                    url: '${pageContext.request.contextPath}/CRM/selectContactByClientName/' + $("input[name='company']").val(),//接受請求的Servlet地址
                    type: 'POST',
                    // data: formData,
                    // async: false,//同步請求
                    // cache: false,//不快取頁面
                    // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        console.log(json);
                        $('.contactname').empty();
                        $('.contactname').append('<option value="">無</option>');
                        for (var j of json) {
                            $('.contactname').append('<option value="' + j.name + '">' + j.name + '</option>');
                            contactmoblie[j.name] = j.moblie;
                            contactjobtitle[j.name] = j.jobtitle;
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });


            });










        </script>

        </html>