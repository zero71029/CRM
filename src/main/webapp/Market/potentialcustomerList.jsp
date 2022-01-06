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

                    <div class="col-md-10 app">
                        <!-- 滑塊 -->
                        <div class="offcanvas offcanvas-end" tabindex="0" id="offcanvasRight"
                            aria-labelledby="offcanvasRightLabel" style="width: 300px;">
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
                                                <form action="${pageContext.request.contextPath}/Potential/selectDate"
                                                    method="post">
                                                    <input type="text" class="form-control" id="from" readonly required>
                                                    到
                                                    <input type="text" class="form-control" required id="to" readonly>
                                                    <input type="button" value="送出" v-on:click="selectDate">
                                                </form>
                                            </div>
                                        </div>

                                    </div>
                                    <!-- 聯絡人-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#flush-collapseThree"
                                                aria-expanded="false" aria-controls="flush-collapseThree">
                                                聯絡人
                                            </button>
                                        </h2>
                                        <div id="flush-collapseThree" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="name"
                                                        aria-label="Recipient's username"
                                                        aria-describedby="button-addon2" name="name">
                                                    <button class="btn btn-outline-secondary" type="submit"
                                                        v-on:click="selectCustomer()" id="selectProduct">搜索</button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <!-- 公司名稱-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i4" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                公司名稱
                                            </button>
                                        </h2>
                                        <div id="i4" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="name"
                                                        aria-label="Recipient's username"
                                                        aria-describedby="button-addon2" name="name">
                                                    <button class="btn btn-outline-secondary" type="submit"
                                                        v-on:click="selectCustomer()" id="selectProduct">搜索</button>
                                                </div>

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
                                                    <li><a v-on:click="selectStatus('未處理')" href="#">未處理</a>
                                                    </li>
                                                    <li><a v-on:click="selectStatus('已聯繫')" href="#">已聯繫</a>
                                                    </li>
                                                    <li><a v-on:click="selectStatus('不合格')" href="#">不合格</a>
                                                    </li>
                                                    <li><a v-on:click="selectStatus('合格')" href="#">合格</a>
                                                    </li>

                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  來源 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i6" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                來源
                                            </button>
                                        </h2>
                                        <div id="i6" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="自己打來" id="s1"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s1">
                                                        自己打來
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="員工推薦" id="s2"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s2">
                                                        員工推薦
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="外部推薦" id="s3"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s3">
                                                        外部推薦
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="合作夥伴" id="s4"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s4">
                                                        合作夥伴
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="公共關係" id="s5"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s5">
                                                        公共關係
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="研討會 - 內部"
                                                        id="s6" name="source" v-model="source">
                                                    <label class="form-check-label" for="s6">
                                                        研討會 - 內部
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="研討會 - 合作夥伴"
                                                        id="s7" name="source" v-model="source">
                                                    <label class="form-check-label" for="s7">
                                                        研討會 - 合作夥伴
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="廣告" id="s8"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s8">
                                                        廣告
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="參展" id="s9"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s9">
                                                        參展
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="網絡" id="s10"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s10">
                                                        網絡
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="口碑" id="s11"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s11">
                                                        口碑
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="其他" id="s12"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s12">
                                                        其他
                                                    </label>
                                                </div>
                                                <button class="btn btn-outline-secondary" v-on:click="selectSource"
                                                    id="selectProduct">搜索</button>


                                            </div>
                                        </div>
                                    </div>
                                    <!--  產業-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i7" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                產業
                                            </button>
                                        </h2>
                                        <div id="i7" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">                                            
                                            <div class="accordion-body" >
                                                <div class="form-check" v-for="(s, index) in ind" :key="index">
                                                    <input class="form-check-input" type="checkbox" :value="s" :id="'industry'+index"
                                                        name="industry" v-model="source">
                                                    <label class="form-check-label" :for="'industry'+index">
                                                        {{s}}
                                                    </label>
                                                </div>
                                            </div>
                                            <button class="btn btn-outline-secondary" v-on:click="selectSource"
                                            id="selectProduct">搜索</button>
                                        </div>
                                    </div>
                                    <!--  XXXXX-->
                                    <!-- <div class="accordion-item">
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
                                    </div> -->
                                </div>

                            </div>
                        </div>


                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/potentialcustomer/0'">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新增</label>
                                <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                <label class="btn btn-outline-primary state2" for="btncheck2" onclick="sta()">刪除</label>
                                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck3"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/PotentialCustomerList'">XXX</label>

             
                                <label class="btn btn-outline-primary" for="btncheck4"  data-bs-toggle="offcanvas"
                                data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">搜索</label>
                            </div>
                        </div>

                        <transition-group name="slide-fade" appear>
                            <!-- <%-- 中間主體--%> -->
                            <table class="Table table-striped orderTable" v-if="show" key="1">
                                <tr>
                                    <td><input type="checkbox" id="activity"></td>
                                    <td>編號</td>
                                    <td>聯絡人</td>
                                    <td>狀態</td>
                                    <td>客戶公司</td>
                                    <td>產業</td>
                                    <td>部門</td>
                                    <td>建立時間</td>
                                    <td>負責人</td>
                                </tr>
                                <tr class="item" v-for="(s, index) in list" :key="s.customerid">
                                    <td><input type="checkbox" value="{s.customerid}" name="mak"></td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.customerid}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.name}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.status}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.company}}</td>

                                    <td v-on:click="customer(s.customerid)">
                                        {{s.industry}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.department}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.createtime}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.user}}</td>
                                </tr>
                            </table>
                        </transition-group>
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
                        console.log(parm);
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Market/delPotentialCustomer',//接受請求的Servlet地址
                            type: 'POST',
                            data: parm,
                            // dataType:"json",
                            // async: false,//同步請求
                            // cache: false,//不快取頁面
                            // contentType: false,//當form以multipart/form-data方式上傳檔案時，需要設定為false
                            // processData: false,//如果要傳送Dom樹資訊或其他不需要轉換的資訊，請設定為false

                            success: function (json) {
                                alert(json);
                                window.location.href = "${pageContext.request.contextPath}/Market/PotentialCustomerList";
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
            Vue.config.productionTip = false;
            const vm = new Vue({
                el: '.app',
                data: {
                    list: [],
                    name: "",
                    show: true,
                    source: [],
                    ind:["尚未分類",'生產 製造','工程公司','學校','研究單位','電子業','光電產業','半導體業','公家機關','機械設備製造','生技製藥','食品加工','醫院/醫療','物流/倉儲','畜牧/農業','公共/消費性環境','製紙業','紡織業','化工業','金屬加工','冷凍空調','航太/造船','環保相關','水處理/水資源','石化能源','印刷','其它','業主','設備換修'],
                    industry:[],
                },
                created: function () {
                    axios
                        .get('${pageContext.request.contextPath}/Potential/CustomerList')
                        .then(response => (
                            this.list = response.data
                        ))
                        .catch(function (error) { // 请求失败处理
                            console.log(error);
                        });
                },
                methods: {
                    customer: function (id) {
                        this.show = false
                        setTimeout(function () {
                            location.href = '${pageContext.request.contextPath}/Market/potentialcustomer/' + id
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
                        axios
                            .get('${pageContext.request.contextPath}/Potential/admin/' + name)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    },
                    selectDate: function () {
                        axios
                            .get('${pageContext.request.contextPath}/Potential/selectDate?from=' + $('#from').val() + "&to=" + $('#to').val())
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    },
                    selectCustomer: function () {
                        axios
                            .get('${pageContext.request.contextPath}/Potential/admin/' + this.name)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    }, selectStatus: function (status) {
                        axios
                            .get('${pageContext.request.contextPath}/Potential/status/' + status)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    }, selectSource: function () {
                        var da = {source:this.source};
                        axios
                            .post('${pageContext.request.contextPath}/Potential/selectSource',da)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    }
                },
            })
        </script>
        <!-- 日期UI -->
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
                transform: translateY(200%);
                opacity: 0;
            }
        </style>

        </html>