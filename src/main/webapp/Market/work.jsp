<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <script src="${pageContext.request.contextPath}/js/vue.js"></script>
            <script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
            <!-- 引入element-ui组件库 -->
            <script src="https://unpkg.com/element-ui/lib/index.js"></script>


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
                                    style="text-decoration: none;text-align: center;background-color: #569b92;color: white;;display: block;"><span class="el-icon-arrow-left"></span></a>
                            </div>

                        </div>
                        <br>
                        <form action="${pageContext.request.contextPath}/work/SaveWork" method="post" id="myform"
                            class="basefrom g-3 ">
                            <div class="row">
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
                                    <div class="col-md-3 cell FormPadding">
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
                                    <div class="col-md-3 cell FormPadding">
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
                                            <div class="col-md-9 cell FormPadding " style="background-color: #ccc;"
                                                @click="dialogTableVisible = true ">
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
                                            <div class="col-md-9 cell FormPadding" style="background-color: #ccc;"
                                                onclick="showCustomer()">
                                                <a href="${pageContext.request.contextPath}/CRM/potentialcustomer/${bean.customer.customerid}"
                                                    target="_blank" class="customerName">${bean.customer.name}</a>
                                                <input type="hidden" class=" form-control cellFrom" name="customerid"
                                                    value="${bean.customer.customerid}" maxlength="20">

                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3 cell">銷售機會</div>
                                            <div class="col-md-9 cell FormPadding" style="background-color: #ccc;"
                                                onclick="showMarket()">
                                                <a href="${pageContext.request.contextPath}/Market/Market/${bean.market.marketid}"
                                                    target="_blank" class="marketName">${bean.market.name}</a>
                                                <input type="hidden" class=" form-control cellFrom" name="marketid"
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

                    }
                },
                created() {
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
                                if (iterator.contactid == newValue){
                                    this.clientbean = iterator                                    
                                } 
                            }
                        }
                    }
                }, methods: {
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
                                this.contact ={}
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });

                    }
                },
            })

        </script>

        </html>