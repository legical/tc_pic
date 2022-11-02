$(document).ready(function(){
    $(".siderbar_menu li").click(function(){
        $(".siderbar_menu li").removeClass("active");
        $(this).addClass("active");
    })
    $(".hamburger").click(function(){
        $(".wrapper").addClass("active");
    })
    $(".bg_shadow,.close").click(function(){
        $(".wrapper").removeClass("active");
    })
})

/**
 *
 * @param int
 * @returns {String}
 */
function isGender(gender){
    // var male = "男";
    // var female = "男";
    if(gender == 1){
        return '男';
    }

    if(gender == 0){
        return '女';
    }
    return null;
}

/**
 * @param idCard
 */
function getBirth(idCard) {
    var birthday = "";
    if(idCard != null && idCard != ""){
        if(idCard.length == 15){
            birthday = "19"+idCard.slice(6,12);
        } else if(idCard.length == 18){
            birthday = idCard.slice(6,14);
        }
        birthday = birthday.replace(/(.{4})(.{2})/,"$1-$2-");
        //通过正则表达式来指定输出格式为:1990-01-01
    }
    return birthday;
}

/**
 * @param idCard
 */
function getSex(idCard) {
    var sexStr = '';
    if (parseInt(idCard.slice(-2, -1)) % 2 == 1) {
        sexStr = 'man';
    }
    else {
        sexStr = 'woman';
    }
    return sexStr;
}

function setBirSex() {
    var idCard = document.getElementById('idCard');
    if(idCard.length != 15 && idCard.length != 18){
        return "";
    }
    var formbirth = document.getElementById('birthday');
    var formsex = document.getElementById('sex');
    var sexStr = '';
    var birthday = "";
    if(idCard != null && idCard != ""){
        if(idCard.length == 15){
            birthday = "19"+idCard.slice(6,12);
        } else if(idCard.length == 18){
            birthday = idCard.slice(6,14);
        }
        birthday = birthday.replace(/(.{4})(.{2})/,"$1-$2-");
        //通过正则表达式来指定输出格式为:1990-01-01
    }
    formbirth.value = birthday;

    if (parseInt(idCard.slice(-2, -1)) % 2 == 1) {
        sexStr = '男';
    }
    else {
        sexStr = '女';
    }
    formsex.value = sexStr;
}