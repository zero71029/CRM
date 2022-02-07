<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>


            <title>CRM客戶管理系統</title>
        </head>
        <style>
            .error{
                color: red;
            }
            .customerbar {
                /* 按鈕顏色 */
                background-color: #afe3d5;
            }

            .cell {
                border: 0px solid black;
                border-bottom: 1px solid black;


            }

            div .cellFrom {
                border: 0px;
                /* width: 33%; */
            }

            .btn a {
                text-decoration: none;
                text-align: center;
                background-color: #569b92;
                color: white;
                ;
                display: block;

            }


            /* 右下角按鈕 */
            .row .box {
                height: 0px;
                width: 460px;
                position: fixed;
                z-index: 1000;
                bottom: 30px;
                right: 0px;
                background-color: #fff;

                padding: 0%;
                border-radius: 15px 0 0 15px;
                margin: 0%;
            }

            .row .dockbar {
                opacity: 1;
                width: 460px;
                height: 30px;
                background-color: #ddd;

                border-radius: 15px 0 0 15px;
            }

            .dockbar div {
                border-right: 1px solid black;
                cursor: pointer;
            }

            .dockbar div:hover {
                background-color: #aaa;

            }

            .box .act {
                position: absolute;
                background-color: #aaa;
                width: 411px;
                bottom: 0px;
                right: 25px;
                color: white;
                padding: 0%;
            }

            .box .act a {
                color: white;
                display: block;
                border: 1px solid white;
                background-color: #569b92;
                text-align: center;
                text-decoration: none;
            }
            /* 右下角按鈕////////////////結束 */
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
                    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <div class="col-md-11 app">
                        <!-- <%-- 中間主體--%> -->
                        <br>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <h3>潛在各戶</h3>
                            </div>
                        </div>
                        <!-- 上一頁 -->
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-1 btn men">
                                <a href="${pageContext.request.contextPath}/Market/potentialcustomerList.jsp">＜</a>
                            </div>
                            <c:if test="${not empty bean}">
                                <!-- <div class="col-md-1 btn men">
                                    <a href="javascript:goClient()">轉成客戶</a>
                                </div>
                                <div class="col-md-1 btn men">
                                    <a href="javascript:goContact()">建立聯絡⼈</a>
                                </div>
                                <div class="col-md-1 btn men">
                                    <a href="javascript:goWork()">新增工作項目</a>
                                </div> -->
                            </c:if>

                        </div>
                        <br>
                        <form action="${pageContext.request.contextPath}/Market/SavePotentialCustomer" method="post"
                            class="basefrom g-3 needs-validation AAA" novalidate>

                            <input type="hidden" name="customerid" value="${bean.customerid}">
                            <input type="hidden" name="fromactivity" value="${bean.fromactivity}" maxlength="50">
                            <div class="row">
                                <!-- 基本資料 -->
                                <div class="col-md-7">
                                    <div class="row" style="text-align: center;">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 bg-warning text-white"
                                            style="background-color: rgb(36, 101, 164);font-size: 1.5rem;color: white;border-radius: 5px 5px 0 0 ;">
                                            基本資料</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">公司<span style="color: red;">*</span></div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class="col-md-4 form-control cellFrom client"
                                                name="company" list="company" value="${bean.company}" maxlength="20"
                                                required>
                                            <datalist id="company">
                                                <c:if test="${not empty client}">
                                                    <c:forEach varStatus="loop" begin="0" end="${client.size()-1}"
                                                        items="${client}" var="s">
                                                        <option value="${s.name}">
                                                    </c:forEach>
                                                </c:if>
                                            </datalist>
                                        </div>




                                        <div class="col-md-2 cell">編號</div>
                                        <div class="col-md-3 cell">${bean.customerid}</div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">聯絡人<span style="color: red;">*</span></div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="name"
                                                value="${bean.name}" maxlength="20" required>
                                        </div>
                                        <div class="col-md-2 cell">部門</div>
                                        <div class="col-md-3 cell FormPadding"><input type="text"
                                                class=" form-control cellFrom" name="department"
                                                value="${bean.department}" maxlength="20">
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">職稱</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="jobtitle"
                                                value="${bean.jobtitle}" maxlength="20">
                                        </div>
                                        <div class="col-md-2 cell">主管</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="director"
                                                value="${bean.director}" maxlength="20">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">Email</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="email" class=" form-control cellFrom" name="email"
                                                value="${bean.email}" maxlength="50">
                                        </div>
                                        <div class="col-md-2 cell">產業</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <select name="industry" class=" form-select cellFrom" v-model="industry">
                                                <option  v-for="(item, index) in industryList" :key="index">{{item}}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">電話</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="phone"
                                                value="${bean.phone}" maxlength="20">
                                        </div>
                                        <div class="col-md-2 cell">公司人數</div>
                                        <div class="col-md-3 cell FormPadding"><input type="number"
                                                class=" form-control cellFrom" name="companynum"
                                                value="${bean.companynum}" maxlength="20"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">傳真</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="fax"
                                                value="${bean.fax}" maxlength="20">
                                        </div>
                                        <div class="col-md-2 cell">來源</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <select class="form-select cellFrom" name="source">
                                                <option value="廣告" class="selItemOff" ${bean.source=="廣告"
                                                    ?"selected":null}>
                                                    廣告
                                                </option>
                                                <option value="員工推薦" class="selItemOff" ${bean.source=="員工推薦"
                                                    ?"selected":null}>
                                                    員工推薦</option>
                                                <option value="外部推薦" class="selItemOff" ${bean.source=="外部推薦"
                                                    ?"selected":null}>
                                                    外部推薦</option>
                                                <option value="合作夥伴" class="selItemOff" ${bean.source=="合作夥伴"
                                                    ?"selected":null}>
                                                    合作夥伴</option>
                                                <option value="參展" class="selItemOff" ${bean.source=="參展"
                                                    ?"selected":null}>
                                                    參展
                                                </option>
                                                <option value="網絡搜索" class="selItemOff" ${bean.source=="網絡搜索"
                                                    ?"selected":null}>
                                                    網絡搜索
                                                </option>
                                                <option value="口碑" class="selItemOff" ${bean.source=="口碑"
                                                    ?"selected":null}>
                                                    口碑
                                                </option>
                                                <option value="其他" class="selItemOff" ${bean.source=="其他"
                                                    ?"selected":null}>
                                                    其他
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">手機</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="moblie"
                                                value="${bean.moblie}" maxlength="20">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">Line</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="line"
                                                value="${bean.line}" maxlength="190">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 ">地址</div>
                                        <div class="col-md-8 ">
                                            <div class="row" id="twzipcode"></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell"></div>
                                        <div class="col-md-8 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="address"
                                                value="${bean.address}" maxlength="50">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">客人詢問</div>
                                        <div class="col-md-8 cell FormPadding">
                                            <textarea class="form-control " id="validationTextarea" name="remark"
                                                rows="5" maxlength="200">${bean.remark}</textarea>
                                        </div>
                                    </div>

                                </div>
                                <!--  -->
                                <div class="col-md-5  ASDFG">
                                    <div class="row">
                                        <div class="col-md-3 cell">潛在各戶負責人</div>
                                        <div class="col-md-7 cell FormPadding">
                                            <c:if test="${user.position != '職員' }">
                                                <select name="user" class="form-select cellFrom"
                                                    aria-label="Default select example">
                                                    <option value="無" ${bean.user=="無" ?"selected":null}>無</option>
                                                    <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                        items="${admin}" var="s">
                                                        <option value="${s.name}" ${bean.user==s.name ?"selected":null}>
                                                            ${s.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </c:if>
                                            <c:if test="${user.position == '職員' }">
                                                <input type="hidden" name="user" value="${bean.user}">
                                                ${bean.user}
                                            </c:if>

                                        </div>
                                    </div>

                                    <div class="row ">
                                        <div class="col-md-3 "></div>
                                        <div class="col-lg-7">
                                            <a href="javascript:$('.help').toggle()">+添加協助者</a>
                                            <div class="input-group help">
                                                
                                                <select class="form-select" name="helper">
                                                    <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                        items="${admin}" var="s">
                                                        <option value="${s.name}">${s.name}</option>
                                                    </c:forEach>
                                                </select>
                                                <button class="btn btn-outline-secondary" type="button"
                                                    onclick="addHelper()">添加</button>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row ">
                                        <div class="col-md-3 cell"></div>
                                        <div class="col-md-7 cell">
                                            <ul class="helpList " style="position: relative;">
                                                <c:forEach varStatus="loop" begin="0" end="${bean.helper.size()}"
                                                    items="${bean.helper}" var="s">
                                                    <li>${s.name}<a style="right: 0px; position: absolute;"
                                                            href="javascript:delHelp('${s.helperid}')">remove</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>


                                    <style>
                                        li {
                                            /* border: black 1px solid; */
                                        }
                                    </style>









                                    <div class="row">

                                        <div class="col-md-3 cell" style="font-size: 14px;">創造時間</div>
                                        <div class="col-md-7 cell FormPadding">
                                            ${bean.createtime}
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3 cell">狀態</div>
                                        <div class="col-md-7 cell FormPadding">
                                            <select name="status" class="form-select cellFrom"
                                                aria-label="Default select example">
                                                <option value="未處理" ${bean.status=="未處理" ?"selected":null}>未處理
                                                </option>
                                                <option value="已聯繫" ${bean.status=="已聯繫" ?"selected":null}>已聯繫
                                                </option>
                                                <option value="不合格" ${bean.status=="不合格" ?"selected":null}>不合格
                                                </option>
                                                <option value="合格" ${bean.status=="合格" ?"selected":null}>合格</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3 cell" >重要性</div>
                                        <div class="col-md-7 cell FormPadding">
                                                <select class="form-select cellFrom" name="important" v-model="important">                                                    
                                                    <option value="高">高</option>
                                                    <option value="中">中</option>
                                                    <option value="低">低</option>
                                                </select>                                            
                                        </div>
                                    </div>
                                </div>
                                <p>&nbsp;</p>
                                <div class="row">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5 FormPadding">
                                        <button type="submit" style="width: 100%; " class="btn btn-warning"
                                            onclick="return window.confirm('確定修改')">儲存</button>
                                    </div>
                                </div>
                            </div>
                        </form>

                        <!-- ////////////////////////////////////////追蹤資訊///////////////////////////////////// -->
                        <hr>
                        <br><br><br>
                        <c:if test="${not empty bean}">
                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-9 bg-warning text-white"
                                    style="text-align: center;background-color: rgb(36, 101, 164);color: white;">
                                    <h5>追蹤資訊</h5>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-1"></div>

                                <div class="col-md-4">客人描述</div>
                                <div class="col-md-3">追蹤結果</div>
                                
                            </div>
                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-9">
                                    <hr>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/Market/SaveTrack" method="post"
                                class="row g-3 needs-validation" novalidate>
                           
                            <!--  -->                                   
                                <input type="hidden" class=" form-control cellFrom" name="remark" maxlength="190" value="${user.name}">                                  
                            <!--  -->
                                <input type="hidden" name="customerid" value="${bean.customerid}">
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4 FormPadding"> 
                                        <textarea class="form-control" name="trackdescribe" rows="1" maxlength="190"
                                            required></textarea>
                                    </div>
                                    <div class="col-md-4 FormPadding">
                                        <textarea class="form-control" name="result" rows="1" maxlength="95"></textarea>
                                    </div>
                                    <div class="col-md-1" style="padding: 0%;">
                                        <button style="width: 100%; " class="btn btn-outline-dark"
                                            onclick="">新增</button>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-9">
                                        <hr>
                                    </div>
                                </div>
                            </form>

                            <c:if test="${not empty bean.trackbean}">
                                <c:forEach varStatus="loop" begin="0" end="${bean.trackbean.size()-1}"
                                    items="${bean.trackbean}" var="s" >
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-4" style="word-wrap:break-word;">${s.trackdescribe}
                                        </div>
                                        <div class="col-md-3" style="word-wrap:break-word;">${s.result}</div>
                                        <div class="col-md-1" style="word-wrap:break-word;"></div>
                                        <div class="col-md-2">${s.remark} <br> ${s.tracktime}</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-9">
                                            <hr>
                                        </div>

                                    </div>
                                    <br>
                                </c:forEach>
                            </c:if>
                        </c:if>
                        <br>
                        <br><br><br><br><br>
                        <div class="row">&nbsp;</div>
                    </div>

                    <!-- 動作區塊 -->
                    <c:if test="${not empty bean}">
                        <div class="row box" id="draggable">
                            <div class="row act" style="height: 30px;">
                                <a class="col-md-4" href="#" onclick="goClient()">轉成客戶</a>
                                <a class="col-md-4" href="#" onclick="goContact()">建立聯絡⼈</a>
                                <a class="col-md-4" href="#" onclick="goWork()">新增工作項目</a>
                            </div>
                            <div class="dockbar row shadow  ">

                                <div class="col-md-2 offset-md-1" style="border-left: black 1px solid;"
                                    onclick="javascript:$('.act').toggle();">
                                    行動
                                </div>
                                <div class="col-md-2">紀錄</div>
                                <div class="col-md-2">留言</div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </body>
        <script>
            
            $('.act').hide();
            $(function () {
                $("#draggable").draggable();
            });
            $(".market").show();
            $('.help').toggle();
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
                $(".tracktime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight - 210 + 'px' });
                    }
                });

            });
            //表單驗證
            $(function () {
                // 密碼驗證
                jQuery.validator.setDefaults({
                    submitHandler: function () {
                        form.submit();
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
                $(".basefrom").validate();
            });
            function delRemark(id) {
                if (confirm("確定刪除?")) {
                    window.location.href = "${pageContext.request.contextPath}/Market/delRemark/" + id + "/${bean.customerid}";
                }
            }
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

            //建立客戶
            function goClient() {
                var formData = new FormData($(".AAA")[0]);
                console.log(formData.values());
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/existsClient',//接受請求的Servlet地址
                    type: 'POST',
                    data: formData,
                    async: false,//同步請求
                    cache: false,//不快取頁面
                    contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        if (json == "客戶已存在") {
                            alert(json);
                            return;
                        }
                        if (json == "不存在") {
                            $(".AAA").attr("action", "${pageContext.request.contextPath}/Market/changeClient.action");
                            $(".AAA")[0].submit();
                            return;
                        }
                        alert("錯誤");
                    },
                    error: function (returndata) {
                        console.log(returndata);

                    }

                });
            }
            //建立聯絡人
            function goContact() {
                var formData = new FormData($(".AAA")[0]);
                console.log(formData.values());
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/existsContact',//接受請求的Servlet地址
                    type: 'POST',
                    data: formData,
                    async: false,//同步請求
                    cache: false,//不快取頁面
                    contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        if (json == "聯絡人已存在") {
                            alert(json);
                            return;
                        }
                        if (json == "公司不存在,請先轉客戶") {
                            alert(json);
                            return;
                        }
                        if (json == "不存在") {
                            $(".AAA").attr("action", "${pageContext.request.contextPath}/Market/changeContact.action");
                            $(".AAA")[0].submit();
                            return;
                        }
                        alert("錯誤");
                    },
                    error: function (returndata) {
                        console.log(returndata);

                    }

                });
            }
            //新增工作項目
            function goWork() {
                $(".AAA").attr("action", "${pageContext.request.contextPath}/Market/changeWork");
                $(".AAA")[0].submit();
            }
            // 添加協助者
            function addHelper() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/Potential/addHelper/${bean.customerid}/' + $("[name='helper']").val(),//接受請求的Servlet地址
                    type: 'POST',
                    success: function (json) {
                        $(".helpList").empty();
                        for (var h of json) {
                            console.log(h)
                            $(".helpList").append('<li ">' + h.name + '<a style="right: 0px; position: absolute;" href="delHelp(' + h.helperid + ')" >remove</a></li>')
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
            // 刪除協助者
            function delHelp(helperid) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/Potential/delHelper/${bean.customerid}/' + helperid,//接受請求的Servlet地址
                    type: 'POST',
                    success: function (json) {
                        $(".helpList").empty();
                        for (var h of json) {
                            $(".helpList").append('<li ">' + h.name + '<a style="right: 0px; position: absolute;" href="javascript:delHelp(`' + h.helperid + '`)" >remove</a></li>')
                        }
                    },
                });
            }
            const vm = new Vue({
                el:'.app',
                data() {
                    return {
                        admin:'${user.name}',
                        important:'${bean.important}',
                        industry: "${bean.industry}",//產業
                        industryList: ["尚未分類",
                            "農、林、漁、牧業",
                            "礦業及土石採取業",
                            "製造業",
                            "電子及半導體生產", "機械設備製造業",
                            "電力及燃氣供應業",
                            "用水供應及污染整治業",
                            "營建工程業",                            
                            "批發及零售業",
                            "運輸及倉儲業",
                            "住宿及餐飲業",
                            "出版影音及資通訊業",
                            "金融及保險業",
                            "不動產業",
                            "專業、科學及技術服務業",
                            "支援服務業",
                            "公共行政及國防；強制性社會安全",
                            "教育業",
                            "醫療保健及社會工作服務業",
                            "藝術、娛樂及休閒服務業",
                            "其他服務業"],//產業列表
                    }
                },
               created() {
                    if( this.important == "")this.important='低';
                },
            })



        </script>

        </html>