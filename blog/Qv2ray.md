# 1、获取软件
## 1.1 获取渠道
- 渠道1：[蓝奏云](https://hzyy.lanzoux.com/iUSv5089y0ah)
点击普通下载，下载程序。假设程序下载完成目录为：` /home/bric/Downloads`
在该目录中打开终端，执行
```
mv /home/bric/Downloads/Qv2ray-v2.7.0-linux-x64.AppImage /usr/local/bin/Qv2ray-v2.7.0-linux-x64.AppImage
```
- 渠道2：Github（推荐）
```
cd /usr/local/bin
wget https://ghproxy.com/https://github.com/Qv2ray/Qv2ray/releases/download/v2.7.0/Qv2ray-v2.7.0-linux-x64.AppImage
```
## 1.2 设置快捷键

打开ubuntu系统设置——键盘快捷键，拉到最下面自定义，点击+号
![image](https://img2022.cnblogs.com/blog/2937389/202208/2937389-20220802181130581-1384398096.png)

- 名字随便填，如VPN
- 命令填`/usr/local/bin/Qv2ray-v2.7.0-linux-x64.AppImage`
- 快捷键同时按下alt+v

最终设置如图：
![image](https://img2022.cnblogs.com/blog/2937389/202208/2937389-20220802181133304-1117655194.png)

# 2、配置核心
## 2.1 获取核心文件
[github发布页](https://github.com/v2fly/v2ray-core/releases)
- 渠道1：[蓝奏云](https://hzyy.lanzoux.com/ixAdE089zpqj)
普通下载后，解压。假设解压后文件夹所在目录为：`/home/bric/Downloads`
在该目录中打开终端，执行
```
mv /home/bric/Downloads/v2ray-linux-64 /usr/local/bin/
```
- 渠道2：Github在线下载
```
cd /usr/local/bin
wget https://ghproxy.com/https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
mkdir v2ray-linux-64 && unzip v2ray-linux-64.zip -d ./v2ray-linux-64
```
## 2.2 配置v2ray核心目录
按下快捷键alt+v，打开程序首选项，两个路径分别设置为：
```
/usr/local/bin/v2ray-linux-64/v2ray
/usr/local/bin/v2ray-linux-64
```
点击检查核心设置，查看是否验证通过。通过后就可以在首页添加链接
![image](https://img2022.cnblogs.com/blog/2937389/202208/2937389-20220802181148979-121158998.png)
