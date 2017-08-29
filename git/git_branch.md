# Git 分支
## 操作方面
```
@program_knowledge $git branch
* master
@program_knowledge $git branch data_analysis
@program_knowledge $git branch
  data_analysis
* master
@program_knowledge $git checkout data_analysis
Switched to branch 'data_analysis'
@program_knowledge $git branch
* data_analysis
  master
```
由上一段代码我们有以下4点需要注意：

1. 在上一段代码中，所有以`* `开头的都表示当前分支；
2. `git branch`用于显示当前repository 中的所有分支；
3. `git branch data_analysis`表示我要创建一个名叫`data_analysis`的分支，要注意这一条指令和上一条的区别；
4. `git checkout data_analysis`表示我要切换到`data_analysis`分支上；

注意在本地新创建的分支提交时的变化
```
@program_knowledge $git push origin data_analysis
Total 0 (delta 0), reused 0 (delta 0)
To https://github.com/Crystal-Lau/program_knowledge.git
 * [new branch]      data_analysis -> data_analysis
```
在上面这段代码中，最后一行说明了我们本地建立的 data_analysis是一个远程repository 没有的全新的分支，推送成功之后，将在远程 repository 建立一个一模一样名称的分支，同时，本地的修改也会上传到这个分支中