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
                bottom: 530px;
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

            .box  .bosMessagediv{
                position: absolute;
                width: 505px;
                bottom: 0px;
                right: 25px;
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
                                            基本資料
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cell">公司<span style="color: red;">*</span></div>
                                        <div class="col-md-8 cell FormPadding">
                                            <input type="text" class="col-md-9 form-control cellFrom client"
                                                @blur="changeCompany" v-model="companyName" name="company"
                                                list="company" maxlength="20" required>
                                            <datalist id="company">
                                                <c:if test="${not empty client}">
                                                    <c:forEach varStatus="loop" begin="0" end="${client.size()-1}"
                                                        items="${client}" var="s">
                                                        <option value="${s.name}">
                                                    </c:forEach>
                                                </c:if>
                                            </datalist>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">聯絡人<span style="color: red;">*</span></div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="name" v-model="name"
                                                maxlength="20" required>
                                        </div>
                                        <div class="col-md-2 cellz">部門</div>
                                        <div class="col-md-3 cellz FormPadding"><input type="text"
                                                class=" form-control cellFrom" name="department" v-model="department"
                                                maxlength="20">
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">職稱</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="jobtitle"
                                                v-model="jobtitle" maxlength="20">
                                        </div>
                                        <div class="col-md-2 cellz">主管</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="director"
                                                v-model="director" maxlength="20">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">Email</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="email" class=" form-control cellFrom" name="email"
                                                v-model="email" maxlength="50">
                                        </div>
                                        <div class="col-md-2 cellz">產業</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <select name="industry" class=" form-select cellFrom" v-model="industry"
                                                v-model="industry">
                                                <option v-for="(item, index) in industryList" :key="index">{{item}}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">電話</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="phone"
                                                v-model="phone" maxlength="20">
                                        </div>
                                        <div class="col-md-2 cellz">公司人數</div>
                                        <div class="col-md-3 cellz FormPadding"><input type="number"
                                                v-model="companynum" class=" form-control cellFrom" name="companynum"
                                                maxlength="20"></div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">傳真</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="fax" v-model="fax"
                                                maxlength="20">
                                        </div>
                                        <div class="col-md-2 cellz">來源</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <select class="form-select cellFrom" name="source" v-model="source">
                                                <option value="廣告" class="selItemOff" ${bean.source=="廣告"
                                                    ?"selected":null}>
                                                    廣告
                                                </option>
                                                <option value="員工推薦" class="selItemOff" ${bean.source=="員工推薦"
                                                    ?"selected":null}>
                                                    員工推薦
                                                </option>
                                                <option value="外部推薦" class="selItemOff" ${bean.source=="外部推薦"
                                                    ?"selected":null}>
                                                    外部推薦
                                                </option>
                                                <option value="合作夥伴" class="selItemOff" ${bean.source=="合作夥伴"
                                                    ?"selected":null}>
                                                    合作夥伴
                                                </option>
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
                                        <div class="col-md-2 cellz">手機</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="moblie"
                                                v-model="moblie" maxlength="20">
                                        </div>


                                        <div class="col-md-2 cellz">Line</div>
                                        <div class="col-md-3 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="line" v-model="line"
                                                maxlength="190">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">地址</div>
                                        <div class="col-md-8 ">
                                            <div class="row" id="twzipcode"></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz"></div>
                                        <div class="col-md-8 cellz FormPadding">
                                            <input type="text" class=" form-control cellFrom" name="address"
                                                v-model="address" maxlength="50">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-2 cellz">客人詢問</div>
                                        <div class="col-md-8 cellz FormPadding">
                                            <textarea class="form-control " id="validationTextarea" name="remark"
                                                v-model="remark" rows="5" maxlength="200">${bean.remark}</textarea>
                                        </div>
                                    </div>

                                </div>
                                <!--  -->
                                <div class="col-md-5  ASDFG">
                                    <div class="row">
                                        <div class="col-md-3 cellz">潛在各戶負責人</div>
                                        <div class="col-md-7 cellz FormPadding">
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
                                        <div class="col-md-3 cellz"></div>
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
                                                    onclick="addHelper()">添加
                                                </button>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="row ">
                                        <div class="col-md-3 cellz"></div>
                                        <div class="col-md-7 ">
                                            <ul class="helpList " style="position: relative;">
                                                <c:forEach varStatus="loop" begin="0" end="${bean.helper.size()}"
                                                    items="${bean.helper}" var="s">
                                                    <li>${s.name}<a style="right: 0px; position: absolute;"
                                                            href="javascript:delHelp('${s.helperid}')">remove</a></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>


                                    <div class="row">

                                        <div class="col-md-3 cellz" style="font-size: 14px;">創造時間</div>
                                        <div class="col-md-7  FormPadding">
                                            ${bean.createtime}
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3 cellz">狀態</div>
                                        <div class="col-md-7 cellz FormPadding">
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
                                        <div class="col-md-3 celzl">重要性</div>
                                        <div class="col-md-7 cellz FormPadding">
                                            <select class="form-select cellFrom" name="important" v-model="important">
                                                <option value="高">高</option>
                                                <option value="中">中</option>
                                                <option value="低">低</option>
                                                <option value="無">無</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <p>&nbsp;</p>
                                <div class="row">
                                    <div class="col-md-3"></div>
                                    <div class="col-md-5 FormPadding">
                                        <button type="submit" style="width: 100%; " class="btn btn-warning"
                                            onclick="return window.confirm('確定修改')">儲存
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
                                <input type="hidden" class=" form-control cellFrom" name="remark" maxlength="190"
                                    value="${user.name}">
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
                                            <div class="col-md-4" style="position: relative; word-wrap:break-word;">
                                                {{s.trackdescribe}}
                                            </div>
                                            <div class="col-md-4" style="position: relative; word-wrap:break-word;">
                                                {{s.result}}
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
                                <div class="bosMessagediv" >
                                    <el-card class="box-card" style="background-color: #ccc">
                                        <div slot="header" class="clearfix">
                                            <el-input type="textarea" v-model="bosMassage" placeholder="请输入内容"
                                                maxlength="200" show-word-limit>
                                            </el-input>
                                            <el-button icon="el-icon-upload" style="width: 100%"
                                                @click="sendBosMessage">送出</el-button>
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
                                <div class="row act" style="height: 30px;">
                                    <a class="col-md-3" href="#" onclick="goClient()">轉成客戶</a>
                                    <a class="col-md-3" href="#" onclick="goContact()">建立聯絡⼈</a>
                                    <a class="col-md-3" href="#" onclick="goMarket()">新增銷售機會</a>
                                    <a class="col-md-3" href="#" onclick="goWork()">新增工作項目</a>
                                </div>
                                <div class="dockbar row shadow  ">
                                    <div class="col-md-2 offset-md-1" style="border-left: black 1px solid;"
                                        onclick="javascript:$('.act').toggle();">
                                        行動
                                    </div>
                                    <div class="col-md-2">紀錄</div>
                                    <div class="col-md-2" v-on:click="showbosMassage">留言</div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    <!-- 動作區塊 -->


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
                //表單驗證
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
                $("select[name='city']").attr("v-model", "city");
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
                        if (json == "公司不存在") {
                            alert("公司不存在,請先轉客戶");
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

            //新增工作項目
            function goMarket() {
                $(".AAA").attr("action", "${pageContext.request.contextPath}/Market/changeMarket");
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
                el: '.app',
                data() {
                    return {
                        
                        bosMassage: "",
                        bosMassageList: [],//組長留言資料
                        //各個欄位
                        department: "${bean.department}", jobtitle: "${bean.jobtitle}", director: "${bean.director}",
                        email: "${bean.email}", phone: "${bean.phone}", fax: "${bean.fax}", source: "${bean.source}",
                        moblie: "${bean.moblie}", line: "${bean.line}", address: "${bean.address}", remark: "${bean.remark}",
                        companynum: "${bean.companynum}", companyName: "${bean.company}", city: "${bean.city}",
                        contact: {},
                        company: {},
                        name: "${bean.name}",
                        visible: false,
                        admin: '${user.name}',//使用者名稱
                        important: '${bean.important}',
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
                        TrackList: {},
                    }
                },
                created() {
                    if (this.important == "") this.important = '低';
                    //要求追蹤資訊
                    axios
                        .get('${pageContext.request.contextPath}/Potential/client/${bean.customerid}')
                        .then(response => (
                            this.TrackList = response.data
                        ))
                        .catch(function (error) { // 请求失败处理
                            console.log("沒有追蹤資訊");
                        });
                    axios
                        .get('${pageContext.request.contextPath}/director/getMessage/${bean.customerid}')
                        .then(response => (
                            this.bosMassageList = response.data
                        ))
                        .catch(function (error) { // 请求失败处理
                            console.log("沒有追蹤資訊");
                        });
                        
                        $('.bosMessagediv').hide();

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
                    }
                },


                methods: {
                    showbosMassage(){
                        $('.bosMessagediv').toggle();
                    },
                    reomveBosMessage(bosmessageid) {//刪除主管留言
                        console.log(bosmessageid);
                        axios
                            .post('${pageContext.request.contextPath}/director/reomveBosMessage/'+bosmessageid)
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
                            .post('${pageContext.request.contextPath}/director/SaveMessage', data)
                            .then(
                                response => (                                 
                                    this.bosMassageList = response.data
                                ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    changeCompany() {///公司改變
                        axios
                            .get('${pageContext.request.contextPath}/Potential/getCompany/' + this.companyName.trim())
                            .then(
                                response => (
                                    this.company = response.data.company,
                                    this.contact = response.data.contact,
                                    this.name = this.contact.name,
                                    this.jobtitle = this.contact.jobtitle,
                                    this.director = this.contact.director,
                                    this.department = this.contact.department,
                                    this.email = this.company.email,
                                    this.industry = this.company.industry,
                                    this.phone = this.company.phone,
                                    this.companynum = this.company.peoplenumber,
                                    this.fax = this.company.fax,
                                    this.moblie = this.contact.moblie,
                                    this.line = this.contact.line,
                                    this.address = this.company.billaddress
                                ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });

                    },
                    open(s) {//修改追蹤資訊
                        this.$alert('<form action="${pageContext.request.contextPath}/Market/SaveTrack" method = "post" >\
                                                    <div class="row">\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="trackdescribe" rows="1"\
                                                                maxlength="190" required>' + s.trackdescribe + '</textarea>\
                                                        </div>\
                                                        <div class="col-md-5 FormPadding">\
                                                            <textarea class="form-control" name="result" rows="1"\
                                                                maxlength="195">' + s.result + '</textarea>\
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
                    }, removeTrackremark(remark) {//
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
                },
            })
        </script>
        <style>
            .el-message-box {
                width: 50%;
            }
        </style>

        </html>