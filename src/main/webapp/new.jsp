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
        </head>
        </head>

        <body>
            <!-- <%-- 彈窗--%> -->
            <div class="hazy"></div>
            <div class="cat">
                <button class="catReturn">X</button>
                <br>
                <div class="row">
                    <div class="input-group mb-3" style="width: 95%; padding-left: 50px;">
                        <input type="text" class="form-control" placeholder="ID or 名稱 or 貨號"
                            aria-label="Recipient's username" aria-describedby="button-addon2">
                        <button class="btn btn-outline-secondary" type="button" id="selectProduct">搜索</button>
                    </div>
                </div>
            </div>
            <!-- <%-- 彈窗/////////////////////////////////////--%> -->
            <!-- <%-- 插入側邊欄--%> -->
            <jsp:include page="/Sidebar.jsp"></jsp:include>
            <!-- <%-- 中間主體////////////////////////////////////////////////////////////////////////////////////////--%> -->
            <div class="col-md-11">
                <div class="row justify-content-end">
                    <div class="col-md-10">
                        <!-- <%-- 中間主體--%> -->
                        <!-- <%-- 抬頭按鈕--%> -->
                        <div class="row">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="checkbox" class="btn-check" id="btncheck1" autocomplete="off"
                                    onclick="newMessage()">
                                <label class="btn btn-outline-primary state1" for="btncheck1">新留言</label>

                                <input type="checkbox" class="btn-check" id="btncheck2" autocomplete="off">
                                <label class="btn btn-outline-primary state2" for="btncheck2"
                                    onclick="inquire()">查詢</label>

                                <input type="checkbox" class="btn-check" id="btncheck3" autocomplete="off">
                                <label class="btn btn-outline-primary" for="btncheck3" onclick="reply()">已回覆</label>
                            </div>
                        </div>
                        <table class="Table table-striped orderTable">
                            <tr>
                                <td>留言編號</td>
                                <td>顧客</td>                                
                                <td>日期</td>
                                <td>回覆</td>
                            </tr>
                            <c:if test="${not empty mess}">
                                <c:forEach varStatus="loop" begin="0" end="${mess.size()-1}" items="${mess}" var="s">
                                    <tr class="item" onclick="mess(${s.id})">
                                        <td>${s.id}</td>
                                        <td>${s.firstname} ${s.lastname}</td>                                        
                                        <td>${s.create_date}</td>
                                        <td><button>回覆</button></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </div>
                </div>
            </div>
        </body>

            <script>
                // 看細節
                function mess(messid){
                    window.location.href = "${pageContext.request.contextPath}/backstage/mess/" + messid;
                }
                //切換回覆狀態
                function reply(){
                    window.location.href = "${pageContext.request.contextPath}/backstage/messList?state=2";
                }
                function newMessage(){
                    window.location.href = "${pageContext.request.contextPath}/backstage/messList?state=1";
                }
            </script>
        </html>