<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="cn">

    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <meta name="description" content="">
      <meta name="author" content="">
      <title>Please sign in</title>
      <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
      <link href="https://getbootstrap.com/docs/4.0/examples/signin/signin.css" rel="stylesheet"
        crossorigin="anonymous" />
        <script src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.13.0.custom/jquery-ui.min.js"></script>
    </head>

    <body>
      <div class="container">
        <form class="form-signin" method="post" action="${pageContext.request.contextPath}/resetPassword/${param.id}" id="myform">
          <h2 class="form-signin-heading">設定新密碼</h2>
          <p>
            <label for="username" class="sr-only">password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="password" required
              autofocus>
          </p>
          <p>
            <label for="password" class="sr-only">Password</label>
            <input type="password" id="password_again" name="password_again" class="form-control" placeholder="密碼驗證" required>
          </p>
           
          <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
          <input type='checkbox' name='remember-me' checked style="visibility: hidden;"/><br>
          
        </form>
      </div>
    </body>
      <!-- 驗證UI -->
      <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js"></script>
      <script>
          $(function () {

              // 密碼驗證
              jQuery.validator.setDefaults({
                  submitHandler: function () {
                      if (confirm("提交確認")) form.submit();

                  }
              });

              $.extend($.validator.messages, {
                  required: "這是必填字段",
                  email: "請输入有效的電子郵件地址",
                  url: "请输入有效的网址",
                  date: "请输入有效的日期",
                  dateISO: "请输入有效的日期 (YYYY-MM-DD)",
                  number: "请输入有效的数字",
                  digits: "只能输入数字",
                  creditcard: "请输入有效的信用卡号码",
                  equalTo: "你的输入不相同",
                  extension: "请输入有效的后缀",
                  maxlength: $.validator.format("最多可以输入 {0} 个字符"),
                  minlength: $.validator.format("最少要输入 {0} 个字符"),
                  rangelength: $.validator.format("请输入长度在 {0} 到 {1} 之间的字符串"),
                  range: $.validator.format("请输入范围在 {0} 到 {1} 之间的数值"),
                  max: $.validator.format("请输入不大于 {0} 的数值"),
                  min: $.validator.format("请输入不小于 {0} 的数值")
              });
              $("#myform").validate({
                  rules: {
                      password: "required",
                      password_again: {
                          equalTo: "#password"
                      }
                  }
              });

          });
          function basefrom() {
              if (confirm("確定修改?")) $(".basefrom").submit();
          }
      </script>

    </html>