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
                                            <img src="${pageContext.request.contextPath}/img/Pre.png" alt="上一頁"
                                                style="width: 60px;height: 54px;">
                                        </a>
                                        <el-button class="el-icon-printer" @click="printTable"></el-button>
                                        </i>
                                    </div>
                                </div>
                                <br>
                                <form action="${pageContext.request.contextPath}/Market/SaveMarket" method="post"
                                    class="basefrom g-3 ">
                                    <input type="hidden" name="clientid" v-model="bean.clientid">
                                    <input type="hidden" name="customerid" v-model="bean.customerid">
                                    <input type="hidden" name="aaa" v-model="bean.aaa">
                                    <input type="hidden" name="clicks" value="${bean.clicks}">
                                    <input type="hidden" name="marketid" value="${bean.marketid}">
                                    <input type="hidden" name="opentime" value="${bean.opentime}">
                                    <input type="hidden" name="fileforeignid" v-model="bean.fileforeignid">
                                    <input type="hidden" name="callbos" v-model="bean.callbos">
                                    <input type="hidden" name="founder" v-model="bean.founder">
                                    <input type="hidden" name="contactid" v-model="bean.contactid">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="row" style="text-align: center;">
                                                <div class="col-md-12 bg-danger text-white"
                                                    style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;">
                                                    基本資料<br>

                                                </div>
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
                                                <div class="col-md-6 FormPadding  clientDiv"
                                                    style="background-color: #EEE;">
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
                                                <div class="col-md-2 cellz">聯絡人 {{bean.contactid}}<span
                                                        style="color: red;">*</span>

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
                                                        <option value="尚未分類">尚未分類</option>

                                                        <c:forEach varStatus="loop" begin="0" end="${library.size()-1}"
                                                            items="${library}" var="s">
                                                            <c:if test='${s.librarygroup == "MarketType"}'>
                                                                <option value="${s.libraryoption}">${s.libraryoption}
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>


                                                    </select>
                                                </div>


                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">聯絡人Email</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="col-md- form-control cellzFrom"
                                                        v-model.trim="bean.contactemail" name="contactemail"
                                                        maxlength="50">
                                                </div>
                                                <div class="col-md-2 cellz">來源 <span style="color: red;">*</span></div>
                                                <div class="col-md-4 FormPadding">
                                                    <select type="text" class="form-control" placeholder="" id="source"
                                                        maxlength="90" name="source" v-model.trim="bean.source"
                                                        list="sourceList">
                                                        <option value="其他">其他</option>
                                                        <c:forEach varStatus="loop" begin="0" end="${library.size()-1}"
                                                            items="${library}" var="s">
                                                            <c:if test='${s.librarygroup == "MarketSource"}'>
                                                                <option value="${s.libraryoption}">${s.libraryoption}
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">Line</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control cellzFrom" name="line"
                                                        v-model.trim="bean.line" maxlength="200">
                                                </div>
                                                <div class="col-md-2 cellz"><span
                                                        v-show="bean.source == '其他'">其他來源</span></div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" v-show="bean.source == '其他'" name="othersource"
                                                        v-model="bean.othersource" style="border: 1px red solid;"
                                                        class="form-control" maxlength="90">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">傳真</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control cellzFrom" name="fax"
                                                        v-model.trim="bean.fax" maxlength="20">
                                                </div>
                                                <div class="col-md-2 cellz">聯絡方式</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control cellzFrom"
                                                        name="contactmethod" v-model.trim="bean.contactmethod"
                                                        maxlength="20" list="contactmethod">
                                                    <datalist id="contactmethod">
                                                        <c:forEach varStatus="loop" begin="0" end="${library.size()-1}"
                                                            items="${library}" var="s">
                                                            <c:if test='${s.librarygroup == "contactmethod"}'>
                                                                <option value="${s.libraryoption}">${s.libraryoption}
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </datalist>
                                                </div>
                                            </div>
                                            <div class="row">&nbsp;</div>

                                            <div class="row" style="text-align: center;">
                                                <div class="col-md-12 bg-danger text-white"
                                                    style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;">
                                                    需求
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-2 cellz">產品類別<span style="color: red;">*</span></div>
                                                <div class="col-md-4 FormPadding">
                                                    <select name="producttype" id="Product_Type"
                                                        v-model="bean.producttype" class=" form-select cellzFrom">
                                                        <option ${bean.producttype=="尚未分類" ?"selected":null}
                                                            value="尚未分類" selected="selected">請選擇...
                                                        </option>
                                                        <c:forEach varStatus="loop" begin="0" end="${library.size()-1}"
                                                            items="${library}" var="s">
                                                            <c:if test='${s.librarygroup == "producttype"}'>
                                                                <option value="${s.libraryoption}">${s.libraryoption}
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <div class="col-md-2 cellz">產品名稱</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class=" form-control cellzFrom" name="product"
                                                        v-model.trim="bean.product" maxlength="20">
                                                </div>
                                            </div>
                                            <div class="row">

                                                <div class="col-md-2 cellz">預算</div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="number" class=" form-control cellzFrom" name="cost"
                                                        v-model.trim="bean.cost" maxlength="30">
                                                </div>
                                                <div class="col-md-2 cellz">成交機率</div>

                                                <div class="col-md-4 FormPadding clinch">
                                                    <el-rate v-model.trim="bean.clinch"
                                                        :colors="{ 2: '#99A9BF', 3:  '#F7BA2A', 4: '#FF9900', 5: 'red' }">
                                                    </el-rate>
                                                    <input type="hidden" name="clinch" v-model.trim="bean.clinch">
                                                </div>
                                            </div>
                                            <div class="row">

                                                <div class="col-md-2 cellz">案件類型 <span style="color: red;">*</span>
                                                </div>
                                                <div class="col-md-4 FormPadding">
                                                    <select name="createtime" id="createtime" v-model="bean.createtime"
                                                        @change="changeCreateTime" class=" form-select cellzFrom">
                                                        <option value="轉賣">轉賣</option>
                                                        <option value="自用">自用</option>
                                                        <option value="設計/預算規劃">設計/預算規劃</option>
                                                        <option value="工程標案">工程標案</option>
                                                    </select>
                                                </div>
                                                <div class="col-md-2 cellz">結束時間
                                                    <el-button type="text" icon="el-icon-phone-outline" @click="callBos"
                                                        style="float:right"></el-button>
                                                </div>
                                                <div class="col-md-4 FormPadding">
                                                    <c:if test="${user.position != '職員' }">
                                                        <el-date-picker v-model="bean.endtime" align="right" type="date"
                                                            name="endtime" placeholder="選擇日期"
                                                            :picker-options="pickerOptions" value-format="yyyy-MM-dd">
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
                                                <div class="col-md-2 cellz">描述<span style="color: red;">*</span></div>
                                                <div class="col-md-10 FormPadding">
                                                    <div v-html="messageheight" id="messageheight"
                                                        style="position: absolute;width: 541px;z-index: -1;"></div>
                                                    <el-input type="textarea" v-model="bean.message" rows="5"
                                                        id="message" maxlength="950" show-word-limit name="message"
                                                        @input="changeTextarea('message')"></el-input>
                                                </div>
                                                <br><br>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row">&nbsp;</div>
                                            <div class="row" style="line-height: 2.5rem;">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz">
                                                    創建時間
                                                </div>
                                                <div class="col-md-4 FormPadding">
                                                    ${bean.aaa}
                                                    <c:if test="${bean.receivestate == 1}">
                                                        <el-tag>領取</el-tag>
                                                    </c:if>
                                                    <c:if test="${bean.receivestate == 2}">
                                                        <el-tag type="danger">分配</el-tag>
                                                    </c:if>

                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz" style="line-height: 30px;"></div>
                                                <div class="col-md-4  FormPadding ">


                                                    <!-- <div class="receive" v-show="bean.receive == '${user.name}'"
                                                        style="color: #0d6efd;cursor: pointer;line-height: 30px;"
                                                        @click="clickReceive">取消任務</div> -->
                                                    <div class="receive" v-show="bean.receivestate == 3"
                                                        style="color: #0d6efd;cursor: pointer;line-height: 30px;"
                                                        @click="clickReceive">領取任務</div>




                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz">
                                                    負責人
                                                </div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="hidden" name="receive" v-model="bean.receive">
                                                    <input type="hidden" name="receivestate"
                                                        v-model="bean.receivestate">

                                                    <c:if test="${user.position != '職員' &&  user.position != '新'}">
                                                        <select name="user" class="form-select cellzFrom"
                                                            @change="changeUser" v-model="bean.user">
                                                            <option value="無">無</option>
                                                            <c:if test="${not empty admin}">
                                                                <c:forEach varStatus="loop" begin="0"
                                                                    end="${admin.size()-1}" items="${admin}" var="s">
                                                                    <c:if test="${s.department == '業務' }">
                                                                        <option value="${s.name}">
                                                                            ${s.name}
                                                                        </option>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <option value="系統管理">
                                                                    系統管理
                                                                </option>
                                                            </c:if>
                                                        </select>
                                                    </c:if>
                                                    <c:if test="${user.position == '職員' || user.position == '新'}">
                                                        <input type="hidden" name="user" v-model.trim="bean.user">
                                                        {{bean.user}}
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="row" style="height: 38px">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz">
                                                    階段
                                                </div>
                                                <div class="col-md-4 FormPadding">
                                                    <select class=" form-select cellzFrom" name="stage"
                                                        @change="chageToSave('stage',bean.stage)" v-model="bean.stage">
                                                        <option value="尚未處理" selected>
                                                            尚未處理
                                                        </option>
                                                        <option value="潛在客戶轉">
                                                            潛在客戶轉
                                                        </option>
                                                        <option value="內部詢價中">
                                                            內部詢價中
                                                        </option>
                                                        <option value="已報價">
                                                            已報價
                                                        </option>
                                                        <option value="提交主管">
                                                            不合格:提交主管
                                                        </option>
                                                        <c:if test="${user.position != '職員' }">
                                                            <option value="失敗結案">
                                                                失敗結案
                                                            </option>
                                                        </c:if>
                                                        <option value="成功結案">
                                                            成功結案
                                                        </option>
                                                    </select>
                                                </div>
                                                <c:if test="${user.position != '職員' }">
                                                    <div class="col-md-5" v-show="bean.stage  =='提交主管'">
                                                        <el-button size="mini" type="primary"
                                                            @click="BosOperate('已報價')">
                                                            撤回
                                                        </el-button>
                                                        <el-button size="mini" type="primary"
                                                            @click="BosOperate('失敗結案')">
                                                            失敗結案
                                                        </el-button>
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="row" v-show="bean.stage == '失敗結案' || bean.stage == '提交主管' ">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz">
                                                    結案理由
                                                    <span style="color: red;">*</span>
                                                </div>
                                                <div class="col-md-4 FormPadding" id="closereason"
                                                    style="border: red 1px solid;">
                                                    <select class="form-select cellzFrom" name="closereason"
                                                        v-model.trim="bean.closereason">
                                                        <c:forEach varStatus="loop" begin="0" end="${library.size()-1}"
                                                            items="${library}" var="s">
                                                            <c:if test='${s.librarygroup == "closereason"}'>
                                                                <option value="${s.libraryoption}">${s.libraryoption}
                                                                </option>
                                                            </c:if>
                                                        </c:forEach>
                                                        <option value="其他">
                                                            其他
                                                        </option>
                                                        <option value="自動結案" v-show="bean.closereason == '自動結案'">
                                                            自動結案
                                                        </option>
                                                        <option value="失敗復活" v-show="bean.closereason == '失敗復活'">
                                                            失敗復活
                                                        </option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row"
                                                v-show="(bean.stage == '失敗結案' || bean.stage == '提交主管') && bean.closereason == '其他' ">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz">
                                                    其他結案理由 </div>
                                                <div class="col-md-4 FormPadding">
                                                    <input type="text" class="form-control" name="closeextend"
                                                        v-model="bean.closeextend">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz">
                                                    重要性
                                                    <span style="color: red;">*</span>
                                                </div>
                                                <div class="col-md-4 FormPadding" id="important">
                                                    <select class="form-select cellzFrom" name="important"
                                                        v-model.trim="bean.important">
                                                        <option value="高">
                                                            高
                                                        </option>
                                                        <option value="中">
                                                            中
                                                        </option>
                                                        <option value="低">
                                                            低
                                                        </option>
                                                        <option value="無">
                                                            無
                                                        </option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="row" v-if="bean.founder != null">
                                                <div class="col-md-1 ">
                                                </div>
                                                <div class="col-md-2 cellz">
                                                    創建人
                                                </div>
                                                <div class="col-md-4 FormPadding">
                                                    {{bean.founder}}
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-1">
                                                </div>
                                                <div class="col-md-6 FormPadding">
                                                    報價內容
                                                    <div v-html="quoteHeight" id="quoteHeight"
                                                        style="visibility: hidden ; position: absolute;z-index: -1;width: 312px;">
                                                    </div>

                                                    <el-input type="textarea" v-model="bean.quote" rows="6" id="quote"
                                                        maxlength="990" show-word-limit name="quote"
                                                        @input="changeTextarea('quote')"></el-input>
                                                </div>
                                            </div>

                                            <div class="row" v-show="existsCustomer">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-6 FormPadding">
                                                    <el-link type="primary"
                                                        :href="'${pageContext.request.contextPath}/Market/potentialcustomer/'+bean.customerid">
                                                        返回潛在顧客
                                                    </el-link>

                                                </div>
                                            </div>

                                            <br>
                                            <div class="row">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-6 FormPadding">
                                                    <el-upload class="upload-demo"
                                                        :action="'${pageContext.request.contextPath}/upFileByMarket?authorizeId='+bean.fileforeignid"
                                                        :on-preview="handlePreview" :on-remove="handleRemove"
                                                        :before-remove="beforeRemove" multiple :on-success="onsuccess"
                                                        :on-error="onerror" :file-list="fileList">
                                                        <el-button size="small" type="primary">
                                                            上傳附件
                                                        </el-button>
                                                    </el-upload>
                                                </div>
                                            </div>

                                            <br>



                                        </div>
                                    </div>
                                    <!-- ////////////////////////////////////////////////////////////////////////////////// -->
                                    <div class="row">&nbsp;</div>

                                    <p>&nbsp;</p>
                                    <div class="row">
                                        <div class="col-md-3"></div>
                                        <div class="col-md-6 FormPadding">
                                            <button type="button" style="width: 100%;" class="btn btn-danger"
                                                id="saveMarket" @click="submitForm">完畢儲存
                                            </button>
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

                                    <el-input type="textarea" :autosize="{ minRows: 4}" v-model="trackdescribe"
                                        show-word-limit name="trackdescribe" maxlength="950" id="trackdescribe">
                                    </el-input>

                                </div>
                                <div class="col-md-4 FormPadding">
                                    <el-input type="textarea" :autosize="{ minRows: 4}" v-model="result" name="result"
                                        show-word-limit maxlength="950" id="result">
                                    </el-input>


                                </div>
                                <div class="col-md-1" style="padding: 0%;">
                                    <button style="width: 100%; background-color: #569b92;" type="button"
                                        class="btn btn-outline-dark" @click="SaveTrackByMarket">新增
                                    </button>
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
                                        <div class="col-md-4" style="position: relative; word-wrap:break-word;"
                                            v-html="s.trackdescribe">


                                            <!-- <el-input type="textarea" v-model="s.trackdescribe" class="aaaa"
                            :id="'Tracktrackdescribe'+index"
                            @input="changeTextarea('Tracktrackdescribe'+index)"></el-input> -->
                                        </div>
                                        <div class="col-md-4" style="position: relative; word-wrap:break-word;"
                                            v-html="s.result">
                                            <!-- <el-input type="textarea" v-model="s.result" class="aaaa"
                            :id="'Trackresult'+index" @input="changeTextarea('Trackresult'+index)">
                        </el-input> -->
                                        </div>
                                        <div class="col-md-3" style="color: #569b92;">
                                            {{s.remark}} {{s.tracktime}}
                                        </div>
                                    </div>
                                </div>
                                <!-- 留言的控制 -->
                                <div class="row replyA" style="font-size: 12px;">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-6 "
                                        style="position: relative; word-wrap:break-word;color: #8e8e8e; ">

                                    </div>
                                    <div class="col-md-3 ccc" style="text-align: right;">
                                        <el-button v-show="s.remark == '${user.name}'" type="text" @click="open(s)">
                                            修改
                                        </el-button>&nbsp;&nbsp;&nbsp;
                                        <el-button v-show="s.remark == '${user.name}'" type="text"
                                            @click="removeTrack(s)">
                                            刪除
                                        </el-button>&nbsp;&nbsp;&nbsp;
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
                                                附件
                                            </div>
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
                                <div v-for="(j, index) in contactList" :key="index">
                                    <div class="row TTT" style="cursor: pointer;" @click="clickContact(j)">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3"> {{j.name}} </div>
                                        <div class="col-md-3"> {{j.phone}} </div>
                                        <div class="col-md-3"> {{j.moblie}} </div>
                                    </div>
                                    <br>
                                </div>
                            </div>
                            <hr>
                            <br>

                            <div class="row">
                                <div class="col-md-1"></div>
                                <button class="col-md-10 catbtn" @click="catbtn" id="catbtn">新增聯絡人</button>
                            </div>
                        </el-dialog>
                        <!-- <%-- 彈窗結束/////////////////////////////////////--%> -->
                        <!-- <%-- 公司彈窗--%> -->
                        <el-dialog title="搜索不到,請先新增客戶" :visible.sync="dialogVisible" width="30%"
                            :close-on-click-modal="false" :before-close="handleClose">
                            <div style="margin-top: 15px;">
                                <el-input placeholder="名稱or統編or電話" class="input-with-select" v-model.trim="inclient"
                                    @change="selectclient">
                                    <el-button slot="append" icon="el-icon-search" @click="selectclient"></el-button>
                                </el-input>
                            </div>
                            <br>
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

                                <%-- 留言區塊--%>
                                    <div class="bosMessagediv">
                                        <el-card class="box-card" style="background-color: #EEE">

                                            <div slot="header" class="clearfix">
                                                <el-input type="textarea" v-model.trim="bosMassage" placeholder="留言"
                                                    maxlength="200" show-word-limit>
                                                </el-input>
                                                <el-button icon="el-icon-upload" style="width: 100%"
                                                    @click="sendBosMessage">送出
                                                </el-button>
                                            </div>

                                            <table class="table table-success">
                                                <tr v-for="(s, index) in bosMassageList" :key="index">
                                                    <td style="width: 100px;">{{s.name}}</td>
                                                    <td style="width: 400px;">{{s.message}}</td>
                                                    <td><i class="el-icon-delete" style="cursor: pointer;"
                                                            @click="reomveBosMessage(s.bosmessageid)"></i></td>
                                                </tr>
                                            </table>
                                        </el-card>
                                    </div>


                                    <div class="row act" style="height: 30px;">
                                        <a href="#" onclick="goWork()">新增工作項目</a>
                                    </div>


                                    <div class="dockbar row shadow  ">

                                        <div class="col-md-2 offset-md-1" style="border-left: black 1px solid;"
                                            onclick="javascript:$('.act').toggle();">
                                            行動
                                        </div>
                                        <div class="col-md-2" @click="changeTableVisible = true">紀錄</div>
                                        <div class="col-md-2" v-on:click="showbosMassage">留言</div>
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


            function catbtn() {
                window.open = "  "





                // vm.bean.contactname = $("input[name='catin']").val();
                // vm.bean.contactphone = "";
                // vm.bean.contactmoblie = "";
                // vm.outerVisible = false;
            }

            //建立報價單
            function goquotation() {
                $(".basefrom").attr("action", "${pageContext.request.contextPath}/Market/goQuotation.action");
                $(".basefrom").submit();
            }


            //新增工作項目
            function goWork() {
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
            $(".bosMessagediv").hide();
            $(".act").hide();
            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            var clinch = parseInt('${bean.clinch}' || null);
            const vm = new Vue({
                el: '.app',
                data() {
                    return {
                        trackdescribe: "",
                        result: "",
                        bosMassageList: [],//留言LIST
                        bosMassage: "",//留言
                        stateNum: 1,//麵包屑顯示用
                        quoteHeight: "",// 報價內容 高度用
                        messageheight: "",// 描述 高度用
                        fileList: [],
                        CallBosCss: "form-control cellzFrom EndTime ",
                        CallHelpCSS: "col-md-2",
                        existsCustomer: false,//是否是淺在顧客轉過來
                        inclient: "",//搜索客戶輸入
                        changeTableVisible: false,
                        dialogVisible: false,//公司彈窗
                        clientList: [],//客戶列表
                        oldClientList: [],
                        bean: {
                            fileforeignid: Math.random() * 1000,
                            createtime: "",//案件類型
                            clinch: 3,
                            phone: "",
                            stage: "",
                            customerid: "",
                            important: "無",
                            endtime: myDate.getFullYear() + "-" + (myDate.getMonth() + 1) + "-" + myDate.getDate(),
                            aaa: new Date(),
                            contacttitle: "",
                            source: "",
                            contactBean: {},
                            clientid: "",
                        },
                        contactList: [],
                        oldBean: {},
                        changeMessageList: [],//修改資訊
                        show: false,
                        loading: true,
                        outerVisible: false,
                        TrackList: {},
                        pickerOptions: {
                            shortcuts: [
                                {
                                    text: '今天',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime());
                                        picker.$emit('pick', new Date());
                                    }
                                }, {
                                    text: '最近一周',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
                                        picker.$emit('pick', start);
                                    }
                                }, {
                                    text: '最近一個月',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
                                        picker.$emit('pick', start);
                                    }
                                }, {
                                    text: '最近三個月',
                                    onClick(picker) {
                                        const end = new Date();
                                        const start = new Date();
                                        start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
                                        picker.$emit('pick', start);
                                    }
                                }]
                        },

                    
                    
                    
                    }
                },

                created() {
                    this.show = true;
                    this.loading = false;
                    //一般進入
                    if ('${bean.marketid}' != '') {
                        var url = '${pageContext.request.contextPath}/Market/init/${bean.marketid}';

                    }
                    //淺在顧客轉銷售機會
                    if ("${changeMarket}" == "changeMarket") {
                        var url = "${pageContext.request.contextPath}/Market/getchange/${changeid}";
                    }

                    if (url != null)
                        $.ajax({
                            url: url,//接受請求的Servlet地址
                            type: 'POST',
                            async: false,//同步請求
                            cache: false,//不快取頁面
                            success: (response => (
                                this.bean = response.data.bean,
                                this.existsCustomer = response.data.existsCustomer,
                                this.changeMessageList = response.data.changeMessageList,
                                this.bean.phone = formatPhone(this.bean.phone),
                                this.bean.contactphone = formatPhone(this.bean.contactphone),
                                this.bean.fax = formatPhone(this.bean.fax),

                                this.oldBean = Object.assign({}, this.bean),
                                this.bosMassageList = response.data.bean.bm

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

                    if (this.bean.callhelp == "1") {
                        this.CallHelpCSS = "col-md-2 bg-danger";
                    }
                    this.fileList = this.bean.marketfilelist;
                    //取 報價內容 高度用
                    this.quoteHeight = this.bean.quote.replace(/\r\n/g, '<br />');
                    this.messageheight = this.bean.message.replace(/\r\n/g, '<br />');

                },
                mounted() {
                    $('title').html(this.bean.name);
                    //取 報價內容 高度用
                    const h = $("#quoteHeight").height();
                    if (h > 100) $("#quote").height((h + 20));
                    if ($("#messageheight").height() > 100) $("#message").height(($("#messageheight").height()));

                },
                watch: {
                    TrackList: {
                        handler(newValue, oldValue) {
                            for (var track of newValue) {
                                track.trackdescribe = track.trackdescribe.replace(/\r\n/g, '<br />');
                                track.result = track.result.replace(/\r\n/g, '<br />');
                            }
                        }
                    }
                },
                methods: {
                    //新增聯絡人
                    catbtn() {

                        if (this.bean.clientid == "") {
                            this.$message.error("先選擇公司");
                            return;
                        }
                        window.open("${pageContext.request.contextPath}/Market/newContact/" + this.bean.clientid);




                        this.outerVisible = false;
                    },
                    submitForm() {//送出表單
                        //表單驗證
                        var isok = true;
                        if (this.bean.marketid != "" && this.bean.source == "其他" && this.bean.othersource.length < 2) {
                            isok = false;
                            this.$message.error('其他來源,需要填');
                        }
                        if (this.bean.source == "其他" && (this.bean.othersource == null || this.bean.othersource == "" || this.bean.othersource == "其他")) {
                            isok = false;
                            this.$message.error('其他來源,需要填');
                        }
                        if (this.bean.name == null || this.bean.name == "") {
                            $("input[name='name']").css("border", "red 1px solid");
                            this.$message.error('機會名稱,需要填');
                            isok = false;
                        } else {
                            $("input[name='name']").css("border", "black 1px solid");
                        }
                        if (this.bean.client == null || this.bean.client == "") {
                            $(".clientDiv").css("border", "red 1px solid");
                            this.$message.error('公司名,需要填');
                            isok = false;
                        } else {
                            $(".clientDiv").css("border", "black 1px solid");
                        }
                        if (this.bean.contactname == null || this.bean.contactname == "") {
                            $("input[name='contactname']").css("border", "red 1px solid");
                            this.$message.error('聯絡人,需要填');
                            isok = false;
                        } else {
                            $("input[name='contactname']").css("border", "black 1px solid");
                        }
                        if (this.bean.producttype == null || this.bean.producttype == "") {
                            $("select[name='producttype']").css("border", "red 1px solid");
                            this.$message.error('產品類別,需要填');
                            isok = false;
                        } else {
                            $("select[name='producttype']").css("border", "black 1px solid");
                        }
                        if (this.bean.message == null || this.bean.message == "") {
                            $("#message").css("border", "red 1px solid");
                            this.$message.error('描述,需要填');
                            isok = false;
                        } else {
                            $("#message").css("border", "black 1px solid");
                        }
                        if (this.bean.important == null || this.bean.important == "" || this.bean.important == "無") {
                            $("#important").css("border", "red 1px solid");
                            this.$message.error('重要性,需要填');
                            isok = false;
                        } else {
                            $("#important").css("border", "black 1px solid");
                        }
                        if (this.bean.source == null || this.bean.source == "") {
                            $("#source").css("border", "red 1px solid");
                            this.$message.error('來源,需要填');
                            isok = false;
                        } else {
                            $("#source").css("border", "black 1px solid");
                        }
                        if (this.bean.createtime == null || this.bean.createtime == "") {
                            $("#createtime").css("border", "red 1px solid");
                            this.$message.error('案件類型 ,需要填');
                            isok = false;
                        } else {
                            $("#createtime").css("border", "black 1px solid");
                        }
                        if (isok) {//通過驗證

                            // ${pageContext.request.contextPath}/Market/SaveMarket
                            if ("${bean.marketid}" == "") {//如果是新資料 就 提交表單

                                this.formSubmit();
                            } else {//如果不是新資料 就 紀錄修改
                                var keys = Object.keys(this.bean);
                                var data = {};
                                var hasSave = false;
                                for (const iterator of keys) {
                                    if (this.bean[iterator] == this.oldBean[iterator]) {

                                    } else {
                                        data[iterator] = [this.bean[iterator], this.oldBean[iterator]];
                                        hasSave = true;
                                    }
                                }

                                if (hasSave) {
                                    axios
                                        .post('${pageContext.request.contextPath}/changeMessage/${bean.marketid}', data)
                                        .then(
                                            response => (
                                                console.log("response3"),
                                                vm.formSubmit()
                                            ))
                                } else {
                                    this.$message.error('沒有任何改變');
                                }
                            }
                        }
                    },
                    formSubmit() {
                        var formData = new FormData($(".basefrom")[0]);
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/SaveMarket',
                            type: 'POST',
                            data: formData,
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: function (response) {
                                if (response.state) {
                                    location.href = "${pageContext.request.contextPath}/Market/Market/" + response.id;
                                } else {
                                    vm.$message({
                                        message: response.mess,
                                        type: 'error'
                                    });
                                }
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    },
                    open(s) {//修改追蹤資訊
                        this.$alert('<form action="${pageContext.request.contextPath}/Market/changeTrackByMarket/${bean.marketid}" method = "post" >\
                                                    <div class="row">\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="trackdescribe" rows="10"\
                                                                maxlength="950"  >' + s.trackdescribe + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="result" rows="10"\
                                                                maxlength="950">' + s.result + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-2" style="padding: 0%;">\
                                                            <button style="width: 100%; background-color: #569b92;"\
                                                                class="btn btn-outline-dark" @click="">修改</button>\
                                                        </div>\
                                                    </div>\
                                                    <input type="hidden" name="trackid" value="' + s.trackid + '">\
                                                    <input type="hidden" name="tracktime" value="' + s.tracktime + '">\
                                                    <input type="hidden" name="customerid" value="' + s.customerid + '">\
                                                    <input type="hidden" name="remark" value="' + s.remark + '"> </form>', '修改',
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
                                    this.TrackList = response.data

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
                                $('textarea[name="result"]').val("")
                            ))
                            .catch(function (error) {
                                alert("請先儲存,再新增追蹤資訊")
                                console.log(error);
                            });
                    },
                    handleClose(done) {
                        done();
                    },
                    //打開聯絡人列表
                    openDialog() {
                        console.log("json");
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/selectContactByClientName/' + $("input[name='client']").val(),
                            type: 'POST',
                            success: json => {
                                this.contactList = json.data;
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                        this.outerVisible = true;
                    },
                    clickContact(contact) {
                        this.bean.contactBean = contact;
                        this.bean.contactphone = contact.phone;
                        this.bean.contactmoblie = contact.moblie;
                        this.bean.contactname = contact.name;
                        this.bean.jobtitle = contact.jobtitle;
                        this.bean.contactid = contact.contactid
                        this.outerVisible = false;
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
                                this.oldClientList = response,
                                this.dialogVisible = true
                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                    },
                    //點擊公司 彈窗內
                    clickClient: function (s) {
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
                        this.clientList = [];
                        this.oldClientList.forEach(e => {
                            if (e.name.indexOf(this.inclient) > 0 || e.name.indexOf(this.inclient) == 0) {
                                this.clientList.push(e);
                            }
                        });

                        // $.ajax({
                        //     url: '${pageContext.request.contextPath}/CRM/selectclientResponseBody/' + this.inclient,
                        //     type: 'POST',
                        //     async: false,//同步請求
                        //     cache: false,//不快取頁面
                        //     success: (response => (
                        //         this.clientList = response.data

                        //     )),
                        //     error: function (returndata) {
                        //         console.log(returndata);
                        //     }
                        // });
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

                        console.log(this.bean.aaa);

                        if (this.bean.aaa == null) {
                            var day = new Date();
                        } else {
                            var day = new Date(this.bean.aaa);
                        }
                        var day = new Date(this.bean.aaa);
                        if (this.bean.createtime == "轉賣") day.setDate(day.getDate() + 7);
                        if (this.bean.createtime == "自用") day.setDate(day.getDate() + 7);
                        if (this.bean.createtime == "設計/預算規劃") day.setDate(day.getDate() + 14);
                        if (this.bean.createtime == "工程標案") day.setDate(day.getDate() + 30);
                        this.bean.endtime = formatDay(day);
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
                                }
                                ;
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

                        window.open("${pageContext.request.contextPath}/file/" + file.url);
                    },
                    beforeRemove(file, fileList) {
                        return this.$confirm(`確定刪除 ${file.name}?`);
                    },
                    onsuccess(response, file, fileList) {
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
                    },
                    printTable() {
                        window.open('${pageContext.request.contextPath}/Market/MarketPrint.jsp?id=' + this.bean.marketid)
                    },
                    //階段下一步
                    nextState() {
                        this.stateNum++;
                    },
                    //測回 或 失敗結案 快捷鍵
                    BosOperate(state) {
                        this.bean.stage = state;
                        this.submitForm();
                    },
                    //送出留言
                    sendBosMessage() {
                        const data = {
                            "message": this.bosMassage,
                            "admin": '${user.name}',
                            "bosmessage": '${bean.customerid}'
                        }
                        axios
                            .post('${pageContext.request.contextPath}/SaveMessage', data)
                            .then(
                                response => (
                                    console.log(response.data),
                                    this.bosMassageList = response.data
                                ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    //
                    showbosMassage() {//點擊留言 顯示區塊

                        $('.bosMessagediv').toggle();
                        $('.act').hide();
                    },
                    reomveBosMessage(bosmessageid) {//刪除主管留言
                        console.log(bosmessageid);
                        axios
                            .post('${pageContext.request.contextPath}/reomveBosMessage/' + bosmessageid)
                            .then(
                                response => (
                                    this.bosMassageList = response.data
                                ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    //失去焦點,儲存
                    chageToSave(field, val) {
                        if (this.bean.marketid) {//有id有案件

                            var oldstage = this.oldBean.stage

                            //儲存改變
                            // if (this.oldBean[field] != val) {
                            //     var data = new FormData();
                            //     data.append("marketid", this.bean.marketid);
                            //     data.append("field", field);
                            //     data.append("val", val);
                            //     this.saveChage(data);
                            // }



                            // if (field == "stage" && this.bean.stage == "成功結案") {
                            //     this.bean.closereason = "成功結案";
                            // var data = new FormData();
                            // data.append("marketid", this.bean.marketid);
                            // data.append("field", "closereason");
                            // data.append("val", "成功結案");
                            // this.saveChage(data);
                            // }




                            //如果是復活
                            if (field == "stage" && oldstage == "失敗結案") {
                                this.bean.closereason = "失敗復活";
                                // var data = new FormData();
                                // data.append("marketid", this.bean.marketid);
                                // data.append("field", "closereason");
                                // data.append("val", "失敗復活");
                                // this.saveChage(data);

                            }
                            //如果私敗
                            if (field == "stage" && this.bean.stage == "失敗結案") {
                                this.bean.closereason = "其他";
                                // var data = new FormData();
                                // data.append("marketid", this.bean.marketid);
                                // data.append("field", "closereason");
                                // data.append("val", "其他");
                                // this.saveChage(data);

                            }
                            console.log(this.bean.closereason)
                        }
                    }, saveChage(data) {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/blur',
                            type: 'POST',
                            data: data,
                            async: false,
                            cache: false,
                            contentType: false,
                            processData: false,
                            success: (response => (

                                this.$message({
                                    message: '儲存 ' + data.get("field") + " = " + data.get("val"),
                                    type: 'success'
                                }),
                                this.oldBean = Object.assign({}, this.bean)


                            )),
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        })
                    },//領取任務
                    clickReceive() {
                        if ('${bean.marketid}' == '') {
                            this.$message({
                                message: '請先建立任務',
                                type: 'error'
                            });
                            return;
                        }
                        if ('${bean.marketid}' == '') {
                            this.$message({
                                message: '請先建立任務',
                                type: 'error'
                            });
                            return;
                        }

                        this.$confirm('會刷新頁面,請先確認資料已儲存', '警告', {
                            confirmButtonText: '確定',
                            cancelButtonText: '取消',
                            type: 'error'
                        }).then(() => {

                            let data = new FormData($(".basefrom")[0]);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/Market/getReceive/${bean.marketid}',
                                type: 'post',
                                data: data,
                                async: false,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: (response => {
                                    this.$message.error(response.message);
                                    if (response.code == 200) {
                                        location.href = "${pageContext.request.contextPath}/Market/Market/${bean.marketid}";
                                    }
                                }),
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            })
                        }).catch(() => {
                            this.$message({
                                type: 'info',
                                message: '已領取删除'
                            });
                        });
                    },
                    //分配人員 (receive 設為null)
                    changeUser() {
                        this.bean.receive = null;
                        if (this.bean.user != '無') {
                            this.bean.receivestate = 2;
                        } else {
                            this.bean.receivestate = 3;
                        }

                    }
                },
            })
            function formatDay(day) {
                let a = day.getMonth() + 1;
                let mon = a + "";
                let b = day.getDate();
                let d = (b + "").padStart(2, "0");
                return day.getFullYear() + "-" + mon.padStart(2, "0") + "-" + d;
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

            .el-date-editor.el-input {
                width: 100%;
            }

            ol li .el-button {
                padding: 0px;
            }
        </style>

        </html>