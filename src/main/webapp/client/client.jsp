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
            <script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
            <!-- 引入element-ui组件库 -->
            <script src="https://unpkg.com/element-ui/lib/index.js"></script>


        </head>
        <style>
            /*標籤 */
            .el-tag {
                margin: 4px;
            }

            .el-tag:hover {
                cursor: pointer;
            }
/*標籤 /////////////////*/


            .clientbar {
                /* 按鈕顏色 */
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
                background-color: #569b92;
                display: block;
            }

            .log {
                text-align: center;
                background-color: #0d6efd;
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

            .men a {
                text-decoration: none;
                text-align: center;
                min-height: 24px;
                background-color: #569b92;
                display: block;
                font-size: 15px;
                display: block;
                height: 100%;
                color: white;
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
                    <title>CRM客戶管理系統</title>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11 app">
                        <div class="row">
                            <div class="col-md-6">
                                <!-- <%-- 中間主體--%> -->
                                <br>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-10">
                                        <h3>各戶</h3>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-2 btn men">
                                        <a href="javascript:history.back()">＜</a>
                                    </div>
                                    <c:if test='${not empty bean}'>
                                        <div class="col-md-2 btn men">
                                            <a href="javascript:changeMarket()">新增銷售機會</a>
                                        </div>
                                        <div class="col-md-2 btn men">
                                            <a href="javascript:changeContact()">新增聯絡人</a>
                                        </div>
                                        <div class="col-md-2 btn men">
                                            <a href="javascript:changeWork()">新增工作項目</a>
                                        </div>
                                    </c:if>
                                </div>
                                <br>


                                <form action="${pageContext.request.contextPath}/CRM/SaveClient" method="post"
                                    id="myform" class="basefrom g-3 AAA">
                                    <div class="row">
                                        <input type="hidden" name="clientid" value="${bean.clientid}">


                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-10 log ">基本資訊</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">名稱*</div>
                                            <div class="col-md-9 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="name"
                                                    value="${bean.name}" maxlength="20" required>
                                            </div>
                                            <div class="col-md-1"></div>

                                        </div>


                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">電話</div>
                                            <div class="col-md-3 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="phone"
                                                    value="${bean.phone}" maxlength="20">
                                            </div>
                                            <div class="col-md-2 cell">聯絡人</div>
                                            <div class="col-md-4 cell FormPadding">
                                                <select name="" id="" class="form-select cellFrom  contactname">
                                                    <option value style="background-color: #eee;">選擇..
                                                    </option>
                                                    <c:if test="${not empty bean.contact}">
                                                        <c:forEach varStatus="loop" begin="0"
                                                            end="${bean.contact.size()-1}" items="${bean.contact}"
                                                            var="con">
                                                            <option value="${con.name}" selected>${con.name}</option>
                                                        </c:forEach>
                                                    </c:if>
                                                    <option value="new" style="background-color: #eee;">新增聯絡人
                                                    </option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">Email</div>
                                            <div class="col-md-3 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="email"
                                                    value="${bean.email}" maxlength="100">
                                            </div>
                                            <div class="col-md-2 cell">聯絡人手機</div>
                                            <div class="col-md-4 cell moblie FormPadding">${bean.contact[0].moblie}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">傳真</div>
                                            <div class="col-md-3 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="fax"
                                                    value="${bean.fax}" maxlength="20">
                                            </div>
                                            <div class="col-md-2 cell">聯絡人職務</div>
                                            <div class="col-md-4 cell jobtitle FormPadding">
                                                ${bean.contact[0].jobtitle}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">統一編號</div>
                                            <div class="col-md-3 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="uniformnumber"
                                                    value="${bean.uniformnumber}" maxlength="20">
                                            </div>
                                            <div class="col-md-2 cell">員工人數</div>
                                            <div class="col-md-4 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="peoplenumber"
                                                    value="${bean.peoplenumber}" maxlength="20">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">類別</div>
                                            <div class="col-md-3 cell FormPadding">


                                                <select name="sort" class="form-select cellFrom"
                                                    aria-label="Default select example">
                                                    <option value="客戶" ${bean.sort=="客戶" ?"selected":null}
                                                        class="selItemOff">客戶
                                                    </option>
                                                    <option value="潛在客戶" ${bean.sort=="潛在客戶" ?"selected":null}
                                                        class="selItemOff">潛在客戶</option>
                                                    <option value="經銷商" ${bean.sort=="經銷商" ?"selected":null}
                                                        class="selItemOff">
                                                        經銷商</option>
                                                    <option value="分析師" ${bean.sort=="分析師" ?"selected":null}
                                                        class="selItemOff">
                                                        分析師</option>
                                                    <option value="競爭對手" ${bean.sort=="競爭對手" ?"selected":null}
                                                        class="selItemOff">競爭對手</option>
                                                    <option value="整合商" ${bean.sort=="整合商" ?"selected":null}
                                                        class="selItemOff">
                                                        整合商</option>
                                                    <option value="投資人" ${bean.sort=="投資人" ?"selected":null}
                                                        class="selItemOff">
                                                        投資人</option>
                                                    <option value="合作夥伴" ${bean.sort=="合作夥伴" ?"selected":null}
                                                        class="selItemOff">合作夥伴</option>
                                                    <option value="媒體" ${bean.sort=="媒體" ?"selected":null}
                                                        class="selItemOff">媒體
                                                    </option>
                                                    <option value="其他" ${bean.sort=="其他" ?"selected":null}
                                                        class="selItemOff">其他
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-md-2 cell">產業</div>
                                            <div class="col-md-4 cell FormPadding ">
                                                <select name="industry" class=" form-select cellFrom">
                                                    <option ${bean.industry=="尚未分類" ?"selected":null} value="尚未分類">
                                                        請選擇...
                                                    </option>
                                                    <option ${bean.industry=="生產 製造" ?"selected":null} value="生產 製造">生產
                                                        製造
                                                    </option>
                                                    <option ${bean.industry=="工程公司" ?"selected":null} value="工程公司">工程公司
                                                    </option>
                                                    <option ${bean.industry=="學校 user" ?"selected":null}
                                                        value="學校 user">學校 user
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
                                                    <option ${bean.industry=="公共/消費性環境" ?"selected":null}
                                                        value="公共/消費性環境">
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
                                                    <option ${bean.industry=="水處理/水資源" ?"selected":null}
                                                        value="水處理/水資源">水處理/水資源
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
                                            <div class="col-md-1 cell">網站</div>
                                            <div class="col-md-9 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="url"
                                                    value="${bean.url}" maxlength="100">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">備註</div>
                                            <div class="col-md-9 cell FormPadding">
                                                <textarea name="remark" class="col-md-9" id="message" maxlength="450"
                                                    style="width: 100%; ">${bean.remark}</textarea>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1">&nbsp;</div>
                                            <div class="col-md-8"></div>
                                        </div>
                                        <br><br>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-10 log">主要地址</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">帳單城市</div>
                                            <div class="col-md-4 cell">
                                                <div class="row" id="twzipcode"></div>
                                            </div>
                                            <div class="col-md-1 cell">送貨城市</div>
                                            <div class="col-md-4 cell ">
                                                <div class="row" id="twzipcode2"></div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">帳單地址</div>
                                            <div class="col-md-4 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="billaddress"
                                                    value="${bean.billaddress}" maxlength="20">
                                            </div>
                                            <div class="col-md-1 cell">送貨地址</div>
                                            <div class="col-md-4 cell FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="deliveraddress"
                                                    value="${bean.deliveraddress}" maxlength="20">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>

                                            <div class="col-md-10 FormPadding">
                                                <button type="submit" style="width: 100%;"
                                                    class="btn btn-outline-dark">儲存</button>
                                            </div>


                                        </div>
                                    </div>
                                </form>
                                <div class="row">
                                    <div class="col-md-1">&nbsp;</div>
                                    <div class="col-md-8"></div>
                                </div>

                                <c:if test='${not empty bean}'>
                                    <!-- ///////////////////////////////其他地址/////////////////////////////////// ..-->
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 log">
                                            <h5>其他地址</h5>
                                        </div>
                                    </div>

                                    <c:if test="${not empty bean.address}">
                                        <c:forEach varStatus="loop" begin="0" end="${bean.address.size()-1}"
                                            items="${bean.address}" var="s">
                                            <div class="row ">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-10 row contact"
                                                    style="margin: 0%; position: relative;"
                                                    onclick="ClientAddress('${s.city}','${s.town}','${s.address}','${s.addressid}')">
                                                    <div class="col-md-11">${s.city} ${s.town}[${s.postal}] ${s.address}
                                                    </div>
                                                    <div class="col-md-1"> <a class="delClientAddress"
                                                            href="${pageContext.request.contextPath}/CRM/delClientAddress/${s.addressid}/${bean.clientid}">remove</a>
                                                    </div>
                                                </div>

                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 row contact" onclick="newAddress()" style="margin: 0%;">
                                            <div class="col-md-2">新增</div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                        </div>
                                    </div>


                                    <!-- ///////////////////////////////聯絡人/////////////////////////////////// ..-->
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 log">
                                            <h5>聯絡人</h5>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 row">
                                            <div class="col-md-2">名稱</div>
                                            <div class="col-md-2">職務</div>
                                            <div class="col-md-2">電話</div>
                                            <div class="col-md-2">手機</div>
                                            <div class="col-md-2">Email</div>
                                            <div class="col-md-2">備註</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10">
                                            <hr>
                                        </div>
                                    </div>
                                    <c:if test="${not empty bean.contact}">
                                        <c:forEach varStatus="loop" begin="0" end="${bean.contact.size()-1}"
                                            items="${bean.contact}" var="s">
                                            <div class="row ">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-10 row contact" style="margin: 0%;"
                                                    onclick="javascript:location.href='${pageContext.request.contextPath}/CRM/contact/${s.contactid}'">
                                                    <div class="col-md-2">${s.name}</div>
                                                    <div class="col-md-2">${s.jobtitle}</div>
                                                    <div class="col-md-2">${s.phone}</div>
                                                    <div class="col-md-2">${s.moblie}</div>
                                                    <div class="col-md-2">Email</div>
                                                    <div class="col-md-2">${s.remark}</div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 row contact" onclick="changeContact()"
                                            style="margin: 0%;">
                                            <div class="col-md-2">新增</div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                        </div>
                                    </div>

                                    <!-- ///////////////////////////////銷售機會/////////////////////////////////// -->
                                    <hr>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 log">
                                            <h5>銷售機會</h5>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 row">
                                            <div class="col-md-2">編號</div>
                                            <div class="col-md-2">名稱</div>
                                            <div class="col-md-2">聯絡人</div>
                                            <div class="col-md-2">負責人</div>
                                            <div class="col-md-2">金額</div>
                                            <div class="col-md-2">階段</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <c:if test="${not empty market}">
                                            <c:forEach varStatus="loop" begin="0" end="${market.size()-1}"
                                                items="${market}" var="s">
                                                <div class="row ">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-10 row contact" style="margin: 0%;"
                                                        onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market/${s.marketid}'">
                                                        <div class="col-md-2">${s.marketid}</div>
                                                        <div class="col-md-2">${s.name}</div>
                                                        <div class="col-md-2">${s.contactname}</div>
                                                        <div class="col-md-2">${s.user}</div>
                                                        <div class="col-md-2">${s.cost}</div>
                                                        <div class="col-md-2">${s.stage}</div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 row contact" onclick="changeMarket()" style="margin: 0%;">
                                            <div class="col-md-2">新增</div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                        </div>
                                    </div>

                                    <!-- ///////////////////////////////工作項目/////////////////////////////////// -->
                                    <hr>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 log">
                                            <h5>工作項目</h5>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 row">
                                            <div class="col-md-4">主題</div>
                                            <div class="col-md-2">到期日</div>
                                            <div class="col-md-2">負責人</div>
                                            <div class="col-md-2">狀態</div>
                                            <div class="col-md-2">重要性</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <c:if test="${not empty bean.work}">
                                            <c:forEach varStatus="loop" begin="0" end="${bean.work.size()-1}"
                                                items="${bean.work}" var="s">
                                                <div class="row ">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-10 row contact"
                                                        onclick="javascript:location.href='${pageContext.request.contextPath}/work/detail/${s.workid}'">
                                                        <div class="col-md-4">${s.name}</div>
                                                        <div class="col-md-2">${s.endtime}</div>
                                                        <div class="col-md-2">${s.user}</div>
                                                        <div class="col-md-2">${s.state}</div>
                                                        <div class="col-md-2">${s.important}</div>

                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 row contact" onclick="changeWork()">
                                            <div class="col-md-2">新增</div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                            <div class="col-md-2"></div>
                                        </div>
                                    </div>


                                    <div class="row">&nbsp;</div>
                                    <div class="row">&nbsp;</div>



                                    <!-- ////////////////////////////////////////////////////////////////// -->
                                </c:if>
                            </div>
                            <div class="col-md-4">
                                <div class="row">&nbsp;</div>
                                <div class="row">&nbsp;</div>
                                <div class="row">&nbsp;</div>
                                <div class="row">&nbsp;</div>
                                <div class="row">&nbsp;</div>
                                <div class="row">&nbsp;</div>
                                <div class="row">&nbsp;</div>
                                <div class="row">
                                    <div class="col-md-3 cell">負責人*</div>
                                    <div class="col-md-8 cell FormPadding">
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
                                    <div class="col-md-3 cell">客戶編號</div>
                                    <div class="col-md-8 cell FormPadding">${bean.clientid}
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-3 cell">新增標籤</div>
                                    <div class="col-md-8 cell FormPadding">
                                        <div class="input-group  ">
                                            <input type="text" class="form-control tag"
                                                aria-label="Recipient's username" aria-describedby="button-addon2"
                                                list="tag" required maxlength="100" v-model="newTag">
                                            <datalist id="tag">
                                                <option value="大型顯示器">
                                                    大型顯示器
                                                </option>
                                                <option value="空氣品質">
                                                    空氣品質
                                                </option>
                                                <option value="流量-AICHI">
                                                    流量-AICHI</option>
                                                <option value="流量-RGL">流量-RGL
                                                </option>
                                                <option value="流量-Siargo">
                                                    流量-Siargo</option>
                                                <optionvalue="流量-其他">
                                                    流量-其他
                                                    </option>
                                                    <option value="記錄器">記錄器
                                                    </option>
                                                    <option value="資料收集器-JETEC">
                                                        資料收集器-JETEC</option>
                                                    <option alue="資料收集器-其他">
                                                        資料收集器-其他</option>
                                                    <option value="溫濕-JETEC">
                                                        溫濕-JETEC</option>
                                                    <option value="溫濕-GALLTEC">
                                                        溫濕-GALLTEC</option>
                                                    <option value="溫濕-E+E">溫濕-E+E
                                                    </option>
                                                    <option value="溫濕-其他">
                                                        溫濕-其他
                                                    </option>
                                                    <option value="紅外線">紅外線
                                                    </option>
                                                    <option value="壓力-JETEC">
                                                        壓力-JETEC</option>
                                                    <option value="壓力-HUBA">
                                                        壓力-HUBA
                                                    </option>
                                                    <option value="壓力-COPAL">
                                                        壓力-COPAL</option>
                                                    <option value="壓力-其他">
                                                        壓力-其他
                                                    </option>
                                                    <option value="差壓">差壓
                                                    </option>
                                                    <option value="氣體-JETEC">
                                                        氣體-JETEC</option>
                                                    <option value="氣體-Senko">
                                                        氣體-Senko</option>
                                                    <option value="氣體-GASDNA">
                                                        氣體-GASDNA</option>
                                                    <option value="氣體-手持">
                                                        氣體-手持
                                                    </option>
                                                    <option value="氣體-其他">
                                                        氣體-其他
                                                    </option>
                                                    <option value="氣象儀器-土壤/pH">
                                                        氣象儀器-土壤/pH</option>
                                                    <option value="氣象儀器-日照/紫外線">
                                                        氣象儀器-日照/紫外線</option>
                                                    <option value="氣象儀器-風速/風向">
                                                        氣象儀器-風速/風向</option>
                                                    <option value="氣象儀器-雨量">
                                                        氣象儀器-雨量
                                                    </option>
                                                    <option value="氣象儀器-其他">
                                                        氣象儀器-其他
                                                    </option>
                                                    <option value="水質相關">
                                                        水質相關
                                                    </option>
                                                    <option value="液位/料位-JETEC">
                                                        液位/料位-JETEC</option>
                                                    <option value="液位/料位-DINEL">
                                                        液位/料位-DINEL</option>
                                                    <option value="液位/料位-HONDA">
                                                        液位/料位-HONDA</option>
                                                    <option value="液位/料位-其他">
                                                        液位/料位-其他</option>
                                                    <option value="溫度貼紙">
                                                        溫度貼紙
                                                    </option>
                                                    <option value="溫控器-TOHO">
                                                        溫控器-TOHO</option>
                                                    <option value="溫控器-其他">溫控器-其他
                                                    </option>
                                                    <option value="感溫線棒">
                                                        感溫線棒
                                                    </option>
                                                    <option value="無線傳輸">
                                                        無線傳輸
                                                    </option>
                                                    <option value="編碼器/電位計">
                                                        編碼器/電位計
                                                    </option>
                                                    <option value="能源管理控制">能源管理控制
                                                    </option>
                                                    <option value="食品">食品
                                                    </option>
                                                    <option value="其它">其它
                                                    </option>

                                            </datalist>

                                            <button class="btn btn-primary" type="button" id="button-addon2"
                                                @click="addtag">新增</button>
                                        </div>
                                    </div>
                                </div>
                                <style>

                                </style>
                                <el-tag v-for="tag in tags" :key="tag.name" closable :type="tag.type" @close="removeTag(tag.clienttagid)"
                                    @click="clickTag(tag.name)">
                                    {{tag.name}}
                                </el-tag>
                               


                            </div>
                        </div>
                    </div>
                    <!-- 其他地址彈窗 -->
                    <div class="AddressDiv " title="其他地址">
                        <form action="${pageContext.request.contextPath}/CRM/newAddress" method="post"
                            class="addressForm">
                            <input type="hidden" name="clientid" value="${bean.clientid}">

                            <div class="row" id="twzipcode3" style="margin: 0%;"></div>

                            <input type="text" class=" form-control cellFrom" name="address" maxlength="20">
                            <input type="submit" value="新增" style="width: 100%;">

                        </form>
                    </div>
                    <!-- 其他地址彈窗/// -->
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
                $(".tracktime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight - 210 + 'px' });
                    }
                });
                // // 密碼驗證
                // jQuery.validator.setDefaults({
                //     submitHandler: function () {
                //         if (confirm("提交確認")) form.submit();
                //     }
                // });
                // $.extend($.validator.messages, {
                //     required: "這是必填字段",
                //     email: "請输入有效的電子郵件地址",
                //     url: "请输入有效的网址",
                //     date: "请输入有效的日期",
                //     dateISO: "请输入有效的日期 (YYYY-MM-DD)",
                //     number: "请输入有效的数字",
                //     digits: "只能输入数字",
                //     creditcard: "请输入有效的信用卡号码",
                //     equalTo: "你的输入不相同",
                //     extension: "请输入有效的后缀",
                //     maxlength: $.validator.format("最多可以输入 {0} 个字符"),
                //     minlength: $.validator.format("最少要输入 {0} 个字符"),
                //     rangelength: $.validator.format("请输入长度在 {0} 到 {1} 之间的字符串"),
                //     range: $.validator.format("请输入范围在 {0} 到 {1} 之间的数值"),
                //     max: $.validator.format("请输入不大于 {0} 的数值"),
                //     min: $.validator.format("请输入不小于 {0} 的数值")
                // });
                // $("#myform").validate();
            });
            // 地區ui
            $("#twzipcode").twzipcode({
                countySel: "${bean.billcity}",
                districtSel: "${bean.billtown}",
                "zipcodeIntoDistrict": true,
                // "css": ["city form-control", "town form-control"],
                "countyName": "billcity", // 指定城市 select name
                "districtName": "billtown", // 指定地區 select name
                "zipcodeName": "billpostal" // 指定號碼 select name
            });
            $("#twzipcode2").twzipcode({
                countySel: "${bean.delivercity}",
                districtSel: "${bean.delivertown}",
                "zipcodeIntoDistrict": true,
                // "css": ["city form-control", "town form-control"],
                "countyName": "delivercity", // 指定城市 select name
                "districtName": "delivertown", // 指定地區 select name
                "zipcodeName": "deliverpostal" // 指定號碼 select name
            });
            $("#twzipcode3").twzipcode({
                "zipcodeIntoDistrict": true,
                // "css": ["city form-control", "town form-control"],
                "countyName": "city", // 指定城市 select name
                "districtName": "town", // 指定地區 select name
                "zipcodeName": "postal" // 指定號碼 select name
            });
            //同帳單地址
            $("#SameAddress").change(function () {
                if ($("#SameAddress:checked").val() == "SSS") {
                    $("select[name='delivercity']").val($("select[name='billcity']").val());
                    $("select[name='delivercity']").change();
                    $("select[name='delivertown']").val($("select[name='billtown']").val());
                    $("input[name='deliveraddress']").val($("input[name='billaddress']").val());
                }
            })

            var moblie = new Object;
            var jobtitle = new Object;
        </script>
        <!-- 產生聯絡人列表 -->
        <c:if test="${not empty bean.contact}">
            <c:forEach varStatus="loop" begin="0" end="${bean.contact.size()-1}" items="${bean.contact}" var="s">
                <script>
                    moblie['${s.name}'] = '${s.moblie}';
                    jobtitle['${s.name}'] = '${s.jobtitle}';
                </script>
            </c:forEach>
        </c:if>

        <script>

            $(".contactname").change(function () {
                var s = $(".contactname").val();
                if (s == "new") {
                    changeContact()
                }
                $(".moblie").text(moblie[s]);
                $(".jobtitle").text(jobtitle[s]);

            });
            //轉成聯絡人
            function changeContact() {
                $(".AAA").attr("action", "${pageContext.request.contextPath}/CRM/changeContact");
                $(".AAA").submit();
            }
            //轉成銷售機會
            function changeMarket() {
                $(".AAA").attr("action", "${pageContext.request.contextPath}/CRM/changeMarket");
                $(".AAA").submit();
            }
            //轉成工作項目
            function changeWork() {
                $(".AAA").attr("action", "${pageContext.request.contextPath}/CRM/changeWork");
                $(".AAA").submit();
            }
            //新增其他地址
            function newAddress() {
                $("input[name='addressid']").remove();
                $('.AddressDiv').dialog("open");
            }
            $(".AddressDiv").dialog({
                autoOpen: false,
                position: {
                    at: "top+300"
                },
                width: 500,
                height: 300
            });
            //點擊地址
            function ClientAddress(city, town, address, id) {

                $("input[name='addressid']").remove();
                $("select[name='city']").val(city);
                $("select[name='city']").trigger("change");//觸發select的change事件           
                $("select[name='town']").val(town);
                $("input[name='address']").val(address);
                $(".addressForm").append('<input type="hidden" name="addressid" value="' + id + '">');
                $('.AddressDiv').dialog("open");
            }
            $(".delClientAddress").click(function (event) {
                event.stopPropagation();
            });


            if ("${message}" == "儲存成功") {
                alert("儲存成功");
                location.href = "${pageContext.request.contextPath}/CRM/client/${bean.clientid}";
            }


            const vm = new Vue({
                el: ".app",
                data() {
                    return {
                        newTag:"",
                        tags: [
 
                        ],
                    };
                },
                created() {
                    axios
                        .get('${pageContext.request.contextPath}/client/getTag/' + ${ bean.clientid })
                        .then(response => (
                            this.tags = response.data
                        ))
                        .catch(function (error) {  
                            console.log(error);
                        });
                },
                watch: {
                    tags: {
                        immediate: true,//初始化時讓handler被調用
                        handler(newValue, oldValue) {
                            var i = 0;
                            for (const iterator of newValue) {                               
                                switch (i % 5) {
                                    case 0:
                                        iterator.type = "primary";
                                        break;
                                    case 1:
                                        iterator.type = "success";
                                        break;
                                    case 2:
                                        iterator.type = "info";
                                        break;
                                    case 3:
                                        iterator.type = "warning";
                                        break;
                                    case 4:
                                        iterator.type = "danger";
                                        break;

                                }
                                i++;
                            }
                        }
                    }
                },
                methods: {
                    removeTag: function (clienttagid) { //刪除標籤
                        console.log(clienttagid);
                        if (confirm("確認刪除")) 
                        axios
                        .get('${pageContext.request.contextPath}/client/removeTag/${bean.clientid}/'+clienttagid)
                        .then(response => (
                            this.tags = response.data

                        ))
                        .catch(function (error) {  
                            console.log(error);
                        });
                    },
                    clickTag: function (tagName) { //點擊標籤
                        location.href="${pageContext.request.contextPath}/CRM/client/list?tag="+tagName;
                    },
                    addtag: function(){ //新增標籤
                        axios
                        .get('${pageContext.request.contextPath}/client/addTag/${bean.clientid}/' + this.newTag)
                        .then(response => (
                            this.tags = response.data

                        ))
                        .catch(function (error) {  
                            console.log(error);
                        });
                       
                    },
                },

            })









        </script>
        <style>
            select[name='city'] {
                height: 30px;
            }

            select[name='town'] {
                height: 30px;
            }
        </style>







        </html>