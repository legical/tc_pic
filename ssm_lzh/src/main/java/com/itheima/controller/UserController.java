package com.itheima.controller;

import com.github.pagehelper.PageInfo;
import com.itheima.controller.results.Code;
import com.itheima.controller.results.Result;
import com.itheima.domain.User;
import com.itheima.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import com.itheima.system.exception.BusinessException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping
    public Result save(User user){
        boolean flag = userService.save(user);
        return new Result(flag ? Code.SAVE_OK:Code.SAVE_ERROR);
    }

    @PutMapping
    public Result update(User user){
        boolean flag = userService.update(user);
        return new Result(flag ? Code.UPDATE_OK:Code.UPDATE_ERROR);
    }

    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        boolean flag = userService.delete(id);
        return new Result(flag ? Code.DELETE_OK:Code.DELETE_ERROR);
    }

    @GetMapping("/{id}")
    public Result get(@PathVariable Integer id){
        User user = userService.get(id);
        //模拟出现异常，使用条件控制，便于测试结果
        if (id == 10 ) throw new BusinessException("查询出错啦，请重试！",Code.GET_ERROR);
        return new Result(null != user ?Code.GET_OK: Code.GET_ERROR,user);
    }

    @GetMapping("/{page}/{size}")
    public Result getAll(@PathVariable Integer page, @PathVariable Integer size){
        PageInfo<User> all = userService.getAll(page, size);
        return new Result(null != all ?Code.GET_OK: Code.GET_ERROR,all);
    }

    @PostMapping("/oldlogin")
    public Result login(String userName,String password){
        User user = userService.login(userName,password);
        return new Result(null != user ?Code.GET_OK: Code.GET_ERROR,user);
    }

    /**
     * 用户登录
     * 1.如果用户名、密码有一个是空的，就不提交
     * 2.如果用户名为root或者admin，就是管理员登录，登录成功进入后台管理界面
     * 3.如果是普通用户登录，登录成功后展示个人信息
     * 4.用户名或密码错误登陆失败，进入登陆失败界面
     * @param userName
     * @param password
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/login")
    public String test(String userName, String password, Model model, HttpServletRequest request) {
        if(userName == "" || password == ""){
            model.addAttribute("loginerror", "登录失败，输入信息不允许为空！");
            return "error";
        }
        //判断是否为管理员登陆
        boolean adminflag = false;
        if(userName.equals("root") || userName.equals("admin")){
            adminflag = true;
        }

        List<User> users = userService.getUserByUser(userName);
        for (User u : users) {
            System.out.println("login info: " + "userName:"+ userName + "\tpassword:" + password);
            if (u.getUsername().equals(userName) && u.getPassword().equals(password)) {
                model.addAttribute("msg", userName);
                model.addAttribute("act", "登陆成功≧ ≦");
                request.getSession().setAttribute("user",u);
                //管理员进入后台管理
                if(adminflag){
                    request.getSession().setAttribute("identity", "身份：管理员");
                }else{
                    request.getSession().setAttribute("identity", "身份：普通用户");
                }
                return "success";
            } else {
                model.addAttribute("loginerror", "登录失败，请检查用户名或密码是否错误！");
                return "error";
            }
        }
        model.addAttribute("loginerror", "登录失败，找不到此用户！");
        return "error";
    }

    /**
     * 用户注册
     * 1.不得注册为管理员 username不得为root或admin
     * 2.三个注册信息，有一个为空就不提交
     * 3.注册成功直接进入个人信息界面
     * 4.如数据库已有注册信息，则注册失败，进入注册失败界面
     * @param userName
     * @param password
     * @param repassword
     * @param model
     * @param request
     * @return
     */
    @RequestMapping("/register")
    public String registerMethod(String userName, String password, String repassword, Model model, HttpServletRequest request) throws ParseException {

        if(password == "" || userName == "" || repassword == ""){
            model.addAttribute("registererror", "注册失败，注册信息不允许为空！");
            return "regiserror";
        }

        if(userName.equals("root") || userName.equals("admin")){
            model.addAttribute("registererror", "注册失败，不允许注册为管理员！");
            return "regiserror";
        }

        List<User> users = userService.getUserByUser(userName);
        if(!users.isEmpty()){
            model.addAttribute("registererror", "注册失败，已存在该用户！");
            return "regiserror";
        }

        if(password.equals(repassword)){
            System.out.println("register info: " + "userName:"+ userName + "\tpassword:" + password);
            User u = new User(userName,password);
            if(u != null){
                int insert = userService.insertMethod(u);
                model.addAttribute("loginerror", "注册成功≧ ≦，请用用户名密码登陆！");
                System.out.println(u.toString());
                return "error";
            } else {
                model.addAttribute("registererror", "创建用户失败，请重新尝试注册！");
                return "regiserror";
            }
        }
        model.addAttribute("registererror", "注册失败，两次输入的密码不一致！");
        return "regiserror";
    }

    /**
     * 注销登陆
     * 返回主界面
     * @param request
     * @return
     */
    @RequestMapping("/loginOut")
    public String loginOutMethod(HttpServletRequest request,Model model){
        //删除当前登录的user对象
        System.out.println("Login out...");
        request.getSession().removeAttribute("user");
        request.getSession().removeAttribute("identity");
        request.getSession().invalidate();
        return "redirect:../index.jsp";//../:返回上一级
    }

    @RequestMapping("/all")
    public String findAll(String username,Model model){
        List<User> allUser = userService.findAllUser(username);
        model.addAttribute("list", allUser);
        return "adminbackend";
    }

    @RequestMapping("/tobackend")
    public String tobackend(int id){
//        if(userName.equals("root") || userName.equals("admin"))
        if (id == 1 || id ==11){
            return "redirect:/user/all";
        }

        return "backend";
    }

    @RequestMapping("/delete")
    public String deleteById(int id) {
        int i = userService.deleteById(id);
        return "redirect:/user/all";
    }

    @RequestMapping("/insert")
    public  String insertUser(){
        return "addUser";
    }

    @RequestMapping(value = "/addUser" ,method = RequestMethod.POST)
    public String addInsert(User user){
        System.out.println(user.toString());
        int insert = userService.insertMethod(user);
        return "redirect:/user/all";
    }

    @RequestMapping("/update")
    public String returnUpdatePage(int id,Model model){
        User user = userService.getUserById(id);
        model.addAttribute("user",user);
        return "updataUser";
    }

    @RequestMapping("/updateSave")
    public String updateByIdMethod(User user){
        int iii=  userService.updateById(user);
        return "redirect:/user/all";
    }

    @RequestMapping("/modify")
    public String modifyMethod(int id, int inden,
                               String userName, String password, String realName, String idCard,
                               Model model, HttpServletRequest request){
        User u = userService.getUserById(id);

        //判断是否修改用户名、密码
        boolean yespasswd = true;
        if(userName.equals(null) && password.equals(null) || userName=="" && password==""){
            yespasswd = false;
        }

        if(userName != ""){
            u.setUserName(userName);
            model.addAttribute("msg", userName);
        }

        if(password != ""){
            u.setPassword(password);
        }

        if(realName != ""){
            u.setRealName(realName);
        }

        if(idCard != ""){
            u.setIdCard2(idCard);
        }

        //更新user
//        int imodify=  userService.updateById(u);
        int i = userService.deleteById(id);
        int insert = userService.insertMethod(u);
        request.getSession().removeAttribute("user");
        request.getSession().setAttribute("user",u);
        model.addAttribute("user",u);
        if(yespasswd && inden == 0 || yespasswd && inden == 1 && (id == 1 || id == 11) ){
            request.getSession().removeAttribute("user");
            request.getSession().removeAttribute("identity");
            request.getSession().invalidate();
            model.addAttribute("loginerror", "已更改登录密码，请重新登陆！");
            return "error";
        }

        if(inden == 1){
            return "redirect:/user/all";
        }
        //不是管理员，就进入普通登陆成功界面
        return "backend";
    }

}
