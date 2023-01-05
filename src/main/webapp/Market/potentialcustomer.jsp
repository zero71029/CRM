<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">


            <title>CRM客戶管理系統</title>
        </head>
        <style>
            .error {
                color: red;
            }

            .customerbar {
                /* 按鈕顏色 */
                background-color: #afe3d5;
            }

            .cellz {
                /* 標題顏色 */
                border: 0px solid black;
                border-bottom: 1px solid black;
                background-color: #CCC;
            }

            div .cellFrom {
                border: 0px;

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
                width: 560px;
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
                width: 560px;
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

            /*留言區塊*/
            .box .bosMessagediv {
                position: absolute;
                width: 505px;
                bottom: 0px;
                right: 20px;
                padding: 0%;
            }

            .box .act {
                position: absolute;
                background-color: #aaa;
                width: 505px;
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
            [v-cloak] {
                display: none;
            }
        </style>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- 台灣縣市二聯式選單 -->
                    <script src="${pageContext.request.contextPath}/js/jquery.twzipcode.min.js"></script>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.bundle.min.js"></script>
                    <div class="col-md-11 app" v-cloak>
                        <!-- <%-- 中間主體--%> -->
                        <br>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <h3>潛在客戶</h3>
                            </div>
                        </div>
                        <!-- 上一頁 -->
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-1 btn men">
                                <a href="${pageContext.request.contextPath}/Market/potentialcustomerList.jsp">＜</a>
                            </div>
                        </div>
                        <br>
                        <form action="${pageContext.request.contextPath}/Market/SavePotentialCustomer" method="post"
                            class="basefrom g-3 needs-validation AAA" novalidate id="basefrom">
                            <input type="hidden" name="customerid" value="${bean.customerid}">
                            <input type="hidden" name="aaa" value="${bean.aaa}">
                            <input type="hidden" name="opentime" value="${bean.opentime}">
                            <input type="hidden" name="fromactivity" value="${bean.fromactivity}">
                            <input type="hidden" name="fileforeignid" v-model="customer.fileforeignid">
                            <input type="hidden" name="founder" v-model="customer.founder">
                            <input type="hidden" name="contactid" v-model="customer.contactid">
                            <div class="row">
                                <!-- 基本資料 -->
                                <div class="col-md-7">
                                    <div class="row" style="text-align: center;">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-10 bg-warning text-white"
                                            style="background-color: rgb(36, 101, 164);font-size: 1.5rem;color: white;border-radius: 5px 5px 0 0 ;">
                                            基本資料
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">公司<span style="color: red;">*</span></div>
                                        <div class="col-md-8 cellz FormPadding">
                                            <div class="input-group ">
                                                <input type="text" class="col-md-9 form-control cellFrom client"
                                                    @blur="changeCompany" v-model.trim="companyName" name="company"
                                                    list="company" maxlength="100" required>
                                                <datalist id="company">
                                                    <c:if test="${not empty client}">
                                                        <c:forEach varStatus="loop" begin="0" end="${client.size()-1}"
                                                            items="${client}" var="s">
                                                            <option value="${s.name}">
                                                        </c:forEach>
                                                    </c:if>
                                                </datalist>

                                                <input type="text" class="form-control" placeholder="編號"
                                                    v-model.trim="customer.serialnumber" name="serialnumber" value="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">聯絡人 {{customer.contactid}}<span
                                                style="color: red;">*</span></div>

                                        <div class="col-md-2 FormPadding">
                                            <select name="contacttitle" class="form-select cellzFrom"
                                                v-model="customer.contacttitle">
                                                <option value="">稱謂</option>
                                                <option value="Mr">Mr</option>
                                                <option value="Ms">Ms</option>
                                                <option value="DR">DR</option>
                                                <option value="Assoc. Prof">Assoc. Prof</option>
                                                <option value="Prof.">Prof.</option>
                                            </select>
                                        </div>


                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="name"
                                                v-model.trim="customer.name" maxlength="20" required list="contactList">
                                            <datalist id="contactList">
                                                <option v-for="(s, index) in contactList" :key="index" :value="s.name">
                                            </datalist>
                                        </div>

                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="jobtitle"
                                                placeholder="職稱" v-model.trim="customer.jobtitle" maxlength="20">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">電話<span style="color: red;">*</span></div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class="form-control ppp" name="phone"
                                                v-model.trim=" customer.phone" maxlength="20">
                                            <input type="text" class="form-control" name="extension" placeholder="分機"
                                                maxlength="10" v-model.trim="customer.extension">
                                        </div>
                                        <div class="col-md-2 cellz">聯絡方式</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" v-model.trim="customer.companynum"
                                                class=" form-control cellFrom" name="companynum" maxlength="20"
                                                list="contactmethod">
                                            <datalist id="contactmethod">
                                                <c:forEach varStatus="loop" begin="0" end="${library.size()-1}"
                                                    items="${library}" var="s">
                                                    <c:if test='${s.librarygroup == "contactmethod"}'>
                                                        <option value="${s.libraryoption}">${s.libraryoption}
                                                        </option>
                                                    </c:if>
                                                </c:forEach>
                                            </datalist>
                                            <input type="text" class="form-control" name="" placeholder=""
                                                maxlength="10">

                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">手機<span style="color: red;">*</span></div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="moblie"
                                                v-model.trim="customer.moblie" maxlength="20">
                                        </div>

                                        <div class="col-md-2 cellz">部門</div>
                                        <div class="col-md-3 cellz FormPadding"><input type="text"
                                                class=" form-control cellFrom" name="department"
                                                v-model.trim="customer.department" maxlength="20">
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">Email<span style="color: red;">*</span></div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="email" class=" form-control cellFrom" name="email"
                                                v-model.trim="customer.email" maxlength="50">
                                        </div>
                                        <div class="col-md-2 cellz">主管</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="director"
                                                v-model.trim="customer.director" maxlength="20">
                                        </div>


                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">Line</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="line"
                                                v-model.trim="customer.line" maxlength="190">
                                        </div>


                                        <div class="col-md-2 cellz">產業</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <select name="industry" class=" form-select cellFrom"
                                                v-model="customer.industry">
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
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">傳真</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="fax"
                                                v-model.trim="customer.fax" maxlength="20">
                                        </div>
                                        <div class="col-md-2 cellz">來源 <span style="color: red;">*</span></div>
                                        <div class="col-md-3 cellz FormPadding ">
                                            <select class="form-select cellFrom " id="source" name="source"
                                                v-model.trim="customer.source">
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



                                    <div class="row" v-show="customer.source == '其他'">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz"></div>
                                        <div class="col-md-3 cellz FormPadding">

                                        </div>
                                        <div class="col-md-2 cellz">其他來源 </div>
                                        <div class="col-md-3 cellz FormPadding ">
                                            <input type="text" class=" form-control cellFrom" name="othersource"
                                                v-model.trim="customer.othersource" maxlength="20">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">縣市</div>
                                        <div class="col-md-8 ">
                                            <div class="row" id="twzipcode"></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">地址</div>
                                        <div class="col-md-8 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="address"
                                                v-model.trim="customer.address" maxlength="50">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">客人詢問 <span style="color: red;">*</span></div>
                                        <div class="col-md-8 cellz FormPadding">

                                            <el-input type="textarea" v-model="customer.remark" rows="5" id="remark"
                                                maxlength="600" show-word-limit name="remark"
                                                @input="changeTextarea('remark')">


                                        </div>
                                    </div>

                                </div>
                                <!-- 右邊區塊 -->
                                <div class="col-md-5  ASDFG">
                                    <div class="row">
                                        <div class="col-md-3 " style="line-height: 30px;"></div>
                                        <div class="col-md-4  FormPadding ">


                                            <!-- <div class="receive" v-show="customer.receive == '${user.name}'  "
                                                style="color: #0d6efd;cursor: pointer;line-height: 30px;"
                                                @click="clickReceive">取消任務</div> -->
                                            <div class="receive" v-show="customer.receivestate == '3' "
                                                style="color: #0d6efd;cursor: pointer;line-height: 30px;"
                                                @click="clickReceive">領取任務</div>




                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-3 cellz" style="line-height: 30px;">潛在客戶負責人</div>
                                        <div class="col-md-4 cellz FormPadding">
                                            <input type="hidden" name="receive" v-model='customer.receive'>
                                            <input type="hidden" name="receivestate" v-model="customer.receivestate">


                                            <c:set var="salary"
                                                value="${user.position == '職員' || user.position == '新'}">
                                            </c:set>

                                            <c:if test="${salary}">
                                                <input type="hidden" name="user" v-model.trim="customer.user">
                                                {{customer.user}}
                                            </c:if>

                                            <c:if test="${!salary}">

                                                <select name="user" class="form-select cellFrom" v-model="customer.user"
                                                    @change="changeUser">
                                                    <option value="無">無</option>
                                                    <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                        items="${admin}" var="s">
                                                        <c:if test="${s.department == '業務' }">
                                                            <option value="${s.name}">
                                                                ${s.name}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                    <option value="系統管理"> 系統管理</option>
                                                </select>
                                            </c:if>

                                        </div>
                                    </div>




                                    <div class="row">

                                        <div class="col-md-3 cellz" style="font-size: 14px;">建立時間</div>
                                        <div class="col-md-7  FormPadding">
                                            ${bean.aaa}
                                            <el-tag v-show="customer.receivestate == 1">領取</el-tag>

                                            <el-tag type="danger" v-show="customer.receivestate == 2">分配</el-tag>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3 cellz">狀態</div>
                                        <div class="col-md-4 cellz FormPadding">
                                            <select name="status" class="form-select cellFrom" @change="changeStatus"
                                                v-model="customer.status">
                                                <option value="未處理">未處理
                                                </option>
                                                <option value="已聯繫">已聯繫
                                                </option>
                                                <option value="提交主管">不合格:提交主管</option>
                                                <c:if test="${user.position != '職員' }">
                                                    <option value="不合格">不合格
                                                    </option>
                                                </c:if>
                                                <option value="合格">合格</option>
                                            </select>
                                        </div>


                                        <c:if test="${user.position != '職員' }">

                                            <div class="col-md-5" v-show="customer.status  =='提交主管'">
                                                <el-button size="mini" type="primary" @click="BosOperate('已聯繫')">
                                                    撤回
                                                </el-button>
                                                <el-button size="mini" type="primary" @click="BosOperate('不合格')">
                                                    失敗結案
                                                </el-button>
                                            </div>
                                        </c:if>
                                    </div>

                                    <a href=""></a>




                                    <div class="row" v-show="customer.status == '不合格' || customer.status == '提交主管'">

                                        <div class="col-md-3 cellz">
                                            結案理由
                                            <span style="color: red;">*</span>
                                        </div>
                                        <div class="col-md-4 FormPadding" id="closereason">
                                            <select class="form-select cellzFrom" name="closereason"
                                                v-model.trim="customer.closereason">
                                                <c:forEach varStatus="loop" begin="0" end="${library.size()-1}"
                                                    items="${library}" var="s">
                                                    <c:if test='${s.librarygroup == "closereason"}'>
                                                        <option value="${s.libraryoption}">${s.libraryoption}
                                                        </option>
                                                    </c:if>
                                                </c:forEach>
                                                <option value="其他"> 其他 </option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row"
                                        v-show="(customer.status == '不合格' || customer.status == '提交主管') && customer.closereason == '其他'">

                                        <div class="col-md-3 cellz">
                                            其他結案理由 </div>
                                        <div class="col-md-4 FormPadding">
                                            <input type="text" class="form-control" name="closeextend"
                                                v-model="customer.closeextend">
                                        </div>
                                    </div>





                                    <div class="row">
                                        <div class="col-md-3 cellz">重要性 <span style="color: red;">*</span></div>
                                        <div class="col-md-4 cellz FormPadding">
                                            <select class="form-select cellFrom" name="important"
                                                v-model.trim="important">
                                                <option value="高">高</option>
                                                <option value="中">中</option>
                                                <option value="低">低</option>
                                                <option value="無">無</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-md-3 cellz" v-if="customer.founder != null">創建人</div>
                                        <div class="col-md-4 FormPadding">
                                            {{customer.founder}}
                                        </div>
                                    </div>
                                    <br>
                                    <c:if test='${not empty marketid}'>
                                        <div class="row">
                                            <div class="col-md-12 " v-if="customer.founder != null">
                                                <a
                                                    href="${pageContext.request.contextPath}/Market/Market/${marketid}">前往銷售機會</a>
                                            </div>
                                        </div>
                                    </c:if>


                                    <br>
                                    <div class="row">
                                        <div class="col-md-10">
                                            <el-upload class="upload-demo"
                                                :action="'${pageContext.request.contextPath}/upFileByMarket?authorizeId='+customer.fileforeignid"
                                                :on-preview="handlePreview" :on-remove="handleRemove"
                                                :before-remove="beforeRemove" multiple :on-success="onsuccess"
                                                :file-list="customer.marketfilelist">
                                                <el-button size="small" type="primary">上傳附件</el-button>
                                            </el-upload>
                                        </div>
                                    </div>

                                    <!--各行業氣體查詢  -->
                                    <br>
                                    <div class="row">
                                        <div class="col-md-7  bg-warning text-white"
                                            style="font-size: 1.5rem;border-radius: 5px 5px 0 0 ;">
                                            各行業氣體查詢
                                        </div>
                                    </div>
                                    <div class="row">

                                        <div class="col-md-7 " style="padding: 0%;">
                                            <el-input v-model="InGasIndustry" placeholder="行業" @change="changeGasDetection"
                                                list="GasIndustry"></el-input>
                                            <datalist id="GasIndustry">
                                                <option :value="s" v-for="(s, index) in GasIndustry" :key="index">
                                                </option>
                                            </datalist>
                                        </div>
                                    </div>
                                    <div class="row" v-if="GasIndustry.includes(InGasIndustry)">

                                        <div class="col-md-7 " style="padding: 0%;">
                                            <el-select v-model="InGasDetection" placeholder="應用" style="width: 100%;" >
                                                <el-option :value="s.application" v-for="(s, index) in GasDetection"
                                                    :key="index" v-if="s.Industry == InGasIndustry"></el-option>
                                            </el-select>
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row" v-if="GasIndustry.includes(InGasIndustry)">
                                        <div class="col-md-12 ">
                                            <span v-for="(s, index) in GasDetection"
                                                v-if="s.Industry == InGasIndustry && s.application  == InGasDetection">{{s.gas}}</span>
                                        </div>
                                    </div>
                                    <!--各行業氣體查詢  結束-->
                                </div>
                                <p>&nbsp;</p>
                                <div class="row">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5 FormPadding">
                                        <button type="button" style="width: 100%;color: white; " class="btn btn-warning"
                                            @click="submitForm" id="saveButton">儲存
                                        </button>
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
                            <!-- -->
                            <form action="${pageContext.request.contextPath}/Market/SaveTrack" method="post"
                                class="row g-3 needs-validation" novalidate>
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
                                        <el-input type="textarea" :autosize="{ minRows: 4}" v-model="result"
                                            show-word-limit name="result" maxlength="950" id="result">
                                        </el-input>
                                    </div>
                                    <div class="col-md-1" style="padding: 0%;">
                                        <button style="width: 100%; background-color: #569b92;"
                                            class="btn btn-outline-dark" onclick="">新增
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <!-- -->
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
                                            </div>
                                            <div class="col-md-4" style="position: relative; word-wrap:break-word;"
                                                v-html="s.result">
                                            </div>
                                            <div class="col-md-3" style="color: #569b92;">
                                                {{s.remark}} {{s.tracktime}}
                                            </div>
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
                                                修改
                                            </el-button>&nbsp;&nbsp;&nbsp;
                                            <el-button v-show="s.remark == '${user.name}'" type="text"
                                                @click="removeTrack(s)">刪除
                                            </el-button>&nbsp;&nbsp;&nbsp;
                                            <el-button type="text" @click="trackremark(s.trackid)">回覆</el-button>
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
                        </c:if>
                        <br>
                        <br><br><br><br><br>
                        <div class="row">&nbsp;</div>
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
                                                            @click="reomveBosMessage(s.bosmessageid)"></td>
                                                </tr>
                                            </table>
                                        </el-card>
                                    </div>
                                    <%-- 行動區塊--%>
                                        <div class="row act" style="height: 30px;">

                                            <a class="col-md-3" href="#" onclick="goClient()">轉成客戶</a>
                                            <a class="col-md-3" href="#" onclick="goContact()">建立聯絡⼈</a>
                                            <a class="col-md-3" href="#" onclick="NotExistMarket()">新增銷售機會</a>
                                            <a class="col-md-3" href="#" onclick="goWork()">新增工作項目</a>
                                        </div>
                                        <div class="dockbar row shadow  ">
                                            <div class="col-md-2 offset-md-1" style="border-left: black 1px solid;"
                                                id="act"
                                                onclick="javascript:$('.act').toggle();$('.bosMessagediv').hide();">
                                                行動
                                            </div>
                                            <div class="col-md-2" @click="changeTableVisible = true">
                                                紀錄
                                            </div>
                                            <div class="col-md-2" v-on:click="showbosMassage">留言 <span
                                                    class="badge rounded-pill bg-danger">{{bosMassageList.length ==
                                                    0?"":bosMassageList.length}}</span></div>
                                            <div :class="CallHelpCSS" @click="CallHelp">求助</div>
                                        </div>

                            </div>
                        </c:if>
                        <!-- 修改紀錄Table 彈窗-->
                        <el-dialog title="修改紀錄" :visible.sync="changeTableVisible">
                            <el-table :data="changeMessageList" height="450">
                                <el-table-column property="name" label="姓名"></el-table-column>
                                <el-table-column property="filed" label="欄位"></el-table-column>
                                <el-table-column property="source" label="原本"></el-table-column>
                                <el-table-column property="after" label="修改後"></el-table-column>
                                <el-table-column property="createtime" label="日期" width="120">
                                </el-table-column>
                            </el-table>
                        </el-dialog>
                        <!-- 合格  彈窗-->
                        <el-dialog title="提示" :visible.sync="changeStatusVisible" width="30%">

                            <div class="row">
                                <div class="col-lg-12">
                                    <button style="width: 100%;" onclick="NotExistMarket()">轉銷售機會
                                    </button>
                                </div>
                                <div class="col-lg-12">
                                    <button style="width: 100%;" @click="changeStatusVisible=false;submitForm()">不轉銷售
                                    </button>
                                </div>
                                <div class="col-lg-12">
                                    <button style="width: 100%;" @click="changeStatusVisible=false">取消
                                    </button>
                                </div>
                            </div>

                        </el-dialog>
                    </div>


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

            $(function () {
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
                $("select[name='city']").attr("v-model.trim", "city");
            });

            function delRemark(id) {
                if (confirm("確定刪除?")) {
                    window.location.href = "${pageContext.request.contextPath}/Market/delRemark/" + id + "/${bean.customerid}";
                }
            }


            //建立客戶
            function goClient() {
                var formData = new FormData($(".AAA")[0]);
                console.log(formData.values());
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/existsClient',
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (json) {
                        if (json == "客戶已存在") {
                            vm.$message({
                                message: json,
                                type: 'warning'
                            });
                            return;
                        }
                        if (json == "不存在") {

                            $.ajax({
                                url: '${pageContext.request.contextPath}/Market/changeClient.action',
                                type: 'POST',
                                data: formData,
                                async: false,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (url) {
                                    vm.$message({
                                        message: url,
                                        type: 'success'
                                    });
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            });
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
                    url: '${pageContext.request.contextPath}/Market/existsContact',
                    type: 'POST',
                    data: formData,
                    async: false,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: json => {
                        console.log(json)
                        if (json.code == 200) {

                            vm.customer.contactid = json.data;
                            vm.$message({
                                message: json.message,
                                type: 'warning'
                            });
                            return;
                        }

                        if (json.code == 300) {
                            if (json.message == "公司不存在") {
                                vm.$message({
                                    message: "公司不存在,請先轉客戶",
                                    type: 'warning'
                                });
                                return;
                            }

                            if (json.message == "不存在") {
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/Market/changeContact.action',
                                    type: 'POST',
                                    data: formData,
                                    async: false,
                                    cache: false,
                                    contentType: false,
                                    processData: false,
                                    success: function (json) {

                                        vm.customer.contactid = json.data;
                                        vm.$message({
                                            message: json.message,
                                            type: 'success'
                                        });
                                    },
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                });
                                return;
                            }
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

            //新增銷售機會
            function goMarket() {
                vm.customer.status = "合格";
                goClient();
                window.setTimeout(function () {
                    goContact();
                }, 300);
                window.setTimeout(function () {
                    //存潛在客戶
                    var formData = new FormData($(".AAA")[0]);
                    $.ajax({
                        url: '${pageContext.request.contextPath}/Market/SavePotentialCustomer',
                        type: 'POST',
                        data: formData,
                        async: false,
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function (response) {
                            if (response.state) {
                                vm.$message({
                                    message: "儲存成功",
                                    type: 'success'
                                });
                                //轉銷售機會
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/Market/existsClient',
                                    type: 'POST',
                                    data: formData,
                                    async: false,
                                    cache: false,
                                    contentType: false,
                                    processData: false,
                                    success: function (json) {
                                        if (json == "客戶已存在") {
                                            $(".AAA").attr("action", "${pageContext.request.contextPath}/Market/changeMarket");
                                            $(".AAA")[0].submit();
                                            return;
                                        }
                                        if (json == "不存在") {
                                            vm.$message({
                                                message: "需先新增客戶",
                                                type: 'warning'
                                            });
                                            return;
                                        }
                                        if (json == "聯絡人不存在") {
                                            vm.$message({
                                                message: "需先新增聯絡人",
                                                type: 'warning'
                                            });
                                            return;
                                        }
                                        alert("錯誤");
                                    },
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                });
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
                }, 600);
            }
            //檢查有無銷售機會
            function NotExistMarket() {
                var formData = new FormData($(".AAA")[0]);
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/existMarket/${bean.customerid}',
                    async: false,
                    cache: false,
                    success: url => {
                        if (url) {//有資料提示   沒資料去儲存
                            vm.$message.error('錯誤 ,已經轉過了');
                        } else {
                            goMarket()
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }


            // 添加協助者
            function addHelper() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/Potential/addHelper/${bean.customerid}/' + $("[name='helper']").val(),
                    type: 'POST',
                    success: function (json) {
                        $(".helpList").empty();
                        for (var h of json) {
                            $(".helpList").append('<li ">' + h.name + '<a style="right: 0px; position: absolute;" href="javascript:delHelp(`' + h.helperid + '`)" >remove</a></li>')
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
                    url: '${pageContext.request.contextPath}/Potential/delHelper/${bean.customerid}/' + helperid,
                    type: 'POST',
                    success: function (json) {
                        $(".helpList").empty();
                        for (var h of json) {
                            $(".helpList").append('<li ">' + h.name + '<a style="right: 0px; position: absolute;" href="javascript:delHelp(`' + h.helperid + '`)" >remove</a></li>')
                        }
                    },
                });
            }

            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            const vm = new Vue({
                el: '.app',
                data() {
                    return {
                        result: "",
                        trackdescribe: "",
                        changeStatusVisible: false,//合格彈窗
                        fileList: [],
                        CallHelpCSS: "col-md-2",//求助CSS
                        isEligible: false,
                        changeTableVisible: false,//修改紀錄彈窗
                        changeMessageList: [],//修改資訊
                        oldCustomer: {},//暫存表
                        customer: {
                            fileforeignid: Math.random() * 1000,
                            contacttitle: "",
                            source: "其他",
                            industry: "尚未分類",
                            receivestate: 3,
                            contactid: 0,

                        },//bean
                        bosMassage: "",//主管留言欄位
                        bosMassageList: [],//組長留言資料
                        companyName: "${bean.company}",
                        contact: {},
                        company: {},
                        name: "${bean.name}",//聯絡人名稱
                        visible: false,
                        admin: '${user.name}',//使用者名稱
                        important: '${bean.important}',
                        industry: "${bean.industry}",//產業
                        industryList: ["尚未分類",
                            "農、林、漁、牧業",
                            "礦業及土石採取業",
                            "製造業",
                            "電子及半導體設備製造",
                            "機械設備製造業",
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
                        contactList: [],

                        // 各行業氣體查詢
                        InGasIndustry: "",
                        InGasDetection: "",
                        GasIndustry: ["航天/國防", "農業", "汽車", "航空", "化工", "塗料和印刷粘合劑", "食品與飲料",
                            "鑄造廠", "燃料電池製造", "危險品", "重型製造", "暖通空調", "室內空氣質量",
                            "鋼鐵", "醫療", "礦業", "石油和天然氣", "紙漿", "製藥", "發電"
                            , "半導體工廠", "造船廠/海洋", "水和廢水", "焊接",],
                        GasDetection: [
                            { Industry: "航天/國防", application: "測試室/實驗室", gas: "可燃氣體 二氧化碳 一氧化氮 氧氣 製冷劑 甲苯" },
                            { Industry: "航天/國防", application: "廠房設施", gas: "可燃氣體 氧氣 製冷劑" },
                            { Industry: "航天/國防", application: "熱處理", gas: "可燃氣體 二氧化碳 氧氣" },
                            { Industry: "航天/國防", application: "發射台", gas: "可燃氣體 氨 氧氣 製冷劑" },
                            { Industry: "農業", application: "冷水機", gas: "氨 二氧化碳 製冷劑" },
                            { Industry: "農業", application: "水果儲藏區", gas: "氨 二氧化碳 乙烯 氧氣 製冷劑 揮發性有機化合物" },
                            { Industry: "農業", application: "溫室、筒倉和儲藏區", gas: "二氧化碳 乙烯 氧氣" },
                            { Industry: "農業", application: "叉車操作", gas: "可燃氣體 一氧化氮 二氧化氮" },
                            { Industry: "農業", application: "密閉空間（筒倉）", gas: "可燃氣體 二氧化碳 乙烯 一氧化氮 二氧化氮 氧氣" },
                            { Industry: "農業", application: "糧食儲藏加工", gas: "膦" },
                            { Industry: "農業", application: "禽舍", gas: "氨 二氧化碳 二氧化硫" },
                            { Industry: "農業", application: "熏蒸", gas: "二氧化碳 環氧乙烷 氰化氫 硫化氫 膦 二氧化硫" },
                            { Industry: "農業", application: "牲畜，石油提取過程", gas: "可燃氣體 氨" },
                            { Industry: "農業", application: "土壤施肥", gas: "氨" },
                            { Industry: "汽車", application: "研究和發展", gas: "可燃氣體 二氧化碳 一氧化碳 一氧化氮 二氧化氮 氧氣 製冷劑 二氧化硫 揮發性有機化合物" },
                            { Industry: "汽車", application: "發動機測試", gas: "可燃氣體 二氧化碳 一氧化碳 一氧化氮 二氧化氮 氧氣 製冷劑" },
                            { Industry: "汽車", application: "環境室", gas: "可燃氣體 二氧化碳 一氧化碳 環氧乙烷 氧氣 製冷劑" },
                            { Industry: "航空", application: "車身和發動機維修與保養", gas: "可燃氣體 一氧化碳 氰化氫 一氧化氮 二氧化氮 揮發性有機化合物" },
                            { Industry: "航空", application: "飛機機庫設施", gas: "可燃氣體 揮發性有機化合物" },
                            { Industry: "航空", application: "燃料和液壓油儲存", gas: "可燃氣體 揮發性有機化合物" },
                            { Industry: "航空", application: "泵送設施", gas: "可燃氣體 揮發性有機化合物" },
                            { Industry: "航空", application: "密閉空間（翼）艙維護", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣" },
                            { Industry: "航空", application: "噴氣燃料蒸汽、溶劑", gas: "可燃氣體 氨 二氧化氮 揮發性有機化合物" },
                            { Industry: "航空", application: "飛機零件製造", gas: "氰化氫 氧氣 揮發性有機化合物" },
                            { Industry: "化工", application: "一般檢漏工藝製造", gas: "可燃氣體 氨 二氧化碳 一氧化碳 氯 二氧化氯 乙烯 環氧乙烷 氯化氫 氰化氫 硫化氫 一氧化氮 二氧化氮 氧氣 膦 二氧化硫 揮發性有機化合物" },
                            { Industry: "化工", application: "密閉空間（液氮載體/儲罐維護、反應堆工作、隧道）", gas: "可燃氣體 二氧化碳 一氧化碳 硫化氫 氧氣" },
                            { Industry: "化工", application: "實驗室、精細化工製造", gas: "可燃氣體 氨 一氧化碳 氯 二氧化氯 乙烯 環氧乙烷 氰化氫 一氧化氮 二氧化氮 膦 製冷劑 揮發性有機化合物" },
                            { Industry: "化工", application: "製造，聚合物塑料，洩漏的過程製造", gas: "可燃氣體 氨 一氧化碳 乙烯 環氧乙烷 氰化氫 二氧化氮 氧氣 膦 揮發性有機化合物" },
                            { Industry: "化工", application: "有機合成操作、液固分離、清洗劑", gas: "可燃氣體 氨 一氧化碳 氯 二氧化氯 乙烯 環氧乙烷 氯化氫 硫化氫 揮發性有機化合物" },
                            { Industry: "化工", application: "一般檢漏、有機合成", gas: "可燃氣體 氨 一氧化碳 氯 二氧化氯 乙烯 環氧乙烷 氰化氫 一氧化氮 二氧化氮 揮發性有機化合物" },
                            { Industry: "化工", application: "紡織品", gas: "氨 氯 乙烯 氰化氫 硫化氫 一氧化氮 氧氣 二氧化硫" },
                            { Industry: "化工", application: "橡膠", gas: "可燃氣體 氨 氰化氫 硫化氫" },
                            { Industry: "化工", application: "倉儲倉庫", gas: "可燃氣體 氨 二氧化碳 一氧化碳 氯 二氧化氯 乙烯 環氧乙烷 氯化氫 氰化氫 硫化氫 一氧化氮 二氧化氮 氧氣 膦 製冷劑 甲苯 二氧化硫" },
                            { Industry: "化工", application: "溶劑回收", gas: "可燃氣體 揮發性有機化合物" },
                            { Industry: "化工", application: "儲罐", gas: "可燃氣體 氨 二氧化碳 一氧化碳 氯 二氧化氯 乙烯 氧氣 揮發性有機化合物" },
                            { Industry: "化工", application: "轉運區、裝卸區", gas: "可燃氣體 氨 二氧化碳 一氧化碳 氯 二氧化氯 乙烯 氧氣 揮發性有機化合物" },
                            { Industry: "塗料和印刷粘合劑", application: "印刷機外的生產車間", gas: "可燃氣體 氧氣 揮發性有機化合物" },
                            { Industry: "塗料和印刷粘合劑", application: "沖壓工序", gas: "可燃氣體 氧氣 揮發性有機化合物" },
                            { Industry: "食品與飲料", application: "冷藏設施及冷庫", gas: "氨 二氧化碳 乙烯 氧氣 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "水果儲藏區", gas: "氨 二氧化碳 乙烯 氧氣 製冷劑 " },
                            { Industry: "食品與飲料", application: "糧食加工", gas: "可燃氣體 二氧化碳 二氧化硫" },
                            { Industry: "食品與飲料", application: "食用油加工", gas: "可燃氣體" },
                            { Industry: "食品與飲料", application: "啤酒廠和釀酒廠", gas: "氨 二氧化碳 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "飲料裝瓶", gas: "氨 二氧化碳 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "發酵罐", gas: "氨 二氧化碳 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "冷藏設施、", gas: "氨 二氧化碳 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "肉類包裝", gas: "氨 二氧化碳 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "食品加工", gas: "氨 二氧化碳 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "加熱器和鍋爐", gas: "可燃氣體 一氧化碳 一氧化氮 二氧化氮" },
                            { Industry: "食品與飲料", application: "汽油動力設備、車輛和叉車", gas: "可燃氣體 一氧化碳 一氧化氮 二氧化氮" },
                            { Industry: "食品與飲料", application: "烘焙設施", gas: "可燃氣體 一氧化碳 一氧化氮 二氧化氮" },
                            { Industry: "食品與飲料", application: "冷卻器", gas: "可燃氣體 氨 一氧化碳 氧氣 製冷劑" },
                            { Industry: "食品與飲料", application: "密閉空間", gas: "可燃氣體 氨 一氧化碳 氧氣 製冷劑" },
                            { Industry: "食品與飲料", application: "廢水池、排水和排污區", gas: "可燃氣體 一氧化碳 硫化氫 氧氣 揮發性有機化合物" },
                            { Industry: "食品與飲料", application: "鍋爐和加熱器", gas: "可燃氣體 一氧化碳 硫化氫  揮發性有機化合物" },
                            { Industry: "食品與飲料", application: "食品包裝", gas: "可燃氣體 一氧化碳 硫化氫  揮發性有機化合物" },
                            { Industry: "食品與飲料", application: "發酵過程", gas: "氨 二氧化碳 一氧化碳 乙烯 氧氣 製冷劑" },
                            { Industry: "食品與飲料", application: "充氣食品包裝", gas: "氨 二氧化碳 一氧化碳 乙烯 氧氣 製冷劑" },
                            { Industry: "食品與飲料", application: "封閉的空間", gas: "氨 二氧化碳 一氧化碳 乙烯 氧氣 製冷劑" },
                            { Industry: "食品與飲料", application: "酵母和黴菌孢子的熏蒸消毒", gas: "二氧化碳 氯 二氧化氯 環氧乙烷 二氧化硫" },
                            { Industry: "食品與飲料", application: "消毒設備和用具", gas: "氯 二氧化氯 環氧乙烷" },
                            { Industry: "食品與飲料", application: "冷藏運輸", gas: "氨 二氧化碳 氧氣 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "肉類加工廠", gas: "氨 二氧化碳 氧氣 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "超市、冰箱和儲藏室", gas: "氨 二氧化碳 氧氣 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "食品儲存系統監控", gas: "氨 二氧化碳 氧氣 製冷劑 二氧化硫" },
                            { Industry: "食品與飲料", application: "食品包裝（溶劑蒸氣過程監控）", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣 揮發性有機化合物" },
                            { Industry: "鑄造廠", application: "熔爐操作", gas: "二氧化碳" },
                            { Industry: "鑄造廠", application: "制芯", gas: "可燃氣體 一氧化碳 硫化氫 一氧化氮 二氧化氮 二氧化硫" },
                            { Industry: "鑄造廠", application: "金屬製備和澆注", gas: "二氧化碳" },
                            { Industry: "鑄造廠", application: "金屬開採，精加工", gas: "可燃氣體 氰化氫 硫化氫" },
                            { Industry: "鑄造廠", application: "熱處理工藝", gas: "可燃氣體 二氧化碳 一氧化碳" },
                            { Industry: "鑄造廠", application: "封閉的空間", gas: "可燃氣體 二氧化碳 一氧化碳" },
                            { Industry: "燃料電池製造", application: "製造車間", gas: "可燃氣體 二氧化碳 一氧化碳 硫化氫 氧氣" },
                            { Industry: "燃料電池製造", application: "燃料電池", gas: "可燃氣體 二氧化碳 一氧化碳 硫化氫 氧氣" },
                            { Industry: "危險品", application: "危險品應用", gas: "可燃氣體 氨 一氧化碳 氯 二氧化氯 硫化氫 膦 二氧化硫 揮發性有機化合物" },
                            { Industry: "危險品", application: "易燃液體/氣體儲存", gas: "可燃氣體 二氧化碳 揮發性有機化合物" },
                            { Industry: "危險品", application: "抽水設施", gas: "可燃氣體 二氧化碳 揮發性有機化合物" },
                            { Industry: "危險品", application: "封閉的空間", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣 揮發性有機化合物" },
                            { Industry: "危險品", application: "地下施工", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "危險品", application: "儲存、轉移和處理", gas: "可燃氣體 一氧化碳 揮發性有機化合物" },
                            { Industry: "重型製造", application: "車輛製造廠", gas: "可燃氣體 一氧化碳 二氧化氮 製冷劑 揮發性有機化合物" },
                            { Industry: "重型製造", application: "傳熱流體", gas: "製冷劑 揮發性有機化合物" },
                            { Industry: "重型製造", application: "車輛排放", gas: "二氧化碳 一氧化碳 一氧化氮 二氧化氮 二氧化硫 揮發性有機化合物" },
                            { Industry: "重型製造", application: "電鍍", gas: "氨 氯化氫 氰化氫" },
                            { Industry: "重型製造", application: "製造過程排放", gas: "可燃氣體 二氧化碳 硫化氫 一氧化氮 二氧化氮 二氧化硫 揮發性有機化合物" },
                            { Industry: "重型製造", application: "叉車和起重機操作", gas: "可燃氣體 一氧化碳 二氧化氮" },
                            { Industry: "重型製造", application: "化學品裝載/卸載", gas: "可燃氣體 氨 氯 揮發性有機化合物" },
                            { Industry: "重型製造", application: "噴漆房", gas: "可燃氣體 一氧化碳 氧氣 揮發性有機化合物" },
                            { Industry: "重型製造", application: "除油劑", gas: "可燃氣體 揮發性有機化合物" },
                            { Industry: "重型製造", application: "機械設備間", gas: "可燃氣體 氨 氧氣 製冷劑" },
                            { Industry: "暖通空調", application: "加熱鍋爐或管道", gas: "可燃氣體 二氧化碳 一氧化碳" },
                            { Industry: "暖通空調", application: "一般辦公應用", gas: "可燃氣體 二氧化碳 一氧化碳" },
                            { Industry: "暖通空調", application: "停車場、倉庫", gas: "氨 一氧化碳 環氧乙烷 二氧化氮" },
                            { Industry: "暖通空調", application: "被佔用的建築物、辦公樓", gas: "可燃氣體 氨 二氧化碳 氧氣 製冷劑 揮發性有機化合物" },
                            { Industry: "暖通空調", application: "研究實驗室", gas: "可燃氣體 氨 二氧化碳 氧氣 製冷劑 揮發性有機化合物" },
                            { Industry: "暖通空調", application: "停車場、隧道、爐房、維修車庫", gas: "可燃氣體 氨 一氧化碳 二氧化氮 氧氣 製冷劑" },
                            { Industry: "暖通空調", application: "通風管道", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 揮發性有機化合物" },
                            { Industry: "暖通空調", application: "冷庫", gas: "氨 二氧化碳 環氧乙烷 氧氣 製冷劑" },
                            { Industry: "暖通空調", application: "交通設施", gas: "氨 二氧化碳 環氧乙烷 氧氣 製冷劑" },
                            { Industry: "暖通空調", application: "肉類加工廠", gas: "氨 二氧化碳 環氧乙烷 氧氣 製冷劑" },
                            { Industry: "暖通空調", application: "超市、冰箱存放處", gas: "氨 二氧化碳 環氧乙烷 氧氣 製冷劑" },
                            { Industry: "暖通空調", application: "食品儲藏系統監控", gas: "氨 二氧化碳 環氧乙烷 氧氣 製冷劑" },
                            { Industry: "暖通空調", application: "機械室", gas: "可燃氣體 氨 氧氣 製冷劑" },
                            { Industry: "室內空氣質量", application: "佔用建築物（工業、商業、住宅）", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣 製冷劑 揮發性有機化合物" },
                            { Industry: "室內空氣質量", application: "辦公樓", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣 製冷劑 揮發性有機化合物" },
                            { Industry: "室內空氣質量", application: "研究實驗室", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣 製冷劑 揮發性有機化合物" },
                            { Industry: "室內空氣質量", application: "停車場", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 氧氣 製冷劑" },
                            { Industry: "室內空氣質量", application: "隧道", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 氧氣 製冷劑" },
                            { Industry: "室內空氣質量", application: "爐房", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 氧氣 製冷劑" },
                            { Industry: "室內空氣質量", application: "維修車庫", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 氧氣 製冷劑" },
                            { Industry: "室內空氣質量", application: "爬行空間", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 氧氣 製冷劑" },
                            { Industry: "鋼鐵", application: "高爐運行維護", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "鋼鐵", application: "轉爐運行", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "鋼鐵", application: "爐氣管道洩漏", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "鋼鐵", application: "金屬開採", gas: "可燃氣體 氨 二氧化碳 硫化氫" },
                            { Industry: "鋼鐵", application: "精加工", gas: "可燃氣體 氨 二氧化碳 硫化氫" },
                            { Industry: "鋼鐵", application: "燃料儲存", gas: "可燃氣體 氨 二氧化碳 硫化氫" },
                            { Industry: "鋼鐵", application: "焦化操作", gas: "可燃氣體 一氧化碳 硫化氫 二氧化硫" },
                            { Industry: "鋼鐵", application: "焊接", gas: "可燃氣體 氨 一氧化氮 二氧化氮" },
                            { Industry: "鋼鐵", application: "封閉的空間", gas: "可燃氣體 一氧化碳 硫化氫 氧氣 揮發性有機化合物" },
                            { Industry: "鋼鐵", application: "維修室（冷卻器）", gas: "氨 製冷劑" },
                            { Industry: "鋼鐵", application: "電機維護與清潔", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 二氧化硫 揮發性有機化合物" },
                            { Industry: "鋼鐵", application: "焦爐排放", gas: "可燃氣體 二氧化碳 一氧化碳 二氧化氮 二氧化硫 揮發性有機化合物" },
                            { Industry: "醫療", application: "手術室、佔用區域", gas: "二氧化碳 乙烯 環氧乙烷 氧氣" },
                            { Industry: "醫療", application: "酒精，“病態建築綜合症”", gas: "二氧化碳 乙烯 環氧乙烷 揮發性有機化合物" },
                            { Industry: "醫療", application: "中央供應、滅菌區", gas: "環氧乙烷 揮發性有機化合物" },
                            { Industry: "醫療", application: "核磁共振", gas: "氧氣" },
                            { Industry: "醫療", application: "停車場", gas: "一氧化碳" },
                            { Industry: "醫療", application: "洗消區", gas: "揮發性有機化合物" },
                            { Industry: "醫療", application: "機械設備間", gas: "可燃氣體 氨 一氧化碳 製冷劑" },
                            { Industry: "礦業", application: "封閉的空間", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣" },
                            { Industry: "礦業", application: "機械化採煤", gas: "可燃氣體" },
                            { Industry: "礦業", application: "採礦過程", gas: "可燃氣體 二氧化碳 硫化氫" },
                            { Industry: "礦業", application: "燃燒（火）", gas: "可燃氣體 一氧化碳 二氧化氮" },
                            { Industry: "礦業", application: "柴油動力機械廢氣", gas: "可燃氣體 一氧化碳 二氧化氮" },
                            { Industry: "礦業", application: "密閉空間爆破的結果", gas: "可燃氣體 一氧化碳 二氧化氮" },
                            { Industry: "礦業", application: "金屬礦業", gas: "氨 二氧化碳 一氧化碳 氰化氫 硫化氫 氧氣 製冷劑" },
                            { Industry: "礦業", application: "柴油機尾氣", gas: "一氧化碳 一氧化氮 二氧化氮" },
                            { Industry: "礦業", application: "柴油動力機械，爆破", gas: "一氧化碳 一氧化氮 二氧化氮" },
                            { Industry: "石油和天然氣", application: "石油煉製", gas: "可燃氣體 氨 氯化氫 硫化氫 二氧化硫 揮發性有機化合物" },
                            { Industry: "石油和天然氣", application: "管道壓縮機站和泵站", gas: "可燃氣體" },
                            { Industry: "石油和天然氣", application: "煉油廠", gas: "可燃氣體 氨 一氧化碳 氯化氫 硫化氫 二氧化硫 揮發性有機化合物" },
                            { Industry: "石油和天然氣", application: "煉油廠、石化設施、周邊監控", gas: "可燃氣體 硫化氫 二氧化硫 揮發性有機化合物" },
                            { Industry: "石油和天然氣", application: "不完全燃燒、轉化、焦化、一般加工、檢漏", gas: "可燃氣體 一氧化碳 硫化氫 二氧化氮" },
                            { Industry: "石油和天然氣", application: "轉化過程、異構化、催化重整、處理過程、洩漏檢測、儲存容器、周邊監測", gas: "可燃氣體 氯化氫 硫化氫 氧氣 揮發性有機化合物" },
                            { Industry: "石油和天然氣", application: "煉油過程，一般洩漏檢測，處理過程，原油分離，鑽機", gas: "可燃氣體 二氧化碳 硫化氫 二氧化硫 揮發性有機化合物" },
                            { Industry: "石油和天然氣", application: "密閉空間（儲罐清洗操作、封閉式建築物或結構）", gas: "可燃氣體 氧氣 揮發性有機化合物" },
                            { Industry: "石油和天然氣", application: "天然氣管線", gas: "可燃氣體 硫化氫" },
                            { Industry: "石油和天然氣", application: "海上鑽井平台——存儲和加工區、控制室、生活空間、發電室", gas: "可燃氣體 硫化氫" },
                            { Industry: "石油和天然氣", application: "精煉工藝、工藝流樣品採集、一般工廠操作", gas: "可燃氣體 二氧化碳 硫化氫 二氧化硫 揮發性有機化合物" },
                            { Industry: "石油和天然氣", application: "機械設備間", gas: "可燃氣體 製冷劑" },
                            { Industry: "石油和天然氣", application: "熱氧化器", gas: "可燃氣體 " },
                            { Industry: "紙漿", application: "造紙（漂白）", gas: "氯 二氧化氯 二氧化氮 製冷劑 二氧化硫" },
                            { Industry: "紙漿", application: "化學製漿、硫酸鹽法製漿", gas: "氨 硫化氫 二氧化硫" },
                            { Industry: "紙漿", application: "密閉空間（水箱、坑、污水坑、大桶）", gas: "可燃氣體 氯 硫化氫 氧氣" },
                            { Industry: "紙漿", application: "造紙（塗層和染色）", gas: "可燃氣體 硫化氫 二氧化氮 揮發性有機化合物" },
                            { Industry: "紙漿", application: "機械設備間", gas: "可燃氣體 氨 製冷劑" },
                            { Industry: "製藥", application: "製造、煤氣洩漏", gas: "可燃氣體 氨 氯 二氧化氯 環氧乙烷 氰化氫 二氧化硫" },
                            { Industry: "製藥", application: "溶劑蒸汽過程監測", gas: "可燃氣體 氨 二氧化碳 乙烯 揮發性有機化合物" },
                            { Industry: "製藥", application: "化學合成操作", gas: "可燃氣體 氨 環氧乙烷 氰化氫 氧氣 揮發性有機化合物" },
                            { Industry: "製藥", application: "實驗室、精細化工製造", gas: "可燃氣體 氨 一氧化碳 氯 二氧化氯 環氧乙烷 氰化氫" },
                            { Industry: "製藥", application: "實驗室，有機合成，", gas: "可燃氣體 氨 二氧化碳 氯 環氧乙烷 製冷劑 揮發性有機化合物" },
                            { Industry: "製藥", application: "液固分離、複合、", gas: "可燃氣體 氨 二氧化碳 氯 環氧乙烷 製冷劑 揮發性有機化合物" },
                            { Industry: "製藥", application: "製粒和片劑包衣操作", gas: "可燃氣體 氨 二氧化碳 氯 環氧乙烷 製冷劑 揮發性有機化合物" },
                            { Industry: "製藥", application: "乾燥和包裝", gas: "可燃氣體 氨 二氧化碳 氯 環氧乙烷 製冷劑 揮發性有機化合物" },
                            { Industry: "製藥", application: "精細化工製造", gas: "可燃氣體 氨 二氧化碳 氯 環氧乙烷 製冷劑 揮發性有機化合物" },
                            { Industry: "製藥", application: "儲存容器、反應器和離心機的氮氣覆蓋", gas: "一氧化碳 氧氣" },
                            { Industry: "製藥", application: "壓縮呼吸空氣", gas: "二氧化碳 一氧化碳 氧氣" },
                            { Industry: "製藥", application: "公用事業", gas: "可燃氣體 一氧化碳 膦" },
                            { Industry: "發電", application: "家用爐子洩漏", gas: "可燃氣體 一氧化碳" },
                            { Industry: "發電", application: "變壓器絕緣", gas: "六氟化硫" },
                            { Industry: "發電", application: "發電廠", gas: "可燃氣體 氨 二氧化碳 一氧化碳 氯 氯化氫 二氧化氮 氧氣 二氧化硫" },
                            { Industry: "發電", application: "燃料儲存", gas: "可燃氣體" },
                            { Industry: "發電", application: "燃料運輸裝卸", gas: "可燃氣體 一氧化碳 揮發性有機化合物" },
                            { Industry: "發電", application: "化石燃料發電廠", gas: "可燃氣體 氨 一氧化碳 一氧化氮 二氧化氮 二氧化硫" },
                            { Industry: "發電", application: "封閉的空間", gas: "可燃氣體 二氧化碳 一氧化碳 氧氣 揮發性有機化合物" },
                            { Industry: "發電", application: "燃燒過程中的煤和燃料油氧化（排放）", gas: "氨 二氧化碳 一氧化碳 氯化氫 二氧化氮 二氧化硫" },
                            { Industry: "半導體工廠", application: "製造、加工", gas: "可燃氣體 胂 溴 一氧化碳 氯 二氧化氯 乙硼烷 鍺烷 氯化氫 氰化氫 一氧化氮 二氧化氮 矽烷" },
                            { Industry: "半導體工廠", application: "作為製造、擴散和離子實施、化學氣相沉積中的摻雜劑", gas: "膦" },
                            { Industry: "半導體工廠", application: "清潔劑、含氟化合物", gas: "可燃氣體 製冷劑 揮發性有機化合物" },
                            { Industry: "半導體工廠", application: "光刻、蝕刻、氧化、金屬化、組裝和測試", gas: "氯化氫 揮發性有機化合物" },
                            { Industry: "半導體工廠", application: "冷水機組", gas: "氨 製冷劑" },
                            { Industry: "半導體工廠", application: "壓縮呼吸空氣", gas: "一氧化碳 氧氣" },
                            { Industry: "造船廠/海洋", application: "密閉空間（儲藏室）", gas: "可燃氣體 一氧化碳 二氧化氯 氧氣 揮發性有機化合物" },
                            { Industry: "造船廠/海洋", application: "燃料儲存", gas: "可燃氣體 二氧化碳" },
                            { Industry: "造船廠/海洋", application: "泵送設施", gas: "可燃氣體 二氧化碳" },
                            { Industry: "造船廠/海洋", application: "機房", gas: "可燃氣體 氨 一氧化碳 製冷劑" },
                            { Industry: "造船廠/海洋", application: "廢物處理", gas: "可燃氣體 硫化氫 氧氣" },
                            { Industry: "造船廠/海洋", application: "冷水機組", gas: "氨 製冷劑" },
                            { Industry: "造船廠/海洋", application: "液化天然氣運輸", gas: "可燃氣體" },
                            { Industry: "造船廠/海洋", application: "油輪泵", gas: "可燃氣體" },
                            { Industry: "造船廠/海洋", application: "美國海軍艦艇", gas: "可燃氣體 氨 一氧化碳 硫化氫 製冷劑 揮發性有機化合物" },
                            { Industry: "造船廠/海洋", application: "擺渡船", gas: "可燃氣體 氨 一氧化碳 製冷劑" },
                            { Industry: "水和廢水", application: "加工儲罐", gas: "可燃氣體 氨 氯 二氧化氯 硫化氫 揮發性有機化合物" },
                            { Industry: "水和廢水", application: "房間和管道", gas: "可燃氣體 氨 氯 二氧化氯 硫化氫 揮發性有機化合物" },
                            { Industry: "水和廢水", application: "沼氣", gas: "可燃氣體 二氧化碳 硫化氫" },
                            { Industry: "水和廢水", application: "停滯的氣體，", gas: "可燃氣體 二氧化碳" },
                            { Industry: "水和廢水", application: "焚化爐", gas: "可燃氣體 二氧化碳" },
                            { Industry: "水和廢水", application: "工廠泵、工廠污水池監測溶劑洩漏或傾倒", gas: "可燃氣體" },
                            { Industry: "水和廢水", application: "一般流程", gas: "可燃氣體 硫化氫 氧氣" },
                            { Industry: "水和廢水", application: "下水道工程", gas: "可燃氣體 硫化氫 氧氣" },
                            { Industry: "水和廢水", application: "封閉的空間", gas: "可燃氣體 二氧化碳 氯 二氧化氯 硫化氫 氧氣 揮發性有機化合物" },
                            { Industry: "水和廢水", application: "脫氯、儲罐", gas: "氯 二氧化氯 二氧化硫" },
                            { Industry: "水和廢水", application: "濕井進水", gas: "可燃氣體 一氧化碳 硫化氫" },
                            { Industry: "水和廢水", application: "泵站", gas: "可燃氣體 一氧化碳 硫化氫 二氧化氮" },
                            { Industry: "焊接", application: "封閉的空間", gas: "可燃氣體 氨 二氧化碳 一氧化碳 乙烯 氧氣" },
                            { Industry: "焊接", application: "電弧空氣切割", gas: "可燃氣體 氨 二氧化碳 一氧化碳 乙烯 氧氣" },
                            { Industry: "焊接", application: "焊劑保護和氣體保護電弧焊", gas: "可燃氣體 氨 二氧化碳 一氧化碳 乙烯 氧氣" },
                            { Industry: "焊接", application: "金屬切割和火焰氣刨，", gas: "可燃氣體 氨 二氧化碳 一氧化碳 乙烯 氧氣" },
                            { Industry: "焊接", application: "氣壓焊", gas: "可燃氣體 氨 二氧化碳 一氧化碳 乙烯 氧氣" },
                            { Industry: "焊接", application: "鋁熱和螺柱焊接", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "焊接", application: "激光焊接和冷卻", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "焊接", application: "電弧空氣切割", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "焊接", application: "電弧焊", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "焊接", application: "電阻和氣壓焊接", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "焊接", application: "金屬切割和氣刨、釬焊", gas: "可燃氣體 一氧化碳 氧氣" },
                            { Industry: "焊接", application: "電弧焊與切割、螺柱焊、電弧+空氣切割、氣壓焊、金屬切割與氣刨", gas: "可燃氣體 二氧化氮 氧氣" },
                            { Industry: "焊接", application: "密閉空間焊接、電子束焊接", gas: "可燃氣體 一氧化碳 氧氣" },
                        ],
                        c: {
                            "Combustible gases": "可燃氣體",
                            "Ammonia": "氨",
                            "Carbon dioxide": "二氧化碳 ",
                            "Carbon monoxide": "一氧化碳",
                            "Chlorine": "氯",
                            "Chlorine dioxide": "二氧化氯",
                            "Ethylene": "乙烯",
                            "Ethylene oxide": "環氧乙烷",
                            "Hydrogen chloride": "氯化氫",
                            "Hydrogen cyanide": "氰化氫",
                            "Hydrogen sulfide": "硫化氫",
                            "Nitric oxide": "一氧化氮",
                            "Nitrogen dioxide": "二氧化氮",
                            "O2 deficiency/enrichment": "氧氣",
                            "Phosphine": "膦",
                            "Refrigerants": "製冷劑",
                            "Toluene": "甲苯",
                            "Sulfur dioxide": "二氧化硫 ",
                            "Sulfur hexafluoride": "六氟化硫",
                            "VOCs": "揮發性有機化合物",
                        },


                    }
                },
                created() {
                    if (this.important == "") this.important = '無';
                    //潛在客戶初始化
                    $.ajax({
                        url: '${pageContext.request.contextPath}/Potential/init/${bean.customerid}',
                        type: 'POST',
                        async: false,//同步請求
                        cache: false,//不快取頁面
                        success: (response => (
                            this.TrackList = response.track,
                            this.bosMassageList = response.bosmessage,
                            this.oldCustomer = response.customer,
                            this.customer = Object.assign({}, this.oldCustomer),
                            this.changeMessageList = response.changeMessage,
                            console.log(this.customer, "bean")

                        )),
                        error: function (returndata) {
                            console.log("沒有取得資訊");
                        }
                    });
                    $('.bosMessagediv').hide();
                    if (this.customer.industry == undefined || this.customer.industry == "") {
                        this.customer.industry = '尚未分類';
                        this.oldCustomer.industry = '尚未分類';
                    }
                    if (this.customer.status == undefined || this.customer.status == "") {
                        this.customer.status = '未處理';
                        this.oldCustomer.status = '未處理';
                    }
                    if (this.customer.callhelp == "1") {
                        this.CallHelpCSS = "col-md-2 bg-danger";
                    }
                    this.changeCompany();
                },
                watch: {
                    company: {
                        // immediate: true,
                        handler(n, oldValue) {//插入城市 區域
                            $("select[name='city']").val(n.billcity);
                            setTimeout(function () {
                            }, 100)
                            $("select[name='town']").append('<option value="' + n.billtown + '">' + n.billtown + '</option>');
                            $("select[name='town']").val(n.billtown);
                        }
                    },
                    TrackList: {
                        handler(newValue, oldValue) {
                            console.log("newValue", newValue);
                            for (var track of newValue) {
                                track.trackdescribe = track.trackdescribe.replace(/\r\n/g, '<br />');
                                track.result = track.result.replace(/\r\n/g, '<br />');
                            }
                        }
                    }
                },
                methods: {
                    submitForm() {//送出表單
                        this.customer.company = this.companyName;
                        //表單驗證
                        var isok = true;


                        if (this.companyName == null || this.companyName == "") {
                            $("input[name='company']").css("border", "red 1px solid");
                            this.$message.error('公司,需要填');
                            isok = false;
                        }
                        if (this.customer.name == null || this.customer.name == "") {
                            $("input[name='name']").css("border", "red 1px solid");
                            this.$message.error('聯絡人,需要填');
                            isok = false;
                        }
                        if (this.customer.email == null && this.customer.phone == null && this.customer.moblie == null) {
                            $("input[name='email']").css("border", "red 1px solid");
                            $("input[name='phone']").css("border", "red 1px solid");
                            $("input[name='moblie']").css("border", "red 1px solid");
                            isok = false;
                            this.$message.error('手機 電話 Email 必填一項');

                        }
                        if (this.customer.remark == null || this.customer.remark == "") {
                            $("#remark").css("border", "red 1px solid");
                            isok = false;
                            this.$message.error('客人詢問,需要填');
                        }

                        if (this.customer.source == null || this.customer.source == "") {
                            $("#source").css("border", "red 1px solid");
                            isok = false;
                            this.$message.error('來源 ,需要填');
                        }
                        if (isok) {//通過驗證
                            var formData = new FormData($(".AAA")[0]);

                            if ("${bean.customerid}" == "") {//如果是新資料 就 提交表單
                                $.ajax({
                                    url: '${pageContext.request.contextPath}/Market/SavePotentialCustomer',
                                    type: 'POST',
                                    data: formData,
                                    async: false,
                                    cache: false,
                                    contentType: false,
                                    processData: false,
                                    success: function (response) {
                                        console.log(response);
                                        if (response.state) {

                                            location.href = "${pageContext.request.contextPath}/Market/potentialcustomer/" + response.id;
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
                            } else {//如果不是新資料 就 紀錄修改
                                var keys = Object.keys(this.customer);
                                var data = {};
                                for (const iterator of keys) {
                                    if (this.customer[iterator] == this.oldCustomer[iterator]) {

                                    } else {
                                        data[iterator] = [this.customer[iterator], this.oldCustomer[iterator]];
                                    }
                                }

                                axios
                                    .post('${pageContext.request.contextPath}/changeMessage/${bean.customerid}', data)
                                    .then(
                                        response => (
                                            $.ajax({
                                                url: '${pageContext.request.contextPath}/Market/SavePotentialCustomer',
                                                type: 'POST',
                                                data: formData,
                                                async: false,
                                                cache: false,
                                                contentType: false,
                                                processData: false,
                                                success: function (response) {
                                                    console.log(response);
                                                    if (response.state) {
                                                        location.href = "${pageContext.request.contextPath}/Market/potentialcustomer/" + response.id;
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
                                            })
                                        ))
                            }
                        } else {
                            alert("紅框要輸入");
                        }
                    },
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
                    sendBosMessage() {//儲存主管留言
                        const data = {
                            "message": this.bosMassage,
                            "admin": this.admin,
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
                    changeCompany() {///公司改變 取得聯絡人
                        console.log("公司改變");
                        axios
                            .get('${pageContext.request.contextPath}/Potential/getCompany/' + this.companyName.trim())
                            .then(
                                response => {
                                    this.contactList = response.data.contact
                                    console.log(response.data.contact);
                                })
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });

                    },
                    //測回 或 失敗結案 快捷鍵
                    BosOperate(state) {

                        this.customer.status = state;
                        // this.submitForm();
                        //需要等 才能成功
                        setTimeout(function () { vm.submitForm(); }, 500);

                    },
                    open(s) {//修改追蹤資訊
                        this.$alert('<form action="${pageContext.request.contextPath}/Market/SaveTrack" method = "post" >\
                                                    <div class="row">\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="trackdescribe" rows="2"\
                                                                maxlength="950" required>' + s.trackdescribe + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="result" rows="2"\
                                                                maxlength="950">' + s.result + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-2" style="padding: 0%;">\
                                                            <button style="width: 100%; background-color: #569b92;"\
                                                                class="btn btn-outline-dark" onclick="">修改</button>\
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
                    //刪除追蹤資訊
                    removeTrack(bean) {
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
                    },
                    removeTrackremark(remark) {
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
                    //改變textarea高度
                    changeTextarea: function (id) {
                        var textarea = document.getElementById(id);
                        if (textarea.style.height < (textarea.scrollHeight + "px"))
                            textarea.style.height = (textarea.scrollHeight + 10) + 'px';
                    },
                    //求助
                    CallHelp: function () {
                        console.log("error");
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Potential/CallHelp/' + this.customer.customerid,
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
                    },
                    //附件
                    handleRemove(file, fileList) {//刪除附件
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
                    handlePreview(file) {//點擊附件
                        console.log("file", file);
                        window.open("${pageContext.request.contextPath}/file/" + file.url);
                    },
                    beforeRemove(file, fileList) {
                        return this.$confirm('確定刪除' + file.name);
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

                    },//改變狀態
                    changeStatus() {

                        if (this.customer.user == null || this.customer.user == "" || this.customer.user == "無") {
                            this.$message.error('需要先設定 負責人');
                            this.customer.status = this.oldCustomer.status;


                        } else {
                            if (this.customer.status == "合格") {

                                this.changeStatusVisible = true;
                            }
                        }


                    }, //失去焦點,儲存
                    chageToSave(field, val) {
                        console.log("this", this);
                        if (this.bean.marketid) {
                            console.log(this.oldBean[field]);
                            console.log(field, val);
                            if (this.oldBean[field] != val) {
                                let data = new FormData();
                                data.append("marketid", this.bean.marketid);
                                data.append("field", field);
                                data.append("val", val);

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
                                            message: '儲存 ' + field + " = " + val,
                                            type: 'success'
                                        }),
                                        this.oldBean = Object.assign({}, this.bean)


                                    )),
                                    error: function (returndata) {
                                        console.log(returndata);
                                    }
                                })
                            }
                        }
                    },
                    //領取任務
                    clickReceive() {
                        if ('${bean.customerid}' == '') {
                            this.$message({
                                message: '請先建立任務',
                                type: 'error'
                            });
                        } else {
                            var basefrom = new FormData(document.getElementById("basefrom"));
                            console.log(basefrom);
                            $.ajax({
                                url: '${pageContext.request.contextPath}/Potential/getReceive',
                                type: 'post',
                                data: basefrom,
                                async: false,
                                cache: false,
                                contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                                processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false
                                success: response => {
                                    if (response.state) {
                                        location.href = "${pageContext.request.contextPath}/Market/potentialcustomer/${bean.customerid}"
                                    } else {
                                        this.$message.error(" 資料已被其他人更新, 不能領取");
                                    }
                                },
                                error: function (returndata) {
                                    console.log(returndata);
                                }
                            })
                        }
                    },
                    //分配人員 (receive 設為null)
                    changeUser() {
                        this.customer.receive = null;
                        console.log(this.customer.user);
                        if (this.customer.user != '無') {
                            this.customer.receivestate = 2;
                        }
                        if (this.customer.user == '無') {
                            this.customer.receivestate = 3;
                        }
                    },
                    //改變各行業氣體查詢
                    changeGasDetection(){
                       this.InGasDetection = "";
                    },






                },
            })
    // textarea.style.height = textarea.scrollHeight + 'px';
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

            .bg-danger {
                color: white;
            }

            .el-upload-list__item-name [class^=el-icon] {
                height: auto;
            }

            .el-icon-close-tip {
                display: none;
            }
        </style>

        </html>