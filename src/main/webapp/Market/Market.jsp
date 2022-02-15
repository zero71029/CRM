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
                                    class="basefrom g-3 ">
                                    <input type="hidden" name="customerid" value="${bean.customerid}">
                                    <input type="hidden" name="aaa" value="${bean.aaa}">
                                    <div class="row">
                                        <input type="hidden" name="marketid" value="${bean.marketid}">
                                        <div class="row" style="text-align: center;">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-6 bg-danger text-white"
                                                style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;">
                                                基本資料</div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">機會名稱 <span style="color: red;">*</span></div>
                                            <div class="col-md-5 FormPadding">
                                                <input type="text" class=" form-control cellFrom" name="name"
                                                    style="width: 100%;" value="${bean.name}" maxlength="20" required>
                                            </div>
                                        </div>



                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">公司名<span style="color: red;">*</span></div>
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
                                            <div class="col-md-1 cell">負責人</div>
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
                                                <select name="type" class=" form-select cellFrom" v-model="type">
                                                    <option v-for="(item, index) in typeList" :key="index">{{item}}
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

                                            <div class="col-md-1 cell">聯絡人Email</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class="col-md- form-control cellFrom"
                                                    name="contactemail" value="${bean.contactemail}" maxlength="50">
                                            </div>
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell">重要性</div>
                                            <div class="col-md-2 FormPadding">
                                                <select class="form-select cellFrom" name="important"
                                                    v-model="important">
                                                    <option value="高">高</option>
                                                    <option value="中">中</option>
                                                    <option value="低" >低</option>
                                                    <option value="無">無</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-1 cell"></div>
                                            <div class="col-md-2 FormPadding">
                                            </div>

                                            <div class="col-md-1 cell">Line</div>
                                            <div class="col-md-2 FormPadding">
                                                <input type="text" class="form-control cellFrom" name="line"
                                                    v-model="line" maxlength="200">
                                            </div>
                                        </div>
                                        <!-- ////////////////////////////////////////////////////////////////////////////////// -->
                                        <div class="row">&nbsp;</div>
                                        <div class="row" style="text-align: center;">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-6 bg-danger text-white"
                                                style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;">
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
                                                <el-rate v-model="value"
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
                                            <div class="col-md-1 cell">描述<span style="color: red;">*</span></div>
                                            <div class="col-md-5 FormPadding">
                                                <textarea name="message" class="col-md-12" id="message" maxlength="9000"
                                                    style=" height:75px;" required>${bean.message}</textarea>
                                            </div><br><br>
                                        </div>
                                        <p>&nbsp;</p>
                                        <div class="row">
                                            <div class="col-md-3"></div>
                                            <div class="col-md-6 FormPadding">
                                                <button type="submit" style="width: 100%;" class="btn btn-danger"
                                                    onclick="return window.confirm('確定修改')">儲存</button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <!-- ///////////////////////////////////////////////////////////////////////////// -->
                                <hr>

                                <!-- ////////////////////////////////////////追蹤資訊///////////////////////////////////// -->
                                <br><br><br>
                                <c:if test="${not empty bean}">
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-9 bg-danger text-white"
                                            style="text-align: center; color: white;">
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
                                    <form action="" method="post" id="SaveTrack" class="row g-3 needs-validation"
                                        novalidate>
                                        <input type="hidden" class=" form-control cellFrom" name="remark"
                                            maxlength="190" value="${user.name}">
                                        <input type="hidden" name="customerid" value="${bean.customerid}">
                                        <div class="row">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-4 FormPadding">
                                                <textarea class="form-control" name="trackdescribe" rows="1"
                                                    maxlength="190" required></textarea>
                                            </div>
                                            <div class="col-md-4 FormPadding">
                                                <textarea class="form-control" name="result" rows="1"
                                                    maxlength="95"></textarea>
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
                                                    <div class="col-md-4"
                                                        style="position: relative; word-wrap:break-word;">
                                                        {{s.trackdescribe}}
                                                    </div>
                                                    <div class="col-md-4"
                                                        style="position: relative; word-wrap:break-word;">
                                                        {{s.result}}
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
                                                    <el-button v-show="s.remark == '${user.name}'" type="text"
                                                        @click="open(s)">
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
                                                <c:forEach varStatus="loop" begin="0" end="${s.file.size()-1}"
                                                    items="${s.file}" var="file">
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
                                                            <el-button v-show="remark.name == '${user.name}'"
                                                                type="text" @click="removeTrackremark(remark)">刪除
                                                            </el-button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <br>
                                <br><br><br><br><br>
                                <div class="row">&nbsp;</div>
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
                                    <div class="col-md-2">紀錄</div>
                                    <div class="col-md-2">留言</div>
                                </div>
                            </div>
                        </c:if>
                        <!-- <%-- 動作區塊結束/////////////////////////////////////--%> -->
                    </div>
                </div>
            </div>
            </div>
        </body>
        <script>
            // console.log("${bean}");
            //    動作區塊
            $("#draggable").draggable();

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



            function clickContact(name, phone, moblie) {
                vm.contactphone = phone;
                vm.contactmoblie = moblie;
                $("input[name='contactname']").val(name);
                // $("input[name='contactphone']").val(phone);
                // $("input[name='contactmoblie']").val(moblie);
                vm.outerVisible = false;
            }

            function catbtn() {
                $("input[name='contactname']").val($("input[name='catin']").val());
                vm.contactphone = "";
                vm.contactmoblie = "";



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
                        important: '${bean.important}',
                        line: '${bean.line}',
                        type: "${bean.type}",//產業
                        typeList: ["尚未分類",
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
                        TrackList: {},
                    }
                },
                created() {
                    this.show = true;
                    this.loading = false;
                    this.phone = formatPhone(this.phone);
                    this.contactphone = formatPhone(this.contactphone);
                    this.contactmoblie = formatPhone(this.contactmoblie);
                    if (this.important == "") this.important = '低';
                    if ('${bean.customerid}' != '') {//追蹤資訊
                        axios
                            .get('${pageContext.request.contextPath}/Potential/client/${bean.customerid}')
                            .then(response => (
                                this.TrackList = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    }
                },
                methods: {
                    open(s) {//修改追蹤資訊
                        this.$alert('<form action="${pageContext.request.contextPath}/Market/changeTrackByMarket/${bean.marketid}" method = "post" >\
                                                    <div class="row">\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="trackdescribe" rows="1"\
                                                                maxlength="190" required>'+ s.trackdescribe + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="result" rows="1"\
                                                                maxlength="195">'+ s.result + '</textarea>\
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
                            confirmButtonText: '缺定',
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
                            confirmButtonText: '缺定',
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
                                console.log(this.TrackList)
                            ))
                            .catch(function (error) {
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

                },
            })


        </script>

        <style>
            .el-message-box {
                width: 50%;
            }
        </style>






        </html>