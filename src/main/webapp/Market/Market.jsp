<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">


            <style>
                /* 動作區塊 */
                .box .bosMessagediv {
                    position: absolute;
                    width: 505px;
                    bottom: 0px;
                    right: 20px;
                    padding: 0%;
                }

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

                /* 動作區塊////////////////結束 */
                .marketbar {
                    /* 按鈕顏色 */
                    background-color: #afe3d5;
                }

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

                .error {
                    color: red;
                }
            </style>
            <title>CRM客戶管理系統</title>
        </head>
        <style>
            .cellz {
                background-color: #CCC;
            }

            .cellzFrom {
                border: 0px solid black;
                width: 100%;
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
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-1"></div>
                    <div class="col-md-10 app" v-cloak>
                        <transition-group name="slide-fade" appear>
                            <div v-loading="loading" v-if="show" key="1">
                                <!-- <%-- 中間主體--%> -->
                                <div class="row">
                                    <div class="col-md-12">
                                        <h3>銷售機會</h3>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-12">
                                        <!-- 上一頁 -->
                                        <!-- <a href="#"  onclick="location.href='${pageContext.request.contextPath}/billboard?pag=1&sort=createtime';" -->
                                        <a href="#" @click="back" style="text-decoration: none;">
                                            <img src="${pageContext.request.contextPath}/img/Pre.png" alt="上一頁">
                                        </a>
                                    </div>
                                </div>
                                <br>
                                <form action="${pageContext.request.contextPath}/Market/SaveMarket" method="post"
                                    class="basefrom g-3 ">
                                    <input type="hidden" name="clientid" v-model="bean.clientid">
                                    <input type="hidden" name="customerid" v-model="bean.customerid">
                                    <input type="hidden" name="aaa" value="${bean.aaa}">
                                    <input type="hidden" name="clicks" value="${bean.clicks}">
                                    <input type="hidden" name="marketid" value="${bean.marketid}">
                                    <input type="hidden" name="fileforeignid" v-model="bean.fileforeignid">
                                    <input type="hidden" name="callbos" v-model="bean.callbos">
                                    <input type="hidden" name="founder" v-model="bean.founder">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="row" style="text-align: center;">
                                                <div class="col-md-12 bg-danger text-white"
                                                    style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;">
                                                    基本資料</div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">機會名稱 <span style="color: red;">*</span>
                                                </div>
                                                <div class="col-md-10 FormPadding">
                                                    <input type="text" class="form-control cellzFrom" name="name"
                                                        v-model.trim="bean.name" style="width: 100%;" maxlength="20"
                                                        required>
                                                </div>
                                            </div>
                                            <div class="row">

                                                <div class="col-md-2 cellz">公司名<span style="color: red;">*</span>
                                                    <el-button type="text" icon="el-icon-search" @click="openClient"
                                                        style="float:right"></el-button>
                                                </div>
                                                <div class="col-md-6 FormPadding" style="background-color: #EEE;">
                                                    <a href="#" @click.stop.prevent="goClient">{{bean.client}}</a>
                                                    <input type="hidden" class="form-control cellzFrom client"
                                                        v-model.trim="bean.client" name="client" maxlength="100"
                                                        readonly>
                                                </div>

                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control" placeholder="編號"
                                                        name="serialnumber" v-model.trim="bean.serialnumber">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">聯絡人 <span style="color: red;">*</span>

                                                </div>

                                                <div class="col-md-2 FormPadding">
                                                    <select name="contacttitle" class="form-select cellzFrom"
                                                        v-model="bean.contacttitle">
                                                        <option value="">稱謂</option>
                                                        <option value="Mr">Mr</option>
                                                        <option value="Ms">Ms</option>
                                                        <option value="DR">DR</option>
                                                        <option value="Assoc. Prof">Assoc. Prof</option>
                                                        <option value="Prof.">Prof.</option>
                                                    </select>
                                                </div>


                                                <div class="col-md-4 FormPadding" @click="openDialog">
                                                    <input type="text" class=" form-control cellzFrom col-md-4"
                                                        v-model.trim="bean.contactname" name="contactname"
                                                        maxlength="20" readonly>
                                                </div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control" placeholder="職稱"
                                                        name="jobtitle" v-model.trim="bean.jobtitle" maxlength="20">
                                                </div>





                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">聯絡人電話</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control ppp" name="contactphone"
                                                        v-model="bean.contactphone" maxlength="20">

                                                    <input type="text" class="form-control" name="contactextension"
                                                        v-model="bean.contactextension" maxlength="10" placeholder="分機">
                                                </div>

                                                <div class="col-md-2 cellz">公司電話</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control ppp" name="phone"
                                                        v-model="bean.phone" maxlength="20">

                                                    <input type="text" class="form-control" name="extension"
                                                        v-model="bean.extension" maxlength="10" placeholder="分機">
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">聯絡人手機</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class=" form-control cellzFrom"
                                                        v-model.trim="bean.contactmoblie" maxlength="20"
                                                        name="contactmoblie">
                                                </div>
                                                <div class="col-md-2 cellz">產業</div>
                                                <div class="col-md-4 FormPadding">
                                                    <select name="type" class=" form-select cellzFrom"
                                                        v-model.trim="bean.type">
                                                        <option v-for="(item, index) in typeList" :key="index">
                                                            {{item}}
                                                        </option>
                                                    </select>
                                                </div>



                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">聯絡人Email </div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="col-md- form-control cellzFrom"
                                                        v-model.trim="bean.contactemail" name="contactemail"
                                                        maxlength="50">
                                                </div>
                                                <div class="col-md-2 cellz">來源 <span style="color: red;">*</span></div>
                                                <div class="col-md-4 FormPadding">
                                                    <select class="form-select cellzFrom" name="source"
                                                        v-model.trim="bean.source">
                                                        <option value="廣告">
                                                            廣告
                                                        </option>
                                                        <option value="員工推薦">
                                                            員工推薦</option>
                                                        <option value="外部推薦">
                                                            外部推薦</option>
                                                        <option value="合作夥伴">
                                                            合作夥伴</option>
                                                        <option value="參展">
                                                            參展
                                                        </option>
                                                        <option value="網絡搜索">
                                                            網絡搜索
                                                        </option>
                                                        <option value="口碑">
                                                            口碑
                                                        </option>
                                                        <option value="其他">
                                                            其他
                                                        </option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">Line</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control cellzFrom" name="line"
                                                        v-model.trim="bean.line" maxlength="200">
                                                </div>
                                                <div class="col-md-2 cellz">聯絡方式</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control cellzFrom"
                                                        name="contactmethod" v-model.trim="bean.contactmethod"
                                                        maxlength="20" list="contactmethod">
                                                    <datalist id="contactmethod">
                                                        <option value="Line">
                                                        <option value="電話">
                                                        <option value="手機">
                                                        <option value="email"></option>
                                                        <option value="網頁留言"></option>
                                                    </datalist>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">傳真</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control cellzFrom" name="fax"
                                                        v-model.trim="bean.fax" maxlength="20">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">&nbsp;</div>
                                            <div class="row">&nbsp;</div>
                                            <div class="row">
                                                <div class="col-md-1 "> </div>
                                                <div class="col-md-2 cellz">負責人</div>
                                                <div class="col-md-4 FormPadding">
                                                    <c:if test="${user.position != '職員' }">
                                                        <select name="user" class="form-select cellzFrom"
                                                            v-model.trim="bean.user"
                                                            aria-label="Default select example">
                                                            <option value="無">無</option>
                                                            <c:if test="${not empty admin}">
                                                                <c:forEach varStatus="loop" begin="0"
                                                                    end="${admin.size()-1}" items="${admin}" var="s">
                                                                    <c:if test="${s.department == '業務' }">
                                                                        <option value="${s.name}">
                                                                            ${s.name}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <option value="系統管理"> 系統管理</option>
                                                            </c:if>
                                                        </select>
                                                    </c:if>
                                                    <c:if test="${user.position == '職員' }">
                                                        <input type="hidden" name="user" v-model.trim="bean.user">
                                                        {{bean.user}}
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-1 "> </div>
                                                <div class="col-md-2 cellz">階段</div>
                                                <div class="col-md-4 FormPadding">
                                                    <select class=" form-select cellzFrom" name="stage"
                                                        v-model="bean.stage">
                                                        <option value="尚未處理" selected>
                                                            尚未處理</option>
                                                        <option value="內部詢價中">
                                                            內部詢價中</option>
                                                        <option value="報價處理中">
                                                            報價處理中 </option>
                                                        <option value="已報價">
                                                            已報價</option>
                                                        <option value="提交主管">不合格:提交主管</option>
                                                        <c:if test="${user.position != '職員' }">
                                                            <option value="失敗結案">失敗結案
                                                            </option>
                                                        </c:if>
                                                        <option value="成功結案">
                                                            成功結案</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-1 "> </div>
                                                <div class="col-md-2 cellz">重要性 <span style="color: red;">*</span></div>
                                                <div class="col-md-4 FormPadding">
                                                    <select class="form-select cellzFrom" name="important"
                                                        v-model.trim="bean.important">
                                                        <option value="高">高</option>
                                                        <option value="中">中</option>
                                                        <option value="低">低</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row" v-if="bean.founder != null">
                                                <div class="col-md-1 "> </div>
                                                <div class="col-md-2 cellz">創建人</div>
                                                <div class="col-md-4 FormPadding">
                                                    {{bean.founder}}
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-1"> </div>
                                                <div class="col-md-6 FormPadding">報價內容
                                                    <el-input type="textarea" v-model="bean.quote" rows="5" id="quote"
                                                        maxlength="990" show-word-limit name="quote"
                                                        @input="changeTextarea('quote')">
                                                </div>
                                            </div>

                                            <div class="row" v-show="existsCustomer">
                                                <div class="col-md-1"> </div>
                                                <div class="col-md-6 FormPadding">
                                                    <el-link type="primary"
                                                        :href="'${pageContext.request.contextPath}/Market/potentialcustomer/'+bean.customerid">
                                                        返回潛在顧客</el-link>

                                                </div>
                                            </div>

                                            <br>
                                            <div class="row">
                                                <div class="col-md-1"> </div>
                                                <div class="col-md-6 FormPadding">
                                                    <el-upload class="upload-demo"
                                                        :action="'${pageContext.request.contextPath}/upFileByMarket?authorizeId='+bean.fileforeignid"
                                                        :on-preview="handlePreview" :on-remove="handleRemove"
                                                        :before-remove="beforeRemove" multiple :on-success="onsuccess"
                                                        :on-error="onerror" :file-list="fileList">
                                                        <el-button size="small" type="primary">上傳附件</el-button>
                                                    </el-upload>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ////////////////////////////////////////////////////////////////////////////////// -->
                                    <div class="row">&nbsp;</div>
                                    <div class="row" style="text-align: center;">
                                        <div class="col-md-6 bg-danger text-white"
                                            style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;">
                                            需求</div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1 cellz">產品類別<span style="color: red;">*</span></div>
                                        <div class="col-md-2 FormPadding">
                                            <select name="producttype" id="Product_Type" v-model="bean.producttype"
                                                class=" form-select cellzFrom">
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
                                                <option ${bean.producttype=="流量-RGL" ?"selected":null} value="流量-RGL">
                                                    流量-RGL
                                                </option>
                                                <option ${bean.producttype=="流量-Siargo" ?"selected":null}
                                                    value="流量-Siargo">
                                                    流量-Siargo</option>
                                                <option ${bean.producttype=="流量-其他" ?"selected":null} value="流量-其他">
                                                    流量-其他
                                                </option>
                                                <option ${bean.producttype=="記錄器" ?"selected":null} value="記錄器">
                                                    記錄器
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
                                                <option ${bean.producttype=="溫濕-E+E" ?"selected":null} value="溫濕-E+E">
                                                    溫濕-E+E
                                                </option>
                                                <option ${bean.producttype=="溫濕-其他" ?"selected":null} value="溫濕-其他">
                                                    溫濕-其他
                                                </option>
                                                <option ${bean.producttype=="紅外線" ?"selected":null} value="紅外線">
                                                    紅外線
                                                </option>
                                                <option ${bean.producttype=="壓力-JETEC" ?"selected":null}
                                                    value="壓力-JETEC">
                                                    壓力-JETEC</option>
                                                <option ${bean.producttype=="壓力-HUBA" ?"selected":null} value="壓力-HUBA">
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
                                                <option ${bean.producttype=="氣象儀器-雨量" ?"selected":null} value="氣象儀器-雨量">
                                                    氣象儀器-雨量
                                                </option>
                                                <option ${bean.producttype=="氣象儀器-其他" ?"selected":null} value="氣象儀器-其他">
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
                                                <option ${bean.producttype=="溫控器-其他" ?"selected":null} value="溫控器-其他">
                                                    溫控器-其他
                                                </option>
                                                <option ${bean.producttype=="感溫線棒" ?"selected":null} value="感溫線棒">
                                                    感溫線棒
                                                </option>
                                                <option ${bean.producttype=="無線傳輸" ?"selected":null} value="無線傳輸">
                                                    無線傳輸
                                                </option>
                                                <option ${bean.producttype=="編碼器/電位計" ?"selected":null} value="編碼器/電位計">
                                                    編碼器/電位計
                                                </option>
                                                <option ${bean.producttype=="能源管理控制" ?"selected":null} value="能源管理控制">
                                                    能源管理控制
                                                </option>
                                                <option ${bean.producttype=="食品" ?"selected":null} value="食品">食品
                                                </option>
                                                <option ${bean.producttype=="其它" ?"selected":null} value="其它">其它
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-md-1 cellz">產品名稱<span style="color: red;">*</span></div>
                                        <div class="col-md-2 FormPadding">
                                            <input type="text" class=" form-control cellzFrom" name="product"
                                                v-model.trim="bean.product" maxlength="20">
                                        </div>
                                    </div>

                                    <div class="row">

                                        <div class="col-md-1 cellz">預算</div>
                                        <div class="col-md-2 FormPadding">
                                            <input type="number" class=" form-control cellzFrom" name="cost"
                                                v-model.trim="bean.cost" maxlength="30">
                                        </div>
                                        <div class="col-md-1 cellz">成交機率</div>

                                        <div class="col-md-2 FormPadding clinch">
                                            <el-rate v-model.trim="bean.clinch"
                                                :colors="{ 2: '#99A9BF', 3:  '#F7BA2A', 4: '#FF9900', 5: 'red' }">
                                            </el-rate>
                                            <input type="hidden" name="clinch" v-model.trim="bean.clinch">
                                        </div>
                                    </div>


                                    <div class="row">

                                        <div class="col-md-1 cellz">案件類型</div>
                                        <div class="col-md-2 FormPadding">
                                            <select name="createtime" id="createtime" v-model="bean.createtime"
                                                @change="changeCreateTime" class=" form-select cellzFrom">
                                                <option value="轉賣/自用">轉賣/自用</option>
                                                <option value="設計/預算規劃">設計/預算規劃</option>
                                                <option value="工程標案">工程標案</option>
                                            </select>
                                        </div>
                                        <div class="col-md-1 cellz">結束時間
                                            <el-button type="text" icon="el-icon-phone-outline" @click="callBos"
                                                style="float:right"></el-button>
                                        </div>
                                        <div class="col-md-2 FormPadding">
                                            <c:if test="${user.position != '職員' }">
                                                <el-date-picker v-model="bean.endtime" align="right" type="date"
                                                    name="endtime" placeholder="選擇日期" :picker-options="pickerOptions"
                                                    value-format="yyyy-MM-dd">
                                                </el-date-picker>
                                            </c:if>
                                            <c:if test="${user.position == '職員' }">
                                                <input type="text" :class="CallBosCss" name="endtime"
                                                    v-model.trim="bean.endtime" readonly>
                                            </c:if>
                                        </div>
                                    </div>

                                    <!-- /////////////////////////////////////////////////////////////////////////// -->
                                    <div class="row">
                                        <div class="col-md-1 cellz">描述<span style="color: red;">*</span></div>
                                        <div class="col-md-5 FormPadding">
                                            <el-input type="textarea" v-model="bean.message" rows="5" id="message"
                                                maxlength="950" show-word-limit name="message"
                                                @input="changeTextarea('message')">
                                        </div><br><br>
                                    </div>
                                    <p>&nbsp;</p>
                                    <div class="row">
                                        <div class="col-md-3"></div>
                                        <div class="col-md-6 FormPadding">
                                            <button type="button" style="width: 100%;" class="btn btn-danger"
                                                id="saveMarket" @click="submitForm">完畢儲存</button>
                                        </div>
                                    </div>
                                </form>

                            </div>
                        </transition-group>
                        <!-- ///////////////////////////////////////////////////////////////////////////// -->
                        <hr>

                        <!-- ////////////////////////////////////////追蹤資訊///////////////////////////////////// -->
                        <br><br><br>

                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-9 bg-danger text-white" style="text-align: center; color: white;">
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
                        <!--  -->
                        <form action="" method="post" id="SaveTrack" class="row g-3 needs-validation" novalidate>
                            <input type="hidden" name="remark" value="${user.name}">
                            <input type="hidden" name="customerid" value="${bean.customerid}">

                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-4 FormPadding">
                                    <textarea class="form-control" name="trackdescribe" rows="2"
                                        @input="changeTextarea('trackdescribe')" id="trackdescribe"
                                        maxlength="950"></textarea>
                                </div>
                                <div class="col-md-4 FormPadding">
                                    <textarea class="form-control" name="result" rows="2" maxlength="950"
                                        @input="changeTextarea('result')" id="result"></textarea>
                                </div>
                                <div class="col-md-1" style="padding: 0%;">
                                    <button style="width: 100%; background-color: #569b92;" type="button"
                                        class="btn btn-outline-dark" @click="SaveTrackByMarket">新增</button>
                                </div>
                            </div>
                        </form>
                        <!--  -->


                        <div class="row replyImg" v-for="(s, index) in TrackList" :key="index">
                            <div class="col-md-1"></div>
                            <div class="col-md-11">
                                <div class="row">
                                    <div class="col-md-10" style=" padding: 0%;">
                                        <hr style="color: #569b92; opacity: 1;">
                                    </div>
                                </div>
                                <!-- {{s}} -->
                                <div class="row" style="min-height: 70px;">
                                    <div class="row">
                                        <div class="col-md-4" style="position: relative; word-wrap:break-word;">
                                            </el-input>
                                            <el-input type="textarea" v-model="s.trackdescribe" class="aaaa"
                                                :id="'Tracktrackdescribe'+index"
                                                @input="changeTextarea('Tracktrackdescribe'+index)">
                                        </div>
                                        <div class="col-md-4" style="position: relative; word-wrap:break-word;">
                                            <el-input type="textarea" v-model="s.result" class="aaaa"
                                                :id="'Trackresult'+index" @input="changeTextarea('Trackresult'+index)">

                                        </div>
                                        <div class="col-md-3" style="color: #569b92;">
                                            {{s.remark}} {{s.tracktime}}</div>
                                    </div>
                                </div>
                                <!-- 留言的控制 -->
                                <div class="row replyA" style="font-size: 12;">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-6 "
                                        style="position: relative; word-wrap:break-word;color: #8e8e8e; ">

                                    </div>
                                    <div class="col-md-3 ccc" style="text-align: right;">
                                        <el-button v-show="s.remark == '${user.name}'" type="text" @click="open(s)">
                                            修改</el-button>&nbsp;&nbsp;&nbsp;
                                        <el-button v-show="s.remark == '${user.name}'" type="text"
                                            @click="removeTrack(s)">刪除</el-button>&nbsp;&nbsp;&nbsp;
                                        <el-button type="text" @click="trackremark(s.trackid)">回覆
                                        </el-button>
                                        &nbsp;&nbsp;&nbsp;
                                    </div>
                                </div>
                                <!-- 留言的附件 -->
                                <c:if test="${not empty s.file}">
                                    <c:forEach varStatus="loop" begin="0" end="${s.file.size()-1}" items="${s.file}"
                                        var="file">
                                        <div class="row">
                                            <div class="col-md-1" style="color: #569b92;">
                                                附件</div>
                                            <div class="col-md-5 ">
                                                <a href="${pageContext.request.contextPath}/file/${file.url}"
                                                    target="_blank">${file.name}</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <!-- 評論 -->
                                <div class="row" v-for="(remark, index) in s.trackremark" :key="index">
                                    <div class="col-md-2"></div>
                                    <div class="col-md-8 ">
                                        <div class="row replyA">
                                            <hr>
                                            <div class="col-md-2 " style="color: #569b92;">
                                                {{remark.name}}
                                            </div>
                                            <div class="col-md-7" style="word-wrap:break-word;">
                                                {{remark.content}}
                                            </div>
                                            <div class="col-md-3 ">
                                                {{remark.createtime}}&nbsp;&nbsp;&nbsp;
                                                <el-button v-show="remark.name == '${user.name}'" type="text"
                                                    @click="removeTrackremark(remark)">刪除
                                                </el-button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <br>
                        <br><br><br><br><br>
                        <div class="row">&nbsp;</div>

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
                        <!-- <%-- 公司彈窗--%> -->
                        <el-dialog title="搜索不到,請先新增客戶" :visible.sync="dialogVisible" width="30%"
                            :before-close="handleClose">


                            <div style="margin-top: 15px;">
                                <el-input placeholder="名稱or統編or電話" class="input-with-select" v-model="inclient"
                                    @change="selectclient">

                                    <el-button slot="append" icon="el-icon-search" @click="selectclient"></el-button>
                                </el-input>
                            </div><br>

                            <table class="table table-primary table-striped table-hover">

                                <tr v-for="(s, index) in clientList" :key="index">
                                    <td @click="clickClient(s)">{{s.name}}</td>
                                </tr>

                            </table>



                            <span slot="footer" class="dialog-footer">
                                <el-button @click="dialogVisible = false">取消</el-button>
                            </span>
                        </el-dialog>

                        <!-- <%-- 公司彈窗結束--%> -->


                        <!-- 動作區塊 -->
                        <c:if test="${not empty bean}">
                            <div class="row box" id="draggable">
                                <div class="row act" style="height: 30px;">
                                    <a href="#" onclick="goWork()">新增工作項目</a>
                                </div>


                                <div class="dockbar row shadow  ">

                                    <div class="col-md-2 offset-md-1" style="border-left: black 1px solid;"
                                        onclick="javascript:$('.act').toggle();">
                                        行動
                                    </div>
                                    <div class="col-md-2" @click="changeTableVisible = true">紀錄</div>
                                    <div class="col-md-2">留言</div>
                                    <div :class="CallHelpCSS" @click="CallHelp">求助</div>
                                </div>
                            </div>
                        </c:if>
                        <!-- <%-- 動作區塊結束/////////////////////////////////////--%> -->
                        <!-- 修改紀錄Table -->
                        <el-dialog title="修改紀錄" :visible.sync="changeTableVisible">
                            <el-table :data="changeMessageList" height="450">
                                <el-table-column property="name" label="姓名"></el-table-column>
                                <el-table-column property="filed" label="欄位"></el-table-column>
                                <el-table-column property="source" label="原本"></el-table-column>
                                <el-table-column property="after" label="修改後"></el-table-column>
                                <el-table-column property="createtime" label="日期" width="120"></el-table-column>
                            </el-table>
                        </el-dialog>
                    </div>
                </div>
            </div>
            </div>
        </body>









        <script>
            var myDate = new Date();
            myDate.setDate(myDate.getDate() + 7);
            //    動作區塊
            $(function () {
                $("#draggable").draggable();
            });
            $(".market").show();


            function delRemark(id) {
                if (confirm("確定刪除?")) {
                    window.location.href = "${pageContext.request.contextPath}/Market/delRemark/" + id + "/${bean.marketid}";
                }
            }

            function contact() {

                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/selectContactByClientName/' + $("input[name='client']").val(),
                    type: 'POST',

                    success: function (json) {
                        $(".CCC").empty();

                        for (var j of json) {

                            $(".CCC").append('<div class="row TTT" onclick="clickContact(`' + j.name + '`,`' + j.phone + '`,`' + j.moblie + '`,`' + j.jobtitle + '`)" >' +
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



            function clickContact(name, phone, moblie, jobtitle) {
                vm.bean.contactphone = phone;
                vm.bean.contactmoblie = moblie;
                vm.bean.contactname = name;
                vm.bean.jobtitle = jobtitle;
                vm.outerVisible = false;
            }

            function catbtn() {
                vm.bean.contactname = $("input[name='catin']").val();
                vm.bean.contactphone = "";
                vm.bean.contactmoblie = "";
                vm.outerVisible = false;
            }
            //建立報價單
            function goquotation() {
                $(".basefrom").attr("action", "${pageContext.request.contextPath}/Market/goQuotation.action");
                $(".basefrom").submit();
            }





            //新增工作項目
            function goWork() {
                console.log("新增工作項目");
                console.log($(".basefrom")[0]);
                $(".basefrom").attr("action", "${pageContext.request.contextPath}/Market/MarketChangeWork");
                $(".basefrom")[0].submit();
            }





            String.prototype.insert = function (index, string) {
                if (index > 0)
                    return this.substring(0, index) + string + this.substring(index, this.length);
                else
                    return string + this;
            };
            function formatPhone(sb) {
                if (sb.length == 10) {
                    sb = sb.insert(2, "-");
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
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            var clinch = parseInt('${bean.clinch}' || null);
            const vm = new Vue({
                el: '.app',
                data() {
                    return {
                        fileList: [],
                        CallBosCss: "form-control cellzFrom EndTime ",
                        CallHelpCSS: "col-md-2",
                        existsCustomer: false,//是否是淺在顧客轉過來
                        inclient: "",//搜索客戶輸入
                        changeTableVisible: false,
                        dialogVisible: false,//公司彈窗
                        clientList: [],//客戶列表
                        bean: {
                            fileforeignid: Math.random() * 1000,
                            createtime: "轉賣/自用",//案件類型
                            clinch: 3,
                            phone: "",
                            stage: "",
                            customerid: "",
                            important: "低",
                            endtime: myDate.getFullYear() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getDate(),
                            aaa: new Date(),
                            contacttitle: "",
                            source: "其他",
                        },
                        oldBean: {},
                        changeMessageList: [],//修改資訊
                        show: false,
                        loading: true,
                        outerVisible: false,
                        typeList: ["尚未分類",
                            "農、林、漁、牧業",
                            "礦業及土石採取業",
                            "製造業",
                            "電子及半導體設備製造", "機械設備製造業",
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
                        TrackList: {},
                        pickerOptions: {
                            shortcuts: [
                                {
                                    text: '今天',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime());
                                        picker.$emit('pick', [start, end]);
                                    }
                                }, {
                                    text: '最近一周',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                                        picker.$emit('pick', [start, end]);
                                    }
                                }, {
                                    text: '最近一個月',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                                        picker.$emit('pick', [start, end]);
                                    }
                                }, {
                                    text: '最近三個月',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                                        picker.$emit('pick', [start, end]);
                                    }
                                }]
                        },
                    }
                },

                created() {
                    this.show = true;
                    this.loading = false;
                    if ('${bean.marketid}' != '') {
                        var url = '${pageContext.request.contextPath}/Market/init/${bean.marketid}';

                    }
                    if ("${changeMarket}" == "changeMarket") {
                        var url = "${pageContext.request.contextPath}/Market/getchange/${changeid}";
                    }
                    console.log(url, "url");
                    if (url != null)
                        $.ajax({
                            url: url,//接受請求的Servlet地址
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: (response => (
                                this.bean = response.bean,
                                console.log(this.bean, "bean"),
                                console.log(this.bean.phone),
                                this.existsCustomer = response.existsCustomer,
                                this.changeMessageList = response.changeMessageList,
                                this.bean.phone = formatPhone(this.bean.phone),
                                this.bean.contactphone = formatPhone(this.bean.contactphone),
                                this.bean.contactmoblie = formatPhone(this.bean.contactmoblie),
                                this.oldBean = Object.assign({}, this.bean)

                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    //取得追蹤資訊
                    axios
                        .get('${pageContext.request.contextPath}/Potential/client/' + this.bean.customerid)
                        .then(response => (
                            this.TrackList = response.data,
                            console.log(response.data)
                        ))
                        .catch(function (error) { // 请求失败处理
                            console.log("沒有取得追蹤資訊");
                        });
                    if (this.bean.stage == undefined || this.bean.stage == "") {
                        this.bean.stage = '尚未處理';
                        this.oldBean.stage = '尚未處理';
                    }
                    if (this.bean.user == undefined || this.bean.user == "") {
                        this.bean.user = '無';
                        this.oldBean.user = '無';
                    }
                    console.log(this.bean.callhelp, "this.bean.callhelp");
                    if (this.bean.callhelp == "1") {
                        this.CallHelpCSS = "col-md-2 bg-danger";
                    }
                    this.fileList = this.bean.marketfilelist;

                    console.log(" this.bean.endtime", this.bean.endtime);
                    console.log(" this.oldBean.endtime", this.oldBean.endtime);


                },
                methods: {
                    submitForm() {//送出表單                       
                        //表單驗證
                        var isok = true;
                        if (this.bean.name == null || this.bean.name == "") {
                            $("input[name='name']").css("border", "red 1px solid");
                            isok = false;
                        }
                        if (this.bean.client == null || this.bean.client == "") {
                            $("input[name='client']").css("border", "red 1px solid");
                            isok = false;
                        }

                        if (this.bean.contactname == null || this.bean.contactname == "") {
                            $("input[name='contactname']").css("border", "red 1px solid");
                            isok = false;
                        }
                        if (this.bean.producttype == null || this.bean.producttype == "") {
                            $("select[name='producttype']").css("border", "red 1px solid");
                            isok = false;
                        }
                        if (this.bean.product == null || this.bean.product == "") {
                            $("input[name='product']").css("border", "red 1px solid");
                            isok = false;
                        }

                        if (this.bean.message == null || this.bean.message == "") {
                            $("#message").css("border", "red 1px solid");
                            isok = false;
                        }

                        if (isok) {//通過驗證
                            if ("${bean.marketid}" == "") {//如果是新資料 就 提交表單
                                $('.basefrom').submit();
                            } else {//如果不是新資料 就 紀錄修改
                                var keys = Object.keys(this.bean);
                                var data = {};
                                console.log(" this.bean.endtime", this.bean.endtime);
                                console.log(" this.oldBean.endtime", this.oldBean.endtime);
                                for (const iterator of keys) {
                                    if (this.bean[iterator] == this.oldBean[iterator]) {

                                    } else {
                                        data[iterator] = [this.bean[iterator], this.oldBean[iterator]];
                                    }

                                }
                                axios
                                    .post('${pageContext.request.contextPath}/changeMessage/${bean.marketid}', data)
                                    .then(
                                        response => (
                                            $('.basefrom').submit()
                                        ))
                            }
                        }
                    },
                    open(s) {//修改追蹤資訊
                        this.$alert('<form action="${pageContext.request.contextPath}/Market/changeTrackByMarket/${bean.marketid}" method = "post" >\
                                                    <div class="row">\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="trackdescribe" rows="2"\
                                                                maxlength="950"  >'+ s.trackdescribe + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="result" rows="2"\
                                                                maxlength="950">'+ s.result + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-2" style="padding: 0%;">\
                                                            <button style="width: 100%; background-color: #569b92;"\
                                                                class="btn btn-outline-dark" @click="">修改</button>\
                                                        </div>\
                                                    </div>\
                                                    <input type="hidden" name="trackid" value="'+ s.trackid + '">\
                                                    <input type="hidden" name="tracktime" value="'+ s.tracktime + '">\
                                                    <input type="hidden" name="customerid" value="'+ s.customerid + '">\
                                                    <input type="hidden" name="remark" value="'+ s.remark + '"> </form>', '修改',
                            {
                                dangerouslyUseHTMLString: true,//将 message 属性作为 HTML 片段处理
                                showConfirmButton: false,	//是否显示确定按钮
                                confirmButtonText: '放棄',//确定按钮的文本内容
                                closeOnClickModal: false,//通过点击遮罩关闭
                                closeOnPressEscape: true,//通过按下 ESC 键关闭

                            });
                    },
                    removeTrack(bean) {//刪除追蹤資訊
                        this.$confirm('此操作將永久删除, 是否繼續?', '提示', {
                            confirmButtonText: '確定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(() => {
                            axios
                                .get('${pageContext.request.contextPath}/Potential/removeTrack/' + bean.trackid)
                                .then(response => (
                                    this.TrackList = response.data,
                                    console.log(this.TrackList),
                                    this.$message({
                                        type: 'success',
                                        message: '删除成功!'
                                    })
                                ))
                                .catch(function (error) {
                                    console.log(error);
                                });


                        }).catch(() => {
                            this.$message({
                                type: 'info',
                                message: '已取消删除'
                            });
                        });
                    }, removeTrackremark(remark) {
                        this.$confirm('此操作將永久删除 "' + remark.content + '" 是否繼續?', '提示', {
                            confirmButtonText: '確定',
                            cancelButtonText: '取消',
                            type: 'warning'
                        }).then(() => {
                            axios
                                .get('${pageContext.request.contextPath}/Potential/removeTrackremark/' + remark.trackremarkid + "/" + remark.trackid)
                                .then(response => (
                                    this.TrackList = response.data,
                                    console.log(this.TrackList),
                                    this.$message({
                                        type: 'success',
                                        message: '删除成功!'
                                    })
                                ))
                                .catch(function (error) {
                                    console.log(error);
                                });


                        }).catch(() => {
                            this.$message({
                                type: 'info',
                                message: '已取消删除'
                            });
                        });
                    },
                    trackremark(id) {//回復追蹤資訊
                        this.$prompt('回覆追蹤資訊', {
                            confirmButtonText: '確定',
                            cancelButtonText: '取消',
                        }).then(({ value }) => {
                            axios
                                .get('${pageContext.request.contextPath}/Potential/saveTrackRemark/' + id + '/' + value)
                                .then(response => (
                                    this.TrackList = response.data,
                                    console.log(this.TrackList)
                                ))
                                .catch(function (error) {
                                    console.log(error);
                                });
                        }).catch(() => {
                            this.$message({
                                type: 'info',
                                message: '取消输入'
                            });
                        });
                    },
                    SaveTrackByMarket() {//存追蹤資訊
                        var formData = new FormData($('#SaveTrack')[0]);
                        axios
                            .post('${pageContext.request.contextPath}/Market/SaveTrackByMarket/${bean.marketid}', formData)
                            .then(response => (
                                this.TrackList = response.data,
                                $('textarea[name="trackdescribe"]').val(""),
                                $('textarea[name="result"]').val(""),
                                console.log(this.TrackList)
                            ))
                            .catch(function (error) {
                                alert("請先儲存,再新增追蹤資訊")
                                console.log(error);
                            });
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
                            location.href = "${pageContext.request.contextPath}/Market/MarketList.jsp";

                            // self.location = document.referrer;
                        }, 200)

                    },
                    openClient: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/CRM/getclientList',
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: (response => (
                                this.clientList = response,
                                this.dialogVisible = true
                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                    },
                    clickClient: function (s) {
                        console.log(s, "client");
                        this.bean.serialnumber = s.serialnumber;
                        this.bean.client = s.name;
                        this.bean.phone = s.phone;
                        this.bean.extension = s.extension;
                        this.bean.fax = s.fax;
                        this.bean.type = s.industry;
                        this.dialogVisible = false;
                        this.bean.clientid = s.clientid;
                    },
                    selectclient: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/CRM/selectclientResponseBody/' + this.inclient,
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: (response => (
                                this.clientList = response

                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }, goClient: function () {//點擊客戶名開新分頁
                        window.open('${pageContext.request.contextPath}/CRM/client/' + this.bean.clientid);
                    },
                    //改變textarea高度
                    changeTextarea: function (id) {
                        var textarea = document.getElementById(id);
                        if (textarea.style.height < (textarea.scrollHeight + "px"))
                            textarea.style.height = (textarea.scrollHeight + 10) + 'px';
                    },
                    //切換案件類型
                    changeCreateTime: function () {
                        var day = new Date(this.bean.aaa);
                        if (this.bean.createtime == "轉賣/自用") day.setDate(day.getDate() + 7);
                        if (this.bean.createtime == "設計/預算規劃") day.setDate(day.getDate() + 14);
                        if (this.bean.createtime == "工程標案") day.setDate(day.getDate() + 30);
                        this.bean.endtime = formatDay(day);
                        console.log(this.bean.marketid, "client");
                    },
                    //通知主管
                    callBos: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/callBos/' + this.bean.marketid,
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: function (response) {
                                if (response == "通知主管") {
                                    vm.$message.success(response + ",請求延長");
                                    vm.bean.callbos = "1";
                                }
                                if (response == "取消通知") {
                                    vm.$message.warning(response);
                                    vm.bean.callbos = "0"
                                };
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    callBosSuccess: function () {

                    },
                    //求助
                    CallHelp: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/CallHelp/' + this.bean.marketid,
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: function (response) {
                                console.log(response);
                                if (response == "求助") {
                                    vm.CallHelpCSS = "col-md-2 bg-danger";
                                    vm.$message.success(response + "成功")
                                } else {
                                    vm.CallHelpCSS = "col-md-2";
                                    vm.$message.warning(response)
                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },//附件
                    handleRemove(file, fileList) {
                        console.log(file, fileList);
                        $.ajax({
                            url: '${pageContext.request.contextPath}/delFileByMarket/' + file.fileid,
                            type: 'POST',
                            success: function (response) {

                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    handlePreview(file) {//點擊檔案
                        console.log("file", file);
                        window.open("${pageContext.request.contextPath}/file/" + file.url);
                    },
                    beforeRemove(file, fileList) {
                        return this.$confirm(`確定刪除 ${file.name}?`);
                    },
                    onsuccess(response, file, fileList) {
                        console.log(response, "response");
                        console.log(file, "file");
                        console.log(fileList, "fileList");
                        if (response == null || response == "") {
                            this.$message.error("上傳錯誤,請聯絡管理員");
                            file.status = "fail";
                            fileList.splice(fileList.length - 1, 1);
                        } else {
                            fileList[fileList.length - 1].url = response.url;
                            fileList[fileList.length - 1].name = response.name;
                        }
                        console.log(fileList, "new");

                    },
                    onerror(response, file, fileList) {
                        console.log(response, "response");
                        console.log(file, "file");
                        console.log(fileList, "fileList");
                    }
                },
            })
            function formatDay(day) {
                return day.getFullYear() + "-" + (day.getMonth() + 1) + "-" + day.getDate();
            }
        </script>

        <style>
            .el-message-box {
                width: 50%;
            }

            /* 電話關注 */
            .ppp:focus {
                width: 300px;
            }

            .form-control:focus {
                color: #276ace;
            }

            .aaaa {
                border: 0px white solid;
            }

            .bg-danger {
                color: white;
            }

            .el-upload-list__item-name [class^=el-icon] {
                height: auto;
            }

            .el-icon-close-tip {
                display: none;
            }
            .el-date-editor.el-input{
                width: 100%;
            }
        </style>

        </html>