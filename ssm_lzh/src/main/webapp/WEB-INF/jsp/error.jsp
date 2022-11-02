<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录失败</title>
    <link rel="stylesheet" href="../css/style.css">
    <link href="https://fonts.useso.com/css?family=Poppins:600&display=swap" rel="stylesheet">
    <script src="../js/check.js"></script>
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
    <!-- https://fontawesome.com/v5/search?s=solid%2Cbrands -->
</head>
<body>
<img src="../img/wave.png" class="wave">
<div class="container">
    <div class="img">
        <img src="../img/bg.svg" alt="">
    </div>
    <div class="login-content">
        <form action="${pageContext.request.contextPath}/user/login">
            <img src="../img/avatar.svg" alt="">
            <h2 class="title">登录</h2><br>
            <h3 class="title">${loginerror}</h3><br>
            <div class="input-div one">
                <div class="i">
                    <i class="fas fa-user"></i>
                </div>
                <div class="div">
                    <h5>用户名</h5>
                    <input type="text" name="userName" class="input">
                </div>
            </div>
            <div class="input-div pass">
                <div class="i">
                    <i class="fas fa-lock"></i>
                </div>
                <div class="div">
                    <h5>密码</h5>
                    <input type="password" name="password" class="input">
                </div>
            </div>
            <a href="../register.jsp">注册为新用户</a>
            <input type="submit" class="btn" value="登录" οnclick="return checkLoginForm()">
        </form>
    </div>
</div>
<script src="../js/main.js"></script>
</body>
</html>
