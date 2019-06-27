# <center>生命周期的管理</center>


[简书的部分文档翻译](https://www.jianshu.com/p/b5e7d7202ba9)

比较复杂, 这里简述一下, 有兴趣可以私下结合官方文档琢磨一下

## 关于 Faulting

一个managed object通常会用于表示被持久化存储的数据，但是在有些情况下，一个managed object可能是fault的，也就是说它的property还没有从外部数据存储中载入进来。这是Core Data用于减少内存占用的一种机制。

当访问到一个managed object的某个持久化的property的时候，fault被触发了，如果没有被cache的话，数据会被自动从持久化存储中取过来，这里的开销是比较昂贵的。
需要注意的是，description方法是不会触发fault的.

可以使用refreshObject:mergeChanges:并传人参数NO让一个managed object变成fault。但是必须保证其中的relationship没有被改变。

