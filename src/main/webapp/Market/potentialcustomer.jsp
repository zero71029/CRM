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
                background-color: #569b92;
                color: white;
                ;
                display: block;

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
                    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <div class="col-md-11">
                        <!-- <%-- 中間主體--%> -->
                        <br>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <h3>潛在各戶</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-1 btn men">
                                <a href="javascript:history.back()">＜</a>
                            </div>
                            <c:if test="${not empty bean}">
                                <div class="col-md-1 btn men">
                                    <a href="javascript:goClient()">轉成客戶</a>
                                </div>
                                <div class="col-md-1 btn men">
                                    <a href="javascript:goContact()">建立聯絡⼈</a>
                                </div>
                                <div class="col-md-1 btn men">
                                    <a href="javascript:goWork()">新增工作項目</a>
                                </div>
                            </c:if>

                        </div>
                        <br>
                        <form action="${pageContext.request.contextPath}/Market/SavePotentialCustomer" method="post"
                            class="basefrom g-3 needs-validation AAA" novalidate>
                            <input type="hidden" name="customerid" value="${bean.customerid}">
                            <input type="hidden" name="fromactivity" value="${bean.fromactivity}" maxlength="50">
                            <div class="row">
                                <!-- 基本資料 -->
                                <div class="col-md-8">
                                    <div class="row" style="text-align: center;">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10"
                                            style="background-color: rgb(36, 101, 164);font-size: 1.5rem;color: white;border-radius: 5px 5px 0 0 ;">
                                            基本資料</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">聯絡人*</div>
                                        <div class="col-md-3 cell FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="name"
                                                value="${bean.name}" maxlength="20" required>
                                        </div>
                                        <div class="col-md-2 cell">編號</div>
                                        <div class="col-md-3 cell">${bean.customerid}</div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">公司*</div>
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
                                            <select name="industry" class=" form-select cellFrom">
                                                <option ${bean.industry=="尚未分類" ?"selected":null} value="尚未分類">
                                                    請選擇...
                                                </option>
                                                <option ${bean.industry=="生產 製造" ?"selected":null} value="生產 製造">生產
                                                    製造
                                                </option>
                                                <option ${bean.industry=="工程公司" ?"selected":null} value="工程公司">工程公司
                                                </option>
                                                <option ${bean.industry=="學校" ?"selected":null} value="學校">學校
                                                </option>
                                                <option ${bean.industry=="研究單位" ?"selected":null} value="研究單位">研究單位
                                                </option>
                                                <option ${bean.industry=="電子業" ?"selected":null} value="電子業">電子業
                                                </option>
                                                <option ${bean.industry=="光電產業" ?"selected":null} value="光電產業">光電產業
                                                </option>
                                                <option ${bean.industry=="半導體業" ?"selected":null} value="半導體業">半導體業
                                                </option>
                                                <option ${bean.industry=="公家機關" ?"selected":null} value="公家機關">公家機關
                                                </option>
                                                <option ${bean.industry=="機械設備製造" ?"selected":null} value="機械設備製造">
                                                    機械設備製造
                                                </option>
                                                <option ${bean.industry=="生技製藥" ?"selected":null} value="生技製藥">生技製藥
                                                </option>
                                                <option ${bean.industry=="食品加工" ?"selected":null} value="食品加工">食品加工
                                                </option>
                                                <option ${bean.industry=="醫院/醫療" ?"selected":null} value="醫院/醫療">
                                                    醫院/醫療
                                                </option>
                                                <option ${bean.industry=="物流/倉儲" ?"selected":null} value="物流/倉儲">
                                                    物流/倉儲
                                                </option>
                                                <option ${bean.industry=="畜牧/農業" ?"selected":null} value="畜牧/農業">
                                                    畜牧/農業
                                                </option>
                                                <option ${bean.industry=="公共/消費性環境" ?"selected":null} value="公共/消費性環境">
                                                    公共/消費性環境 </option>
                                                <option ${bean.industry=="製紙業" ?"selected":null} value="製紙業">製紙業
                                                </option>
                                                <option ${bean.industry=="紡織業" ?"selected":null} value="紡織業">紡織業
                                                </option>
                                                <option ${bean.industry=="化工業" ?"selected":null} value="化工業">化工業
                                                </option>
                                                <option ${bean.industry=="金屬加工" ?"selected":null} value="金屬加工">金屬加工
                                                </option>
                                                <option ${bean.industry=="冷凍空調" ?"selected":null} value="冷凍空調">冷凍空調
                                                </option>
                                                <option ${bean.industry=="航太/造船" ?"selected":null} value="航太/造船">
                                                    航太/造船
                                                </option>
                                                <option ${bean.industry=="環保相關" ?"selected":null} value="環保相關">環保相關
                                                </option>
                                                <option ${bean.industry=="水處理/水資源" ?"selected":null} value="水處理/水資源">
                                                    水處理/水資源
                                                </option>
                                                <option ${bean.industry=="石化能源" ?"selected":null} value="石化能源">石化能源
                                                </option>
                                                <option ${bean.industry=="印刷" ?"selected":null} value="印刷">印刷
                                                </option>
                                                <option ${bean.industry=="其它" ?"selected":null} value="其它">其它(請填寫)
                                                </option>
                                                <option ${bean.industry=="業主" ?"selected":null} value="業主">業主
                                                </option>
                                                <option ${bean.industry=="設備換修" ?"selected":null} value="設備換修">設備換修
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
                                                <option value="自己打來" class="selItemOff" ${bean.source=="自己打來"
                                                    ?"selected":null}>
                                                    自己打來</option>
                                                <option value="員工推薦" class="selItemOff" ${bean.source=="員工推薦"
                                                    ?"selected":null}>
                                                    員工推薦</option>
                                                <option value="外部推薦" class="selItemOff" ${bean.source=="外部推薦"
                                                    ?"selected":null}>
                                                    外部推薦</option>
                                                <option value="合作夥伴" class="selItemOff" ${bean.source=="合作夥伴"
                                                    ?"selected":null}>
                                                    合作夥伴</option>
                                                <option value="公共關係" class="selItemOff" ${bean.source=="公共關係"
                                                    ?"selected":null}>
                                                    公共關係</option>
                                                <option value="研討會 - 內部" class="selItemOff" ${bean.source=="研討會 - 內部"
                                                    ?"selected":null}>研討會 - 內部 </option>
                                                <option value="研討會 - 合作夥伴" class="selItemOff"
                                                    ${bean.source=="研討會 - 合作夥伴" ?"selected":null}>研討會 - 合作夥伴
                                                </option>
                                                <option value="廣告" class="selItemOff" ${bean.source=="廣告"
                                                    ?"selected":null}>
                                                    廣告
                                                </option>
                                                <option value="參展" class="selItemOff" ${bean.source=="參展"
                                                    ?"selected":null}>
                                                    參展
                                                </option>
                                                <option value="網絡" class="selItemOff" ${bean.source=="網絡"
                                                    ?"selected":null}>
                                                    網絡
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
                                        <div class="col-md-2 cell">備註</div>
                                        <div class="col-md-8 cell FormPadding">
                                            <textarea class="form-control " id="validationTextarea" name="remark"
                                                rows="5" maxlength="200">${bean.remark}</textarea>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 FormPadding">
                                            <button type="submit" style="width: 100%;" class="btn btn-primary"
                                                onclick="return window.confirm('確定修改')">儲存</button>
                                        </div>
                                    </div>
                                </div>
                                <!--  -->
                                <div class="col-md-4  ASDFG">
                                    <div class="row">
                                        <div class="col-md-2 cell">負責人*</div>
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
                                            <a href="javascript:$('.help').toggle()">+添加協助者</a>
                                        </div>
                                    </div>

                                    <div class="row help">
                                        <div class="col-md-2 "></div>
                                        <div class="col-lg-7">
                                            <div class="input-group">
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
                                        <div class="col-md-2 "></div>
                                        <ul class="helpList col-md-7" style="position: relative;">
                                            <c:forEach varStatus="loop" begin="0" end="${bean.helper.size()}"
                                                items="${bean.helper}" var="s">
                                                <li >${s.name}<a style="right: 0px; position: absolute;"
                                                        href="javascript:delHelp('${s.helperid}')">remove</a></li>
                                            </c:forEach>
                                        </ul>
                                    </div>


                                    <style>
                                        li{
                                            /* border: black 1px solid; */
                                        }
                                    </style>









                                    <div class="row">

                                        <div class="col-md-2 cell" style="font-size: 14px;">創造時間</div>
                                        <div class="col-md-7 cell FormPadding">
                                            ${bean.createtime}
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-md-2 cell">狀態</div>
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
                                </div>
                            </div>
                        </form>

                        <!-- ////////////////////////////////////////追蹤資訊///////////////////////////////////// -->
                        <hr>
                        <br><br><br>
                        <c:if test="${not empty bean}">
                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-9"
                                    style="text-align: center;background-color: rgb(36, 101, 164);color: white;">
                                    <h5>追蹤資訊</h5>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-1"></div>

                                <div class="col-md-3">客人描述</div>
                                <div class="col-md-3">追蹤結果</div>
                                <div class="col-md-2">備註</div>
                            </div>
                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-9">
                                    <hr>
                                </div>
                            </div>
                            <form action="${pageContext.request.contextPath}/Market/SaveTrack" method="post"
                                class="row g-3 needs-validation" novalidate>
                                <input type="hidden" name="customerid" value="${bean.customerid}">
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-3 FormPadding">
                                        <textarea class="form-control" name="trackdescribe" rows="1" maxlength="190"
                                            required></textarea>
                                    </div>
                                    <div class="col-md-3 FormPadding">
                                        <textarea class="form-control" name="result" rows="1" maxlength="95"></textarea>
                                    </div>
                                    <div class="col-md-2 FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="remark" maxlength="190">
                                    </div>
                                    <div class="col-md-1">
                                        <button style="width: 100%;" class="btn btn-primary" onclick="">新增</button>
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
                                    items="${bean.trackbean}" var="s">
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="word-wrap:break-word;">${s.trackdescribe}
                                        </div>
                                        <div class="col-md-3">${s.result}</div>
                                        <div class="col-md-2">${s.remark}</div>
                                        <div class="col-md-2">${s.tracktime}</div>
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

                </div>
            </div>
        </body>
        <script>
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
            function basefrom() {
                if (confirm("確定修改?")) $(".basefrom").submit();
            }
            //表單驗證
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (function () {
                'use strict'

                // Fetch all the forms we want to apply custom Bootstrap validation styles to
                var forms = document.querySelectorAll('.needs-validation')

                // Loop over them and prevent submission
                Array.prototype.slice.call(forms)
                    .forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault()
                                event.stopPropagation()
                            }

                            form.classList.add('was-validated')
                        }, false)
                    })
            })()
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
                            $(".AAA").submit();
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
                        if (json == "不存在") {
                            $(".AAA").attr("action", "${pageContext.request.contextPath}/Market/changeContact.action");
                            $(".AAA").submit();
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
                $(".AAA").submit();
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
        </script>

        </html>