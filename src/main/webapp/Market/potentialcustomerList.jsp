<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="zh-TW">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">

            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">


            <title>CRM客戶管理系統</title>
            <style>
                .customerbar {
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
                        <!-- 滑塊 -->
                        <div class="offcanvas offcanvas-end" tabindex="0" id="offcanvasRight" style="width: 450px;">
                            <div class="offcanvas-header">
                                <h5 id="offcanvasRightLabel"><i class="bi-search"></i>&nbsp; 搜索</h5>
                                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
                            </div>
                            <div class="offcanvas-body">
                                <div class="accordion accordion-flush" id="accordionFlushExample">


                                    <div class="accordion-body">
                                        <el-date-picker v-model="inDay" type="daterange" align="right" unlink-panels
                                            id="inDay" range-separator="到" start-placeholder="開始日期"
                                            end-placeholder="結束日期" :picker-options="pickerOptions"
                                            value-format="yyyy-MM-dd">
                                        </el-date-picker>
                                        <input type="submit" value="送出" @click="selectList" id="sendDay">
                                    </div>
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingOne">
                                            <button class="accordion-button collapsed" type="button"
                                                onclick="javascript:location.href='${pageContext.request.contextPath}/Market/potentialcustomerList.jsp'">
                                                <i class="bi bi-arrow-repeat"></i>&nbsp; 重置
                                            </button>
                                        </h2>
                                    </div>
                                    <!-- 負責人 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingOne">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#flush-collapseOne"
                                                id="principal">
                                                <i class="bi bi-person-square"></i>&nbsp; 負責人
                                            </button>
                                        </h2>
                                        <div id="flush-collapseOne" class="accordion-collapse collapse">
                                            <div id="flush-collapseOne" class="accordion-collapse collapse">
                                                <div class="accordion-body">
                                                    <el-checkbox-group v-model="inUserList">
                                                        <c:if test="${not empty admin}">
                                                            <c:forEach varStatus="loop" begin="0"
                                                                end="${admin.size()-1}" items="${admin}" var="s">
                                                                <c:if test="${s.department == '業務' }">
                                                                    <el-checkbox label="${s.name}"></el-checkbox>
                                                                </c:if>
                                                            </c:forEach>
                                                        </c:if>
                                                    </el-checkbox-group>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 詢問內容 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingTwo">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#selectContent" id="Inquiry">
                                                &nbsp; 詢問內容
                                            </button>
                                        </h2>
                                        <div id="selectContent" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="content"
                                                        name="content">
                                                    <button class="btn btn-outline-secondary" type="submit"
                                                        id="selectInquiry" v-on:click="selectList">搜索</button>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <!-- 聯絡人-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#flush-collapseThree"
                                                id="contact">
                                                <i class="bi bi-arrows-angle-contract"></i>&nbsp; 聯絡人
                                            </button>
                                        </h2>
                                        <div id="flush-collapseThree" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="name" name="name">
                                                    <button class="btn btn-outline-secondary" v-on:click="selectList"
                                                        id="selectContact">搜索</button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <!-- 公司名稱-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button" id="company"
                                                data-bs-toggle="collapse" data-bs-target="#i4">
                                                <i class="bi bi-building"></i>&nbsp; 公司名稱
                                            </button>
                                        </h2>
                                        <div id="i4" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="name">
                                                    <button class="btn btn-outline-secondary" type="submit"
                                                        id="selectCompany" v-on:click="selectList">搜索</button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>





                                    <!-- 電話-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button" id="company"
                                                data-bs-toggle="collapse" data-bs-target="#phone">
                                                <i class="bi bi-telephone-fill"></i>&nbsp; 電話
                                            </button>
                                        </h2>
                                        <div id="phone" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="phone">
                                                    <button class="btn btn-outline-secondary" type="submit"
                                                        id="selectCompany" v-on:click="selectList">搜索</button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>








                                    <!-- 狀態-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button" id="Status"
                                                data-bs-toggle="collapse" data-bs-target="#i5">
                                                <i class="bi bi-heart-pulse"></i>&nbsp; 狀態
                                            </button>
                                        </h2>
                                        <div id="i5" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <el-checkbox-group v-model="inStateList">
                                                    <el-checkbox label="未處理"></el-checkbox>
                                                    <el-checkbox label="已聯繫"></el-checkbox>
                                                    <el-checkbox label="提交主管"></el-checkbox>
                                                    <el-checkbox label="不合格"></el-checkbox>
                                                    <el-checkbox label="合格"></el-checkbox>
                                                </el-checkbox-group>

                                            </div>
                                        </div>
                                    </div>
                                    <!--  來源 -->
                                    <!-- <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i6">
                                                <i class="el-icon-c-scale-to-original
                                              "></i>&nbsp; 來源
                                            </button>
                                        </h2>
                                        <div id="i6" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="廣告" id="s8"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s8">
                                                        廣告
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
                                                    <input class="form-check-input" type="checkbox" value="參展" id="s9"
                                                        name="source" v-model="source">
                                                    <label class="form-check-label" for="s9">
                                                        參展
                                                    </label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" value="網絡搜索"
                                                        id="s10" name="source" v-model="source">
                                                    <label class="form-check-label" for="s10">
                                                        網絡搜索
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
                                                    id="selectList">搜索</button>


                                            </div>
                                        </div>
                                    </div> -->
                                    <!--  產業-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button" id="industry"
                                                data-bs-toggle="collapse" data-bs-target="#i7">
                                                <i class="bi bi-globe"></i>&nbsp; 產業
                                            </button>
                                        </h2>
                                        <div id="i7" class="accordion-collapse collapse">
                                            <div class="accordion-body">
                                                <div class="form-check" v-for="(s, index) in ind" :key="index">
                                                    <input class="form-check-input" type="checkbox" :value="s"
                                                        :id="'industry'+index" name="industry" v-model="industry">
                                                    <label class="form-check-label" :for="'industry'+index">
                                                        {{s}}
                                                    </label>
                                                </div>
                                            </div>
                                            <button class="btn btn-outline-secondary" v-on:click="selectList"
                                                id="selectIndustry">搜索</button>
                                        </div>
                                    </div>
                                    <!--  上次聯絡時間-->
                                    <!-- <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i8" 
                                                >
                                                <i class="bi bi-calendar3"></i>&nbsp; 上次聯絡時間
                                            </button>
                                        </h2>
                                        <div id="i8" class="accordion-collapse collapse"
                                            
                                            >
                                            <div class="accordion-body">
                                                <dp @update="selfUpdate"></dp>
                                            </div>
                                        </div>
                                    </div> -->
                                    <!--  XXXXX-->
                                </div>

                            </div>
                        </div>


                        <!-- <%-- 抬頭按鈕--%> -->

                        <div class="row">
                            <div class="btn-group" role="group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="javascript: window.open('${pageContext.request.contextPath}/Market/potentialcustomer.jsp')">
                                <label class="btn btn-outline-primary state1" for="btncheck1"><i
                                        class="bi bi-clipboard-check"></i> 新增</label>

                                <c:if test="${user.position == '主管' || user.position == '系統'}">
                                    <label class="btn btn-outline-primary state2" for="btncheck2" onclick="sta()"><i
                                            class="el-icon-delete"></i>刪除</label>
                                </c:if>



                                <input type="checkbox" class="btn-check" id="btncheck3" v-model="btncheck3">
                                <label class="btn btn-outline-primary" for="btncheck3" @click="aadmin(admin)"><i
                                        class="bi bi-person-square"></i> {{admin}}</label>


                                <label class="btn btn-outline-primary" for="btncheck4" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcanvasRight" id="sec"><i class="bi-search"></i> 搜索</label>
                            </div>
                        </div>


                        <!-- 分頁 -->
                        <!-- <div class="block text-center">
                            <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage1"
                                :page-size="20" layout="  prev, pager, next" :total="MaxPag">
                            </el-pagination>
                        </div> -->
                        <transition-group name="slide-fade" appear>
                            <!-- <%-- 中間主體--%> -->
                            <table class="Table table-striped orderTable" v-if="show" key="1">
                                <tr>
                                    <td><input type="checkbox" id="activity"></td>
                                    <td></td>
                                    <td style="width: 90px;" @click="sortState()"><a href="#">狀態</a></td>
                                    <td style="width: 90px;">負責人</td>
                                    <td><a href="#" @click="sortReceive()">領取</a></td>
                                    <td>客戶名稱</td>

                                    <td>詢問內容</td>
                                    <td style="width: 130px;">建立時間</td>
                                    <td>聯絡人</td>
                                    <td>產業</td>
                                    <!-- 詢問產品種類		客戶來源	備註 -->
                                    <td>重要性</td>
                                </tr>
                                <tr class="item" v-for="(s, index) in list" :key="s.customerid">
                                    <%-- --%>
                                        <td><input type="checkbox" :value="s.customerid" name="mak" @change="clickmak"
                                                :id="s.customerid"></td>
                                        <%-- 列表編號--%>
                                            <td>{{index+1}} <span class="badge rounded-pill bg-danger"
                                                    v-show="s.bm.length > 0">{{s.bm.length ==
                                                    0?"":s.bm.length}}</span>
                                                <i class="el-icon-help" style="color: red;" v-if="s.callhelp == 1"></i>
                                            </td>
                                            <!--  狀態-->
                                            <td v-on:click="customer(s.customerid)" style="cursor: pointer;"
                                                :class="'state'+index">
                                                {{s.status}}</td>
                                            <!-- 負責人 -->
                                            <td v-on:click="customer(s.customerid)" style="cursor: pointer;"
                                                v-html="s.user">
                                            </td>
                                            <!-- 領取 -->
                                            <td v-html="s.receivestate">
                                                <div></div>
                                            </td>
                                            <!-- 客戶名稱 -->
                                            <td>
                                                {{s.company}}<i class="el-icon-paperclip" style="color: blue;"
                                                    v-if="isEmpty(s.marketfilelist)"></i></td>
                                            <!-- 詢問內容 -->
                                            <td v-if="s.remark.length <100 " style="width: 500px;cursor: pointer;"
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
                                            <td v-on:click="customer(s.customerid)" style="cursor: pointer;">
                                                {{s.name}}</td>
                                            <td v-on:click="customer(s.customerid)">
                                                {{s.industry}}</td>
                                            <td v-on:click="customer(s.customerid)" style="cursor: pointer;"
                                                :class="'important'+index">
                                                {{s.important}}</td>
                                </tr>
                            </table>
                        </transition-group>
                        <div>今天筆數 : {{todayTotal}}</div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            $(".market").show();

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
                                window.location.href = "${pageContext.request.contextPath}/Market/potentialcustomerList.jsp";
                            },
                            error: function (returndata) {
                                console.log(returndata.responseJSON.message);

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
                    btncheck3: false,//個人頁面按鈕
                    todayTotal: "",
                    content: "",//
                    currentPage1: 1,//當前分頁
                    MaxPag: 1,//所有筆數
                    list: [],
                    admin: '${user.name}',
                    show: true,
                    source: [],
                    pickerOptions: {
                        shortcuts: [
                            {
                                text: '今天',
                                onClick(picker) {
                                    const end = new Date();
                                    const start = new Date();
                                    start.setTime(start.getTime());
                                    picker.$emit('pick', [start, end]);
                                }
                            }, {
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
                    ind: ["尚未分類",
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
                    //搜索用
                    inDay: [],//日期
                    inUserList: [],//負責人
                    name: "",//公司名稱,聯絡人
                    content: "",//詢問內容
                    inStateList: [],//狀態
                    source: [],//來源
                    industry: [],//產業
                    phone: "",//電話

                },
                created: function () {
                    var url = new URL(location.href);
                    const name = url.searchParams.get("user");
                    if (this.admin != "") {
                        //要求列表
                        $.ajax({
                            url: '${pageContext.request.contextPath}/Potential/CustomerList?pag=1',
                            type: 'POST',
                            async: false,
                            cache: false,
                            success: response => {
                                this.list = response.list;
                                this.todayTotal = response.todayTotal;

                                var now = new Date().getTime();
                                this.list.forEach(e => {
                                    var create = new Date(e.aaa).getTime();
                                    if ((now - create) / 3600000 > 2 && (e.user == "" || e.user == null)) {
                                        e.user = '<div class="el-tag">需分配</div>';
                                    }
                                    switch (e.receivestate) {
                                        case 1: e.receivestate = '<el-tag>領取</el-tag>'; break;
                                        case 2: e.receivestate = '<el-tag>分配</el-tag>'; break;
                                        case 3: e.receivestate = ''; break;
                                    }
                                });
                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });
                        //要求所有筆數
                        // axios
                        //     .get('${pageContext.request.contextPath}/Potential/MaxPag')
                        //     .then(response => (
                        //         this.MaxPag = response.data
                        //     ))
                        //     .catch(function (error) {
                        //         console.log(error);
                        //     });
                    } else {
                        location.href = "${pageContext.request.contextPath}/"
                    }
                    if (name != null) {
                        this.btncheck3 = true;
                        axios
                            .get('${pageContext.request.contextPath}/Potential/admin/' + name)
                            .then(response => (
                                this.list = response.data,
                                this.list.forEach(e => {
                                    switch (e.receivestate) {
                                        case 1: e.receivestate = '<el-tag>領取</el-tag>'; break;
                                        case 2: e.receivestate = '<el-tag>分配</el-tag>'; break;
                                        case 3: e.receivestate = ''; break;
                                    }
                                })
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                    }
                },
                methods: {
                    //搜索
                    selectList: function () {
                        const loading = this.$loading({
                            lock: true,
                            text: 'Loading',
                            spinner: 'el-icon-loading',
                            background: 'rgba(0, 0, 0, 0.7)'
                        });
                        console.log(this.inDay[0]);
                        this.btncheck3 = false;
                        if (this.inDay == "") {//沒輸入日期                  
                            this.inDay[0] = "";
                            this.inDay[1] = "";
                        }

                        var url = '${pageContext.request.contextPath}/Potential/selectDate?startDay=' + this.inDay[0] + "&endDay=" + this.inDay[1];
                        if (this.inUserList != "") {//負責人
                            url = '${pageContext.request.contextPath}/Potential/selectPotential?startDay=' + this.inDay[0] + "&endDay=" + this.inDay[1] + "&key=UserList&val=" + this.inUserList;
                        } else if (this.content != "") {//詢問內容
                            url = '${pageContext.request.contextPath}/Potential/selectPotential?startDay=' + this.inDay[0] + "&endDay=" + this.inDay[1] + "&key=content&val=" + this.content;
                        } else if (this.name != "") {//聯絡人,公司名稱
                            url = '${pageContext.request.contextPath}/Potential/selectPotential?startDay=' + this.inDay[0] + "&endDay=" + this.inDay[1] + "&key=name&val=" + this.name;
                        } else if (this.inStateList != "") {//狀態
                            url = '${pageContext.request.contextPath}/Potential/selectPotential?startDay=' + this.inDay[0] + "&endDay=" + this.inDay[1] + "&key=inStateList&val=" + this.inStateList;
                        } else if (this.industry != "") {//產業
                            url = '${pageContext.request.contextPath}/Potential/selectPotential?startDay=' + this.inDay[0] + "&endDay=" + this.inDay[1] + "&key=industry&val=" + this.industry;
                        } else if (this.phone != "") {
                            url = '${pageContext.request.contextPath}/Potential/selectPotential?startDay=' + this.inDay[0] + "&endDay=" + this.inDay[1] + "&key=phone&val=" + this.phone;

                        }

                        $.ajax({
                            url: url,
                            type: 'POST',
                            // async: false,
                            // cache: false,
                            success: response => {
                                this.list = response;
                                this.total = this.list.length;
                                if (this.inUserList != "") {//負責人
                                    this.oldList = this.list;
                                    this.list = []
                                    for (var u of this.inUserList)
                                        for (var bean of this.oldList) {
                                            if (u == bean.user) {
                                                this.list.push(bean);
                                            }
                                        }
                                }

                                if (this.content != "") {//詢問內容
                                    this.oldList = this.list;
                                    this.list = [];
                                    for (var bean of this.oldList) {
                                        if (bean.remark.indexOf(this.content) >= 0) {
                                            this.list.push(bean);
                                        }
                                    }
                                }
                                if (this.name != "") {//聯絡人,公司名稱
                                    this.oldList = this.list;
                                    this.list = [];
                                    for (var bean of this.oldList) {
                                        if (bean.name.indexOf(this.name) >= 0 || bean.company.indexOf(this.name) >= 0) {
                                            this.list.push(bean);
                                        }
                                    }
                                }
                                if (this.inStateList != "") {//狀態
                                    console.log(this.inStateList);
                                    this.oldList = this.list;
                                    this.list = [];
                                    for (var u of this.inStateList)
                                        for (var bean of this.oldList) {
                                            console.log(u == bean.status);
                                            if (u == bean.status) {
                                                this.list.push(bean);
                                            }
                                        }
                                }
                                console.log(this.industry);
                                if (this.industry != "") {//產業
                                    this.oldList = this.list;
                                    this.list = [];
                                    for (var u of this.industry)
                                        for (var bean of this.oldList) {
                                            if (u == bean.industry) {
                                                this.list.push(bean);
                                            }
                                        }
                                }
                                this.total = 40;
                                console.log(this.list.length, "this.list.length");


                                //領取狀態翻譯
                                this.list.forEach(e => {
                                    switch (e.receivestate) {
                                        case 1: e.receivestate = '<el-tag>領取</el-tag>'; break;
                                        case 2: e.receivestate = '<el-tag>分配</el-tag>'; break;
                                        case 3: e.receivestate = ''; break;
                                    }
                                });
                                loading.close();

                            },
                            error: function (returndata) {
                                console.log(returndata);
                            }
                        });

                    },
                    handleCurrentChange(val) {//點擊分頁
                        axios
                            .get('${pageContext.request.contextPath}/Potential/CustomerList?pag=' + val)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    //進入細節
                    customer: function (id) {
                        window.open('${pageContext.request.contextPath}/Market/potentialcustomer/' + id)

                    },
                    aadmin: function (name) {//搜索負責人
                        var url = new URL(location.href);
                        const n = url.searchParams.get("user");
                        if (n == null) {
                            location.href = "${pageContext.request.contextPath}/Market/potentialcustomerList.jsp?user=" + name;
                        } else {
                            location.href = "${pageContext.request.contextPath}/Market/potentialcustomerList.jsp";
                        }
                    },
                    // 勾選單項 
                    clickmak: function () {
                        var $all = $("input[name=mak]");
                        var $zx = $("input[name=mak]:checked");
                        $("#activity").prop("checked", $zx.length == $all.length);
                    },
                    //階段 排序  
                    sortState: function () {
                        var d = $('.state0').text().trim();
                        var oldList = this.list;
                        const imp = ["未處理", "已聯繫", "提交主管", "不合格", "合格"];//先輪替這列表
                        var nimp = []
                        this.list = [];//清空
                        var b = false;

                        var i = imp.indexOf(d);//找到輸入第幾個

                        //重整列表
                        for (let index = i + 1; index < 5; index++) {
                            nimp.push(imp[index])
                        }
                        for (let index = 0; index <= i; index++) {
                            nimp.push(imp[index])
                        }

                        console.log(nimp);
                        //根據列表抓數據
                        for (const iterator of nimp) {
                            for (var o of oldList) {
                                if (o.status == iterator) this.list.push(o)
                            }
                        }
                    },
                    //判斷有沒有附件
                    isEmpty(marketfilelist) {
                        if (marketfilelist == null) {
                            return false
                        } else { return marketfilelist.length > 0 }

                    },
                    //轉換 領取狀態
                    receives(val) {
                        switch (val) {
                            case 1: return "領取";
                            case 2: return "分配";
                            case 3: return "";
                        }

                    },
                    //領取排序
                    sortReceive() {
                        const oldList = this.list;
                        const direct = this.list[0].receivestate;



                        //創建列表
                        const imp = ["", "<el-tag>領取</el-tag>", "<el-tag>分配</el-tag>"];
                        var nimp = []
                        this.list = [];//清空

                        var i = imp.indexOf(direct);//找到輸入第幾個

                        //重整列表
                        for (let index = i + 1; index < 5; index++) {
                            nimp.push(imp[index])
                        }
                        for (let index = 0; index <= i; index++) {
                            nimp.push(imp[index])
                        }

                        console.log(nimp);
                        //根據列表抓數據
                        for (const iterator of nimp) {
                            for (var o of oldList) {
                                if (o.receivestate == iterator) this.list.push(o)
                            }
                        }






                    }
                },
            })
        </script>

        <script>
            // 勾選全部
            $("#activity").change(function () {
                var $all = $("input[name=mak]");
                $all.prop("checked", this.checked);
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

            .el-tag {
                background-color: red;
                display: inline-block;
                height: 32px;
                padding: 0 10px;
                line-height: 30px;
                font-size: 12px;
                color: #fff;
                border: 1px solid #d9ecff;
                border-radius: 4px;
                box-sizing: border-box;
                white-space: nowrap;
            }
        </style>


        </html>