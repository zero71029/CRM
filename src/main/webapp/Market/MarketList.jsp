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
            <!-- 引入样式 -->
            <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
            <!-- 引入组件库 -->
            <script src="https://unpkg.com/element-ui/lib/index.js"></script>

            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>
                .item:hover {
                    background-color: #afe3d5;
                }
            </style>
        </head>

        <body>
            <div class="container-fluid">
                <div class="row">
                    <!-- <%-- 插入側邊欄--%> -->
                    <jsp:include page="/Sidebar.jsp"></jsp:include>

                    <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
                    <div class="col-md-11 app">
                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/Market.jsp'">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>

                                <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                <label class="btn btn-outline-primary state2" for="btncheck2" onclick="sta()">刪除</label>
                                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck3"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/MarketList'">XXX</label>

                                <input type="checkbox" class="btn-check" id="btncheck4" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck4" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">搜索</label>
                            </div>
                        </div>

                        <!-- <%-- 中間主體--%> -->
                        <table class="Table table-striped orderTable">
                            <tr>
                                <td><input type="checkbox" id="activity"></td>
                                <td>名稱</td>
                                <td>客戶</td>
                                <td>負責人</td>
                                <td>類型</td>
                                <td>階段</td>
                                <td>機率</td>
                                <td>開始時間</td>
                                <td>終止時間</td>
                            </tr>
                            <tr class="item" v-for="(s, index) in list" :key="index">
                                <td><input type="checkbox" :value="s.marketid" name="mak"></td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.name}}</td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.client}}</td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.user}}</td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.type}}</td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.stage}}</td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.clinch}}</td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.createtime}}</td>
                                <td v-on:click="market(s.marketid)">
                                    {{s.endtime}}</td>
                            </tr>

                        </table>

                        <!-- 滑塊 -->
                        <div class="offcanvas offcanvas-end " tabindex="0" id="offcanvasRight"
                            aria-labelledby="offcanvasRightLabel" style="width: 450px;">
                            <div class="offcanvas-header">
                                <h5 id="offcanvasRightLabel">搜索</h5>
                                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                                    aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body">
                                <div class="accordion accordion-flush" id="accordionFlushExample">
                                    <!-- 負責人 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingOne">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#flush-collapseOne"
                                                aria-expanded="false" aria-controls="flush-collapseOne">
                                                負責人
                                            </button>
                                        </h2>
                                        <div id="flush-collapseOne" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <ul class=" ">
                                                    <c:if test="${not empty admin}">
                                                        <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                            items="${admin}" var="s">
                                                            <li><a v-on:click="admin('${s.name}')"
                                                                    href="#">${s.name}</a>
                                                            </li>
                                                        </c:forEach>
                                                    </c:if>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 建立日期 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingTwo">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo"
                                                aria-expanded="false" aria-controls="flush-collapseTwo">
                                                建立日期
                                            </button>
                                        </h2>
                                        <div id="flush-collapseTwo" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">        
                                                    
                                                    <dp></dp>
                                                    <input type="submit" value="送出" v-on:click="selectCreateDate">
                                           
                                            </div>
                                        </div>

                                    </div>
                                    <!-- 機會名稱-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#flush-collapseThree"
                                                aria-expanded="false" aria-controls="flush-collapseThree">
                                                機會名稱
                                            </button>
                                        </h2>
                                        <div id="flush-collapseThree" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <form action="${pageContext.request.contextPath}/Market/selectMarket"
                                                    method="post">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control" placeholder=""
                                                            aria-label="Recipient's username"
                                                            aria-describedby="button-addon2" name="name">
                                                        <button class="btn btn-outline-secondary" type="submit"
                                                            id="selectProduct">搜索</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  客戶-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i4" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                客戶
                                            </button>
                                        </h2>
                                        <div id="i4" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <form action="${pageContext.request.contextPath}/Market/selectMarket"
                                                    method="post">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control" placeholder=""
                                                            aria-label="Recipient's username"
                                                            aria-describedby="button-addon2" name="name" list="company">
                                                        <button class="btn btn-outline-secondary" type="submit"
                                                            id="selectProduct">搜索</button>
                                                        <datalist id="company">
                                                            <c:if test="${not empty client}">
                                                                <c:forEach varStatus="loop" begin="0"
                                                                    end="${client.size()-1}" items="${client}" var="s">
                                                                    <option value="${s.name}">
                                                                </c:forEach>
                                                            </c:if>
                                                        </datalist>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 狀態-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i5" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                狀態
                                            </button>
                                        </h2>
                                        <div id="i5" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <ul class=" ">
                                                    <li><a
                                                            href="${pageContext.request.contextPath}/Market/selectStage/尚未處理">尚未處理</a>
                                                    </li>
                                                    <li><a
                                                            href="${pageContext.request.contextPath}/Market/selectStage/需求確認">需求確認</a>
                                                    </li>
                                                    <li><a
                                                            href="${pageContext.request.contextPath}/Market/selectStage/聯繫中">聯繫中</a>
                                                    </li>
                                                    <li><a
                                                            href="${pageContext.request.contextPath}/Market/selectStage/處理中">處理中</a>
                                                    </li>
                                                    <li><a
                                                            href="${pageContext.request.contextPath}/Market/selectStage/已報價">已報價</a>
                                                    </li>
                                                    <li><a
                                                            href="${pageContext.request.contextPath}/Market/selectStage/成功結案">成功結案</a>
                                                    </li>
                                                    <li><a
                                                            href="${pageContext.request.contextPath}/Market/selectStage/失敗結案">失敗結案</a>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  聯絡人-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i6" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                聯絡人
                                            </button>
                                        </h2>
                                        <div id="i6" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <form action="${pageContext.request.contextPath}/Market/selectMarket"
                                                    method="post">
                                                    <div class="input-group mb-3">
                                                        <input type="text" class="form-control" placeholder=""
                                                            aria-label="Recipient's username"
                                                            aria-describedby="button-addon2" name="name">
                                                        <button class="btn btn-outline-secondary" type="submit"
                                                            id="selectProduct">搜索</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  聯絡人電話-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i7" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                聯絡人電話
                                            </button>
                                        </h2>
                                        <div id="i7" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                ke itf how this would look in a real-world application.
                                            </div>
                                        </div>
                                    </div>
                                    <!--  XXXXX-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i8" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                XXXXX
                                            </button>
                                        </h2>
                                        <div id="i8" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                ke itf how this would look in a real-world application.
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </body>
        <script>
            $(".market").show();
            // 勾選單項
            var $all = $("input[name=mak]");
            $("input[type=checkbox][name=mak]").change(function () {
                var $zx = $("input[name=mak]:checked");
                $("#activity").prop("checked", $zx.length == $all.length);
            });
            // 勾選全部
            $("#activity").change(function () {
                $all.prop("checked", this.checked);
            });
            //  刪除按鈕
            function sta() {

                var $zx = $("input[name=mak]:checked");
                if ($zx.length == 0) {
                    alert("須勾選要刪除項目");
                } else {
                    if (confirm("警告 ! 確定修改?")) {
                        var parm = "";
                        for (var a = 0; a < $zx.length; a++) {
                            parm += "id=" + $($zx[a]).val();
                            if (a < $zx.length - 1) parm += "&";
                        }
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/delMarket', //接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/Market/MarketList";
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                    }
                }

            }
        </script>
        <script>
            //時間選擇器
            Vue.component('dp', {
                template:
                    '<div class="block"><el-date-picker v-model="value2"      type="daterange"      align="right"      unlink-panels      range-separator="到"      start-placeholder="開始"      end-placeholder="結束" :picker-options="pickerOptions"></el-date-picker></div>',
                data() {
                    return {
                        pickerOptions: {
                            shortcuts: [{
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
                        value1: '',
                        value2: ''
                    };
                },
                
            })
            Vue.config.productionTip = false;
            const vm = new Vue({
                el: '.app',
              
                data: {
                    list: [],
                    name: "",
                    show: true,
                    source: [],
                    ind: ["尚未分類", '生產 製造', '工程公司', '學校', '研究單位', '電子業', '光電產業', '半導體業', '公家機關', '機械設備製造', '生技製藥', '食品加工', '醫院/醫療', '物流/倉儲', '畜牧/農業', '公共/消費性環境', '製紙業', '紡織業', '化工業', '金屬加工', '冷凍空調', '航太/造船', '環保相關', '水處理/水資源', '石化能源', '印刷', '其它', '業主', '設備換修'],
                    industry: [],
                },
                created: function () {
                    axios
                        .get('${pageContext.request.contextPath}/Market/MarketList')
                        .then(response => (
                            this.list = response.data
                        ))
                        .catch(function (error) { // 请求失败处理
                            console.log(error);
                        });
                },
                methods: {
                    market: function (id) {
                        this.show = false
                        setTimeout(function () {
                            location.href = '${pageContext.request.contextPath}/Market/Market/' + id
                        }, 100)

                    },
                    closed: function () {
                        axios
                            .get('${pageContext.request.contextPath}/Potential/closed')
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    },
                    admin: function (name) {
                        console.log(name)
                        axios
                            .get('${pageContext.request.contextPath}/Market/selectMarket/' + name)
                            .then(response => (
                                this.list = response.data,
                                console.log(response.data)
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    },
                    selectCreateDate: function (value2) {
                        console.log(this.value1);
                        console.log(value2)

                        // axios
                        //     .get('${pageContext.request.contextPath}/Potential/selectDate?from=' + $('#from').val() + "&to=" + $('#to').val())
                        //     .then(response => (
                        //         this.list = response.data
                        // console.log(this.list)
                        //     ))
                        //     .catch(function (error) { // 请求失败处理
                        //         console.log(error);
                        //     });
                    },
                    // selectCustomer: function () {
                    //     axios
                    //         .get('${pageContext.request.contextPath}/Potential/admin/' + this.name)
                    //         .then(response => (
                    //             this.list = response.data
                    //         ))
                    //         .catch(function (error) { // 请求失败处理
                    //             console.log(error);
                    //         });
                    // }, selectStatus: function (status) {
                    //     axios
                    //         .get('${pageContext.request.contextPath}/Potential/status/' + status)
                    //         .then(response => (
                    //             this.list = response.data
                    //         ))
                    //         .catch(function (error) { // 请求失败处理
                    //             console.log(error);
                    //         });
                    // }, selectSource: function () {
                    //     var da = { source: this.source };
                    //     axios
                    //         .post('${pageContext.request.contextPath}/Potential/selectSource', da)
                    //         .then(response => (
                    //             this.list = response.data
                    //         ))
                    //         .catch(function (error) { // 请求失败处理
                    //             console.log(error);
                    //         });
                    // }
                },
            })
        </script>
        <script>
            $(function () {
                $("#from").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd"
                });
                $("#to").datepicker({
                    changeMonth: true,
                    changeYear: true,
                    dateFormat: "yy-mm-dd"
                });
            });
        </script>
        <style>
            .el-date-editor--daterange.el-input__inner{
                width: auto;
            }
        </style>




        </html>