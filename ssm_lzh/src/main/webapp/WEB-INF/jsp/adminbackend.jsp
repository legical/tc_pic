<%--
  Created by IntelliJ IDEA.
  User: BricR
  Date: 2022/7/20
  Time: 2:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员</title>
    <link rel="stylesheet" href="../css/backstyle.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="../js/b99e675b6e.js"></script>
    <script src="../js/index.js"></script>
    <!-- https://fontawesome.com/v5/icons/times?s=solid -->
</head>

<body>
<div class="wrapper">
    <div class="sidebar">
        <div class="bg_shadow"></div>
        <div class="sidebar_inner">
            <div class="close">
                <i class="fas fa-times"></i>
            </div>
            <div class="profile_info">
                <div class="profile_img">
                    <img src="../img/admin_Profile_id.png" alt="">
                </div>
                <div class="profile_data">
                    <p class="name" style="color:goldenrod">${user.getRealName()}</p>
                    <span>
            <i class="fa-solid fa-id-card-clip"></i>
            ${identity}
          </span>
                </div>
            </div>
            <%--      导航--%>
            <ul class="siderbar_menu">
                <%--  个人信息--%>
                <li class="active">
                    <a href="#">
                        <div class="icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="title" >查看信息</div>
                    </a>
                </li>
            </ul>

            <%--      退出登录--%>
            <div class="logout_btn">
                <a href="${pageContext.request.contextPath}/user/loginOut">退出登录</a>
            </div>

        </div>
    </div>

    <div class="main_container">
        <div class="navbar">
            <div class="hamburger">
                <i class="fas fa-bars"></i>
            </div>
            <div class="logo">
                <a >用户详细信息</a>
            </div>
        </div>
        <div style="overflow-x:auto;">
            <table class="table">
                <tr>
                    <th>序号</th>
                    <th>用户ID</th>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>真实姓名</th>
                    <th>性别</th>
                    <th>出生日期</th>
                    <th>身份证号</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${list}" var="user" varStatus="status">
                    <tr>
                        <td>${status.count}</td>
                        <td>${user.getId()}</td>
                        <td>${user.getUsername()}</td>
                        <td>${user.getPassword()}</td>
                        <td>${user.getRealName()}</td>
                        <td>${user.getSex()}</td>
                        <td>${user.getBirthday()}</td>
                        <td>${user.getIdCard()}</td>
                        <td>
