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

            <style>
                /* 可以设置不同的进入和离开动画 */
                /* 设置持续时间和动画函数 */
                .slide-fade-enter-active {
                    transition: all .3s ease;
                }

                .slide-fade-leave-active {
                    transition: all .3s cubic-bezier(1.0, 0.5, 0.8, 1.0);
                }

                .slide-fade-enter,
                .slide-fade-leave-to

                /* .slide-fade-leave-active 用于 2.1.8 以下版本 */
                    {
                    transform: translateY(-200%);
                    opacity: 0;
                }
            </style>
            <title>CRM客戶管理系統</title>
        </head>
        <style>
            .cell {
                background-color: #CCC;
            }

            .cellFrom {
                border: 0px solid black;
                width: 100%;
            }

            /* 彈窗 */

            .hazy {
                position: fixed;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 40;
                visibility: visible;
            }

            .cat {
                border: blue 1px solid;
                background-color: white;
                width: 830px;
                height: 450px;
                z-index: 50;
                position: absolute;
                left: 0%;
                right: 0%;
                margin: auto;
                top: 150px;
                border-radius: 15px;
                visibility: visible;
            }

            .cat form {
                top: 10px;
                position: relative;
                left: 20px;
            }

            .cat input {
                width: 95%;
            }

            .cat select {
                width: 95%;
            }

            /* 購物車返回 */

            .catReturn {
                top: -10px;
                right: -10px;
                position: absolute;
                background-color: red;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                z-index: 20;
            }

            div.FormPadding {
                padding: 0%;
            }

            .TTT:hover {
                background-color: #0d6efd;
            }

            [v-cloak] {
                display: none;
            }
        </style>

        <body>

            <div class="container-fluid ">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- 驗證UI -->
                    <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->


                    <div class="col-md-10 app" v-cloak>

                        <transition-group name="slide-fade" appear>
                            <div v-loading="loading" v-if="show" key="1">
                                <!-- <%-- 中間主體--%> -->
                                <br>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-10">
                                        <h3>銷售機會</h3>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-9">
                                        <!-- 上一頁 -->
                                        <!-- <a href="#"  onclick="location.href='${pageContext.request.contextPath}/billboard?pag=1&sort=createtime';" -->

                                        <a href="#" @click="back" style="text-decoration: none;">
                                            <img src="${pageContext.request.contextPath}/img/Pre.png" alt="上一頁">
                                        </a>
                                    </div>
                                </div>

                                <br>
                                <form action="${pageContext.request.contextPath}/Market/SaveMarket" method="post"
                                    class="basefrom g-3 needs-validation AAA">
                                    <input type="hidden" name="aaa" value="${bean.aaa}">
                                    <div class="row">
                                        <input type="hidden" name="marketid" value="${bean.marketid}">
                                        <div class="row" style="text-align: center;">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-6"
                                                style="background-color: rgb(102, 102, 102);font-size: 1.5rem;color: white;border-radius: 5px 5px 0 0 ;">
                                                基本資料</div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">機會名稱*</div>
                                            <div class="col-md-5 FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="name"
                                                    style="width: 100%;" value="${bean.name}" maxlength="20" required>
                                            </div>
                                        </div>



                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">公司名*</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class="col-md-4 form-control cellFrom client"
                                                    name="client" list="company" value="${bean.client}" maxlength="20"
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


                                            <div class="col-md-1 cell">聯絡人</div>
                                            <div class="col-md-2 FormPadding" @click="openDialog">
                                                <input type="text" class=" form-control cellFrom col-md-4"
                                                    name="contactname" value="${bean.contactname}" maxlength="20"
                                                    readonly>


                                                <!-- onclick="contact()"> -->
                                            </div>
                                            <div class="col-md-1 "> </div>
                                            <div class="col-md-1 cell">機會編號</div>
                                            <div class="col-md-2 ">${bean.marketid}</div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-1"></div>

                                            <div class="col-md-1 cell">公司電話</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class="col-md- form-control cellFrom" name="phone"
                                                    v-model="phone" maxlength="20">
                                            </div>
                                            <div class="col-md-1 cell">聯絡人電話</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class="col-md- form-control cellFrom"
                                                    v-model="contactphone" name="contactphone" maxlength="19">
                                            </div>

                                            <div class="col-md-1 "> </div>
                                            <div class="col-md-1 cell">負責人*</div>
                                            <div class="col-md-2 FormPadding">
                                                <select name="user" class="form-select cellFrom"
                                                    aria-label="Default select example">
                                                    <option value="無" ${bean.user=="無" ?"selected":null}>無</option>
                                                    <c:if test="${not empty admin}">
                                                        <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                            items="${admin}" var="s">
                                                            <option value="${s.name}" ${bean.user==s.name
                                                                ?"selected":null}>
                                                                ${s.name}</option>
                                                        </c:forEach>
                                                    </c:if>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">產業</div>
                                            <div class="col-md-2 FormPadding">
                                                <select name="type" class=" form-select cellFrom">
                                                    <option ${bean.type=="尚未分類" ?"selected":null} value="尚未分類">請選擇...
                                                    </option>
                                                    <option ${bean.type=="生產 製造" ?"selected":null} value="生產 製造">生產 製造
                                                    </option>
                                                    <option ${bean.type=="工程公司" ?"selected":null} value="工程公司">工程公司
                                                    </option>
                                                    <option ${bean.type=="學校 user" ?"selected":null} value="學校 user">學校
                                                        user
                                                    </option>
                                                    <option ${bean.type=="研究單位" ?"selected":null} value="研究單位">研究單位
                                                    </option>
                                                    <option ${bean.type=="電子業" ?"selected":null} value="電子業">電子業
                                                    </option>
                                                    <option ${bean.type=="光電產業" ?"selected":null} value="光電產業">光電產業
                                                    </option>
                                                    <option ${bean.type=="半導體業" ?"selected":null} value="半導體業">半導體業
                                                    </option>
                                                    <option ${bean.type=="公家機關" ?"selected":null} value="公家機關">公家機關
                                                    </option>
                                                    <option ${bean.type=="機械設備製造" ?"selected":null} value="機械設備製造">
                                                        機械設備製造
                                                    </option>
                                                    <option ${bean.type=="生技製藥" ?"selected":null} value="生技製藥">生技製藥
                                                    </option>
                                                    <option ${bean.type=="食品加工" ?"selected":null} value="食品加工">食品加工
                                                    </option>
                                                    <option ${bean.type=="醫院/醫療" ?"selected":null} value="醫院/醫療">醫院/醫療
                                                    </option>
                                                    <option ${bean.type=="物流/倉儲" ?"selected":null} value="物流/倉儲">物流/倉儲
                                                    </option>
                                                    <option ${bean.type=="畜牧/農業" ?"selected":null} value="畜牧/農業">畜牧/農業
                                                    </option>
                                                    <option ${bean.type=="公共/消費性環境" ?"selected":null} value="公共/消費性環境">
                                                        公共/消費性環境
                                                    </option>
                                                    <option ${bean.type=="製紙業" ?"selected":null} value="製紙業">製紙業
                                                    </option>
                                                    <option ${bean.type=="紡織業" ?"selected":null} value="紡織業">紡織業
                                                    </option>
                                                    <option ${bean.type=="化工業" ?"selected":null} value="化工業">化工業
                                                    </option>
                                                    <option ${bean.type=="金屬加工" ?"selected":null} value="金屬加工">金屬加工
                                                    </option>
                                                    <option ${bean.type=="冷凍空調" ?"selected":null} value="冷凍空調">冷凍空調
                                                    </option>
                                                    <option ${bean.type=="航太/造船" ?"selected":null} value="航太/造船">航太/造船
                                                    </option>
                                                    <option ${bean.type=="環保相關" ?"selected":null} value="環保相關">環保相關
                                                    </option>
                                                    <option ${bean.type=="水處理/水資源" ?"selected":null} value="水處理/水資源">
                                                        水處理/水資源
                                                    </option>
                                                    <option ${bean.type=="石化能源" ?"selected":null} value="石化能源">石化能源
                                                    </option>
                                                    <option ${bean.type=="印刷" ?"selected":null} value="印刷">印刷</option>
                                                    <option ${bean.type=="其它" ?"selected":null} value="其它">其它(請填寫)
                                                    </option>
                                                    <option ${bean.type=="業主" ?"selected":null} value="業主">業主</option>
                                                    <option ${bean.type=="設備換修" ?"selected":null} value="設備換修">設備換修
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-md-1 cell">聯絡人手機</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class=" form-control cellFrom"
                                                    v-model="contactmoblie" maxlength="20" name="contactmoblie">
                                            </div>
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">階段</div>
                                            <div class="col-md-2 FormPadding">
                                                <select class=" form-select cellFrom" name="stage">
                                                    <option value="尚未處理" class="selItemOff" selected>
                                                        尚未處理</option>
                                                    <option value="需求確認" class="selItemOff" ${bean.stage=="需求確認"
                                                        ?"selected":null}>
                                                        需求確認</option>
                                                    <option value="聯繫中" class="selItemOff" ${bean.stage=="聯繫中"
                                                        ?"selected":null}>
                                                        聯繫中 </option>
                                                    <option value="處理中" class="selItemOff" ${bean.stage=="處理中"
                                                        ?"selected":null}>
                                                        處理中</option>
                                                    <option value="已報價" class="selItemOff" ${bean.stage=="已報價"
                                                        ?"selected":null}>
                                                        已報價</option>
                                                    <option value="成功結案" class="selItemOff" ${bean.stage=="成功結案"
                                                        ?"selected":null}>
                                                        成功結案</option>
                                                    <option value="失敗結案" class="selItemOff" ${bean.stage=="失敗結案"
                                                        ?"selected":null}>
                                                        失敗結案</option>
                                                </select>
                                            </div>



                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">來源</div>
                                            <div class="col-md-2 FormPadding">
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
                                                    <option value="研討會 - 內部" class="selItemOff"
                                                        ${bean.source=="研討會 - 內部" ?"selected":null}>研討會 - 內部 </option>
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

                                            <div class="col-md-1 cell">聯絡人Email</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class="col-md- form-control cellFrom"
                                                    name="contactemail" value="${bean.contactemail}" maxlength="50">
                                            </div>


                                        </div>
                                        <!-- ////////////////////////////////////////////////////////////////////////////////// -->
                                        <div class="row">&nbsp;</div>
                                        <div class="row" style="text-align: center;">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-6"
                                                style="background-color: rgb(102, 102, 102);font-size: 1.5rem;color: white;border-radius: 5px 5px 0 0 ;">
                                                需求</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">產品類別</div>
                                            <div class="col-md-2 FormPadding">
                                                <select name="producttype" id="Product_Type"
                                                    class=" form-select cellFrom">
                                                    <option ${bean.producttype=="尚未分類" ?"selected":null} value="尚未分類"
                                                        selected="selected">請選擇...</option>
                                                    <option ${bean.producttype=="大型顯示器" ?"selected":null} value="大型顯示器">
                                                        大型顯示器
                                                    </option>
                                                    <option ${bean.producttype=="空氣品質" ?"selected":null} value="空氣品質">
                                                        空氣品質
                                                    </option>
                                                    <option ${bean.producttype=="流量-AICHI" ?"selected":null}
                                                        value="流量-AICHI">
                                                        流量-AICHI</option>
                                                    <option ${bean.producttype=="流量-RGL" ?"selected":null}
                                                        value="流量-RGL">
                                                        流量-RGL
                                                    </option>
                                                    <option ${bean.producttype=="流量-Siargo" ?"selected":null}
                                                        value="流量-Siargo">
                                                        流量-Siargo</option>
                                                    <option ${bean.producttype=="流量-其他" ?"selected":null} value="流量-其他">
                                                        流量-其他
                                                    </option>
                                                    <option ${bean.producttype=="記錄器" ?"selected":null} value="記錄器">記錄器
                                                    </option>
                                                    <option ${bean.producttype=="資料收集器-JETEC" ?"selected":null}
                                                        value="資料收集器-JETEC">
                                                        資料收集器-JETEC</option>
                                                    <option ${bean.producttype=="資料收集器-其他" ?"selected":null}
                                                        value="資料收集器-其他">
                                                        資料收集器-其他</option>
                                                    <option ${bean.producttype=="溫濕-JETEC" ?"selected":null}
                                                        value="溫濕-JETEC">
                                                        溫濕-JETEC</option>
                                                    <option ${bean.producttype=="溫濕-GALLTEC" ?"selected":null}
                                                        value="溫濕-GALLTEC">
                                                        溫濕-GALLTEC</option>
                                                    <option ${bean.producttype=="溫濕-E+E" ?"selected":null}
                                                        value="溫濕-E+E">
                                                        溫濕-E+E
                                                    </option>
                                                    <option ${bean.producttype=="溫濕-其他" ?"selected":null} value="溫濕-其他">
                                                        溫濕-其他
                                                    </option>
                                                    <option ${bean.producttype=="紅外線" ?"selected":null} value="紅外線">紅外線
                                                    </option>
                                                    <option ${bean.producttype=="壓力-JETEC" ?"selected":null}
                                                        value="壓力-JETEC">
                                                        壓力-JETEC</option>
                                                    <option ${bean.producttype=="壓力-HUBA" ?"selected":null}
                                                        value="壓力-HUBA">
                                                        壓力-HUBA
                                                    </option>
                                                    <option ${bean.producttype=="壓力-COPAL" ?"selected":null}
                                                        value="壓力-COPAL">
                                                        壓力-COPAL</option>
                                                    <option ${bean.producttype=="壓力-其他" ?"selected":null} value="壓力-其他">
                                                        壓力-其他
                                                    </option>
                                                    <option ${bean.producttype=="差壓" ?"selected":null} value="差壓">差壓
                                                    </option>
                                                    <option ${bean.producttype=="氣體-JETEC" ?"selected":null}
                                                        value="氣體-JETEC">
                                                        氣體-JETEC</option>
                                                    <option ${bean.producttype=="氣體-Senko" ?"selected":null}
                                                        value="氣體-Senko">
                                                        氣體-Senko</option>
                                                    <option ${bean.producttype=="氣體-GASDNA" ?"selected":null}
                                                        value="氣體-GASDNA">
                                                        氣體-GASDNA</option>
                                                    <option ${bean.producttype=="氣體-手持" ?"selected":null} value="氣體-手持">
                                                        氣體-手持
                                                    </option>
                                                    <option ${bean.producttype=="氣體-其他" ?"selected":null} value="氣體-其他">
                                                        氣體-其他
                                                    </option>
                                                    <option ${bean.producttype=="氣象儀器-土壤/pH" ?"selected":null}
                                                        value="氣象儀器-土壤/pH">
                                                        氣象儀器-土壤/pH</option>
                                                    <option ${bean.producttype=="氣象儀器-日照/紫外線" ?"selected":null}
                                                        value="氣象儀器-日照/紫外線">
                                                        氣象儀器-日照/紫外線</option>
                                                    <option ${bean.producttype=="氣象儀器-風速/風向" ?"selected":null}
                                                        value="氣象儀器-風速/風向">
                                                        氣象儀器-風速/風向</option>
                                                    <option ${bean.producttype=="氣象儀器-雨量" ?"selected":null}
                                                        value="氣象儀器-雨量">
                                                        氣象儀器-雨量
                                                    </option>
                                                    <option ${bean.producttype=="氣象儀器-其他" ?"selected":null}
                                                        value="氣象儀器-其他">
                                                        氣象儀器-其他
                                                    </option>
                                                    <option ${bean.producttype=="水質相關" ?"selected":null} value="水質相關">
                                                        水質相關
                                                    </option>
                                                    <option ${bean.producttype=="液位/料位-JETEC" ?"selected":null}
                                                        value="液位/料位-JETEC">
                                                        液位/料位-JETEC</option>
                                                    <option ${bean.producttype=="液位/料位-DINEL" ?"selected":null}
                                                        value="液位/料位-DINEL">
                                                        液位/料位-DINEL</option>
                                                    <option ${bean.producttype=="液位/料位-HONDA" ?"selected":null}
                                                        value="液位/料位-HONDA">
                                                        液位/料位-HONDA</option>
                                                    <option ${bean.producttype=="液位/料位-其他" ?"selected":null}
                                                        value="液位/料位-其他">
                                                        液位/料位-其他</option>
                                                    <option ${bean.producttype=="溫度貼紙" ?"selected":null} value="溫度貼紙">
                                                        溫度貼紙
                                                    </option>
                                                    <option ${bean.producttype=="溫控器-TOHO" ?"selected":null}
                                                        value="溫控器-TOHO">
                                                        溫控器-TOHO</option>
                                                    <option ${bean.producttype=="溫控器-其他" ?"selected":null}
                                                        value="溫控器-其他">
                                                        溫控器-其他
                                                    </option>
                                                    <option ${bean.producttype=="感溫線棒" ?"selected":null} value="感溫線棒">
                                                        感溫線棒
                                                    </option>
                                                    <option ${bean.producttype=="無線傳輸" ?"selected":null} value="無線傳輸">
                                                        無線傳輸
                                                    </option>
                                                    <option ${bean.producttype=="編碼器/電位計" ?"selected":null}
                                                        value="編碼器/電位計">
                                                        編碼器/電位計
                                                    </option>
                                                    <option ${bean.producttype=="能源管理控制" ?"selected":null}
                                                        value="能源管理控制">
                                                        能源管理控制
                                                    </option>
                                                    <option ${bean.producttype=="食品" ?"selected":null} value="食品">食品
                                                    </option>
                                                    <option ${bean.producttype=="其它" ?"selected":null} value="其它">其它
                                                    </option>
                                                </select>
                                            </div>
                                            <div class="col-md-1 cell">產品名稱</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="product"
                                                    value="${bean.product}" maxlength="20">
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">預算</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="number" class=" form-control cellFrom" name="cost"
                                                    value="${bean.cost}" maxlength="30">
                                            </div>
                                            <div class="col-md-1 cell">成交機率</div>

                                            <div class="col-md-2 FormPadding">
                                                <el-rate v-model="value" show-text
                                                    :texts="['極差', '失望', '一般', '滿意', '驚喜']"
                                                    :colors="{ 2: '#99A9BF', 3:  '#F7BA2A', 4: '#FF9900', 5: 'red' }">
                                                </el-rate>
                                                <input type="hidden" name="clinch" v-model="value">


                                                <!-- <select name="clinch" id="" class="form-select cellFrom">
                                            <option value=""></option>
                                            <option value="高" ${bean.clinch=="高" ?"selected":""}>高</option>
                                            <option value="中" ${bean.clinch=="中" ?"selected":""}>中</option>
                                            <option value="低" ${bean.clinch=="低" ?"selected":""}>低</option>
                                        </select> -->
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">開始時間</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class="  form-control cellFrom CreateTime"
                                                    name="createtime" readonly value="${bean.createtime}">
                                            </div>
                                            <div class="col-md-1 cell">結束時間</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class=" form-control cellFrom EndTime" name="endtime"
                                                    value="${bean.endtime}" readonly>
                                            </div>
                                        </div>

                                        <!-- /////////////////////////////////////////////////////////////////////////// -->
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">描述*</div>
                                            <div class="col-md-5 FormPadding">
                                                <textarea name="message" class="col-md-12" id="message" maxlength="9000"
                                                    style=" height:75px;" required>${bean.message}</textarea>
                                            </div><br><br>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-6 FormPadding">
                                                <button type="submit" style="width: 100%;" class="btn btn-primary"
                                                    onclick="return window.confirm('確定修改')">儲存</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <!-- ///////////////////////////////////////////////////////////////////////////// -->
                                <hr>

                                <form action="${pageContext.request.contextPath}/Market/SaveRemark" method="post"
                                    class="row g-3 needs-validation" novalidate>
                                    <div class="row">
                                        <input type="hidden" name="marketid" value="${bean.marketid}">
                                        <input type="hidden" name="user" value="${user.name}">

                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-6 FormPadding">
                                                <label for="validationTextarea" class="form-label ">追蹤資訊</label>
                                                <textarea class="form-control" id="validationTextarea" required
                                                    name="remark" rows="5" maxlength="200"></textarea>
                                                <div class="invalid-feedback">須填寫</div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-6 FormPadding">
                                                <button style="width: 100%;" class="btn btn-primary"
                                                    onclick="">確認</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4">內容</div>
                                    <div class="col-md-1">創建人 </div>
                                    <div class="col-md-1"> 創建時間</div>
                                    <div class="col-md-1"></div>
                                </div>
                                <br>
                                <c:if test="${not empty bean.mrb}">
                                    <c:forEach varStatus="loop" begin="0" end="${bean.mrb.size()-1}" items="${bean.mrb}"
                                        var="s">
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-4" style="word-wrap: break-word;">${s.remark}</div>
                                            <div class="col-md-1">${s.user}</div>
                                            <div class="col-md-1">${s.createtime}</div>
                                            <div class="col-md-1"><a href="javascript:delRemark(${s.id})"
                                                    style="text-decoration: none;">remove</a></div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <br><br><br><br><br>

                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-7"></div>
                                    <div class="col-md-1"> </div>
                                    <div class="col-md-1">&nbsp;</div>
                                    <div class="col-md-1"></div>
                                </div>
                            </div>
                        </transition-group>
                        <!-- <%-- 彈窗--%> -->

                        <el-dialog title="選擇聯絡人" :visible.sync="outerVisible" width="50%" :before-close="handleClose"
                            :opened="openDialog">

                            <br>
                            <span>&nbsp;&nbsp;&nbsp; 選擇聯絡人</span>
                            <hr>
                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-3">名稱</div>
                                <div class="col-md-3">電話</div>
                                <div class="col-md-3">手機</div>
                            </div>
                            <div class="CCC">
                                <!-- append -->
                            </div>
                            <hr>
                            <br>
                            <span>&nbsp;&nbsp;&nbsp; 輸入聯絡人</p>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-10">
                                        <div class="input-group input-group-sm mb-3">
                                            <span class="input-group-text" id="inputGroup-sizing-sm">名稱</span>
                                            <input type="text" class="form-control" aria-label="Sizing example input"
                                                aria-describedby="inputGroup-sizing-sm" name="catin">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <button class="col-md-10 catbtn" onclick="catbtn()">提交</button>

                                </div>
                        </el-dialog>
                        <!-- <%-- 彈窗結束/////////////////////////////////////--%> -->


                    </div>
                </div>
            </div>
            </div>
        </body>
        <script>
            $(".market").show();
            // 日期UI
            $(function () {
                $(".EndTime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd"
                });
                $(".CreateTime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd"
                });
            });
            // function basefrom() {
            //     if (confirm("確定修改?")) $(".basefrom").submit();
            // }

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
                    window.location.href = "${pageContext.request.contextPath}/Market/delRemark/" + id + "/${bean.marketid}";
                }
            }

            function contact() {
                $(".cat").show();
                $(".hazy").show();
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/selectContactByClientName/' + $("input[name='client']").val(), //接受請求的Servlet地址
                    type: 'POST',
                    // data: formData,
                    // async: false,//同步請求
                    // cache: false,//不快取頁面
                    // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                    // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                    success: function (json) {
                        $(".CCC").empty();

                        for (var j of json) {

                            $(".CCC").append('<div class="row TTT" onclick="clickContact(`' + j.name + '`,`' + j.phone + '`,`' + j.moblie + '`)" >' +
                                '<div class="col-md-1"></div>' +
                                '<div class="col-md-3">' + j.name + '</div>' +
                                '<div class="col-md-3">' + j.phone + '</div>' +
                                '<div class="col-md-3">' + j.moblie + '</div>' +
                                '</div>');
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
            $(".cat").hide();
            $(".hazy").hide();
            $(".catReturn").click(function () {
                $(".cat").hide();
                $(".hazy").hide();
            });

            function clickContact(name, phone, moblie) {
                $(".cat").hide();
                $(".hazy").hide();
                $("input[name='contactname']").val(name);
                $("input[name='contactphone']").val(phone);
                $("input[name='contactmoblie']").val(moblie);
                vm.outerVisible = false;
            }

            function catbtn() {
                $(".cat").hide();
                $(".hazy").hide();
                $("input[name='contactname']").val($("input[name='catin']").val());
                $("input[name='contactphone']").val("");
                $("input[name='contactmoblie']").val("");
                vm.outerVisible = false;
            }
            //建立報價單
            function goquotation() {
                $(".AAA").attr("action", "${pageContext.request.contextPath}/Market/goQuotation.action");
                $(".AAA").submit();
            }
String.prototype.insert = function (index, string) {
    if (index > 0)
        return this.substring(0, index) + string + this.substring(index, this.length);
    else
        return string + this;
};
function formatPhone(sb) {
    if (sb.length == 10) {
        sb = sb.insert(3, "-");
        sb = sb.insert(7, "-");
    }
    if (sb.length == 9) {
        sb = sb.insert(2, "-");
        sb = sb.insert(6, "-");
    }
    if (sb.length == 8) {
        sb = sb.insert(5, "-");
    }
    if (sb.length == 7) {
        sb = sb.insert(4, "-");
    }
    return sb;
}



        </script>
        <script>
            var clinch = parseInt('${bean.clinch}' || null);
            const vm = new Vue({
                el: '.app',
                data() {
                    return {
                        value: clinch,
                        show: false,
                        loading: true,
                        outerVisible: false,
                        phone: '${bean.phone}',
                        contactphone: '${bean.contactphone}',
                        contactmoblie: '${bean.contactmoblie}',

                    }
                },
                created() {
                    this.show = true;
                    this.loading = false;
                    this.phone = formatPhone(this.phone);
                    this.contactphone = formatPhone(this.contactphone);
                    this.contactmoblie = formatPhone(this.contactmoblie);

                },
                methods: {
                    ddd: function () {
                        console.log(this.value);
                    },
                    handleClose(done) {

                        done();

                    },
                    openDialog: function () {
                        contact();
                        this.outerVisible = true;
                    },
                    back: function () {
                        this.show = false;
                        setTimeout(function () {
                            // location.href="http://localhost:8080/CRM/Market/MarketList.jsp";

                            self.location = document.referrer;
                        }, 200)

                    }
                },
            })

        </script>








        </html>