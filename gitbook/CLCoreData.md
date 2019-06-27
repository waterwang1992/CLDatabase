#<center>CLCoreData</center>

coreData 是管理应用程序中的模型层对象的框架。它为与 对象生命周期 和 object grap 以及 数据持久化管理 等相关的常见任务提供通用的自动化解决方案。

coreData 通常会减少开发者为支持模型层而编写的代码量的50％到70％。这主要是由于开发者不必实现，测试或优化以下内置功能：

- 更改除基本文本编辑之外的撤消和重置的跟踪和内置管理。

- 维护变更传播(propagation)，包括维护对象之间关系的一致性。

- 延迟 加载(lazy loading)对象，部分 materialized futures (faulting)以及 写时复制(copy-on-write)数据共享以减少开销。

- 自动验证属性值。托管对象扩展了标准键值编码验证方法，以确保各个值位于可接受的范围内，保证了值的组合是有意义的。

- 模式迁移工具，可简化模式更改并允许执行高效的就地模式迁移。

- 可选地与应用程序的控制器层集成以支持用户界面同步。

- 在内存和用户界面中对数据进行分组，过滤和组织。

- 自动支持在外部数据存储库中存储对象。

- 复杂的查询编译。可以通过将NSPredicate对象与fetch request相关联来创建复杂查询，而不是编写SQL。

- 版本跟踪和乐观锁定(optimistic locking)，以支持 automatic multiwriter conflict resolution。

- 与macOS和iOS工具链有效集成。

```
注意
CoreData框架不仅限于数据库样式的应用程序，也不 expectation 客户端 - 服务器行为。
该框架同样可用作矢量图形应用程序（如Sketch）或演示应用程序（如Keynote）的基础。
```



