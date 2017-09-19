# Shell脚本编程基础知识点
## 第一个示例
```
#!/bin/sh  # 指定脚本编辑器，‘#!’基本上是所有脚本编辑器通用的指明编辑器的位置的规定
# 只有单行注释
cd ~       # linux指令可以用，例如：cd, mkdir, touch, echo
mkdir shell_tut

for ((i=0; i<10; i++)); do  # 下面会讲到的循环体语法
    touch test_$i.txt
done
```

## macOS环境下的Shell脚本
```
@linux $ls -l /bin/*sh
-r-xr-xr-x  1 root  wheel   626272  4 29 08:31 /bin/bash
-rwxr-xr-x  1 root  wheel   375632  3 23 07:57 /bin/csh
-r-xr-xr-x  1 root  wheel  1377872  3 23 07:57 /bin/ksh
-r-xr-xr-x  1 root  wheel   630464  4 29 08:31 /bin/sh
-rwxr-xr-x  1 root  wheel   375632  3 23 07:57 /bin/tcsh
-rwxr-xr-x  1 root  wheel   592656  3 23 07:57 /bin/zsh
```

除了这些，还有高级脚本语言，例如：Perl, Tcl, Python, PHP, Ruby。

### 运行方式

* 作为可执行程序
```
chmod +x test.sh
./test.sh
```

* 作为解释器参数`sh test.sh`

## 变量&字符串
```
# 定义变量，不能有空格，同样的方式可以重复定义变量，数据类型有数字和字符串
your_name="mengying.liu"

# 拼接字符串的方式之一；单引号时，变量和转义字符无效，双引号就有效
greeting="Hello, "$your_name"!"
# 拼接字符串的方式之二；推荐这一种中的变量使用方式
greeting_2="Hello, ${your_name}!"

# 字符串之间没有空格，则输出就没有空格，有一个或多个空格，就只输出一个空格
# 第一个词后面出现空格代表第一个词是命令
echo $greeting    $greeting_2

# 输出字符串长度
echo ${#your_name}

# 截取子字符串，输出eng
echo ${#your_name:1:4}
```
输出结果
```
Hello, mengying.liu! Hello, mengying.liu!
```

## 流程控制
### 条件控制
#### if

* if
```
第一种
if [[1 == 1]]  # 比较符两边必须同时有空格或者没有空格
then
    echo 'Hello'
    echo "Hello"
fi  # 以倒写if结尾

第二种
if [[ 1 == 1 ]]; then echo "Hello"; echo "Hello"; fi
```

* if [elif] else
```
if condition1; then
    command1
elif condition2
    command2
else
    commandN
fi
```

### 循环控制
#### for
```
多行形式
for var in item1 item2 ... itemN
do
    command1
    command2
    ...
    commandN
done

或者
for (( i = 0; i < 10; i++ )); do
    #statements
done

写成一行
for var in item1 item2 ... itemN; do command1; command2… done;
```

#### while
```
while [[ condition ]]; do
    #statements
done
```

#### until
```
until [[ condition ]]; do
    #statements
done
```

#### case
```
语法
case word in
    pattern )
        ;;  # 表示break
esac

例子
case "${opt}" in
    "Install-Puppet-Server" )
        install_master $1
        exit
    ;;

    "Install-Puppet-Client" )
        install_client $1
        exit
    ;;

    "Config-Puppet-Server" )
        config_puppet_master
        exit
    ;;

    "Config-Puppet-Client" )
        config_puppet_client
        exit
    ;;

    "Exit" )
        exit
    ;;

    * ) echo "Bad option, please choose again"
esac
```
