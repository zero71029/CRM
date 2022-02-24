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

                    <div class="col-md-10 app" v-cloak>
                        <!-- 滑塊 -->
                        <div class="offcanvas offcanvas-end" tabindex="0" id="offcanvasRight"
                            aria-labelledby="offcanvasRightLabel" style="width: 450px;">
                            <div class="offcanvas-header">
                                <h5 id="offcanvasRightLabel"><i class="bi-search"></i>&nbsp; 搜索</h5>
                                <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                                    aria-label="Close"></button>
                            </div>
                            <div class="offcanvas-body">
                                <div class="accordion accordion-flush" id="accordionFlushExample">
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
                                                aria-expanded="false" aria-controls="flush-collapseOne">
                                                <i class="bi bi-person-square"></i>&nbsp; 負責人
                                            </button>
                                        </h2>
                                        <div id="flush-collapseOne" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <ul class=" ">


                                                    <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                        items="${admin}" var="s">
                                                        <c:if test="${s.department == '業務' }">
                                                            <li><a v-on:click="aadmin('${s.name}')"
                                                                    href="#">${s.name}</a>
                                                            </li>
                                                        </c:if>
                                                    </c:forEach>
                                                    <hr>
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
                                                <i class="bi bi-calendar-minus"></i>&nbsp; 建立日期
                                            </button>
                                        </h2>
                                        <div id="flush-collapseTwo" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <dp @update="selectDate"></dp>
                                            </div>
                                        </div>

                                    </div>
                                    <!-- 建立日期 -->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingTwo">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#selectContent">
                                                &nbsp; 詢問內容
                                            </button>
                                        </h2>
                                        <div id="selectContent" class="accordion-collapse collapse"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <div class="input-group mb-3">
                                                    <input type="text" class="form-control" v-model="content"
                                                        placeholder="未完成" name="name">
                                                    <button class="btn btn-outline-secondary" type="submit"
                                                        v-on:click="selectcontent">搜索</button>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                    <!-- 聯絡人-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#flush-collapseThree"
                                                aria-expanded="false" aria-controls="flush-collapseThree">
                                                <i class="bi bi-arrows-angle-contract"></i>&nbsp; 聯絡人
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
                                                <i class="bi bi-building"></i>&nbsp; 公司名稱
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
                                                <i class="bi bi-heart-pulse"></i>&nbsp; 狀態
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
                                                <i class="el-icon-c-scale-to-original
                                              "></i>&nbsp; 來源
                                            </button>
                                        </h2>
                                        <div id="i6" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
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
                                                <i class="bi bi-globe"></i>&nbsp; 產業
                                            </button>
                                        </h2>
                                        <div id="i7" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <div class="form-check" v-for="(s, index) in ind" :key="index">
                                                    <input class="form-check-input" type="checkbox" :value="s"
                                                        :id="'industry'+index" name="industry" v-model="source">
                                                    <label class="form-check-label" :for="'industry'+index">
                                                        {{s}}
                                                    </label>
                                                </div>
                                            </div>
                                            <button class="btn btn-outline-secondary" v-on:click="selectSource"
                                                id="selectProduct">搜索</button>
                                        </div>
                                    </div>
                                    <!--  上次聯絡時間-->
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="flush-headingThree">
                                            <button class="accordion-button collapsed" type="button"
                                                data-bs-toggle="collapse" data-bs-target="#i8" aria-expanded="false"
                                                aria-controls="flush-collapseThree">
                                                <i class="bi bi-calendar3"></i>&nbsp; 上次聯絡時間
                                            </button>
                                        </h2>
                                        <div id="i8" class="accordion-collapse collapse"
                                            aria-labelledby="flush-headingThree"
                                            data-bs-parent="#accordionFlushExample">
                                            <div class="accordion-body">
                                                <dp @update="selfUpdate"></dp>
                                            </div>
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
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/potentialcustomer.jsp'">
                                <label class="btn btn-outline-primary state1" for="btncheck1"><i
                                        class="bi bi-clipboard-check"></i> 新增</label>

                                <c:if test="${user.position == '主管' || user.position == '系統'}">
                                    <label class="btn btn-outline-primary state2" for="btncheck2" onclick="sta()"><i
                                            class="el-icon-delete"></i>刪除</label>
                                </c:if>




                                <label class="btn btn-outline-primary" for="btncheck3" @click="aadmin(admin)"><i
                                        class="bi bi-person-square"></i> {{admin}}</label>


                                <label class="btn btn-outline-primary" for="btncheck4" data-bs-toggle="offcanvas"
                                    data-bs-target="#offcanvasRight" aria-controls="offcanvasRight"><i
                                        class="bi-search"></i> 搜索</label>
                            </div>
                        </div>


                        <!-- 分頁 -->
                        <div class="block text-center">
                            <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage1"
                                :page-size="20" layout="  prev, pager, next" :total="MaxPag">
                            </el-pagination>
                        </div>





                        <transition-group name="slide-fade" appear>
                            <!-- <%-- 中間主體--%> -->
                            <table class="Table table-striped orderTable" v-if="show" key="1">
                                <tr>
                                    <td><input type="checkbox" id="activity"></td>
                                    <td></td>
                                    <td style="width: 90px;">狀態</td>
                                    <td style="width: 90px;">負責人</td>
                                    <td style="width: 110px;">建立時間</td>
                                    <td>客戶名稱</td>
                                    <td>聯絡人</td>
                                    <td>詢問內容</td>
                                    <td>產業</td>
                                    <!-- 詢問產品種類		客戶來源	備註 -->
                                    <td @click="sortItem('important')"><a href="#">重要性</a></td>


                                </tr>
                                <tr class="item" v-for="(s, index) in list" :key="s.customerid">
                                    <td><input type="checkbox" :value="s.customerid" name="mak" @change="clickmak"></td>
                                    <td>{{index+1}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.status}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.user}}</td>
                                    <!-- 建立時間 -->
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.aaa}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.company}}</td>
                                    <td v-on:click="customer(s.customerid)">
                                        {{s.name}}</td>




                                    <td v-if="s.remark.length <100 " style="width: 500px;cursor: pointer;"
                                        v-on:click="customer(s.customerid)">{{s.remark}}</td>

                                    <td v-on:click="customer(s.customerid)" v-if="s.remark.length >=100 ">

                                        <el-popover placement="top-start" width="300" trigger="hover"
                                            :content="s.remark">
                                            <el-button slot="reference" class="text-truncate text-start"
                                                style="width: 500px; color: #000;" type="text">{{s.remark}}</el-button>
                                        </el-popover>

                                    </td>

                                    <td v-on:click="customer(s.customerid)">
                                        {{s.industry}}</td>
                                    <td v-on:click="customer(s.customerid)" :class="'important'+index">
                                        {{s.important}}</td>


                                </tr>
                            </table>
                        </transition-group>
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
            //element-ui時間選擇器
            Vue.component('dp', {
                template:
                    '<div class="block"> <el-date-picker v-model="value2"      type="daterange"      align="right"      unlink-panels      range-separator="到"      start-placeholder="開始b日期"      end-placeholder="結束日期" :picker-options="pickerOptions" value-format="yyyy-MM-dd"></el-date-picker> <input type="submit" value="送出" v-on:click="updateText"> </div>',
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
            Vue.config.productionTip = false;
            const vm = new Vue({
                el: '.app',
                data: {
                    content: "",//
                    currentPage1: 1,//當前分頁
                    MaxPag: 1,//所有筆數
                    list: [],
                    name: "",
                    admin: '${user.name}',
                    show: true,
                    source: [],
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
                    industry: [],
                },
                created: function () {
                    if (this.admin != "") {
                        //要求列表
                        axios
                            .get('${pageContext.request.contextPath}/Potential/CustomerList?pag=' + this.currentPage1)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) { // 请求失败处理
                                console.log(error);
                            });
                        //要求所有筆數
                        axios
                            .get('${pageContext.request.contextPath}/Potential/MaxPag')
                            .then(response => (
                                this.MaxPag = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    } else {
                        alert("沒有權限");
                        location.href = "${pageContext.request.contextPath}/"
                    }
                },
                methods: {
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
                    customer: function (id) {
                        window.open('${pageContext.request.contextPath}/Market/potentialcustomer/' + id)

                    },
                    selfUpdate(val) {//搜索上次聯絡時間
                        console.log(val)
                        axios
                            .get('${pageContext.request.contextPath}/Potential/selectTrackDate?from=' + val[0] + "&to=" + val[1])
                            .then(response => (
                                this.list = response.data,
                                console.log(this.list)
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    selectDate(val) {//搜索建立日期
                        console.log(val)
                        axios
                            .get('${pageContext.request.contextPath}/Potential/selectDate?from=' + val[0] + "&to=" + val[1])
                            .then(response => (
                                this.list = response.data,
                                console.log(this.list)
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
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
                        axios
                            .get('${pageContext.request.contextPath}/Potential/admin/' + name)
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
                        var da = { source: this.source };
                        axios
                            .post('${pageContext.request.contextPath}/Potential/selectSource', da)
                            .then(response => (
                                this.list = response.data
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });
                    },
                    sortItem: function (direct) {//重要性 排序
                        console.log($('.' + direct + '0').text().trim())
                        var d = $('.' + direct + '0').text().trim();
                        var oldList = this.list;
                        const imp = ["高", "中", "低"];//先輪替這列表
                        var nimp = []
                        this.list = [];
                        var b = false;
                        var i = imp.indexOf(d);//找到輸入第幾個
                        for (let index = i + 1; index < 3; index++) {
                            nimp.push(imp[index])
                        }

                        //根據列表抓數據
                        for (let index = 0; index <= i; index++) {
                            console.log(imp[index] + "index2");
                            nimp.push(imp[index])
                        }
                        for (const iterator of nimp) {
                            for (var o of oldList) {
                                if (o.important == iterator) this.list.push(o)
                            }
                        }
                    },
                    clickmak: function () {// 勾選單項    
                        var $all = $("input[name=mak]");
                        var $zx = $("input[name=mak]:checked");
                        $("#activity").prop("checked", $zx.length == $all.length);
                    },
                    selectcontent: function () {//搜索詢問內容

                        axios
                            .post('${pageContext.request.contextPath}/Potential/selectcontent', { "selectcontent": this.content })
                            .then(response => (
                                alert(response.data)
                             
                            ))
                            .catch(function (error) {
                                console.log(error);
                            });


                    },
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
        </style>

        </html>