<%--                            <a href="${pageContext.request.contextPath}/user/update?id=${user.getId()}">✏编辑</a>--%>
                            <div class="email" onclick="this.classList.add('expand')">
        <div class="from">
            <div class="from-contents">
                <!--<div class="avatar me"></div>-->
                <div class="name">✏编辑</div>
            </div>
        </div>
        <div class="to">
            <div class="to-contents">
                <div class="top">
                    <div class="avatar-large me"></div>
                    <div class="name-large">修改ID${user.getId()}用户信息</div>
                    <div class="x-touch" onclick="document.querySelector('.email').classList.remove('expand');event.stopPropagation();">
                        <div class="x">
                            <div class="line1"></div>
                            <div class="line2"></div>
                        </div>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/user/modify" method="post">
                    <div class="bottom">
                        <div class="row">
                            <svg t="1658480772310" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1389" width="32" height="32"><path d="M880 896c0-126.29-63.62-237.72-160.57-304a368.15 368.15 0 0 1-414.86 0C207.62 658.28 144 769.71 144 896a48 48 0 0 0 48 48h640a48 48 0 0 0 48-48z" fill="#FFFFFF" p-id="1390"></path><path d="M880 896c0-126.29-63.62-237.72-160.57-304A366.25 366.25 0 0 1 512 656c-76.95 0-144-31-160-39.94-84.7 67.5-160 167.87-160 279.94a48 48 0 0 0 48 48h592a48 48 0 0 0 48-48z" fill="#82AAFA" p-id="1391"></path><path d="M512 304m-224 0a224 224 0 1 0 448 0 224 224 0 1 0-448 0Z" fill="#FFFFFF" p-id="1392"></path><path d="M536 328m-200 0a200 200 0 1 0 400 0 200 200 0 1 0-400 0Z" fill="#FF9580" p-id="1393"></path><path d="M832 960H192a64.07 64.07 0 0 1-64-64 384.1 384.1 0 0 1 167.54-317.21 16 16 0 0 1 18.06 0 352.14 352.14 0 0 0 396.8 0 16 16 0 0 1 18.06 0A384.1 384.1 0 0 1 896 896a64.07 64.07 0 0 1-64 64zM304.85 611.38A352.11 352.11 0 0 0 160 896a32 32 0 0 0 32 32h640a32 32 0 0 0 32-32 352.11 352.11 0 0 0-144.85-284.62 384.25 384.25 0 0 1-414.3 0zM512 544a240 240 0 0 1-169.71-409.71 240 240 0 0 1 339.42 339.42A238.43 238.43 0 0 1 512 544z m0-448c-114.69 0-208 93.31-208 208s93.31 208 208 208 208-93.31 208-208S626.69 96 512 96z" fill="#333333" p-id="1394"></path><path d="M576 864H448a32 32 0 0 1 0-64h128a32 32 0 0 1 0 64z" fill="#333333" p-id="1395"></path></svg>
                            <div class="link">
                                <input type="text" name="userName" class="input" placeholder="输入新用户名">
                            </div>
                        </div>
                        <div class="row">
                            <svg t="1658480799647" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1577" width="32" height="32"><path d="M144 416m112 0l512 0q112 0 112 112l0 304q0 112-112 112l-512 0q-112 0-112-112l0-304q0-112 112-112Z" fill="#FFFFFF" p-id="1578"></path><path d="M192 464m112 0l448 0q112 0 112 112l0 240q0 112-112 112l-448 0q-112 0-112-112l0-240q0-112 112-112Z" fill="#A89BFA" p-id="1579"></path><path d="M512 768a32 32 0 0 1-32-32V608a32 32 0 0 1 64 0v128a32 32 0 0 1-32 32z" fill="#333333" p-id="1580"></path><path d="M256 336c0-141.38 114.62-256 256-256s256 114.62 256 256v80H256z" fill="#FFFFFF" p-id="1581"></path><path d="M304.76 343.62C304.76 215.7 408.46 112 536.38 112S768 215.7 768 343.62V416H304.76z" fill="#82DAFA" p-id="1582"></path><path d="M784 403.59V336a272 272 0 0 0-544 0v67.59c-64 14.59-112 72-112 140.41v272c0 79.4 64.6 144 144 144h480c79.4 0 144-64.6 144-144V544c0-68.41-47.95-125.82-112-140.41zM272 336c0-132.34 107.66-240 240-240s240 107.66 240 240v64H272z m592 480a112.12 112.12 0 0 1-112 112H272a112.12 112.12 0 0 1-112-112V544a112.12 112.12 0 0 1 112-112h480a112.12 112.12 0 0 1 112 112z" fill="#333333" p-id="1583"></path></svg>
                            <div class="link"><input type="password" name="password" class="input" placeholder="输入新密码"></div>
                        </div>

                        <div class="row">
                            <svg t="1658484041330" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1765" width="32" height="32"><path d="M880 944L558.64 818.25a128 128 0 0 0-93.28 0L144 944V208A128 128 0 0 1 272 80h480a128 128 0 0 1 128 128z" fill="#FFFFFF" p-id="1766"></path><path d="M864 928L559.93 803.61a128 128 0 0 0-96-0.38l-228 91.22A32 32 0 0 1 192 864.73V224a96 96 0 0 1 96-96h480a96 96 0 0 1 96 96z" fill="#FFE07A" p-id="1767"></path><path d="M630.66 640L512 577.14 393.33 640 416 506.86l-96-94.29 132.67-19.43L512 272l59.33 121.14L704 412.56l-96 94.29L630.66 640z" fill="#FFFFFF" p-id="1768"></path><path d="M630.66 640L512 577.14l-40.08 8.68A16 16 0 0 1 452.85 567L465 506.86l-34.9-41.21a16 16 0 0 1 6-25.09l60.55-25.42L517.59 363a16 16 0 0 1 27.51-3.83l26.23 34L704 412.56l-96 94.29z" fill="#FF9580" p-id="1769"></path><path d="M880 960a15.91 15.91 0 0 1-5.83-1.1L552.81 833.15a111.66 111.66 0 0 0-81.62 0L149.83 958.9A16 16 0 0 1 128 944V208c0-79.4 64.6-144 144-144h480c79.4 0 144 64.6 144 144v736a16 16 0 0 1-16 16zM272 96a112.12 112.12 0 0 0-112 112v712.56l299.53-117.21a143.59 143.59 0 0 1 104.94 0L864 920.56V208A112.12 112.12 0 0 0 752 96z" fill="#333333" p-id="1770"></path><path d="M393.33 656a16 16 0 0 1-15.77-18.69l21.26-124.9-90-88.43a16 16 0 0 1 8.89-27.24L442 378.53 497.63 265a16 16 0 0 1 14.37-9 16 16 0 0 1 14.37 9L582 378.53l124.33 18.2a16 16 0 0 1 8.88 27.27l-90 88.44 21.26 124.9a16 16 0 0 1-23.26 16.82L512 595.24l-111.18 58.9a16 16 0 0 1-7.49 1.86zM354.2 423.73l73 71.71a16 16 0 0 1 4.56 14.1l-17.2 101.11L504.51 563a16 16 0 0 1 15 0l89.94 47.64-17.21-101.1a16 16 0 0 1 4.57-14.1l73-71.72L569 409a16 16 0 0 1-12-8.8l-45-91.79-45 91.8a16 16 0 0 1-12 8.79z" fill="#333333" p-id="1771"></path></svg>
                            <div class="link">
                                <input type="text" name="realName" class="input" placeholder="输入新的真实姓名">
                            </div>
                        </div>
                        <div class="row">
                            <svg t="1658484493017" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="1985" width="32" height="32"><path d="M80 144m128 0l608 0q128 0 128 128l0 480q0 128-128 128l-608 0q-128 0-128-128l0-480q0-128 128-128Z" fill="#FFFFFF" p-id="1986"></path><path d="M128 193m112 0l576 0q112 0 112 112l0 447q0 112-112 112l-576 0q-112 0-112-112l0-447q0-112 112-112Z" fill="#A89BFA" p-id="1987"></path><path d="M816 896H208c-79.4 0-144-64.6-144-144V272c0-79.4 64.6-144 144-144h608c79.4 0 144 64.6 144 144v480c0 79.4-64.6 144-144 144zM208 160A112.12 112.12 0 0 0 96 272v480a112.12 112.12 0 0 0 112 112h608a112.12 112.12 0 0 0 112-112V272a112.12 112.12 0 0 0-112-112z" fill="#333333" p-id="1988"></path><path d="M352 416m-112 0a112 112 0 1 0 224 0 112 112 0 1 0-224 0Z" fill="#FFFFFF" p-id="1989"></path><path d="M368 432m-80 0a80 80 0 1 0 160 0 80 80 0 1 0-160 0Z" fill="#FFBF80" p-id="1990"></path><path d="M352 544a128 128 0 1 1 128-128 128.14 128.14 0 0 1-128 128z m0-224a96 96 0 1 0 96 96 96.11 96.11 0 0 0-96-96z" fill="#333333" p-id="1991"></path><path d="M528 670a167.6 167.6 0 0 0-56.48-125.64 160 160 0 0 1-231.42 8A167.43 167.43 0 0 0 192 670a66 66 0 0 0 66 66h204a66 66 0 0 0 66-66z" fill="#FFFFFF" p-id="1992"></path><path d="M528.64 681.13c0-29.5-6.79-51.78-21-72.53a32.08 32.08 0 0 0-43.26-9.27c-28.74 17.77-60.41 32.55-95.35 32.55-30.44 0-70.44-4.68-100.45-14.61a32 32 0 0 0-41.1 23.27c-2.8 12-3.51 25.46-3.51 40.59 0 21.87 15 39.23 32.84 39.23h212c25.2 0 59.84-17.36 59.84-39.23z" fill="#FFBF80" p-id="1993"></path><path d="M462 752H258a82.1 82.1 0 0 1-82-82 183 183 0 0 1 52.68-128.87 16 16 0 0 1 22.61-0.22 144 144 0 0 0 208.28-7.19 16 16 0 0 1 22.57-1.32A184.21 184.21 0 0 1 544 670a82.1 82.1 0 0 1-82 82zM241.41 574.92A150.92 150.92 0 0 0 208 670a50.06 50.06 0 0 0 50 50h204a50.06 50.06 0 0 0 50-50 152.19 152.19 0 0 0-40.27-103 176 176 0 0 1-230.32 7.95z" fill="#333333" p-id="1994"></path><path d="M592 384m32 0l160 0q32 0 32 32l0 0q0 32-32 32l-160 0q-32 0-32-32l0 0q0-32 32-32Z" fill="#333333" p-id="1995"></path><path d="M656 576m32 0l96 0q32 0 32 32l0 0q0 32-32 32l-96 0q-32 0-32-32l0 0q0-32 32-32Z" fill="#333333" p-id="1996"></path></svg>
                            <div class="link"><input type="text" name="idCard" class="input" placeholder="输入新身份证号码" onchange="setBirSex()"></div>
                        </div>

                        <div>
                            <input type="text" style="visibility:hidden;" name="id" value="${user.getId()}"/>
                            <input type="number" style="display:none" name="inden" value="1"/>
                        </div>
                        <div class="row">
                            <svg t="1658491124653" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="2597" width="32" height="32"><path d="M112 112m128 0l544 0q128 0 128 128l0 544q0 128-128 128l-544 0q-128 0-128-128l0-544q0-128 128-128Z" fill="#FFFFFF" p-id="2598"></path><path d="M160 160m112 0l512 0q112 0 112 112l0 512q0 112-112 112l-512 0q-112 0-112-112l0-512q0-112 112-112Z" fill="#A0F090" p-id="2599"></path><path d="M784 928H240c-79.4 0-144-64.6-144-144V240c0-79.4 64.6-144 144-144h544c79.4 0 144 64.6 144 144v544c0 79.4-64.6 144-144 144zM240 128a112.12 112.12 0 0 0-112 112v544a112.12 112.12 0 0 0 112 112h544a112.12 112.12 0 0 0 112-112V240a112.12 112.12 0 0 0-112-112z" fill="#333333" p-id="2600"></path><path d="M256 448l480-160-176 496-130.29-144 115.05-161L384 592 256 448z" fill="#FFFFFF" p-id="2601"></path><path d="M368.63 467.23l304-119a16 16 0 0 1 21.06 19.79L560 784 429.71 640l115.05-161L384 576l-32.33-64.66a32 32 0 0 1 16.96-44.11z" fill="#82AAFA" p-id="2602"></path><path d="M560 800a16 16 0 0 1-11.86-5.27l-130.29-144a16 16 0 0 1-1.15-20l60.47-84.63-84 59a16 16 0 0 1-21.17-2.47l-128-144a16 16 0 0 1 6.9-25.81l480-160a16 16 0 0 1 20.14 20.53l-176 496A16 16 0 0 1 560 800zM450.22 638.82l103.66 114.57L710 313.55l-425.88 142L386.48 570.7l149.08-104.79a16 16 0 0 1 22.22 22.39z" fill="#333333" p-id="2603"></path></svg>
                            <input type="submit" class="btn" value="提交修改">
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
                            <a href="${pageContext.request.contextPath}/user/delete?id=${user.getId()}">❌删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>

        </div>
    </div>

</div>

</div>

</body>

</html>
