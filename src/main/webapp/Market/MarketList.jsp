<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-TW">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRM</title>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}\icons\bootstrap-icons.css">

    <!-- <%-- 主要的CSS、JS放在這裡--%> -->
    <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css"> -->

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
                           onclick="javascript: window.open('${pageContext.request.contextPath}/Market/Market.jsp')">
                    <label class="btn btn-outline-primary state1" for="btncheck1"><i
                        class="bi bi-clipboard-check"></i>新增</label>


                    <c:if test="${user.position == '主管' || user.position == '系統'}">
                        <label class="btn btn-outline-primary state2"
                               onclick="sta()"><i class="bi bi-trash"></i>刪除</label>
                    </c:if>

                    <input type="checkbox" class="btn-check" id="btncheck3" v-model="btncheck3">
                    <label class="btn btn-outline-primary" for="btncheck3"
                           @click="aadmin(admin)"><i  class="bi bi-person-square"></i>{{admin}}</label>


                    <label class="btn btn-outline-primary" data-bs-toggle="offcanvas"
                           data-bs-target="#offcanvasRight" id="search"><i class="bi-search"></i>搜索</label>
                    <label class="btn btn-outline-primary" data-bs-toggle="offcanvas"
                           data-bs-target="#StateSetSlider" id="StateSet"><i class="bi bi-wrench"></i>狀態設定</label>
                </div>
            </div>
            <!-- <%-- 中間主體--%> -->

            <div class="row" style="border-bottom: #0a53be 1px solid">
                <div class="col-lg-12">
                    <el-tag style="margin: 5px"
                            v-for="tag in MarketStateList"
                            key="tag.marketstateid"
                            closable
                            :disable-transitions="false"
                            @close="CloseMarketState(tag)"
                            :type="tag.type">
                        {{tag.state}}
                    </el-tag>
                </div>

            </div>
            <transition-group name="slide-fade" appear>
                <table class="Table table-striped orderTable" key="1" v-if="show">
                    <tr>
                        <td><input type="checkbox" id="activity" @change="changeActivity"></td>
                        <td></td>
                        <td style="max-width: 180px;">
                            <el-select v-model="inSortState" multiple placeholder="階段" @change="sortState"
                                       size="mini">
                                <el-option v-for="item in options" :key="item.value" :label="item.label"
                                           :value="item.value">
                                </el-option>
                            </el-select>
                        </td>
                        <td style="width: 230px;">客戶</td>
                        <td>描述</td>
                        <td>負責人</td>
                        <td>機率</td>
                        <td @click="sortItem('important')"><a href="#">重要性</a></td>
                        <td>追蹤次數</td>
                        <td>
                            <span>建立時間</span>
                            <br>
                            <span class="text-danger">最後追蹤時間</span>
                        </td>
                        <c:if test="${user.position == '主管' || user.position == '系統'}">
                            <td>點擊數</td>
                        </c:if>
                    </tr>
                    <tr class="item" v-for="(s, index) in list" :key="index">
                        <td><input type="checkbox" :value="s.marketid" name="mak" @change="clickmak"></td>
                        <%--    列表編號--%>
                        <td>{{index+1}} <i class="el-icon-help" style="color: red;"
                                           v-if="s.callhelp == 1"></i></td>
                        <!-- 階段 -->
                        <td v-on:click="market(s.marketid)" :class="'state'+index" style="cursor: pointer;">
                            {{s.stage}} <i class="el-icon-paperclip" style="color: blue;"
                                           v-if="isEmpty(s.marketfilelist)"></i>


                            <span class="badge rounded-pill bg-danger"
                                  v-show="s.bm.length > 0">{{s.bm.length ==
                                            0?"":s.bm.length}}</span>

                        </td>
                        <td>
                            {{s.client}}
                        </td>
                        <!-- <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                            {{s.message}}</td> -->
                        <td v-if="s.message.length <100 " style="width: 500px;cursor: pointer;"
                            v-on:click="market(s.marketid)">{{s.message}}
                        </td>
                        <td v-on:click="market(s.marketid)" v-if="s.message.length >=100 ">
                            <el-popover placement="top-start" width="300" trigger="hover"
                                        :content="s.message">
                                <el-button slot="reference" class="text-truncate text-start"
                                           style="width: 500px; color: #000;" type="text">{{s.message}}
                                </el-button>
                            </el-popover>
                        </td>
                        <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                            {{s.user}}
                        </td>
                        <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                            {{s.clinch}}
                        </td>
                        <td v-on:click="market(s.marketid)" :class="'important'+index"
                            style="cursor: pointer;">
                            {{s.important}}
                        </td>
                        <!-- 追蹤次數 -->
                        <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                            {{s.trackbean.length}}
                        </td>
                        <!--  建立時間-->
                        <td v-on:click="market(s.marketid)" style="cursor: pointer;">
                            <span>{{s.aaa}}</span>
                            <br>
                            <span class="text-danger">{{s.tracktime}}</span>
                        </td>
                        <c:if test="${user.position == '主管' || user.position == '系統'}">
                            <td>{{s.clicks}}</td>
                        </c:if>
                    </tr>

                </table>
                <!-- 分頁 -->
                <div class="block text-center" key="2" v-if="show">
                    <el-pagination @current-change="handleCurrentChange" :current-page.sync="currentPage1"
                                   :page-size="20" layout="  prev, pager, next" :total="total">
                    </el-pagination>
                </div>
                <div key="3">今天筆數 : {{todayTotal}}</div>
                <div key="4">
                    <el-button type="text" @click="SubmitBosVisible=true">提交主管 {{SubmitBos.length+PotentialSubmitBos.length}}
                    </el-button>
                    <el-button type="text" @click="CallBosVisible=true">延長請求 {{CallBos.length}}
                    </el-button>
                    <el-button type="text" @click="CreateVisible = true">轉賣/自用 - 今天到期 {{markeCreateTime.length}}</el-button>
                </div>
            </transition-group>


            <!-- 轉賣/自用 - 今天到期 彈窗-->
            <el-dialog title="轉賣/自用 - 今天到期" :visible.sync="CreateVisible"
                       :default-sort="{prop: 'stage', order: 'descending'}">
                <el-table :data="markeCreateTime" @row-click="clickEndCast">
                    <el-table-column property="client" label="公司"></el-table-column>
                    <el-table-column property="message" label="描述"></el-table-column>
                    <el-table-column property="stage" label="階段" sortable></el-table-column>
                    <el-table-column property="user" label="負者人" sortable></el-table-column>
                </el-table>
            </el-dialog>





            <!-- 到期任務 彈窗-->
            <el-dialog title="到期任務 (延長結束時間 或 結案)" :visible.sync="endCastVisible"
                       :default-sort="{prop: 'stage', order: 'descending'}">
                <el-table :data="endCast" @row-click="clickEndCast">
                    <el-table-column property="client" label="公司"></el-table-column>
                    <el-table-column property="message" label="描述"></el-table-column>
                    <el-table-column property="stage" label="階段" sortable></el-table-column>
                </el-table>
            </el-dialog>
            <!-- 提交主管 彈窗-->
            <c:if test="${user.position == '主管' || user.position == '系統'}">
                <el-dialog title="提交主管" :visible.sync="SubmitBosVisible"
                           :default-sort="{prop: 'aaa', order: 'descending'}">
                    <el-table :data="SubmitBos" @row-click="clickEndCast">
                        <el-table-column property="client" label="公司"></el-table-column>
                        <el-table-column property="message" label="描述"></el-table-column>
                        <el-table-column property="aaa" label="創建日期" sortable></el-table-column>
                    </el-table>
                    <hr>
                    <el-table :data="PotentialSubmitBos" @row-click="clickPotential">
                        <el-table-column property="company" label="潛在客戶"></el-table-column>
                        <el-table-column property="remark" label="詢問"></el-table-column>
                        <el-table-column property="aaa" label="創建日期" sortable></el-table-column>
                    </el-table>
                </el-dialog>
            </c:if>
            <br><br><br><br><br>
            <!-- 延長請求 彈窗-->
            <c:if test="${user.position == '主管' || user.position == '系統'}">
                <el-dialog title="延長請求" :visible.sync="CallBosVisible"
                           :default-sort="{prop: 'aaa', order: 'descending'}">
                    <el-table :data="CallBos" @row-click="clickEndCast">
                        <el-table-column property="client" label="公司"></el-table-column>
                        <el-table-column property="message" label="描述"></el-table-column>
                        <el-table-column property="aaa" label="創建日期" sortable></el-table-column>
                    </el-table>
                </el-dialog>
            </c:if>
            <!-- 滑塊 -->
            <div class="offcanvas offcanvas-end " tabindex="0" id="offcanvasRight" style="width: 450px;">
                <div class="offcanvas-header">
                    <h5 id="offcanvasRightLabel">搜索</h5>
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"
                            aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <div class="accordion accordion-flush" id="accordionFlushExample">
                        <div class="accordion-body">
                            <el-date-picker v-model="inDay" type="daterange" align="right" unlink-panels
                                            range-separator="到" start-placeholder="開始日期" end-placeholder="結束日期"
                                            :picker-options="pickerOptions" value-format="yyyy-MM-dd">
                            </el-date-picker>
                            <input type="submit" value="送出" @click="selectList" id="sendDay">
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        onclick="javascript:location.href='${pageContext.request.contextPath}/Market/MarketList.jsp'">
                                    重置
                                </button>
                            </h2>
                        </div>
                        <!-- 最後追蹤時間 -->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#最後追蹤時間">
                                    最後追蹤時間
                                </button>
                            </h2>
                            <div id="最後追蹤時間" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    <el-date-picker v-model="intracktime" type="daterange" align="right"
                                                    unlink-panels range-separator="到" start-placeholder="開始日期"
                                                    end-placeholder="結束日期" :picker-options="pickerOptions"
                                                    value-format="yyyy-MM-dd">
                                    </el-date-picker>
                                    <input type="submit" value="送出" @click="selectList" id="sendDay">
                                </div>
                            </div>
                        </div>
                        <!-- 負責人 -->
                        <div class="accordion-item">
                            <h2 class="accordion-header" id="flush-headingOne">
                                <button class="accordion-button collapsed" type="button" id="principal"
                                        data-bs-toggle="collapse" data-bs-target="#flush-collapseOne">
                                    負責人
                                </button>
                            </h2>
                            <div id="flush-collapseOne" class="accordion-collapse collapse">
                                <div class="accordion-body">
                                    <el-checkbox-group v-model="inUserList">
                                        <c:if test="${not empty admin}">
                                            <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}"
                                                       items="${admin}" var="s">
                                                <c:if test="${s.department == '業務' }">
                                                    <el-checkbox label="${s.name}"></el-checkbox>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </el-checkbox-group>
                                </div>
                            </div>
                        </div>
                        <!-- 機會名稱-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" id="search3"
                                        data-bs-toggle="collapse" data-bs-target="#flush-collapseThree">
                                    機會名稱
                                </button>
                            </h2>
                            <div id="flush-collapseThree" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder=""
                                               v-model="name" name="name">
                                        <button class="btn btn-outline-secondary" id="clickname"
                                                @click="selectList">搜索
                                        </button>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!--  客戶-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" id="search4"
                                        data-bs-toggle="collapse" data-bs-target="#i4">
                                    客戶
                                </button>
                            </h2>
                            <div id="i4" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder=""
                                               v-model="company" list="company">
                                        <button class="btn btn-outline-secondary"
                                                @click="selectList">搜索
                                        </button>
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
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" id="search5"
                                        data-bs-toggle="collapse" data-bs-target="#i5">
                                    狀態
                                </button>
                            </h2>
                            <div id="i5" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">


                                    <el-checkbox-group v-model="inStateList">
                                        <el-checkbox label="尚未處理"></el-checkbox>
                                        <el-checkbox label="內部詢價中"></el-checkbox>                                     
                                        <el-checkbox label="已報價"></el-checkbox>
                                        <el-checkbox label="提交主管"></el-checkbox>
                                        <el-checkbox label="成功結案"></el-checkbox>
                                        <el-checkbox label="失敗結案"></el-checkbox>
                                    </el-checkbox-group>
                                </div>
                            </div>
                        </div>
                        <!--  聯絡人-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" id="search6"
                                        data-bs-toggle="collapse" data-bs-target="#i6">
                                    聯絡人
                                </button>
                            </h2>
                            <div id="i6" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder="" id="Contact"
                                               v-model="inContact">
                                        <button class="btn btn-outline-secondary"
                                                @click="selectList">搜索
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--  聯絡人電話-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#i7">
                                    聯絡人電話
                                </button>
                            </h2>
                            <div id="i7" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <div class="input-group mb-3">
                                        <input type="text" class="form-control" placeholder=""
                                               v-model="ContantPhone">
                                        <button class="btn btn-outline-secondary"
                                                @click="selectList">搜索
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--  商品-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#i11">
                                    商品
                                </button>
                            </h2>
                            <div id="i11" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <div class="accordion-body">
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" placeholder=""
                                                   v-model="product">
                                            <button class="btn btn-outline-secondary"
                                                    @click="selectList">搜索
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--  報價內容-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#i12">
                                    報價內容
                                </button>
                            </h2>
                            <div id="i12" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <div class="accordion-body">
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" placeholder=""
                                                   v-model="quote">
                                            <button class="btn btn-outline-secondary"
                                                    @click="selectList">搜索
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--  產業-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#i99">
                                    產業
                                </button>
                            </h2>
                            <div id="i99" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <div class="form-check" v-for="(s, index) in ind" :key="index">
                                        <input class="form-check-input" type="checkbox" :value="s"
                                               :id="'industry'+index" name="industry" v-model="source">
                                        <label class="form-check-label" :for="'industry'+index">
                                            {{s}}
                                        </label>
                                    </div>
                                </div>
                                <button class="btn btn-outline-secondary"
                                        v-on:click="selectList">搜索
                                </button>
                            </div>
                        </div>
                        <!--  產品類別-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#i8">
                                    產品類別
                                </button>
                            </h2>
                            <div id="i8" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <el-checkbox :indeterminate="isIndeterminate" v-model="checkAll"
                                                 @change="handleCheckAllChange">全选
                                    </el-checkbox>
                                    <div style="margin: 15px 0;"></div>
                                    <el-checkbox-group v-model="checkedCities"
                                                       @change="handleCheckedCitiesChange">
                                        <div class="row">
                                            <div class="col-md-5" v-for="city in cities" :key="city">
                                                <el-checkbox :label="city">
                                                    {{city}}
                                                </el-checkbox>
                                            </div>
                                        </div>
                                    </el-checkbox-group>
                                    <el-button type="primary" @click="selectList" style="width: 100%;">送出
                                    </el-button>
                                </div>
                            </div>
                        </div>
                        <!--  機會來源 -->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#i9">
                                    機會來源
                                </button>
                            </h2>
                            <div id="i9" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <el-checkbox :indeterminate="isSource" v-model="sourceAll"
                                                 @change="CheckSourceAllChange">全选
                                    </el-checkbox>
                                    <div style="margin: 15px 0;"></div>
                                    <el-checkbox-group v-model="checkedSources"
                                                       @change="handleCheckedSourcesChange">
                                        <div class="row">
                                            <div class="col-md-5" v-for="source in sources" :key="source">
                                                <el-checkbox :label="source">
                                                    {{source}}
                                                </el-checkbox>
                                            </div>
                                        </div>
                                    </el-checkbox-group>
                                    <el-button type="primary" @click="selectList" style="width: 100%;">送出
                                    </el-button>

                                </div>
                            </div>
                        </div>
                        <!--  成交機率-->
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#i10">
                                    成交機率
                                </button>
                            </h2>
                            <div id="i10" class="accordion-collapse collapse"
                                 aria-labelledby="flush-headingThree">
                                <div class="accordion-body">
                                    <el-rate v-model="clinch" :texts="['極差', '失望', '一般', '滿意', '驚喜']"
                                             style="height: 30px;"
                                             :colors="{ 2: '#99A9BF', 3:  '#F7BA2A', 4: '#FF9900', 5: 'red' }">
                                    </el-rate>
                                    <el-button type="primary" @click="selectList" style="width: 100%;">送出
                                    </el-button>
                                </div>
                            </div>
                        </div>





                    </div>
                </div>
            </div>
            <!-- 狀態滑塊 -->
            <div class="offcanvas offcanvas-end " tabindex="0" id="StateSetSlider"
                 style="width: 450px;">
                <div class="offcanvas-header">
                    <h5>狀態</h5>
                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas"></button>
                </div>
                <div class="offcanvas-body">
                    <div class="accordion accordion-flush">
                        <div class="accordion-body">
                            <el-date-picker v-model="stateDay" type="daterange" align="right" unlink-panels
                                            range-separator="到" start-placeholder="開始日期" end-placeholder="結束日期"
                                            :picker-options="pickerOptions" value-format="yyyy-MM-dd">
                            </el-date-picker>
                            <input type="submit" value="送出" @click="AddState('day',stateDay , 'success')">
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" @click="delAllState">
                                    重置
                                </button>
                            </h2>
                        </div>
                        <br>
                        <div>
                            <c:forEach varStatus="loop" begin="0" end="${admin.size()-1}" items="${admin}"
                                       var="s">
                                <c:if test="${s.department == '業務' }">
                                    <div style="float: left;margin: 3px;">
                                        <el-button type="primary" size="mini" plain
                                                   @click="AddState('admin','${s.name}','user')"
                                                   icon="el-icon-user-solid">${s.name}</el-button>


                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div style="clear:both;margin-bottom: 15px;"></div>
                        <hr>
                        <div>
                            <div style="float: left;margin: 3px;">
                                <el-button type="info" size="mini" plain
                                           @click="AddState('state','尚未處理','info')"
                                           icon="el-icon-s-goods">尚未處理
                                </el-button>
                            </div>

                            <div style="float: left;margin: 3px;">
                                <el-button type="info" size="mini" plain
                                           @click="AddState('state','內部詢價中','info')"
                                           icon="el-icon-s-goods">內部詢價中
                                </el-button>
                            </div>


                            <div style="float: left;margin: 3px;">
                                <el-button type="info" size="mini" plain
                                           @click="AddState('state','已報價','info')"
                                           icon="el-icon-s-goods">已報價
                                </el-button>
                            </div>
                            <div style="float: left;margin: 3px;">
                                <el-button type="info" size="mini" plain
                                           @click="AddState('state','提交主管','info')"
                                           icon="el-icon-s-goods">提交主管
                                </el-button>
                            </div>
                            <div style="float: left;margin: 3px;">
                                <el-button type="info" size="mini" plain
                                           @click="AddState('state','成功結案','info')"
                                           icon="el-icon-s-goods">成功結案
                                </el-button>
                            </div>
                            <div style="float: left;margin: 3px;">
                                <el-button type="info" size="mini" plain
                                           @click="AddState('state','失敗結案','info')"
                                           icon="el-icon-s-goods">失敗結案
                                </el-button>
                            </div>

                        </div>
                        <div style="clear:both;margin-bottom: 15px;"></div>
                        <hr>

                    </div>
                </div>
            </div>
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
                        window.location.href = "${pageContext.request.contextPath}/Market/MarketList.jsp";
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
            MarketStateList: [],//狀態列表
            stateDay: "",//狀態日期
            options: [
                {
                value: '尚未處理',
                label: '尚未處理'
            }, {
                value: '內部詢價中',
                label: '內部詢價中'
            }, {
                value: '報價處理中',
                label: '報價處理中'
            }, {
                value: '已報價',
                label: '已報價'
            }, {
                value: '提交主管',
                label: '提交主管'
            }, {
                value: '成功結案',
                label: '成功結案'
            }, {
                value: '失敗結案',
                label: '失敗結案'
            }],
            markeCreateTime:[],//轉賣今天到期
            CreateVisible:false,
            inSortState: "",//排序用
            btncheck3: false,//個人頁面按鈕
            todayTotal: "",//
            currentPage1: 1,//當前分頁
            total: 1,//所有筆數
            oldtotal: 0,
            list: [],
            name: "",
            show: false,
            admin: '${user.name}',
            endCast: [],//到期資料
            endCastVisible: false,//到期資料彈窗
            PotentialSubmitBos:[],//提交主管by淺在顧客
            SubmitBos: [],//提交主管
            SubmitBosVisible: false,//提交主管彈窗
            CallBos: [],//延長通知
            CallBosVisible: false,//延長通知彈窗
            ind: ["尚未分類",
                "農、林、漁、牧業",
                "礦業及土石採取業",
                "製造業",
                "電子及半導體設備製造", "機械設備製造業",
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
            ContantPhone: "",
            //產品類別
            checkAll: false,
            isIndeterminate: true,
            cities: cityOptions,
            //來源
            sourceAll: false,
            isSource: false,
            sources: sourceOptions,
            checkedSources: [],
            budget1: "0",
            budget2: "",
            //搜索區資料
            company:"",
            intracktime: [],
            oldList: [],
            product: "",
            source: [],//產業
            inDay: [],
            inUserList: [],//負責人
            inStateList: [],//狀態
            inContact: "",//聯絡人
            checkedCities: [],//產品類別
            checkedSources: [],//機會來源
            clinch: null,//成交率
            quote:"",
            //搜索區資料結束
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
        },
        created: function () {
            //讀取url參數name
            var url = new URL(location.href);
            const name = url.searchParams.get("user");

            if (this.admin != "") {
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/MarketList?pag=1',
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: response => {
                        this.list = response.list,
                            this.endCast = response.endCast,
                            this.todayTotal = response.todayTotal,
                            this.PotentialSubmitBos = response.potential,
                            this.SubmitBos = response.SubmitBos,
                            this.CallBos = response.CallBos,
                            this.show = true,
                            this.endCast.length > 0 ? this.endCastVisible = true : this.endCastVisible = false,
                            this.oldList = this.list,
                            this.MarketStateList = response.marketstate,
                            this.total = response.total,
                            this.markeCreateTime = response.markeCreateTime

                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });

            } else {
                location.href = "${pageContext.request.contextPath}/"
            }
            //url有參數name進入個人頁面
            if (name != null) {
                this.btncheck3 = true;
                axios
                    .get('${pageContext.request.contextPath}/Market/selectMarket/' + name)
                    .then(response => (
                        this.list = response.data,
                            this.oldList = this.list,
                            this.MarketStateList = [],
                            this.total = 20
                    ))
                    .catch(function (error) {
                        console.log(error);
                    });
            }
        },
        watch: {
            list: {
                immediate: true,
                handler(newValue, oldValue) {
                    //插入最後追蹤時間
                    for (var bean of newValue) {
                        if (bean.trackbean.length != 0)
                            bean.tracktime = bean.trackbean[0].tracktime;
                    }

                }
            },
        },
        methods: {
            clickEndCast: function (row, column, event) {
                window.open('${pageContext.request.contextPath}/Market/Market/' + row.marketid);

            },
            clickPotential:function(row, column, event){
                window.open('${pageContext.request.contextPath}/Market/potentialcustomer/' + row.customerid);
            },
            handleCurrentChange(val) {//點擊分頁
                // this.inSortState =[];
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/MarketList?pag=' + val,
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: response => {
                        this.list = response.list,
                            this.oldList = response.list
                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }

                });
                this.sortState();
            },
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
            market: function (id) {//進入詳細頁面
                $.ajax({//點擊數
                    url: '${pageContext.request.contextPath}/Market/clicks/' + id,
                    type: 'POST',
                    success: function (url) {
                        window.open('${pageContext.request.contextPath}/Market/Market/' + id);

                    },
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
                var url = new URL(location.href);
                const n = url.searchParams.get("user");
                if (n == null) {
                    location.href = "${pageContext.request.contextPath}/Market/MarketList.jsp?user=" + name;
                } else {
                    location.href = "${pageContext.request.contextPath}/Market/MarketList.jsp";
                }

            },
            selectList: function () {//搜索
                this.inSortState = [];
                this.btncheck3 = false;
                if (this.inDay == "") {//沒輸入日期
                    this.inDay[0] = "";
                    this.inDay[1] = "";
                }
                var url = '${pageContext.request.contextPath}/Market/selectDate?from=' + this.inDay[0] + "&to=" + this.inDay[1];


                if (this.intracktime != "") {//最後追蹤時間
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=tractime&val=" + this.intracktime;

                } else if (this.inUserList != "") {//負責人
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=UserList&val=" + this.inUserList;
                } else if (this.name != "" ) {//機會民稱 客戶
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=name&val=" + this.name;
                }

                else if ( this.company != "") {//機會民稱 客戶
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=name&val=" + this.company;
                }




                else if (this.inStateList != "") {//狀態
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=inStateList&val=" + this.inStateList;

                } else if (this.inContact != "") {//聯絡人
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=inContact&val=" + this.inContact;
                } else if (this.ContantPhone != "") {//聯絡人電話
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=ContantPhone&val=" + this.ContantPhone;
                } else if (this.source != "") {//產業
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=source&val=" + this.source;
                } else if (this.checkedSources != "") {//機會來源
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=checkedSources&val=" + this.checkedSources;
                } else if (this.clinch != "") {//成交機率
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=clinch&val=" + this.clinch;
                } else if (this.product != "") {//商品
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=product&val=" + this.product;
                } else if (this.checkedCities != "") {//產品類別
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=checkedCitiest&val=" + this.product;
                }else if (this.quote != "") {//產品類別
                    url = '${pageContext.request.contextPath}/Market/selectMarket?from=' + this.inDay[0] + "&to=" + this.inDay[1] + "&key=quote&val=" + this.quote;
                }






                $.ajax({
                    url: url,
                    type: 'POST',
                    async: false,//同步請求
                    cache: false,//不快取頁面
                    success: (response => (
                        this.list = response,
                            this.total = this.list.length,
                            this.oldList = this.list,
                        console.log(response ,"response")
                    )),
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });
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





                if (this.name != "") {//機會民稱
                    this.oldList = this.list;
                    this.list = [];
                    for (var bean of this.oldList) {
                        if (bean.name.indexOf(this.name) >= 0 ) {
                            this.list.push(bean);
                        }
                    }
                }
                if (this.company != "") {//客戶
                    this.oldList = this.list;
                    this.list = [];
                    for (var bean of this.oldList) {
                        if ( bean.client.indexOf(this.company) >= 0) {
                            this.list.push(bean);
                        }
                    }
                }

                if (this.inStateList != "") {//狀態
                    this.oldList = this.list;
                    this.list = [];
                    for (var u of this.inStateList)
                        for (var bean of this.oldList) {
                            if (u == bean.stage) {
                                this.list.push(bean);
                            }
                        }
                }
                if (this.inContact != "") {//聯絡人
                    this.oldList = this.list;
                    this.list = [];
                    for (var bean of this.oldList) {
                        if (bean.contactname.indexOf(this.inContact) >= 0) {
                            this.list.push(bean);
                        }
                    }
                }
                if (this.ContantPhone != "") {//聯絡人電話
                    this.oldList = this.list;
                    this.list = [];
                    for (var bean of this.oldList) {
                        if (bean.contactphone.indexOf(this.ContantPhone) >= 0) {
                            this.list.push(bean);
                        }
                    }
                }
                if (this.source != "") {//產業
                    this.oldList = this.list;
                    this.list = [];
                    for (var u of this.source)
                        for (var bean of this.oldList) {
                            if (u == bean.type) {
                                this.list.push(bean);
                            }
                        }
                }
                if (this.checkedCities != "") {//產品類別
                    this.oldList = this.list;
                    this.list = [];
                    for (var u of this.checkedCities)
                        for (var bean of this.oldList) {
                            if (u == bean.producttype) {
                                this.list.push(bean);
                            }
                        }
                }
                if (this.checkedSources != "") {//機會來源
                    this.oldList = this.list;
                    this.list = [];
                    for (var u of this.checkedSources)
                        for (var bean of this.oldList) {
                            if (u == bean.source) {
                                this.list.push(bean);
                            }
                        }
                }
                if (this.clinch != "") {//成交機率
                    this.oldList = this.list;
                    this.list = [];
                    for (var bean of this.oldList) {
                        if (bean.clinch == this.clinch) {
                            this.list.push(bean);
                        }
                    }
                }
                if (this.product != "") {//商品
                    this.oldList = this.list;
                    this.list = [];
                    for (var bean of this.oldList) {
                        if (bean.product.indexOf(this.product) >= 0 || bean.message.indexOf(this.product) >= 0 || bean.name.indexOf(this.product) >= 0 || bean.quote.indexOf(this.product) >= 0) {
                            this.list.push(bean);
                        }
                    }
                }
                this.total = 20;
                this.oldList = this.list
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
                const imp = ["高", "中", "低", ""];//先輪替這列表
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
            },//階段 排序
            sortState: function () {
                if (this.inSortState.length == 0) {
                    this.list = this.oldList;

                } else {
                    var list = this.oldList;
                    this.list = [];
                    for (const State of this.inSortState) {
                        for (let i = 0; i < list.length; i++) {
                            if (list[i].stage == State)
                                this.list.push(list[i]);
                        }
                    }
                }

            },
            changeActivity: function () {
                var $all = $("input[name=mak]");
                $all.prop("checked", $("#activity").prop("checked"));
            },
            // 勾選單項
            clickmak: function () {
                var $all = $("input[name=mak]");
                var $zx = $("input[name=mak]:checked");
                $("#activity").prop("checked", $zx.length == $all.length);
            },
            //判斷有沒有附件
            isEmpty(marketfilelist) {
                if (marketfilelist == null) {
                    return false
                } else {
                    return marketfilelist.length > 0
                }

            },
            //添加使用者狀態
            AddState(filed, state, type) {


                if (filed == "day") {
                    if (state == "") {//沒輸入日期
                        return null;
                    }
                    state = this.stateDay[0] + "~" + this.stateDay[1];
                }

                console.log(filed, state, type);
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/AddState/' + filed + '/' + state + '/' + type,
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: (response => (
                        this.MarketStateList = response
                    )),
                    error: function (returndata) {
                        console.log(returndata);
                    }

                })
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/MarketList?pag=1',
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: response => {
                        this.list = response.list,
                            this.endCast = response.endCast,
                            this.todayTotal = response.todayTotal,
                            this.SubmitBos = response.SubmitBos,
                            this.CallBos = response.CallBos,
                            this.show = true,
                            this.endCast.length > 0 ? this.endCastVisible = true : this.endCastVisible = false,
                            this.oldList = this.list,
                            this.MarketStateList = response.marketstate,
                            this.total = response.total

                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });


            },
            //刪除使用者狀態
            CloseMarketState(tag) {
                this.MarketStateList.splice(this.MarketStateList.indexOf(tag), 1);
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/delState/' + tag.marketstateid,
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: (response => (

                        this.MarketStateList = response
                        // this.list = response,
                        // this.total = this.list.length,
                        // this.oldList = this.list
                    )),
                    error: function (returndata) {
                        console.log(returndata);
                    }
                })
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/MarketList?pag=1',
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: response => {
                        this.list = response.list,
                            this.endCast = response.endCast,
                            this.todayTotal = response.todayTotal,
                            this.SubmitBos = response.SubmitBos,
                            this.CallBos = response.CallBos,
                            this.show = true,
                            this.endCast.length > 0 ? this.endCastVisible = true : this.endCastVisible = false,
                            this.oldList = this.list,
                            this.MarketStateList = response.marketstate,
                            this.total = response.total

                    },
                    error: function (returndata) {
                        console.log(returndata);
                    }
                });


            }, delAllState() {
                $.ajax({
                    url: '${pageContext.request.contextPath}/Market/delAllState/${user.adminid}',
                    type: 'POST',
                    async: false,
                    cache: false,
                    success: (response => (
                        location.href = "${pageContext.request.contextPath}/Market/MarketList.jsp"

                    )),
                    error: function (returndata) {
                        console.log(returndata);
                    }
                })
            }
        },
    })
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