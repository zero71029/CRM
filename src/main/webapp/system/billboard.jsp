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
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">

            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">

            <!-- tiny所見即所得 -->
            <!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/tinymce/4.7.6/tinymce.min.js"></script> -->
            <script src="${pageContext.request.contextPath}/tinymce/js/tinymce/tinymce.min.js"></script>
            <script>
                tinymce.init({
                    language: 'zh_TW',
                    branding: false,//去除右下角的'由tinymce驅動'
                    elementpath: false,//左下角的當前標籤路徑
                    selector: 'textarea',
                    height: '460',
                    plugins: [
                        "autosave advlist autolink lists link image charmap print preview hr anchor pagebreak ",
                        "searchreplace wordcount visualblocks visualchars code ax_wordlimit fullscreen",
                        "insertdatetime media nonbreaking save table contextmenu directionality",
                        "emoticons template paste textcolor colorpicker textpattern imagetools"
                    ],
                    toolbar1: "insertfile undo redo restoredraft | formatselect fontselect fontsizeselect lineheight| alignleft aligncenter alignright alignjustify | bullist numlist outdent indent  " +
                        "bold italic underline strikethrough subscript superscript | forecolor backcolor charmap emoticons | link unlink selectiveDateButton media | cut copy paste | insertdatetime fullscreen code|table hr pagebreak blockquote |" +
                        "print preview ",

                    menubar: false,
                    image_advtab: true,
                    autosave_ask_before_unload: false,//關閉 嘗試關閉當前窗口時提示他們有未保存的更改
                    ax_wordlimit_num: 990,
                    ax_wordlimit_callback: function (editor, txt, num) {
                        alert('当前字数：' + txt.length + '，限制字数：' + num);
                    },
                    //自訂義按鈕
                    setup: (editor) => {
                        //定義新icon
                        editor.ui.registry.addIcon('triangleUp', `<i class="bi bi-image"></i>`);
                        //設定功能
                        editor.ui.registry.addButton('selectiveDateButton', {
                            icon: 'triangleUp',
                            tooltip: 'Insert Image',
                            onAction: (_) => {
                                vm.imgVisible = true;
                            },
                        });
                    }
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
            <!-- <%--上傳 彈窗--%> -->
            <div class="app">
                <el-dialog title="上傳" :visible.sync="imgVisible" width="30%">
                    <el-upload class="upload-demo" drag action="${pageContext.request.contextPath}/upfile" multiple
                        :on-success="upSuccess" :before-upload="beforeAvatarUpload">
                        <i class="el-icon-upload"></i>
                        <div class="el-upload__text">將文件拖到此處，或<em>點擊上傳</em></div>
                        <div class="el-upload__tip" slot="tip">只能上傳jpg/png文件，且不超過2MB</div>
                    </el-upload>
                </el-dialog>
            </div>







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
                    <button class="btn btn-outline-secondary" type="button" id="button-addon2"
                        onclick="addOption()">提交</button>
                </div>
            </div>
            <!-- <%-- 彈窗/////////////////////////////////////--%> -->
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-lg-11 ">
                        <div class="row ">
                            <div class="col-md-8">
                                <!-- <%-- 中間主體--%> -->
                                <br>
                                <!-- 上一頁 -->
                                <div class="row">
                                    <div class="col-lg-2">
                                        <a href="javascript:history.back()" style="text-decoration: none;"><img
                                                src="${pageContext.request.contextPath}/img/Pre.png" alt="上一頁"></a>
                                    </div>
                                </div>
                                <br>


                                <!-- 授權 -->
                                <c:if test="${empty authorizeBean}">
                                    <c:if test="${empty bean}">
                                        <form action="${pageContext.request.contextPath}/system/authorize" method="POST"
                                            name="authorize">
                                            <div class="row">
                                                <div class="col-lg-1 cell cellbackgroud">授權</div>
                                                <div class="col-lg-5 cell" style="padding: 0%;">
                                                    <select input type="text" class=" form-select cellFrom"
                                                        name="adminid">
                                                        <option class="selItemOff" value="0">新增</option>
                                                        <c:if test="${not empty admin}">
                                                            <c:forEach varStatus="loop" begin="0"
                                                                end="${admin.size()-1}" items="${admin}" var="s">
                                                                <option class="selItemOff" value="${s.adminid}">
                                                                    ${s.name}
                                                                </option>
                                                            </c:forEach>
                                                        </c:if>
                                                    </select>
                                                </div>
                                                <div class="col-lg-4 cell" style="padding: 0%;"><button type="submit"
                                                        style="width: 100%;background-color: #08604f;color: white;"
                                                        class="btn ">發送</button></div>
                                            </div>
                                            <br><br>
                                        </form>
                                    </c:if>
                                </c:if>




                                <c:if test="${empty authorizeBean}">
                                    <form action="${pageContext.request.contextPath}/system/SaveBillboard" method="post"
                                        id="myform" class="g-3 needs-validation">
                                </c:if>
                                <c:if test="${not empty authorizeBean}">
                                    <form action="${pageContext.request.contextPath}/saveAuthorize/${authorizeBean.id}"
                                        method="post" id="myform" class="g-3 needs-validation">
                                </c:if>


                                <div class="row">
                                    <input type="hidden" name="authorize" value="${param.authorize}">
                                    <input type="hidden" name="billboardid" value="${bean.billboardid}">
                                    <input type="hidden" name="user" value="${user.name}">
                                    <div class="row">
                                        <div class="col-lg-10 cell position-relative cellbackgroud"
                                            style="text-align: center;color:white;background-color: #569b92; font-size: 20px;">
                                            發布公告</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 cell position-relative cellbackgroud">發佈者</div>
                                        <div class="col-lg-9 cell">${bean.user}${param.authorize}</div>
                                    </div>

                                    <div class="row">

                                        <div class="col-lg-1 cell position-relative cellbackgroud">主題*</div>
                                        <div class="col-lg-9 cell" style="padding: 0%;">
                                            <input type="text" class=" form-control cellFrom" name="theme"
                                                value="${bean.theme}" maxlength="90" required>
                                        </div>

                                    </div>
                                    <div class="row">

                                        <div class="col-lg-1 cell position-relative cellbackgroud">內容*</div>
                                        <div class="col-lg-9 cell " style="padding: 0%;">
                                            <textarea class="cellFrom" name="content" style="width: 100%;" rows="10"
                                                required id="content" maxlength="950">${bean.content} </textarea>
                                        </div>

                                    </div>
                                    <div class="row">

                                        <div class="col-lg-1 cell cellbackgroud">狀態</div>
                                        <div class="col-lg-4 cell" style="padding: 0%;">
                                            <select input type="text" class=" form-select cellFrom" name="state">
                                                <option ${bean.state=="公開" ?"selected":null} class="selItemOff">公開
                                                </option>
                                                <option ${bean.state=="封存" ?"selected":null} class="selItemOff">封存
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-1 cell cellbackgroud">日期</div>
                                        <div class="col-lg-4 cell">${bean.lastmodified}</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-1 cell cellbackgroud">群組</div>
                                        <div class="col-lg-4 cell" style="padding: 0%;">
                                            <select input type="text" class=" form-select cellFrom billboardGroup"
                                                name="billtowngroup">
                                                <option ${bean.billtowngroup=="一般公告" ?"selected":null}
                                                    class="selItemOff" value="一般公告">一般公告</option>
                                                <option ${bean.billtowngroup=="生產" ?"selected":null} class="selItemOff"
                                                    value="生產">生產</option>
                                                <option ${bean.billtowngroup=="採購" ?"selected":null} class="selItemOff"
                                                    value="採購">採購</option>
                                                <option ${bean.billtowngroup=="研發" ?"selected":null} class="selItemOff"
                                                    value="研發">研發</option>
                                                <option ${bean.billtowngroup=="業務" ?"selected":null} class="selItemOff"
                                                    value="業務">業務</option>
                                                <option ${bean.billtowngroup=="行銷" ?"selected":null} class="selItemOff"
                                                    value="行銷">行銷</option>
                                                <option ${bean.billtowngroup=="財務" ?"selected":null} class="selItemOff"
                                                    value="財務">財務</option>
                                            </select>
                                        </div>
                                        <div class="col-lg-1 cell cellbackgroud">子項</div>
                                        <div class="col-lg-4 cell" style="padding: 0%;">
                                            <select name="billboardgroupid" id="" class="form-select billtownoption">
                                                <!--  -->

                                                <!--  -->
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row">

                                        <div class="col-lg-1 cell cellbackgroud">點讚人數</div>
                                        <div class="col-lg-9 cell"> <a
                                                href="javascript:ReadNum()">${bean.read.size()}</a>
                                        </div>

                                    </div>
                                    <c:if test='${user.position == "系統" || user.position == "總經理"}'>
                                        <div class="row">
                                            <div class="col-lg-1 cell cellbackgroud">置頂</div>
                                            <div class="col-lg-9 cell">
                                                <input type="radio" name="top" id="asd" value="" ${empty bean?"checked"
                                                    :""} ${bean.top=="" ?"checked":""}> <label for="asd">一般</label>
                                                <input type="radio" name="top" id="top" value="置頂" ${bean.top=="置頂"
                                                    ?"checked":""}><label for="top">置頂</label>
                                            </div>

                                        </div>
                                    </c:if>
                                    <c:if test='${!(user.position == "系統" || user.position == "總經理")}'>
                                        <input type="hidden" name="top" value="">
                                    </c:if>




                                    <c:if test="${not empty bean}">
                                        <div class="row">
                                            <div onclick="advice()"
                                                class="col-lg-1 cell position-relative cellbackgroud adv">
                                            </div>
                                            <style>
                                                .adv {
                                                    height: 27px;
                                                    background-image: url(${pageContext.request.contextPath}/img/aaa.png);
                                                    background-repeat: no-repeat;
                                                    background-size: contain;
                                                    background-position: center;
                                                    border-top: #ccc 3px solid;
                                                    border-right: black 2px solid;
                                                    border-bottom: #000 2px solid;
                                                    border-left: #ccc 3px solid;
                                                    cursor: pointer;
                                                }
                                            </style>
                                            <div class="col-lg-9 cell">
                                                <c:if test="${not empty bean.advice}">
                                                    <c:forEach varStatus="loop" begin="0" end="${bean.advice.size()-1}"
                                                        items="${bean.advice}" var="ad">
                                                        ${ad.formname} &nbsp;&nbsp;&nbsp;

                                                    </c:forEach>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:if>


                                    <c:if test="${bean.user == user.name  || empty bean}">
                                        <div class="row">
                                            <div class="col-lg-10" style="padding: 0%;">
                                                <button type="submit"
                                                    style="width: 100%;background-color: #08604f;color: white;"
                                                    class="btn ">儲存</button>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                </form>
                                <br><br>



                                <!-- 回覆內容 -->
                                <c:if test="${not empty bean.reply}">
                                    <c:forEach varStatus="loop" begin="0" end="${bean.reply.size()-1}"
                                        items="${bean.reply}" var="s">
                                        <div class="row" style="line-height: 2rem;">
                                            <div class="col-md-1 cell cellbackgroud">${s.name}</div>
                                            <div class="col-md-9 cell" style="position: relative;word-wrap:break-word;">
                                                ${s.content} <span
                                                    style="position: absolute;right: 0%;">${s.lastmodified}</span>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <br><br><br><br><br>
                            </div>


                            <div class="col-md-3">
                                <c:if test="${not empty bean}">
                                    <br><br><br><br><br>

                                    <br>
                                    <!-- 附件 -->
                                    <c:if test="${not empty bean.file}">
                                        <div class="row">
                                            <div class="col-lg-12 cell"
                                                style="background-color : #569b92 ;text-align: center;">
                                                附件</div>
                                        </div>
                                        <c:forEach varStatus="loop" begin="0" end="${bean.file.size()-1}"
                                            items="${bean.file}" var="s">
                                            <c:set var="url" value="${pageContext.request.contextPath}/file/${s.url}">
                                            </c:set>
                                            <div class="row" draggable="true"
                                                ondragstart="event.dataTransfer.setData('text/plain', '<img width=100% src=${url} onerror=errorOne()>')">
                                                <div class="col-md-2 cell position-relative cellbackgroud">附件</div>
                                                <div class="col-lg-8 cell" style="word-wrap: break-word;"><a
                                                        href="${pageContext.request.contextPath}/file/${s.url}"
                                                        target="_blank">${s.name} </a>
                                                </div>
                                                <div class="col-md-2 cell position-relative ">
                                                    <a
                                                        href="${pageContext.request.contextPath}/system/remove/${s.fileid}/${bean.billboardid}">remove</a>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <img src="" alt="">
                                    <!-- 上傳 -->
                                    <div class="row">
                                        <form class="row uppdf" action="" method="post" enctype='multipart/form-data'>
                                            <input type="file" name="file1" onchange="upfile(0);" class="fileInput"
                                                value="" />
                                        </form>
                                    </div>
                                    <!-- @表單 -->
                                    <c:if test="${not empty admin}">
                                        <form
                                            action="${pageContext.request.contextPath}/system/advice/${user.adminid}/${bean.billboardid}"
                                            method="post">


                                            <div class="row advice" style="border: #08604f 1px solid;">
                                                <div class="col-lg-12" style="background-color: #569b92;"><input
                                                        type="checkbox" id="all">全部: </div>
                                                <div class="col-lg-12" style="background-color: #569b92;"><input
                                                        type="checkbox" id="group1">生產: </div>


                                                <!-- admin 迴圈 -->
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
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
                                                        type="checkbox" id="group2">採購:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '採購'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group2" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                                <div class="col-lg-12" style="background-color: #569b92;">國貿:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '國貿'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group2" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                                <div class="col-lg-12" style="background-color: #569b92;"><input
                                                        type="checkbox" id="group3">研發:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
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
                                                        type="checkbox" id="group4">業務:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
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
                                                        type="checkbox" id="group5">行銷:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
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
                                                        type="checkbox" id="group6">財務:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
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
                                                        type="checkbox" id="group7">IT:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == 'IT'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group7" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>
                                                <div class="col-lg-12" style="background-color: #569b92;"><input
                                                        type="checkbox" id="group8">總經理:</div>
                                                <c:forEach varStatus="loop" begin="0" end="${admin.size()}"
                                                    items="${admin}" var="s">
                                                    <c:if test="${s.department == '總經理'}">
                                                        <div class="col-lg-4">
                                                            <input type="checkbox" name="adviceto" id="${s.name}"
                                                                class="group8" value="${s.adminid}"><label
                                                                for="${s.name}">${s.name}
                                                            </label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                                                        </div>
                                                    </c:if>
                                                </c:forEach><br>

                                                <button type="submit">標記</button>
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
                                    </c:if>
                                    <!-- @表單 /////////////////////////////////////////////////////////////////-->
                                </c:if>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </body>
        <!-- @ java 轉資料給javaScript -->
        <c:forEach varStatus="loop" begin="0" end="${bean.advice.size()}" items="${bean.advice}" var="ad">
            <script>
                var a = "${ad.formname}"
                $("#${ad.formname}").prop("checked", true);
            </script>
        </c:forEach>



        <!-- 驗證UI -->
        <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
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
            console.log(group);
            if (group == "") group = "一般公告";
            console.log(group);
            // 插入子項
            for (var option of billboardgroup) {
                if (Object.keys(option)[0] == group) $(".billtownoption").append('<option  value="' + option[group] + '">' + option[group] + '</option>');
            }
            var aaa = '${bean.bgb.billboardoption}';
            if (aaa == '') {

            } else {
                $(".billtownoption").val(aaa);
            }
            // 新增分類
            var $group = $(".billboardGroup");
            var $option = $(".billtownoption");

            $(".billtownoption").append('<option value="new" style="background-color: #ccc;">新增</option>');

            //切換子項
            $(".billtownoption").change(function () {
                //切換子項 選到新稱
                if ($(".billtownoption").val() == "new") {
                    $(".cat").show();
                    $(".hazy").show();
                    $(".optinUL").empty();

                    for (var option of billboardgroup) {
                        if (Object.keys(option)[0] == $group.val()) $(".optinUL").append('<li>' + option[$group.val()] + ' &nbsp;&nbsp;&nbsp;&nbsp; <a href="javascript:delOption(`' + option[$group.val()] + '`)">remove</a></li>');
                    }
                }
            });
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
                $(".billtownoption").append('<option value="new" style="background-color: #ccc;">新增</option>');
            })
            //新增子項
            function addOption() {
                console.log($(".addOption").val());
                console.log(group);
                $.ajax({
                    url: '${pageContext.request.contextPath}/system/addOption/' + group + "/" + $(".addOption").val(),//接受請求的Servlet地址
                    type: 'POST',
                    // data: formData,
                    // async: false,//同步請求
                    // cache: false,//不快取頁面
                    // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        alert(json);
                        if ("${bean.billboardid}" == "") {
                            location.href = '${pageContext.request.contextPath}/system/NewBillboard.jsp';
                            console.log("ddd" + "${bean.billboardid}");
                        } else {
                            location.href = '${pageContext.request.contextPath}/system/billboard/${bean.billboardid}';
                        }


                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
            //刪除子項

            function delOption(a) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/system/delOption/' + group + "/" + a,//接受請求的Servlet地址
                    type: 'POST',
                    // data: formData,
                    // async: false,//同步請求
                    // cache: false,//不快取頁面
                    // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        alert(json);
                        if ("${bean.billboardid}" == "") {
                            location.href = '${pageContext.request.contextPath}/system/billboard.jsp';
                        }
                        else {
                            location.href = '${pageContext.request.contextPath}/system/billboard/${bean.billboardid}';
                        }


                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
        </script>
        <!-- 分類結束///////////// -->
        <script>
            $(".system").show();
            $(".cat").hide();
            $(".hazy").hide();
            // 返回按鈕
            $(".catReturn").click(function () {
                $(".cat").hide();
                $(".hazy").hide();
                $("option[value='全部']").prop("selected", true);

            });

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
                $("#myform").validate({
                    // rules: {
                    //     password: "required",
                    //     password_again: {
                    //         equalTo: "#password"
                    //     }
                    // }
                });

            });
            //上傳型錄
            upfile = function (i) {
                var formData = new FormData($(".uppdf")[0]);
                console.log(formData);
                $.ajax({
                    url: '${pageContext.request.contextPath}/system/upFile/${bean.billboardid}',//接受請求的Servlet地址
                    type: 'POST',
                    data: formData,
                    async: false,//同步請求
                    cache: false,//不快取頁面
                    contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (url) {
                        alert(url);
                        window.location.href = "${pageContext.request.contextPath}/system/billboard/${bean.billboardid}";
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
            //@標註
            function advice() {
                $(".advice").toggle();
            }
            $(".advice").hide();

            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        imgVisible: false,
                    }
                },
                created() {

                },
                methods: {
                    //上傳檢查
                    beforeAvatarUpload(file) {
                        const isJPG = file.type === 'image/jpeg';
                        const isLt2M = file.size / 1024 / 1024 < 2;
                        if (!(file.type == 'image/jpeg' || file.type == 'image/png')) {
                            this.$message.error('上傳圖片只能是 JPG/PNG 格式!');
                            return false;
                        }
                        if (!isLt2M) {
                            this.$message.error('上傳圖片大小不能超過 2MB!');
                            return false;
                        }
                        return true;
                    },
                    //上傳成功
                    upSuccess(response, file, fileList) {
                        console.log(response);
                        const img = `<p><img src="${pageContext.request.contextPath}/file/` + response + `"  style="max-width: 90%; height: auto;"></p><p>&nbsp;</p>`;
                        console.log(img);
                        this.imgVisible = false;
                        tinymce.activeEditor.execCommand('mceInsertContent', false, img);
                    },
                },
            })



        </script>
        <div id="dialog" title="已讀人員">
            <p>
                <c:forEach varStatus="loop" begin="0" end="${bean.read.size()}" items="${bean.read}" var="s">
                    ${s.name} <br>
                </c:forEach>


            </p>
        </div>
        <style>
            .el-upload {
                width: 100%;
            }

            .el-upload-dragger {
                width: auto;
            }

            .img-fluid {
                max-width: 100px;
                height: auto;
            }
        </style>

        </html>