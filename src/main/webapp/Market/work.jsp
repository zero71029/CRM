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
            .workbar {
                /* 按鈕顏色 */
                background-color: #afe3d5;
            }

            .cell {
                border: 0px solid black;
                border-bottom: 1px solid black;
                background-color: #CCC;

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

                display: block;
            }

            .log {
                text-align: center;
                background-color: rgb(36, 101, 164);
                color: white;
                border-radius: 5px 5px 0 0;
            }

            .error {
                color: red;
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
                    <div class="col-md-11 app">
                        <!-- <%-- 中間主體--%> -->
                        <br>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <h3>工作項目</h3>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-1 btn">
                                <a href="${pageContext.request.contextPath}/Market/workList.jsp"
                                    style="text-decoration: none;text-align: center;background-color: #569b92;color: white;;display: block;"><span
                                        class="el-icon-arrow-left"></span></a>
                            </div>

                        </div>
                        <br>
                        <form action="${pageContext.request.contextPath}/work/SaveWork" method="post" id="myform"
                            class="basefrom g-3 ">
                            <div class="row">
                                <input type="hidden" name="track" value="${bean.track}">
                                <input type="hidden" name="workid" value="${bean.workid}">
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4 log">項目內容</div>
                                    <div class="col-md-2"></div>
                                    <div class="col-md-3 log">其它資訊</div>

                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">主題*</div>
                                    <div class="col-md-3   FormPadding">
                                        <input type="text" class=" form-control cellFrom" name="name"
                                            value="${bean.name}" maxlength="95" required>
                                    </div>
                                    <div class="col-md-2"></div>
                                    <div class="col-md-1 cell">項目編號</div>
                                    <div class="col-md-2 cell">${bean.workid}
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">到期日</div>
                                    <div class="col-md-3   FormPadding">
                                        <input type="text" class="form-control cellFrom endtime" name="endtime"
                                            value="${bean.endtime}" maxlength="20" readonly>
                                    </div>

                                    <div class="col-md-2"></div>
                                    <div class="col-md-1 cell">負責人*</div>
                                    <div class="col-md-2 cell FormPadding">
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
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">重要性</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <input type="text" class="form-control cellFrom" name="important"
                                            value="${bean.important}" maxlength="10" list="important">
                                        <datalist id="important">
                                            <option value="高"></option>
                                            <option value="中"></option>
                                            <option value="低"></option>
                                        </datalist>
                                    </div>
                                    <div class="col-md-2"></div>
                                    <div class="col-md-1 cell">狀態</div>
                                    <div class="col-md-2 cell FormPadding">
                                        <select class=" form-select cellFrom" name="state">
                                            <option value="尚未處理" class="selItemOff" selected>
                                                尚未處理</option>
                                            <option value="需求確認" class="selItemOff" ${bean.state=="需求確認"
                                                ?"selected":null}>
                                                需求確認</option>
                                            <option value="聯繫中" class="selItemOff" ${bean.state=="聯繫中"
                                                ?"selected":null}>
                                                聯繫中 </option>
                                            <option value="處理中" class="selItemOff" ${bean.state=="處理中"
                                                ?"selected":null}>
                                                處理中</option>
                                            <option value="已報價" class="selItemOff" ${bean.state=="已報價"
                                                ?"selected":null}>
                                                已報價</option>
                                            <option value="成功結案" class="selItemOff" ${bean.state=="成功結案"
                                                ?"selected":null}>
                                                成功結案</option>
                                            <option value="失敗結案" class="selItemOff" ${bean.state=="失敗結案"
                                                ?"selected":null}>
                                                失敗結案</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-1 cell">備註</div>
                                    <div class="col-md-3 cell FormPadding">
                                        <textarea name="remake" id="" style="width: 100%;" rows="5" maxlength="490"
                                            required>${bean.remake}</textarea>
                                    </div>
                                </div>
                                <div class="row">&nbsp; </div>
                                <div class="row">&nbsp; </div>
                                <div class="row">&nbsp; </div>
                                <div class="row">&nbsp; </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4 ">
                                        <div class="row">
                                            <div class="col-md-12 log">關聯資訊</div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 cell">客戶</div>
                                            <div class="col-md-9   FormPadding " @click="dialogTableVisible = true ">
                                                <a :href="'${pageContext.request.contextPath}/CRM/client/'+clientid"
                                                    target="_blank" class="clientName">{{client}}</a>
                                                <input type="hidden" name='clientid' :value="clientid">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 cell">聯絡人</div>
                                            <div class="col-md-9 cell FormPadding">
                                                <select name="contactid" class="form-select cellFrom"
                                                    v-model="contactid">
                                                    <option v-for="(contact, index) in contactList" :key="index"
                                                        :value="contact.contactid">{{contact.name}}</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 cell">潛在顧客</div>
                                            <div class="col-md-9   FormPadding" onclick="showCustomer()">
                                                <a href="${pageContext.request.contextPath}/CRM/potentialcustomer/${bean.customer.customerid}"
                                                    target="_blank" class="customerName">${bean.customer.name}</a>
                                                <input type="hidden" class=" form-control cellFrom" name="customerid"
                                                    value="${bean.customer.customerid}" maxlength="20">

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 cell">銷售機會</div>
                                            <div class="col-md-9   FormPadding" onclick="showMarket()">
                                                <a href="${pageContext.request.contextPath}/Market/Market/${bean.market.marketid}"
                                                    target="_blank" class="marketName">${bean.market.name}</a>
                                                <input type="hidden" class=" form-control " name="marketid"
                                                    value="${bean.marketid}" maxlength="20">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-1"></div>
                                    <div class="col-md-4" v-show="Object.keys(client).length !=0">
                                        公司地址:{{clientbean.billcity}} {{clientbean.billtown}}({{clientbean.billpostal}})
                                        {{clientbean.billaddress}}<br>
                                        公司電話: {{clientbean.phone}}<br>
                                        公司傳真: {{clientbean.fax}}<br>
                                        聯絡人地址:{{contact.address}} <br>
                                        聯絡人電話:{{contact.phone}} <br>
                                        聯絡人手機: {{contact.moblie}}<br>
                                        聯絡人LIne:{{contact.line}} <br>

                                    </div>



                                    <div class="row">&nbsp; </div>
                                    <!-- 送出按鈕 -->
                                    <div class="row">
                                        <div class="col-md-4"></div>
                                        <div class="col-md-4 FormPadding">
                                            <button type="submit"
                                                style="width: 100%;background-color: rgb(36, 101, 164);color: white;"
                                                class="btn">送出</button>
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
                                <div class="col-md-9 log text-white" style="text-align: center; color: white;">
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
                                <input type="hidden" class=" form-control cellFrom" name="remark" maxlength="190"
                                    value="${user.name}">
                                <input type="hidden" name="customerid" value="${bean.track}">
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
                                        <button style="width: 100%; background-color: #569b92;" type="button"
                                            class="btn btn-outline-dark" @click="SaveTrackByWork">新增</button>
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
                                                {{s.trackdescribe}}
                                            </div>
                                            <div class="col-md-4" style="position: relative; word-wrap:break-word;">
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
                                            <el-button v-show="s.remark == '${user.name}'" type="text" @click="open(s)">
                                                修改</el-button>&nbsp;&nbsp;&nbsp;
                                            <el-button v-show="s.remark == '${user.name}'" type="text"
                                                @click="removeTrack(s)">刪除</el-button>&nbsp;&nbsp;&nbsp;
                                            <el-button type="text" @click="trackremark(s.trackid)">回覆
                                            </el-button>
                                            &nbsp;&nbsp;&nbsp;
                                        </div>
                                    </div>
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











                        <!-- ///////////////////////////////////////////////////////////////////////////// -->
                        <!-- 客戶彈窗 -->

                        <el-dialog title="客戶" :visible.sync="dialogTableVisible">
                            <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                <input type="text" class="form-control selectclient"
                                    placeholder=" 名稱  or 統編 or 負責人or 電話" aria-label="Recipient's username"
                                    aria-describedby="button-addon2">
                                <button class="btn btn-outline-secondary " type="submit"
                                    onclick="selectclient()">搜索</button>
                            </div>
                            <table class="Table table-striped clientTable">
                                <tr>
                                    <td>客戶名稱</td>
                                    <td>統編</td>
                                    <td>負責人</td>
                                    <td>電話</td>
                                    <td>產業</td>
                                </tr>
                                <tr v-for="(bean, index) in clientList" :key="index" class="item"
                                    @click="clickClient(bean)" style="cursor: pointer;">
                                    <td>{{bean.name}}</td>
                                    <td>{{bean.uniformnumber}}</td>
                                    <td>{{bean.user}}</td>
                                    <td>{{bean.phone}}</td>
                                    <td>{{bean.industry}}</td>
                                </tr>
                            </table>
                        </el-dialog>


                        <!-- 客戶彈窗/// -->
                        <!-- 潛在顧客彈窗 -->
                        <div class="CustomerWork" title="潛在顧客">
                            <!-- <%-- 抬頭搜索--%> -->
                            <div class="col-lg-5">
                                <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                    <input type="text" class="form-control selectCustomer"
                                        placeholder=" 客戶名稱 or 公司 or 負責人" aria-label="Recipient's username"
                                        aria-describedby="button-addon2">
                                    <button class="btn btn-outline-secondary " type="submit"
                                        onclick="selectCustomer()">搜索</button>
                                </div>
                            </div>
                            <table class="Table table-striped CustomerTable">

                            </table>
                        </div>
                        <!-- 潛在顧客彈窗/// -->
                        <!-- 銷售機會彈窗 -->
                        <div class="MarketWork" title="銷售機會">
                            <!-- <%-- 抬頭搜索--%> -->
                            <div class="col-lg-5">
                                <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                                    <input type="text" class="form-control selectMarket"
                                        placeholder="名稱  or 客戶 or 聯絡人or 負責人" aria-label="Recipient's username"
                                        aria-describedby="button-addon2">
                                    <button class="btn btn-outline-secondary " type="submit"
                                        onclick="selectMarket()">搜索</button>
                                </div>
                            </div>
                            <table class="Table table-striped MarketTable">

                            </table>
                        </div>
                        <!-- 銷售機會彈窗/// -->

                    </div>

                </div>
            </div>

        </body>
        <script>

            $(".market").show();
            // 日期UI
            $(function () {
                $(".endtime").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd",
                    beforeShow: function (input, inst) {
                        inst.dpDiv.css({ marginTop: -input.offsetHeight + 'px' });
                    }
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
                $("#myform").validate();
            });


            $(".CustomerWork").dialog({
                autoOpen: false,
                position: {
                    at: "top+300"
                },
                width: 1000,
                height: 300
            });
            $(".MarketWork").dialog({
                autoOpen: false,
                position: {
                    at: "top+300"
                },
                width: 1000,
                height: 300
            });
            function showCustomer() {
                $('.CustomerWork').dialog("open");
            }
            function showMarket() {
                $('.MarketWork').dialog("open");
            }

            //搜索潛在顧客
            function selectCustomer() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/work/selectCustomer/' + $('.selectCustomer').val(),//接受請求的Servlet地址
                    type: 'POST',
                    success: function (list) {
                        $(".CustomerTable").empty();
                        $(".CustomerTable").append("<tr><td>客戶名稱</td> <td>客戶公司</td><td>負責人</td> <td>電話</td> <td>產業</td></tr>");
                        for (var bean of list) {

                            $(".CustomerTable").append('<tr class="item" onclick="clickCustomer(`' + bean.name + '`,' + bean.customerid + ')" style="cursor: pointer;">' +
                                '<td> ' + bean.name + '</td><td>' + bean.company + ' </td><td> ' + bean.user + '</td><td> ' + bean.phone + '</td><td>' + bean.industry + ' </td></tr>');
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }
            //搜索銷售機會
            function selectMarket() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/work/selectMarket/' + $('.selectMarket').val(),//接受請求的Servlet地址
                    type: 'POST',
                    success: function (list) {
                        $(".MarketTable").empty();
                        $(".MarketTable").append("<tr><td>客戶名稱</td> <td>公司</td><td>負責人</td> <td>電話</td> </tr>");
                        for (var bean of list) {
                            $(".MarketTable").append('<tr class="item" onclick="clickMarket(`' + bean.name + '`,' + bean.marketid + ')" style="cursor: pointer;">' +
                                '<td> ' + bean.name + '</td><td>' + bean.client + ' </td><td> ' + bean.user + '</td><td> ' + bean.phone + '</td><td>' + bean.type + ' </td></tr>');
                        }
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
            }

            //點選客戶後
            // function clickClient(name, id) {
            //     $(".clientName").text(name);
            //     $(".clientName").attr("href", "${pageContext.request.contextPath}/CRM/client/" + id);
            //     $("input[name='clientid']").val(id);
            //     // $('.clientwork').dialog("close");
            //     $.ajax({
            //         url: '${pageContext.request.contextPath}/work/selectContact/' + name,//接受請求的Servlet地址
            //         type: 'POST',
            //         success: function (list) {
            //             $("select[name='contactid']").empty();
            //             for (var bean of list) {
            //                 $("select[name='contactid']").append('<option value="' + bean.contactid + '" selected>' + bean.name + '</option>');
            //             }
            //         },
            //         error: function (returndata) {
            //             console.log(returndata);
            //         }
            //     });
            // }
            $(".clientName").click(function (event) {
                event.stopPropagation();
            });
            //點選潛在顧客後
            function clickCustomer(name, id) {
                $(".customerName").text(name);
                $(".customerName").attr("href", "${pageContext.request.contextPath}/CRM/potentialcustomer/" + id);
                $("input[name='customerid']").val(id);
                $('.CustomerWork').dialog("close");
                console.log("點選潛在顧客後");
            }
            $(".clientName").click(function (event) {
                event.stopPropagation();
            });
            //點選銷售機會後
            function clickMarket(name, id) {
                $(".marketName").text(name);
                $(".marketName").attr("href", "${pageContext.request.contextPath}/CRM/Market/" + id);
                $("input[name='marketid']").val(id);
                $('.MarketWork').dialog("close");
            }
            $(".clientName").click(function (event) {
                event.stopPropagation();
            });
            $(".customerName").click(function (event) {
                event.stopPropagation();
            });
            $(".marketName").click(function (event) {
                event.stopPropagation();
            });
            function initContact() {
                var clientid = $("input[name='clientid']").val();
                if (clientid != "") {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/work/contactList/' + clientid,//接受請求的Servlet地址
                        type: 'POST',
                        success: function (list) {
                            for (var bean of list)
                                $('select[name="contactid"]').append('<option value="' + bean.contactid + '">' + bean.name + '</option>');
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                }


            }

            const vm = new Vue({
                el: ".app",
                data() {
                    return {
                        contact: {},
                        contactid: "",//聯絡人
                        contactList: [],//聯絡人列表
                        clientid: '${bean.clientid}',
                        client: "${bean.client.name}",//客戶
                        clientbean: {},
                        clientList: [],//客戶列表
                        dialogTableVisible: false,//客戶彈窗
                        TrackList: {},

                    }
                },
                created() {
                    console.log('${bean.track}','bean.track');
                    axios//取得客戶列表
                        .get('${pageContext.request.contextPath}/work/clientList')
                        .then(response => (
                            this.clientList = response.data
                        ))
                        .catch(function (error) {
                            console.log(error);
                        });
                    for (const iterator of this.clientList) {
                        console.log(iterator.name);
                        if (iterator.name == client) this.clientbean = iterator;
                    }
                    if (this.client != "") {
                        for (const iterator of this.clientList) {
                            console.log(iterator.name);
                            if (iterator.name == client) this.clientbean = iterator;
                        }
                        axios//取得聯絡人列表
                            .get('${pageContext.request.contextPath}/work/selectContact/' + this.client)
                            .then(response => (
                                this.contactList = response.data,
                                this.contactid = "${bean.contact.contactid}",
                                this.clientid = '${bean.clientid}'

                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    }
                    if ('${bean.track}' != '') {
                        axios
                            .get('${pageContext.request.contextPath}/Potential/client/${bean.track}')
                            .then(response => (
                                this.TrackList = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    }
                }, watch: {
                    clientList: {
                        handler(newValue, oldValue) {
                            for (const iterator of newValue) {
                                if (iterator.name == this.client) this.clientbean = iterator;
                            }
                        }
                    },
                    contactid: {
                        handler(newValue, oldValue) {
                            for (const iterator of this.contactList) {
                                if (iterator.contactid == newValue) this.contact = iterator
                            }
                        }
                    },
                    clientid: {  //客戶改變 
                        handler(newValue, oldValue) {
                            for (const iterator of this.clientList) {
                                if (iterator.contactid == newValue) {
                                    this.clientbean = iterator
                                }
                            }
                        }
                    }
                }, methods: {
                    open(s) {//修改追蹤資訊
                        this.$alert('<form action="${pageContext.request.contextPath}/work/changeTrackByMarket/${bean.workid}" method = "post" >\
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
                    SaveTrackByWork() {//存追蹤資訊
                        var formData = new FormData($('#SaveTrack')[0]);
                        axios
                            .post('${pageContext.request.contextPath}/work/SaveTrackByWork/${bean.workid}', formData)
                            .then(response => (
                                this.TrackList = response.data,
                                console.log(this.TrackList)
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    //選取客戶後 換聯絡人列表
                    clickClient: function (bean) {
                        this.clientid = bean.clientId;
                        this.client = bean.name;
                        this.clientbean = bean;
                        this.dialogTableVisible = false;
                        axios
                            .get('${pageContext.request.contextPath}/work/selectContact/' + bean.name,)
                            .then(response => (
                                this.contactList = response.data,
                                this.contact = {}
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });

                    }
                },
            })

        </script>
        <style>
            .el-message-box {
                width: 50%;
            }
        </style>

        </html>