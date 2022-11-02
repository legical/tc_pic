<%--
  Created by IntelliJ IDEA.
  User: BricR
  Date: 2022/7/19
  Time: 22:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录成功！</title>
    <link rel="stylesheet" href="../css/newindex.css">
</head>
<body>
<div class="login">
    <h1>${act}</h1><br>
    <form action="${pageContext.request.contextPath}/user/tobackend">
        <h2 style="color:cadetblue">${user.getRealName()}</h2>
        <input type="number" style="display:none" name="id" value="${user.id}"/><br>
        <h2 style="color:cadetblue">${user.getUserName()}</h2><br>
        <h3 style="color:cadetblue">${identity}</h3><br>
        <button type="submit">查看个人信息</button>
    </form>
</div>

<script>
    //获取 login
    let login = document.querySelector('.login')

    let span
    let inTime, outTime
    let isIn = true //默认开关 打开
    let isOut

    //鼠标进入事件
    login.addEventListener('mouseenter', function(e)
    {
        isOut = false //预先关闭，若不进入if语句，则不能进入鼠标离开事件里的 if
        if(isIn)
        {
            inTime = new Date().getTime()

            //生成 span 元素并添加进 login 的末尾
            span = document.createElement('span')
            login.appendChild(span)

            //span 去使用 in动画
            span.style.animation = 'in .5s ease-out forwards'

            //计算 top 和 left 值，跟踪鼠标位置
            let top = e.clientY - e.target.offsetTop
            let left = e.clientX - e.target.offsetLeft

            span.style.top = top + 'px'
            span.style.left = left + 'px'

            isIn = false //当我们执行完程序后，关闭
            isOut = true //当我们执行完里面的程序，再打开
        }

    })
    //鼠标离开事件
    login.addEventListener('mouseleave', function(e)
    {
        if(isOut)
        {
            outTime = new Date().getTime()
            let passTime = outTime - inTime

            if(passTime < 500)
            {
                setTimeout(mouseleave, 500 - passTime) //已经经过的时间就不要了
            }
            else
            {
                mouseleave()
            }
        }

        function mouseleave()
        {
            span.style.animation = 'out .5s ease-out forwards'

            //计算 top 和 left 值，跟踪鼠标位置
            let top = e.clientY - e.target.offsetTop
            let left = e.clientX - e.target.offsetLeft

            span.style.top = top + 'px'
            span.style.left = left + 'px'

            //注意：因为要等到动画结束，所以要给个定时器
            setTimeout(function()
            {
                login.removeChild(span)
                isIn = true //当我们执行完鼠标离开事件里的程序，才再次打开
            }, 500)
        }
    })
</script>
</body>
</html>