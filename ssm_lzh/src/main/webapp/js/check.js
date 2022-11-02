/**
 * 检验登录表单
 *
 * @returns {Boolean}
 */
function checkLoginForm() {
    // 获取用户名文本框
    var username = document.getElementById("userName");
    // 获取密码文本框
    var password = document.getElementById("password");
    // 非空校验
    if (username.value == "") {
        alert("用户名不能为空！");
        // 让用户名文本框获得焦点
        username.focus();
        return false;
    }
    if (password.value == "") {
        alert("密码不能为空！");
        // 让密码文本框获得焦点
        password.focus();
        return false;
    }

    return true; // 表明可以提交数据到服务器端
}

/**
 * 检验注册表单
 *
 * @returns {Boolean}
 */
function checkRegForm() {
    // 获取用户名文本框
    var username = document.getElementById("userName");
    // 获取密码文本框
    var password = document.getElementById("password");
    // 获取确认密码文本框
    var repassword = document.getElementById("repassword");
    // 非空校验
    if (username.value == "") {
        alert("用户名不能为空！");
        // 让用户名文本框获得焦点
        username.focus();
        return false;
    }
    if (password.value == "") {
        alert("密码不能为空！");
        // 让密码文本框获得焦点
        password.focus();
        return false;
    }
    if (repassword.value == "") {
        alert("确认密码不能为空！");
        // 让密码文本框获得焦点
        repassword.focus();
        return false;
    }

    if ((password === repassword) == false) {
        alert("输入密码不一致！");
        // 让密码文本框获得焦点
        repassword.focus();
        return false;
    }

    return true; // 表明可以提交数据到服务器端
}