<h2>一、下载镜像</h2>

推荐<a class="wp-editor-md-post-content-link" href="https://mirrors.ustc.edu.cn/" title="中科大镜像">中科大镜像</a>
 选择Ubuntu20.04的镜像文件放入U盘发行版下载

下载<a class="wp-editor-md-post-content-link" href="https://www.ventoy.net/cn/download.html" title="ventoy">ventoy</a>
 制作启动盘，将Ubuntu20.04的镜像文件放入U盘

<h2>二、安装</h2>

此处仅记录部分重要过程

<h3>1. 不联网</h3>

<h3>2. 最小安装，其他选项均选无</h3>

<h3>3. 分区（总空间只有40GB）</h3>

逻辑空间，空间起始位置
  - <strong>/root</strong> 根目录，整个系统的区域一般15G~更大，<strong>这里我给15G</strong>
  - <strong>/boot</strong> 启动目录，开机启动所需目录。一般几百m–2G，<strong>这里我给1G</strong>
  - <strong>/swap</strong> 交换空间，一般和内存一样大。给了和内存一样多的8G
  - <strong>/home</strong> 主目录，存放用户数据的目录。剩下空间全给它

<h3>4. 时区：上海</h3>

<h3>5. 设置用户名/密码</h3>

完事重启，看见界面提示就拔出U盘，按<strong>回车</strong>进入系统

<h2>三、基本设置</h2>

<h3>1. 联网</h3>

<h3>2. 更换软件更新源</h3>

找到“软件更新器”，下载自——其他站点——选择中科大源

<a class="wp-editor-md-post-content-link" href="https://i.loli.net/2021/08/24/LIzEqjNYZQJHlex.jpg"><img src="https://i.loli.net/2021/08/24/LIzEqjNYZQJHlex.jpg" alt="" /></a>

关闭，更新软件源

<pre><code class="language-shell line-numbers">apt-get update
</code></pre>

<h3>3. 打开语言支持（language support）</h3>

会显示语言支持没有完全安装，点击安装并输入密码开始安装

<h3>4. 设置root密码</h3>

<pre><code class="language-shell line-numbers">sudo passwd root
</code></pre>

提示输入sudo密码，ubuntu输入密码过程没有提示，输完按回车即可

<a class="wp-editor-md-post-content-link" href="https://i.loli.net/2021/08/24/dWhNREqTs3n9mJH.jpg"><img src="https://i.loli.net/2021/08/24/dWhNREqTs3n9mJH.jpg" alt="" /></a>

<h3>5. 安装中文输入法</h3>

这里选择的谷歌拼音输入法

<pre><code class="language-shell line-numbers">sudo apt-get install fcitx-googlepinyin -y
</code></pre>

安装完成后，再次进入语言支持界面，最下面一行键盘输入法系统（Keyboard input method system），默认是iBus，点击下拉单切换到fcitx（系统初始没有fctix，安装fcitx-googlepinyin的时候会装好fcitx）。然后重启电脑。
 <a class="wp-editor-md-post-content-link" href="https://i.loli.net/2021/08/24/y2jKVIMTN1O9rhF.jpg"><img src="https://i.loli.net/2021/08/24/y2jKVIMTN1O9rhF.jpg" alt="" /></a>

重启后进入系统，按ctrl+space即可切换成谷歌拼音输入法。

<h2>四、安装其他软件</h2>

<h3>1. 一些可以选装的软件如下</h3>

<pre><code class="language-shell line-numbers">sudo apt-get install fcitx-googlepinyin # 谷歌拼音输入法
sudo apt-get install git # git
sudo apt-get install stacer # 系统管理器
sudo apt-get install seafile-gui # 云盘
sudo apt-get install virtualbox # 虚拟机
sudo apt-get install okular # pdf阅读器
sudo apt-get install smplayer # 视频播放器
sudo apt-get install flameshot # 截图工具
sudo apt-get install pandoc # markdown转word
sudo apt-get install texmaker # latex编辑器
sudo apt-get install redshift # 屏幕色温调节
sudo apt-get install pdfgrep # pdf文件正则表达式检索
sudo apt-get install recoll poppler-utils # 文件内容检索工具
sudo apt-get install rdfind # 重复文件扫描
sudo snap install mathpix-snipping-tool # 图片转latex
</code></pre>

<h3>2. 个人用软件安装</h3>

<ul>
<li>vscode：直接在ubuntu软件商店搜索visual studio code下载即可</li>
<li>vim：<code>sudo apt-get install vim -y</code>，具体使用可参考<a class="wp-editor-md-post-content-link" href="https://blog.csdn.net/lixinghua666/article/details/82289809" title="这里">这里</a></li>
</ul>