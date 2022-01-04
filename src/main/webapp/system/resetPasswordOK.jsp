<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="cn">

    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <meta name="description" content="">
      <meta name="author" content="">
      <title>已寄出</title>
      <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
      <link href="https://getbootstrap.com/docs/4.0/examples/signin/signin.css" rel="stylesheet"
        crossorigin="anonymous" />
    </head>

    <body>
      <div class="container">
        <form class="form-signin" method="post" action="${pageContext.request.contextPath}/forget">         
          <h3>設定成功<a href="${pageContext.request.contextPath}/time.jsp">請重新登入</a></H3>           

        </form>
      </div>
    </body>

    </html>