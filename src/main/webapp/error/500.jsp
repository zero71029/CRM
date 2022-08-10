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
                    <div class="row text-center" >
                        <div class="col-md-12">
                            <h1>抱歉發生了錯誤! ${message}</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var vm = new Vue({
        el: ".app",
        data() {
            return {



            }
        },
        created() {

        },
        methods: {

        },
    })
</script>




</html>