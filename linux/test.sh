#!/bin/bash
#
your_name="mengying.liu"
echo ${#your_name}
echo ${your_name:1:4}  
printf "1. The complete list is %s\n" "$$"  # Shell本身的PID（ProcessID）
printf "2. The complete list is %s\n" "$!"  # Shell最后运行的后台Process的PID
printf "3. The complete list is %s\n" "$?"  # 最后运行的命令的结束代码（返回值）
printf "4. The complete list is %s\n" "$*"  # 所有参数列表。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
printf "5. The complete list is %s\n" "$@"  # 所有参数列表。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
printf "6. The complete list is %s\n" "$#"  # 添加到Shell的参数个数
printf "7. The complete list is %s\n" "$0"  # Shell本身的文件名
printf "8. The complete list is %s\n" "$1"  # 添加到Shell的各参数值。$1是第1参数、$2是第2参数…。
printf "9. The complete list is %s\n" "$2"

# 运行结果
# @linux $sh test.sh a b
# 1. The complete list is 28331
# 2. The complete list is 
# 3. The complete list is 0
# 4. The complete list is a b
# 5. The complete list is a
# 5. The complete list is b
# 6. The complete list is 2
# 7. The complete list is test.sh
# 8. The complete list is a
# 9. The complete list is b