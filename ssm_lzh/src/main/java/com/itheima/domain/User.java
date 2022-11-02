package com.itheima.domain;

import java.io.Serializable;
import java.text.ParseException;
import java.util.Date;
import java.text.SimpleDateFormat;

public class User implements Serializable {
    private int id;
    private String userName;
    private String password;
    private String realName;
    private int gender;
    private Date birthday;
    private String idCard;
    private String sex;

    public User() {
    }

    public User(String username, String password) throws ParseException {
        this.userName = username;
        this.password = password;
        this.realName = username;
        Date now = new Date(); // 创建一个Date对象，获取当前时间
        // 指定格式化格式
        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.birthday = f.parse(f.format(now));
        setSexGender("女");
        this.idCard = "123456190011112222";
    }

    //uuid
    public int getUuid() {
        return id;
    }
    public void setUuid(int uuid) {
        this.id = uuid;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    //userName
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUsername() {
        return userName;
    }

    public void setUsername(String username) {
        this.userName = username;
    }

    //password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    //realName
    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    //Gender
    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    //Birthday
    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public void setSBirthday(String birthday)  {
        try {
            SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
            Date d = f.parse(birthday);
            this.birthday = d;
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    //idcard
    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }
    public int setIdCard2(String idCard) {
        if(idCard.trim().length() != 15 && idCard.trim().length() != 18){
            return 0;
        }
        this.idCard = idCard;

        String birth = null;
        StringBuffer tempStr=null;
        String sexCode = null;

        if(idCard != null && idCard.trim().length() > 0){
            if(idCard.trim().length()==15){
                //2000年以前出生的
                tempStr=new StringBuffer(idCard.substring(6, 12));
                tempStr.insert(4, '-');
                tempStr.insert(2, '-');
                tempStr.insert(0, "19");
                sexCode = Integer.parseInt(idCard.substring(idCard.length() - 3, idCard.length())) % 2 == 0 ? "女" : "男";
            }else if(idCard.trim().length()==18){
                tempStr=new StringBuffer(idCard.substring(6, 14));
                tempStr.insert(6, '-');
                tempStr.insert(4, '-');
                sexCode = Integer.parseInt(idCard.substring(idCard.length() - 4, idCard.length() - 1)) % 2 == 0 ? "女" : "男";
            }
        }
        if(tempStr!=null&&tempStr.toString().trim().length()>0){
            birth = tempStr.toString();
        }
        setSBirthday(birth);
        setSexGender(sexCode);

        return idCard.length();
    }

    //sex
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
        if(sex.equals("男")){
            this.gender = 1;
        } else if (sex.equals("女")) {
            this.gender = 0;
        }
    }

    public void setSexGender(String sex) {
        if(sex.equals("男")){
            this.sex = "男";
            this.gender = 1;
        } else if (sex.equals("女")) {
            this.sex = "女";
            this.gender = 0;
        }
    }

    @Override
    public String toString() {
        return "User{" +
                "uuid=" + id +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", realName='" + realName + '\'' +
                ", gender=" + gender +
                ", birthday=" + birthday +
                '}';
    }

}
