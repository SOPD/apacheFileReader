# apacheFileReader(1.0)
## 浏览指定服务器中的资源文件 
## 快捷方便的传递本机照片(注 也许您需要配合fileEnumrator使用https://github.com/SOPD/fileEnumator  )

##已完成 
####基本功能实现 图片 视频 文件 的访问和打开 

##待完善 
* 当使用热点时屏幕下移导致部分动画不能完美对应问题
##待实现 
* 文件搜索
* 清除磁盘缓存以重新加载
* 占位图片
* 网络提示
* 内建视频播放器
* 下载管理
* 社交软件分享
* 多数据源服务器管理
* 完善注释
* 代码优化
##待选(感觉并没有太大用以后有空了在做)
* 使用rsa对地址进行加密
* 本地相册

#使用方法 
### 构建本机apache服务器 并在根目录创建Preview 文件夹 
#MAC系统下如何搭建apache服务器
###1在你的用户根目录下创建一个文件夹作为服务器的根目录例如"/Users/mac/webDoc"
###2前往/etc/apahce2文件夹 修改此文件夹的权限为可读写
###3备份httpd.conf文件后使用文本编辑器打开做如下修改:
####`DocumentRoot "/User/用户名/webDoc"`
####`<Directory "/User/用户名/webDoc">`
####添加
####`Indexes`
####`Options Indexes FollowSymLinks Multiviews`
####`MultiviewsMatch Any`
####去掉下面一句话的#号
####`#LoadModule php5_module libexec/apache2/libphp5.so`

###在终端中使用 sudo apachectl -k start开启服务器 
#####PS .如果实在不会配  就百度或者GOOGLE一下

                                                     
#### 建议 在服务器根目录下创建一个单独的文件夹存储资源
# 使用fileEnumator获取文件列表
###移步我的另一个项目获取fileEnumator的使用说明
###保存列表文件的路径请使用 apache根目录\files.json

![picutre1](http://cl.ly/373u3B120B1t)

## 重要提示  
### 获取服务器地址 如手机与服务器在同一局域网内建议使用服务器的DHCP地址

##可重用代码资源 
* 类似系统自带相册的图片浏览器 
# 预览图片
![picture2](http://ww3.sinaimg.cn/mw690/be3cd04ajw1f437xlzzb1j20ku112gml.jpg)
![picture3](http://ww3.sinaimg.cn/mw690/be3cd04ajw1f437yk0pnuj20ku1127jx.jpg)
![picture3](http://ww1.sinaimg.cn/mw690/be3cd04ajw1f437y7qb1wj20ku1127a0.jpg)



