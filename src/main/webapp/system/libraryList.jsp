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
                .item:hover {
                    background-color: #afe3d5;
                    cursor: pointer;
                }
            </style>
        </head>

        <body>
        <div class="container-fluid">
            <div class="row">
            <!-- <%-- 插入側邊欄--%> -->
            <jsp:include page="/Sidebar.jsp"></jsp:include>
            <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
            <div class="col-lg-11  ">
                <div class="row ">
                    <div class="col-md-12"  >
                        <table class="Table table-striped orderTable" key="1" v-if="show">
                            <tr>
                                <td>名稱</td>
                            </tr>
                            <tr onclick="goDetail('producttype')" style="" class="item">
                                <td>銷售機會 - 產品類別</td>
                            </tr>
<%--                            <tr onclick="goDetail('MarketType')" class="item">--%>
<%--                                <td>銷售機會 - 產業</td>--%>
<%--                            </tr>--%>
<%--                            <tr onclick="goDetail('MarketSource')" class="item">--%>
<%--                                <td>銷售機會 - 來源 </td>--%>
<%--                            </tr>--%>
<%--                            <tr onclick="goDetail('MarketCreateTime')" class="item">--%>
<%--                                <td>銷售機會 - 案件類型</td>--%>
<%--                            </tr>--%>
<%--                            <tr onclick="goDetail('position')" class="item">--%>
<%--                                <td>員工管理 - 職位</td>--%>
<%--                            </tr>--%>
<%--                            <tr onclick="goDetail('department')" class="item">--%>
<%--                                <td>員工管理 - 部門</td>--%>
<%--                            </tr>--%>
                        </table>

                    </div>
                    

                </div>
            </div>
        </body>
        <script>
            $(".system").show();
            // 勾選單項
            var $all = $("input[name=mak]");
            $("input[type=checkbox][name=mak]").change(function () {
                var $zx = $("input[name=mak]:checked");
                $("#activity").prop("checked", $zx.length == $all.length);
            });

            function goDetail(librarygroup){
                location.href="${pageContext.request.contextPath}/system/library.jsp?librarygroup="+librarygroup;
            }

        </script>


        </html>