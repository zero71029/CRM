<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">


            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>
                [v-cloak] {
                    display: none;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>
                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11 app" v-cloak>
                        <div class="row ">
                            <div class="col-md-12">
                                <!-- <%-- 中間主體--%> -->

                                <div class="row ">
                                    <div>銷售任務</div>
                                    <table class="Table table-striped orderTable">
                                        <tr>
                                            <td></td>
                                            <td style="max-width: 130px;">階段</td>
                                            <td>負責人</td>
                                            <td>領取</td>
                                            <td style="width: 230px;">客戶</td>
                                            <td>描述</td>
                                            <td>建立時間</td>
                                            <td>追蹤次數</td>
                                            <c:if test="${user.position == '主管' || user.position == '系統'}">
                                                <td>點擊數</td>
                                            </c:if>
                                        </tr>
                                        <tr class="item" v-for="(s, index) in Market" :key="index">
                                            <%-- 列表編號--%>
                                                <td>{{index+1}}</td>
                                                <!-- 階段 -->
                                                <td v-on:click="market(s.marketid)" :class="'state'+index"
                                                    style="cursor: pointer;">
                                                    {{s.stage}}
                                                </td>
                                                <!-- 負責人 -->
                                                <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                                                    {{s.user}}
                                                </td>
                                                <!-- 領取 -->
                                                <td> {{  receives(s.receivestate) }} </td>
                                                <!-- 客戶 -->
                                                <td> {{s.client}} </td>
                                                <td v-if="s.message.length <100 " style="width: 500px;">
                                                    <a :href="'${pageContext.request.contextPath}/Market/Market/'+s.marketid"
                                                        target="_blank"> {{s.message}}</a>
                                                </td>
                                                <!-- 描述 -->
                                                <td v-on:click="market(s.marketid)" v-if="s.message.length >=100 ">
                                                    <el-popover placement="top-start" width="300" trigger="hover"
                                                        :content="s.message">
                                                        <el-button slot="reference" class="text-truncate text-start"
                                                            style="width: 500px; color: #000;" type="text">{{s.message}}
                                                        </el-button>
                                                    </el-popover>
                                                </td>
                                                <!--  建立時間-->
                                                <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                                                    <span>{{s.aaa}}</span>
                                                    <br>
                                                    <span class="text-danger">{{s.tracktime}}</span>
                                                </td>
                                                <!-- 追蹤次數 -->
                                                <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                                                    {{s.trackbean.length}}
                                                </td>
                                                <!-- 點擊數 -->
                                                <c:if test="${user.position == '主管' || user.position == '系統'}">
                                                    <td>{{s.clicks}}</td>
                                                </c:if>
                                        </tr>

                                    </table>
                                </div>
                                <div class="row ">
                                    <div>潛在客戶</div>
                                    <table class="Table table-striped orderTable">
                                        <tr>
                                            <td></td>
                                            <td style="width: 90px;">狀態</td>
                                            <td style="width: 90px;">負責人</td>
                                            <td>領取</td>
                                            <td>客戶名稱</td>
                                            <td>詢問內容</td>
                                            <td style="width: 130px;">建立時間</td>

                                        </tr>
                                        <tr class="item" v-for="(s, index) in Customer" :key="s.customerid">
                                            <!-- <%-- 列表編號--%> -->
                                            <td>{{index+1}} <span class="badge rounded-pill bg-danger"
                                                    v-show="s.bm.length > 0">{{s.bm.length ==
                                                    0?"":s.bm.length}}</span>
                                                <i class="el-icon-help" style="color: red;" v-if="s.callhelp == 1"></i>
                                            </td>
                                            <td v-on:click="customer(s.customerid)" style="cursor: pointer;"
                                                :class="'state'+index">
                                                {{s.status}}</td>


                                            <td v-on:click="customer(s.customerid)" style="cursor: pointer;"
                                                v-html="s.user">
                                            </td>
                                            <td> {{receives(s.receivestate)}} </td>
                                            <td>
                                                {{s.company}}<i class="el-icon-paperclip" style="color: blue;"></i></td>
                                            <!-- 詢問內容 -->
                                            <td v-if="s.remark.length <100 " style="width: 900px;cursor: pointer;"
                                                v-on:click="customer(s.customerid)">{{s.remark}}</td>
                                            <td v-on:click="customer(s.customerid)" v-if="s.remark.length >=100 ">
                                                <el-popover placement="top-start" width="300" trigger="hover"
                                                    :content="s.remark">
                                                    <el-button slot="reference" class="text-truncate text-start"
                                                        style="width: 500px; color: #000;" type="text">{{s.remark}}
                                                    </el-button>
                                                </el-popover>
                                            </td>
                                            <!-- 建立時間 -->
                                            <td v-on:click="customer(s.customerid)" style="cursor: pointer;">
                                                {{s.aaa}}</td>


                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            //state 1 成功  2 失敗  3未結案 4全
            //receices 1領取 2分配  3 全
            const url = new URL(location.href);
            const parm = url.search;
            console.log(parm);


            var vm = new Vue({
                el: ".app",
                data() {
                    return {
                        Market: [],
                        Customer: []

                    }
                },
                created() {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/statistic/BusinessDetail' + parm,
                        type: 'POST',
                        async: false,
                        cache: false,
                        success: response => {
                            this.Customer = response.Customer;
                            this.Market = response.Market;
                            console.log(this.Customer);
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                },
                methods: {
                    market(id) {//進入詳細頁面
                        $.ajax({//點擊數
                            url: '${pageContext.request.contextPath}/Market/clicks/' + id,
                            type: 'POST',
                            success: function (url) {
                                window.open('${pageContext.request.contextPath}/Market/Market/' + id);

                            },
                        });
                    },
                    //進入細節
                    customer: function (id) {
                        window.open('${pageContext.request.contextPath}/Market/potentialcustomer/' + id)

                    },
                    //轉換 領取狀態
                    receives(val){                        
                        switch(val){
                            case 1 :return"領取";
                            case 2 :return"分配";
                            case 3 :return"";
                        }
                     
                    },
                },

            })
        </script>




        </html>