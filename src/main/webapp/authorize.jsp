<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE HTML>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <!-- tiny -->
            <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.7.6/tinymce.min.js"></script> -->
            <script src="${pageContext.request.contextPath}/tinymce/js/tinymce/tinymce.min.js"></script>
            <script>
                tinymce.init({
                    language: 'zh_TW',
                    selector: 'textarea',
                    height: '460',
                    plugins: [
                        "advlist autolink lists link image charmap print preview hr anchor pagebreak",
                        "searchreplace wordcount visualblocks visualchars code fullscreen",
                        "insertdatetime media nonbreaking save table contextmenu directionality",
                        "emoticons template paste textcolor colorpicker textpattern imagetools"
                    ],
                    toolbar1: "insertfile undo redo | formatselect fontselect fontsizeselect | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | table hr pagebreak blockquote",
                    toolbar2: "bold italic underline strikethrough subscript superscript | forecolor backcolor charmap emoticons | link unlink image media | cut copy paste | insertdatetime fullscreen code",
                    menubar: false,
                    image_advtab: true,
                });
            </script>

            <title>CRM客戶管理系統</title>
        </head>
        <style>
            .cell {
                border: 0px solid black;
                border-bottom: 1px solid black;
            }

            .cellbackgroud {
                background-color: #AAA;
            }

            .cellFrom {
                border: 0px solid black;
                /* width: 33%; */
            }

            .error {
                color: red;
            }
        </style>

        <body>
            <!-- <%-- 彈窗--%> -->
            <div class="hazy"></div>
            <div class="cat">
                <button class="catReturn">X</button>
                <br>
                <ul class="optinUL">
                </ul>
                <div class="input-group mb-3">
                    <input type="text" class="form-control addOption" placeholder="新增" aria-label="Recipient's username"
                        aria-describedby="button-addon2">
                    <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="addOption()">提交
                    </button>
                </div>
            </div>
            <!-- <%-- 彈窗/////////////////////////////////////--%> -->
            <!-- <%-- 插入側邊欄--%> -->
            <div class="container-fluid">
                <div class="row">
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11">
                        <div class="row justify-content-end">
                            <div class="col-lg-7">
                                <!-- <%-- 中間主體--%> -->
                                <br>
                                <br>
                                <form method="post" id="myform" class="g-3 needs-validation">
                                    <div class="row">
                                        <input type="hidden" name="authorize" value="${param.authorize}">
                                        <input type="hidden" name="billboardid" value="${bean.billboardid}">
                                        <input type="hidden" name="user" value="${user.name}">
                                        <input type="hidden" name="state" value="公開">
                                        <input type="hidden" name="top" value="">
                                        <div class="row">
                                            <div class="col-lg-1 cell position-relative cellbackgroud">主題*</div>
                                            <div class="col-lg-9 cell" style="padding: 0%;">
                                                <input type="text" class=" form-control cellFrom" name="theme" id="name"
                                                    value="${bean.theme}" maxlength="90" required>
                                                <span style="color: red;" id="error"></span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-1 cell position-relative cellbackgroud">內容*</div>
                                            <div class="col-lg-9 cell " style="padding: 0%;">
                                                <textarea class="cellFrom" name="content" rows="10" required
                                                    style="width: 100%;" maxlength="450">${bean.content}</textarea>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-1 cell cellbackgroud">群組</div>
                                            <div class="col-lg-4 cell" style="padding: 0%;">
                                                <select input type="text" class=" form-select cellFrom billboardGroup"
                                                    name="billtowngroup">
                                                    <option ${bean.billtowngroup=="一般公告" ?"selected":null}
                                                        class="selItemOff" value="一般公告">一般公告
                                                    </option>
                                                    <option ${bean.billtowngroup=="生產" ?"selected":null}
                                                        class="selItemOff" value="生產">生產
                                                    </option>
                                                    <option ${bean.billtowngroup=="採購" ?"selected":null}
                                                        class="selItemOff" value="採購">採購
                                                    </option>
                                                    <option ${bean.billtowngroup=="研發" ?"selected":null}
                                                        class="selItemOff" value="研發">研發
                                                    </option>
                                                    <option ${bean.billtowngroup=="業務" ?"selected":null}
                                                        class="selItemOff" value="業務">業務
                                                    </option>
                                                    <option ${bean.billtowngroup=="行銷" ?"selected":null}
                                                        class="selItemOff" value="行銷">行銷
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-lg-1 cell cellbackgroud">子項</div>
                                            <div class="col-lg-4 cell" style="padding: 0%;">
                                                <select name="billboardgroupid" id=""
                                                    class="form-select billtownoption">
                                                    <!--  -->

                                                    <!--  -->
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-lg-10" style="padding: 0%;">
                                                <button type="button" style="width: 100%;" class="btn btn-primary"
                                                    onclick="submitMyForm()">儲存
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <br><br>
                                <!-- 回覆內容 -->
                                <c:if test="${not empty bean.reply}">
                                    <c:forEach varStatus="loop" begin="0" end="${bean.reply.size()-1}"
                                        items="${bean.reply}" var="s">
                                        <div class="row" style="line-height: 2rem;">
                                            <div class="col-md-1 cell cellbackgroud">${s.name}</div>
                                            <div class="col-md-9 cell" style="position: relative;">${s.content} <span
                                                    style="position: absolute;right: 0%;">${s.createtime}</span></div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <div class="col-lg-3">
                                <!-- 附件 -->
                                <br><br><br><br><br>
                                <div class="row">
                                    <div class="col-lg-12 cell" style="background-color : #569b92 ;text-align: center;">
                                        附件
                                    </div>
                                </div>
                                <div class="row fileDiv">
                                    <div class="col-lg-6 ">
                                        <a href="${pageContext.request.contextPath}/file/${s.url}"
                                            style="word-wrap: break-word;">${s.url}</a>
                                    </div>
                                    <div class="col-lg-6 ">
                                        <a
                                            href="${pageContext.request.contextPath}/system/remove/${s.fileid}/${bean.billboardid}">remove</a>
                                    </div>
                                </div>
                                <br>
                                <!-- 上傳 -->
                                <div class="row upDiv">
                                    <form class="row uppdf" action="" method="post" enctype='multipart/form-data'>
                                        <input type="file" name="file1" onchange="upfile(0);" class="fileInput"
                                            value="" />
                                    </form>
                                </div>
                                <br><br><br>
                                <!-- @他人 -->
                                <div class="row">
                                    <form id="advice" method="post">
                                        <div class="row advice" style="border: #08604f 1px solid;">
                                            <div class="col-lg-12" style="background-color: #569b92;">
                                                <input type="checkbox" id="all">全部:
                                            </div>
                                            <div class="col-lg-12" style="background-color: #569b92;">
                                                <input type="checkbox" id="group1">生產:
                                            </div>
                                            <!-- admin 迴圈 -->
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == '生產'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group1" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                    </div>
                                                </c:if>
                                            </c:forEach><br>

                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group2">採購:
                                            </div>
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == '採購'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group2" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                    </div>
                                                </c:if>
                                            </c:forEach><br>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group3">研發:
                                            </div>
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == '研發'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group3" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                    </div>
                                                </c:if>
                                            </c:forEach><br>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group4">業務:
                                            </div>
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == '業務'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group4" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                    </div>
                                                </c:if>
                                            </c:forEach><br>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group5">行銷:
                                            </div>
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == '行銷'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group5" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                    </div>
                                                </c:if>

                                            </c:forEach><br>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group6">財務:
                                            </div>
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == '財務'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group6" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                    </div>
                                                </c:if>

                                            </c:forEach><br>
                                            <div class="col-lg-12" style="background-color: #569b92;"><input
                                                    type="checkbox" id="group7">IT:
                                            </div>
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == 'IT'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group7" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                    </div>
                                                </c:if>
                                            </c:forEach><br>

                                            <div class="col-lg-12" style="background-color: #569b92;">
                                                <input type="checkbox" id="group8">總經理:
                                            </div>
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()}" items="${admin}"
                                                var="s">
                                                <c:if test="${s.department == '總經理'}">
                                                    <div class="col-lg-4">
                                                        <input type="checkbox" name="adviceto" id="${s.name}"
                                                            class="group8" value="${s.adminid}"><label
                                                            for="${s.name}">${s.name}
                                                        </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </div>
                                                </c:if>
                                            </c:forEach><br>
                                         
                                        </div>

                                        <input type="hidden" name="adviceto" value="0">
                                    </form>
                                    <script>

                                        var $all = $("input[name='adviceto']");
                                        var $group1 = $(".group1");
                                        var $group2 = $(".group2");
                                        var $group3 = $(".group3");
                                        var $group4 = $(".group4");
                                        var $group5 = $(".group5");
                                        var $group6 = $(".group6");
                                        var $group7 = $(".group7");
                                        var $group8 = $(".group8");
                                        // 勾選單項
                                        $("input[name='adviceto']").change(function () {
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $(".group1").change(function () {
                                            var $zx = $(".group1:checked");
                                            $("#group1").prop("checked", $zx.length == $group1.length);
                                        });
                                        $(".group2").change(function () {
                                            var $zx = $(".group2:checked");
                                            $("#group2").prop("checked", $zx.length == $group2.length);
                                        });
                                        $(".group3").change(function () {
                                            var $zx = $(".group3:checked");
                                            $("#group3").prop("checked", $zx.length == $group3.length);
                                        });
                                        $(".group4").change(function () {
                                            var $zx = $(".group4:checked");
                                            $("#group4").prop("checked", $zx.length == $group4.length);
                                        });
                                        $(".group5").change(function () {
                                            var $zx = $(".group5:checked");
                                            $("#group5").prop("checked", $zx.length == $group5.length);
                                        });
                                        $(".group6").change(function () {
                                            var $zx = $(".group6:checked");
                                            $("#group6").prop("checked", $zx.length == $group6.length);
                                        });
                                        $(".group7").change(function () {
                                            var $zx = $(".group7:checked");
                                            $("#group7").prop("checked", $zx.length == $group7.length);
                                        });
                                        $(".group8").change(function () {
                                            var $zx = $(".group8:checked");
                                            $("#group8").prop("checked", $zx.length == $group8.length);
                                        });
                                        // 勾選全部
                                        $("#all").change(function () {
                                            $("input[type='checkbox']").prop("checked", this.checked);
                                        });
                                        // 勾選部門
                                        $("#group1").change(function () {
                                            $group1.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group2").change(function () {
                                            $group2.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group3").change(function () {
                                            $group3.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group4").change(function () {
                                            $group4.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group5").change(function () {
                                            $group5.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group6").change(function () {
                                            $group6.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group7").change(function () {
                                            $group7.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                        $("#group8").change(function () {
                                            $group8.prop("checked", this.checked);
                                            var $aa = $("input[name='adviceto']:checked");
                                            $("#all").prop("checked", $aa.length == $all.length);
                                        });
                                    </script>

                                </div>

                            </div>

                            <div class="col-lg-1">






                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        <!-- 分類 -->
        <script>
            var billboardgroup = new Array();
        </script>
        <c:forEach varStatus="loop" begin="0" end="${billboardgroup.size()-1}" items="${billboardgroup}" var="s">
            <script>
                billboardgroup.push({ "${s.billboardgroup}": "${s.billboardoption}" });
            </script>
        </c:forEach>
        <script>
            var group = "${bean.billtowngroup}";

            if (group == "") group = "一般公告";

            // 插入子項
            for (var option of billboardgroup) {
                if (Object.keys(option)[0] == group) $(".billtownoption").append('<option  value="' + option[group] + '">' + option[group] + '</option>');
            }
            var aaa = '${bean.bgb.billboardoption}';
            if (aaa == '') {

            } else {
                $(".billtownoption").val(aaa);
            }
            var $group = $(".billboardGroup");
            var $option = $(".billtownoption");
            //切換群組
            $group.change(function () {
                $group = $(".billboardGroup");
                group = $group.val();
                console.log(group);
                $option.empty();
                for (var b of billboardgroup) {
                    if (Object.keys(b)[0] == $group.val()) {
                        $option.append('<option  value="' + b[$group.val()] + '">' + b[$group.val()] + '</option>');
                    }
                }

            })
        </script>
        <!-- 分類結束///////////// -->
        <script>
            $(".system").show();
            $(".cat").hide();
            $(".hazy").hide();


            //先傳送主文  再傳送@標記
            function submitMyForm() {
                const formData = new FormData(document.getElementById("myform"));
                let isOk = true;
                if (document.getElementById("name").value == "") {
                    isOk = false;
                    document.getElementById("name").style.border = "red 1px solid";
                    document.getElementById("error").innerText = "主題必填";
                }
                if (isOk) {
                    $.ajax({
                        url: '${ pageContext.request.contextPath }/saveAuthorize/${authorizeBean.id}',
                        type: 'POST',
                        data: formData,
                        async: false,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (Billboardid) {
                            const d = new FormData(document.getElementById("advice"));
                            $.ajax({
                                url: '${pageContext.request.contextPath}/system/adviceBody/${user.adminid}/'+Billboardid,
                                type: 'POST',
                                data: d,
                                async: false,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (url) {
                                  location.href="${pageContext.request.contextPath}/billboard/Reply/"+Billboardid;
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                }
            };
            $(function () {
                // 日期UI
                $(".contacttime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd"
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
            });
            //上傳型錄
            upfile = function (i) {
                var formData = new FormData($(".uppdf")[0]);
                console.log(formData);
                $.ajax({
                    url: '${pageContext.request.contextPath}/upFile/${authorizeBean.id}',//接受請求的Servlet地址
                    type: 'POST',
                    data: formData,
                    async: false,//同步請求
                    cache: false,//不快取頁面
                    contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (url) {
                        alert(url);
                        selectFile();
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
            $(function () {
                $("#dialog").dialog({ autoOpen: false });
            });

            function ReadNum() {
                $("#dialog").dialog("open");
            }

            //要求附件
            function selectFile() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/selectFile/${authorizeBean.id}',//接受請求的Servlet地址
                    type: 'POST',
                    // data: formData,
                    // async: false,//同步請求
                    // cache: false,//不快取頁面
                    // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        console.log(json);
                        $(".fileDiv").empty();
                        for (var f of json) {
                            var url = "${pageContext.request.contextPath}/file/" + f.url;
                            $(".fileDiv").append('<div class="col-lg-6" style="word-wrap: break-word;" ><a draggable="true"' +
                                ' ondragstart="event.dataTransfer.setData(`text/plain`, `<img width=100% src=' + url + ' onerror=errorOne()>`)" href="${pageContext.request.contextPath}/file/' + f.url + '">' + f.name + '</a></div>' +
                                '<div class="col-lg-6 "><a href="javascript:remove(`' + f.fileid + '`)">remove</a></div>');
                        }
                        $(".upDiv").empty();
                        $(".upDiv").append('<form class="row uppdf" action="" method="post" enctype="multipart/form-data">' +
                            '<input type="file" name="file1" onchange="upfile(0);" class="fileInput" value="" /></form>');
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }

            selectFile();

            //刪除型錄
            function remove(fileId) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/remove/' + fileId,//接受請求的Servlet地址
                    type: 'POST',
                    // data: formData,
                    // async: false,//同步請求
                    // cache: false,//不快取頁面
                    // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        console.log("刪除型錄");
                        console.log(json);
                        $(".fileDiv").empty();
                        selectFile()
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
        </script>
        <div id="dialog" title="已讀人員">
            <p>
                <c:forEach varStatus="loop" begin="0" end="${bean.read.size()}" items="${bean.read}" var="s">
                    ${s.name} <br>
                </c:forEach>
            </p>
        </div>

        </html>