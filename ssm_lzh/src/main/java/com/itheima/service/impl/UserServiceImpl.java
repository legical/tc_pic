package com.itheima.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itheima.dao.UserDao;
import com.itheima.domain.User;
import com.itheima.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED)
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Transactional(readOnly = true,isolation = Isolation.REPEATABLE_READ)
    public List<User> findAllUser(String username) {
        return userDao.finall(username);
    }

    @Override
    public int updateById(User user) {
        return userDao.updateById(user);
    }

    @Override
    public int deleteById(Integer id) {
        return userDao.deleteById(id);
    }

    @Override
    public int insertMethod(User user) {
        return userDao.insertMethod(user);
    }

    @Override
    public User getUserById(int id) {
        return userDao.getUserById(id);
    }

    @Override
    public List<User> getUserByUser(String username) {
        return  userDao.getUserByUser(username);
    }

    @Override
    public boolean save(User user) {
        return userDao.save(user);
    }

    @Override
    public boolean update(User user) {
        return userDao.update(user);
    }

    @Override
    public boolean delete(Integer id) {
        return userDao.delete(id);
    }

    @Override
    public User get(Integer id) {
        return userDao.get(id);
    }

    @Override
    public PageInfo<User> getAll(int page, int size) {
        PageHelper.startPage(page, size);
        List<User> all = userDao.getAll();
        return new PageInfo<User>(all);
    }

    @Override
    public User login(String userName, String password) {
        return userDao.getByUserNameAndPassword(userName, password);
    }
}
