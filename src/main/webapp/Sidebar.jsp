<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!-- <%-- jQuery放這裡 --%> -->
        <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.css">

        <!-- bootstrap的CSS、JS樣式放這裡  -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css">
        <!-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.rtl.min.css"> -->
        <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
        <!--  popper.min.js 用于弹窗、提示、下拉菜单 -->
        <script src="https://cdn.staticfile.org/popper.js/2.9.3/umd/popper.min.js"></script>
        <!-- <%-- 主要的CSS、JS放在這裡--%> -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
        <!-- <%-- VUE放這裡 --%> -->
        <!-- <script src="${pageContext.request.contextPath}/js/vue.js"></script> -->

        <!-- 引入样式 vue-->
        <script src="${pageContext.request.contextPath}/js/vue.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/axios.min.js"></script>
        <!-- 引入element-ui样式 -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/js/element-ui.css">
        <!-- 引入element-ui组件库 -->
        <script src="${pageContext.request.contextPath}/js/element-ui.js"></script>

        <style>

        </style>

        <!-- <%-- 抬頭--%> -->
        <header class="mainColor headtop">
            <div class="row">
                <a href='${pageContext.request.contextPath}/' class='col-lg-2' style="font-size: 2rem;">久德資訊平台</a>
                <div class='col-lg-7'></div>
                <span class='col-lg-3 username' style="font-size: 2rem;"><span class='workitem'
                        style="cursor: pointer;"></span>
                    <c:if test='${empty user}'>
                        <a href="${pageContext.request.contextPath}/newAdmin.jsp">註冊</a>
                    </c:if> /
                    <a class="Signout" href="${pageContext.request.contextPath}/logout">登出 </a>
                </span><br>
            </div>
        </header>
        <!--側邊欄  -->
        <div class="col-lg-1 navfix mainColor" style="padding: 0%;">
            <ul class="list-group">
                <button class="list-group-item" onclick="market()">
                    營銷模塊
                </button>
                <button class="market customerbar"
                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/potentialcustomerList.jsp'">潛在客戶</button>
                <button class="market marketbar"
                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/MarketList.jsp'">銷售機會</button>
                <button class="market workbar"
                    onclick="javascript:location.href='${pageContext.request.contextPath}/Market/workList.jsp'">工作項目</button>
                <!-- <button class="market"
                    onclick="javascript:location.href='${pageContext.request.contextPath}/CRM/QuotationList'">報價單</button> -->
                <button class="list-group-item" onclick="client()" >
                    客戶管理
                </button>
                <button class="client clientbar"
                    onclick="javascript:location.href='${pageContext.request.contextPath}/client/clientList.jsp'">客戶</button>
                <button class="client contactbar"
                    onclick="javascript:location.href='${pageContext.request.contextPath}/CRM/ContactList'">聯絡人</button>
                <!-- <button class="client">流失客戶</button> -->
                <button class="list-group-item" onclick="javascript:location.href=''">
                    服務管理
                </button>
                <button class="list-group-item " onclick="javascript:location.href='${pageContext.request.contextPath}/statistic/statistic.jsp'">
                    數據管理
                </button>
                <c:if test='${user.position == "主管" || user.position == "系統" ||user.position == "總經理"}'>
                    <button class="list-group-item " onclick="system()">
                        系統管理
                    </button>
                    <c:if test='${user.position == "系統"||user.position == "總經理"}'>
                        <!-- <button class="system"
                        onclick="javascript:location.href='#'">下拉選單管理</button> -->
                        <button class="system"
                            onclick="javascript:location.href='${pageContext.request.contextPath}/system/adminList/adminid'">員工管理</button>
                    </c:if>
                    <button class="system"
                        onclick="javascript:location.href='${pageContext.request.contextPath}/system/billboardList?pag=1'">討論區管理</button>
                </c:if>
                <button class="list-group-item"
                    onclick="javascript:location.href='${pageContext.request.contextPath}/Task/TaskList.jsp'">
                    每日任務
                </button>
            </ul>
            <!-- session 認證-->
            <c:if test='${empty user}'>
                <script>

                    console.log("未登入");
                    $.ajax({
                        url: '${pageContext.request.contextPath}/UserAuthorize', 
                        type: 'POST',
                        success: function (json) {
                            if (json) {
                                location.reload();
                            } else {

                                console.log("沒有認證");
                            }
                        },
                        error: function (returndata) {
                            console.log(returndata);
                        }
                    });
                </script>
            </c:if>
            <!-- 工作項目彈窗 -->
            <div class="work" title="工作項目">
                <table class="Table table-striped workTable">
                    <tr class=''>
                        <td width='100'>種類</td>
                        <td>主題</td>
                        <td width='100'>狀態</td>
                    </tr>
                </table>
            </div>
        </div>
        <c:set var="ddd" value="未讀(${user.mail.size()})"></c:set>
        <c:set var="CRM" value='${empty user?"未登入":"CRM"}'></c:set>
        <script>
            $('title').html('${user.mail.size() > 0 ? ddd:CRM}');

            window.setTimeout(function () {
                location.reload();
            }, 3600000);//1小時
            $(".market").hide();
            $(".client").hide();
            $(".system").hide();

            function market() {
                $(".market").toggle();
                $(".client").hide();
                $(".system").hide();
            }

            function client() {
                $(".client").toggle();
                $(".market").hide();
                $(".system").hide();
            }

            function system() {
                $(".system").toggle();
                $(".market").hide();
                $(".client").hide();
            }
            var Signout = '${user.name}';
            if (Signout == '') {
                $('.Signout').text("登入");
                $('.Signout').attr("href", "${pageContext.request.contextPath}/time.jsp");
            } else { }
            //取得工作項目
            $.ajax({
                url: '${pageContext.request.contextPath}/workitem/${user.name}', 
                type: 'POST',
                success: function (json) {
                    $('.workitem').html("${user.name}<span class='badge bg-primary'>" + (json.length) + "</span>");
                    $('.workTable').empty();
                    $('.workTable').append("<tr><td width='100'> </td><td>主題</td> <td width='100'>狀態</td></tr>");

                    if (json.length == 0) {
                        $('.workitem').empty()
                    } else {
                        for (var bean of json) {
                            $('.workTable').append('<tr class="www workTR" onclick="gowork(`' + bean.workid + '`)"><td>工作項目</td><td>' + bean.name + '</td><td>' + bean.state + '</td></tr>');
                        }
                    }
                    //取得銷售機會
                    $.ajax({
                        url: '${pageContext.request.contextPath}/marketitem/${user.name}', 
                        type: 'POST',
                        success: function (market) {
                            $('.workitem').html("${user.name}<span class='badge bg-primary'>" + (json.length + market.length) + "</span>");
                            for (var bean of market) {
                                $('.workTable').append('<tr class="www workTR" onclick="gomarket(`' + bean.marketid + '`)"><td>銷售機會</td><td>' + bean.name + '</td><td>' + bean.stage + '</td></tr>');
                            }
                            //取得潛在顧客
                            $.ajax({
                                url: '${pageContext.request.contextPath}/PotentialItem/${user.name}', 
                                type: 'POST',
                                success: function (customer) {
                                    $('.workitem').html("${user.name}<span class='badge bg-primary' >" + (json.length + market.length + customer.length) + "</span>");
                                    for (var bean of customer) {
                                        $('.workTable').append('<tr class="www workTR" onclick="goPotential(`' + bean.customerid + '`)"><td>潛在顧客</td><td>' + bean.company + '</td><td>' + bean.status + '</td></tr>');
                                    }
                                    $('.workTable').append('<br><br>')
                                }
                            });

                        }

                    });

                },
                error: function (returndata) {
                    console.log(returndata);
                }

            });

            // 取得使用者
            // $.ajax({
            //     url: '${pageContext.request.contextPath}/admin/${user.adminid}', 
            //     type: 'POST',
            //     success: function (market) {
            //         $('.helpItem').text("協助工作:" );
            //         // for (var bean of market) {
            //         //     $('.workTable').append('<tr class="www workTR" onclick="gomarket(' + bean.marketid + ')"><td>銷售機會</td><td>' + bean.name + '</td><td>' + bean.stage + '</td></tr>');
            //         // }
            //     }
            // });



            $('.workitem').click(function () {
                $('.work').dialog("open");
            })

            $(".work").dialog({
                autoOpen: false,
                position: {
                    at: "top+300"
                },
                width: 700,
                height: 300
            });

            function gowork(workid) {
                location.href = "${pageContext.request.contextPath}/work/detail/" + workid;
            }

            function gomarket(marketid) {
                location.href = "${pageContext.request.contextPath}/Market/Market/" + marketid;
            }

            function goPotential(customerid) {
                location.href = "${pageContext.request.contextPath}/Market/potentialcustomer/" + customerid;
            }
            //取得工作項目=========================
        </script>
        <style>
            .workTable .workTR:hover {
                color: #FFF;
                line-height: 3rem;
                background-color: #62A5A1;
                cursor: pointer;
            }

            a {
                text-decoration: none;
            }
        </style>