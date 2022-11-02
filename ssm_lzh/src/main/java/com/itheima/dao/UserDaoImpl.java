package com.itheima.dao;

import com.itheima.domain.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository("userDao")
public class UserDaoImpl implements UserDao{
    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Override
    public List<User> finall(String username) {
        if (username!=null){
            List<User> uList = jdbcTemplate.query("select * from user where userName like '%' ? '%'", new BeanPropertyRowMapper<User>(User.class),username);
            return uList;
        }else {
            List<User> userList = jdbcTemplate.query("select * from user", new BeanPropertyRowMapper<User>(User.class));
            return userList;
        }
    }

    @Override
    public int updateById(User user) {
        int u = jdbcTemplate.update("update user set userName=? , password=? , realName=? , gender=?, birthday=?, idCard=?, sex=? where id=?",
                user.getUsername(), user.getPassword(),user.getPassword(), user.getRealName(),user.getGender(),user.getBirthday(),user.getIdCard(),user.getSex(), user.getId());
        return u;
    }
    @Override
    public int deleteById(Integer id) {
        int i = jdbcTemplate.update("DELETE FROM USER WHERE id=?", id);
        return i;
    }

    @Override
    public int insertMethod(User user) {
        int ins = jdbcTemplate.update("insert into USER(id,username,password,realName,gender,birthday,idCard,sex) values (?,?,?,?,?,?,?,?)",
                user.getId(),user.getUsername(),user.getPassword(), user.getRealName(),user.getGender(),user.getBirthday(),user.getIdCard(),user.getSex());
        return ins;
    }

    @Override
    public User getUserById(int id) {
        List<User> List = jdbcTemplate.query("select * from user WHERE id=?", new BeanPropertyRowMapper<User>(User.class),id);
        User user =List.get(0);
        return user;
    }

    @Override
    public List<User> getUserByUser(String username) {
        List<User> query = jdbcTemplate.query("select * from user WHERE userName=?", new BeanPropertyRowMapper<User>(User.class), username);
        return  query;
    }

    @Override
    public boolean save(User user){
        int ins = jdbcTemplate.update("insert into USER(id,username,password,realName,gender,birthday,idCard,sex) values (?,?,?,?,?,?,?,?)",
                user.getId(),user.getUsername(),user.getPassword(), user.getRealName(),user.getGender(),user.getBirthday(),user.getIdCard(),user.getSex());
        return ins>=0?true:false;
    }

    @Override
    public boolean update(User user){
        int u = jdbcTemplate.update("update user set userName=? , password=? , realName=? , gender=?, birthday=?, idCard=?, sex=?  where id=?",
                user.getUsername(), user.getPassword(), user.getRealName(),user.getGender(),user.getBirthday(),user.getIdCard(),user.getSex(),user.getId());
        return u>=0?true:false;
    }

    @Override
    public boolean delete(Integer id){
        int i = jdbcTemplate.update("DELETE FROM USER WHERE id=?", id);
        return i>=0?true:false;
    }

    public User get(Integer id){
        List<User> List = jdbcTemplate.query("select * from user WHERE id=?", new BeanPropertyRowMapper<User>(User.class),id);
        User user =List.get(0);
        return user;
    }

    @Override
    public List<User> getAll(){
        List<User> userList = jdbcTemplate.query("select * from user", new BeanPropertyRowMapper<User>(User.class));
        return userList;
    }

    /**
     * 根据用户名密码查询个人信息
     * @param userName 用户名
     * @param password 密码信息
     * @return
     */
    //注意：数据层操作不要和业务层操作的名称混淆，通常数据层仅反映与数据库间的信息交换，不体现业务逻辑
    public User getByUserNameAndPassword(@Param("userName") String userName, @Param("password") String password){
        List<User> List = jdbcTemplate.query("select * from user WHERE userName=? and password=?", new BeanPropertyRowMapper<User>(User.class),userName,password);
        User user =List.get(0);
        return user;
    }



}
