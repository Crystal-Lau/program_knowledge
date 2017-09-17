# replace 警告解决方案
首先，先说结论，个人很不建议大家使用 replace=True，太容易出现 SettingWithCopyWarning的警告了。

## 分析

```
/data/home/wenxiu.sun/anaconda3/lib/python3.6/site-packages/pandas/core/frame.py:2746: SettingWithCopyWarning: 
A value is trying to be set on a copy of a slice from a DataFrame

See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy
  **kwargs)
```
通过定位警告，发现是如下代码出了问题
```
X_1.rename(columns={'CLOSEPRICE': x_code1}, inplace=True)
```
尝试将`inplace=True`删除后使用代码`X_1 = X_1.rename(columns={'CLOSEPRICE': x_code1})`替换，这一次没有发出警告。

这就引发了我的一个思考，既然官方是有这个属性的，为什么会发出这样的警告呢？带着这样的疑问，我查看了发出警告时，系统给出的[文档链接][doc]，官方文档上明确说明不支持chained indexing，那么什么是chained indexing呢？其实就是用`dfmi['one']['second']`这样的方式获取列数据。可为什么官方自己推出的获取方式自己都不支持了？他们发现了什么？

1. 性能问题，效率低：有层级的列名时，用`dfmi['one']['second']`的方式需要先获取`one`这一个大列，然后再获取其下的`second`，而用`df.loc[:,('one','second')]`的方式，可以一次将需要的子列定位并返回，效率自然高；
2. SettingWithCopyWarning：首先，pandas 基本不会对运行只需要几毫秒的事务报错。然后，在底层，`loc`的方式直接将新值付给 DataFrame，而chained indexing却是将结果赋给了DataFrame临时对象，而这个临时对象可能是视图或者副本。但有时候吧，没毛病的代码也会报这个错，这是他们的bug，咱们就忍了吧。你说这是不是坑了/(ㄒoㄒ)/~~ 。要是问我哪些情况会出现 SettingWithCopyWarning，我只能说看运行时的警告吧。不过，我回不断更新下一小节内容，争取总结一下自己遇到 SettingWithCopyWarning 的情况；
3. 上面的 inplace 就是在副本上设置了值，导致的这个问题；

## 出现这个警告的函数列表
1. `rename(inplace=True)`


[doc]: http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy