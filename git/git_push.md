# Git Push指令
本文件主讲和`git push`指令相关的`git`知识。

## 指令分析
本小节简述`git bush [remote-name] [branch-name]`指令。
1. 如果你是通过`git clone`指令得到线上库的副本，该命令会自动添加`clone`后面跟随的地址为`remote-name`；
2. `branch-name`是你目前有提交信息的那个分支。最初就是在本地新建的分支，而后上传的朋友，不必关注在远程仓库中是否有这个分支，它会自动绑定好的，本地分支和线上分支同一个名字。
3. 将远程仓库分支对应绑定的分支关闭了的要小心，远程关闭之后，本地分支仍然存在，且绑定的远程分支不会改变，具体怎么解决这个问题，稍后再描述；


## 遇到的问题
要求本小结收藏的问题都是在实际应用过程中可以复现的问题。编辑规则是，首先以代码方式贴出错误的信息（允许但不建议用图片），然后在下面分析出错原因。
```
@program_knowledge $git push origin data_analysis
Username for 'https://github.com': Crystal-Lau
Password for 'https://Crystal-Lau@github.com': 
Counting objects: 17, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (13/13), done.
Writing objects: 100% (17/17), 3.30 KiB | 0 bytes/s, done.
Total 17 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1), done.
To https://github.com/Crystal-Lau/program_knowledge.git
   b1173f5..5c953b9  data_analysis -> data_analysis
```
在遇到这个问题时，我在网上查了一下。首先，根据文章[git 每次更新代码都提示输入密码][https://segmentfault.com/q/1010000005857277]所说，出现这种问题是最初使用`git clone`时用了 http的地址，应该改为 ssh的。而后搜到文章[git查看远程的地址][git_remote]中，提示使用`git remote -v`来查看远程克隆地址，检查了一下自己的地址，得到如下：
```
@program_knowledge $git remote -v
origin  https://github.com/Crystal-Lau/program_knowledge.git (fetch)
origin  https://github.com/Crystal-Lau/program_knowledge.git (push)
```
修改指令为`git remote set-url origin git@github.com:Crystal-Lau/program_knowledge.git`，该命令修改成功没有任何提示信息
再次检查远程克隆地址
```
@program_knowledge $git remote -v
origin  git@github.com:Crystal-Lau/program_knowledge.git (fetch)
origin  git@github.com:Crystal-Lau/program_knowledge.git (push)
```


[git_remote]: http://weitao1026.iteye.com/blog/2328063