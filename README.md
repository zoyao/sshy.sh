# sshy.sh
一个简单的ssh登录脚本，mac及ubuntu上没有方便的ssh工具，故写了这个脚本，结合terminal可通过配置的方式直接登录服务器

# 用法
```cmd <user@host> <password> [-p <port>] [-d <dir>] [-i]```

参数说明：
> ```<user@host> 用户名@服务器IP```
> 
> ```<password>  服务器密码```
> 
> ```[-p <port>] 服务器端口号（可选，默认22）```
> 
> ```[-d <dir>]  登陆后跳转到指定目录（可选）```
> 
> ```[-i]  登陆后sudo -i切换到root用户```
