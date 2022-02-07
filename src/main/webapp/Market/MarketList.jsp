<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">


            <!-- 引入样式 vue-->
            <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
            <script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
            <!-- 引入element-ui样式 -->
            <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
            <!-- 引入element-ui组件库 -->
            <script src="https://unpkg.com/element-ui/lib/index.js"></script>

            <!-- <%-- 主要的CSS、JS放在這裡--%> -->
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
            <title>CRM客戶管理系統</title>
            <style>
                .marketbar {
                    /* 按鈕顏色 */
                    background-color: #afe3d5;
                }

                .item:hover {
                    background-color: #afe3d5;
                }

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
                                    @click="aadmin(admin)">{{admin}}</label>

                                <input type="checkbox" class="btn-check" id="btncheck4" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck4" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">搜索</label>
                            </div>
                        </div>

                        <!-- <%-- 中間主體--%> -->
                        <transition-group name="slide-fade" appear>
                            <table class="Table table-striped orderTable" key="1" v-if="show">
                                <tr>
                                    <td><input type="checkbox" id="activity"></td>
                                    <td>名稱</td>
                                    <td>客戶</td>
                                    <td>負責人</td>
                                    <td>產業</td>
                                    <td>階段</td>
                                    <td>機率</td>
                                    <td @click="sortItem('important')"><a href="#">重要性</a></td>
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
                                    <td v-on:click="market(s.marketid)" :class="'important'+index">
                                        {{s.important}}</td>
                                    <td v-on:click="market(s.marketid)">
                                        {{s.endtime}}</td>
                                </tr>

                            </table>
                        </transition-group>
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
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingOne">
                                            <button class="accordion-button collapsed" type="button"
                                                onclick="javascript:location.href='${pageContext.request.contextPath}/Market/MarketList.jsp'">
                                                重置
                                            </button>
                                        </h2>
                                    </div>
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
                                                            <li><a v-on:click="aadmin('${s.name}')"
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

                                                <dp @update="selfUpdate"></dp>


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

                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" placeholder=""
                                                        aria-label="Recipient's username" v-model="name"
                                                        aria-describedby="button-addon2" name="name">
                                                    <button class="btn btn-outline-secondary" @click="selectCustomer"
                                                        id="selectProduct">搜索</button>
                                                </div>

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

                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" placeholder=""
                                                        v-model="name" aria-label="Recipient's username"
                                                        aria-describedby="button-addon2" name="name" list="company">
                                                    <button class="btn btn-outline-secondary" @click="selectCustomer"
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
                                                    <li><a href="#" @click="selectStatus('尚未處理')">尚未處理</a>
                                                    </li>
                                                    <li><a href="#" @click="selectStatus('需求確認')">需求確認</a>
                                                    </li>
                                                    <li><a href="#" @click="selectStatus('聯繫中')">聯繫中</a>
                                                    </li>
                                                    <li><a href="#" @click="selectStatus('處理中')">處理中</a>
                                                    </li>
                                                    <li><a href="#" @click="selectStatus('已報價')">已報價</a>
                                                    </li>
                                                    <li><a href="#" @click="selectStatus('成功結案')">成功結案</a>
                                                    </li>
                                                    <li><a href="#" @click="selectStatus('失敗結案')">失敗結案</a>
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
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" placeholder=""
                                                        aria-label="Recipient's username" v-model="name"
                                                        aria-describedby="button-addon2" name="name">
                                                    <button class="btn btn-outline-secondary" @click="selectCustomer"
                                                        id="selectProduct">搜索</button>
                                                </div>

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
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" placeholder=""
                                                        aria-label="Recipient's username" v-model="ContantPhone"
                                                        aria-describedby="button-addon2" name="ContantPhone">
                                                    <button class="btn btn-outline-secondary"
                                                        @click="selectContantPhone" id="selectProduct">搜索</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  產品類別-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i8" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                產品類別
                                            </button>
                                        </h2>
                                        <div id="i8" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <el-checkbox :indeterminate="isIndeterminate" v-model="checkAll"
                                                    @change="handleCheckAllChange">全选</el-checkbox>
                                                <div style="margin: 15px 0;"></div>
                                                <el-checkbox-group v-model="checkedCities"
                                                    @change="handleCheckedCitiesChange">
                                                    <div class="row">
                                                        <div class="col-md-5" v-for="city in cities" :key="city">
                                                            <el-checkbox :label="city">
                                                                {{city}}</el-checkbox>
                                                        </div>
                                                    </div>
                                                </el-checkbox-group>
                                                <el-button type="primary" @click="selectProductType"
                                                    style="width: 100%;">送出</el-button>


                                            </div>
                                        </div>
                                    </div>
                                    <!--  機會來源 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i9" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                機會來源
                                            </button>
                                        </h2>
                                        <div id="i9" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <el-checkbox :indeterminate="isSource" v-model="sourceAll"
                                                    @change="CheckSourceAllChange">全选</el-checkbox>
                                                <div style="margin: 15px 0;"></div>
                                                <el-checkbox-group v-model="checkedSources"
                                                    @change="handleCheckedSourcesChange">
                                                    <div class="row">
                                                        <div class="col-md-5" v-for="source in sources" :key="source">
                                                            <el-checkbox :label="source">
                                                                {{source}}</el-checkbox>
                                                        </div>
                                                    </div>
                                                </el-checkbox-group>
                                                <el-button type="primary" @click="selectSource" style="width: 100%;">送出
                                                </el-button>

                                            </div>
                                        </div>
                                    </div>
                                    <!--  成交機率-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i10" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                成交機率
                                            </button>
                                        </h2>
                                        <div id="i10" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <el-rate v-model="clinch" show-text
                                                    :texts="['極差', '失望', '一般', '滿意', '驚喜']" style="height: 30px;"
                                                    :colors="{ 2: '#99A9BF', 3:  '#F7BA2A', 4: '#FF9900', 5: 'red' }">
                                                </el-rate>
                                                <el-button type="primary" @click="selectClinch" style="width: 100%;">送出
                                                </el-button>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  預算-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i11" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                預算
                                            </button>
                                        </h2>
                                        <div id="i11" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="budget1">
                                                    <span class="input-group-text">~</span>
                                                    <input type="text" class="form-control" v-model="budget2">
                                                    <el-button type="primary" @click="selectBudget"
                                                        style="width: 100%;">送出
                                                    </el-button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!--  XXXXX-->
                                    <!-- <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i12" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                XXXXX
                                            </button>
                                        </h2>
                                        <div id="i12" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                ke itf how this would look in a real-world application.
                                            </div>
                                        </div>
                                    </div> -->
                                    <!--  XXXXX-->
                                    <!-- <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i13" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                XXXXX
                                            </button>
                                        </h2>
                                        <div id="i13" class="accordion-collapse collapse"
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
            //element-ui時間選擇器
            Vue.component('dp', {
                template:
                    '<div class="block"> <el-date-picker v-model="value2"      type="daterange"      align="right"      unlink-panels      range-separator="到"      start-placeholder="開始b日期"      end-placeholder="結束日期" :picker-options="pickerOptions" value-format="yyyy-MM-dd"></el-date-picker> <input type="submit" value="送出" v-on:click="updateText"> </div>',
                data() {
                    return {
                        pickerOptions: {
                            shortcuts: [
                            {
                                text: '今天',
                                onClick(picker) {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime() - 3600 * 1000 * 24 );
                                    picker.$emit('pick', [start, end]);
                                }
                            },{
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
                methods: {
                    updateText() {
                        //事件名稱 //value =>this.message是指子層的噢！
                        this.$emit('update', this.value2);
                    }
                },

            })
            const cityOptions = ['尚未分類', '大型顯示器', '空氣品質', '流量-AICHI', '流量-RGL', '流量-其他'
                , '記錄器', '資料收集器-JETEC', '資料收集器-其他'
                , '溫濕-JETEC', '溫濕-GALLTEC'
                , '溫濕-E+E', '溫濕-其他'
                , '紅外線', '壓力-JETEC', '壓力-HUBA'
                , '壓力-COPAL', '壓力-其他', '差壓'
                , '氣體-JETEC', '氣體-Senko', '氣體-GASDNA'
                , '氣體-手持', '氣體-其他', '氣象儀器-土壤/pH'
                , '氣象儀器-日照/紫外線', '氣象儀器-風速/風向', '氣象儀器-雨量'
                , '氣象儀器-其他', '水質相關', '液位/料位-JETEC'
                , '液位/料位-DINEL', '液位/料位-HONDA'
                , '液位/料位-其他', '溫度貼紙', '溫控器-TOHO'
                , '溫控器-其他', '能源管理控制', '無線傳輸'
                , '編碼器/電位計', '食品', '其它'];
            const sourceOptions = ['廣告', '員工推薦', '外部推薦', '合作夥伴', '參展', '網絡搜索', '口碑', '其他'];
            Vue.config.productionTip = false;
            const vm = new Vue({
                el: '.app',
                data: {
                    list: [],
                    name: "",
                    show: false,
                    admin: '${user.name}',
                    ind: ["尚未分類", '生產 製造', '工程公司', '學校', '研究單位', '電子業', '光電產業', '半導體業', '公家機關', '機械設備製造', '生技製藥', '食品加工', '醫院/醫療', '物流/倉儲', '畜牧/農業', '公共/消費性環境', '製紙業', '紡織業', '化工業', '金屬加工', '冷凍空調', '航太/造船', '環保相關', '水處理/水資源', '石化能源', '印刷', '其它', '業主', '設備換修'],
                    industry: [],
                    ContantPhone: "",
                    //產品類別
                    checkAll: false,
                    isIndeterminate: true,
                    cities: cityOptions,
                    checkedCities: ['尚未分類'],
                    //來源
                    sourceAll: false,
                    isSource: false,
                    sources: sourceOptions,
                    checkedSources: [],
                    clinch: null,
                    budget1: "0",
                    budget2: "",
                },
                created: function () {
                    console.log(this.admin)

                    if (this.admin != "") {
                        axios
                            .get('${pageContext.request.contextPath}/Market/MarketList')
                            .then(response => (
                                this.list = response.data,
                                this.show = true
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    } else {
                        alert("沒有權限");
                        location.href = "${pageContext.request.contextPath}/"
                    }
                },
                methods: {
                    //////////////////////產品類別
                    handleCheckAllChange(val) {
                        this.checkedCities = val ? cityOptions : [];
                        this.isIndeterminate = false;
                    },
                    handleCheckedCitiesChange(value) {
                        this.checkedSources = [];//重置來源
                        let checkedCount = value.length;
                        this.checkAll = checkedCount === this.cities.length;
                        this.isIndeterminate = checkedCount > 0 && checkedCount < this.cities.length;
                    },
                    ////////////////////////////產品類別結束
                    //////////////////////來源
                    CheckSourceAllChange(val) {
                        this.checkedSources = val ? sourceOptions : [];
                        this.isSource = false;
                    },
                    handleCheckedSourcesChange(value) {
                        this.checkedCities = ['尚未分類'];//重置類別結束
                        let checkedCount = value.length;
                        this.sourceAll = checkedCount === this.sources.length;
                        this.isSource = checkedCount > 0 && checkedCount < this.sources.length;
                    },
                    ////////////////////////////來源結束
                    market: function (id) {
                        this.show = false
                        setTimeout(function () {
                            location.href = '${pageContext.request.contextPath}/Market/Market/' + id
                        }, 200)

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
                    aadmin: function (name) {//搜索負責人
                        console.log(name)
                        axios
                            .get('${pageContext.request.contextPath}/Market/selectMarket/' + name)
                            .then(response => (
                                this.list = response.data,
                                console.log(response.data)
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    selfUpdate(val) {//搜索建立日期
                        console.log(val)

                        axios
                            .get('${pageContext.request.contextPath}/Market/selectDate?from=' + val[0] + "&to=" + val[1])
                            .then(response => (
                                this.list = response.data,
                                console.log(this.list)
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    selectCustomer: function () {//搜索客戶
                        axios
                            .get('${pageContext.request.contextPath}/Market/selectMarket/' + this.name)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    selectStatus: function (status) {//搜索狀態
                        axios
                            .get('${pageContext.request.contextPath}/Market/selectStage/' + status)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    },
                    selectContantPhone: function () {
                        axios
                            .get('${pageContext.request.contextPath}/Market/selectContantPhone/' + this.ContantPhone)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    //select產品類別
                    selectProductType: function () {
                        axios
                            .post('${pageContext.request.contextPath}/Market/selectProductType', this.checkedCities)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    //select來源

                    selectSource: function () {
                        axios
                            .post('${pageContext.request.contextPath}/Market/selectSource', this.checkedSources)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    selectClinch: function () {
                        axios
                            .post('${pageContext.request.contextPath}/Market/selectClinch/' + this.clinch)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    selectBudget: function () {//select預算                        
                        axios
                            .post('${pageContext.request.contextPath}/Market/selectBudget/' + this.budget1 + "/" + this.budget2)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    }, 
                    sortItem: function (direct) {//重要性 排序                        
                        var d = $('.' + direct + '0').text().trim();
                        var oldList = this.list;
                        const imp = ["高", "中", "低",""];//先輪替這列表
                        var nimp = []
                        this.list = [];
                        var b = false;
                        var i = imp.indexOf(d);//找到輸入第幾個
                        for (let index = i + 1; index < 3; index++) {
                            nimp.push(imp[index])
                        }

                        //根據列表抓數據
                        for (let index = 0; index <= i; index++) {                           
                            nimp.push(imp[index])
                        }
                        for (const iterator of nimp) {
                            for (var o of oldList) {
                                if (o.important == iterator) this.list.push(o)
                            }
                        }
                    },
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
            .el-date-editor--daterange.el-input__inner {
                width: auto;
            }

            .el-rate__icon {
                font-size: 30px;
                width: 30px;

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
                transform: translateY(200%);
                opacity: 0;
            }
        </style>




        </html>