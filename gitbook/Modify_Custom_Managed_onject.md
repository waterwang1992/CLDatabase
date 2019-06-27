# <center>修改自定义的ManagedObject</center>

## 创建自定义托管对象子类(NSManagedObject)
- 在Objective-C托管对象子类中，您可以在接口文件中声明建模属性的属性，但不要声明实例变量
- Core Data动态生成get和set属性访问器方法和relationship访问器方法。因此，通常不需要为建模属性编写自定义访问器方法。

```
请注意，属性声明为nonatomic和strong。出于性能原因，即使值类采用NSCopying 协议，
Core Data通常也不会复制对象值。
```

## Overriding Methods

NSManagedObject本身定制了许多功能,以便可以将托管对象正确地集成到Core Data基础结构中。

Core Data依赖于NSManagedObject以下方法的实现，因此决不能覆盖的方法：

- primitiveValueForKey:

- setPrimitiveValue:forKey:

- isEqual:

- hash

- superclass

- class

- self

- zone

- isProxy

- isKindOfClass:

- isMemberOfClass:

- conformsToProtocol:

- respondsToSelector:

- managedObjectContext

- entity

- objectID

- isInserted

- isUpdated

- isDeleted

- isFault

不建议重写的方法:

- nitWithEntity:insertIntoManagedObjectContext:
- escription
- key-value code method: 如 valueForKey: 和  setValue:forKeyPath:

需要调用super:

- awakeFromInsert
- awakeFromFetch
- validate 方法, 如 validateForUpdate:

总而言之, 重写访问器方法时要小心，因为这可能会对性能产生负面影响。

## 使用非标准属性

创建 一个新的 NSManagedObject 子类 来实现

## 日期时间的存储
NSDate, 基于GMT.   如果需要存储 Time Zone, 需要在模型中自行存储

## 自定义 Initialization 和 Deallocation

系统的方法已经做的很完善了,  一般情况下不需要重写, 如果非要重写 , 那么有三个方法:

- initWithEntity:insertIntoManagedObjectContext: (不推荐, as state changes made in this method may not be properly integrated with undo and redo)
- awakeFromInsert (对象被创建的时候调用, 且只会调用一次)
- awakeFromFetch (reinitialized from a persistent store)
- 不要重写 Dealloc, 用 didTurnIntoFault, (当对象被 turn into fault 时调用, 时间上先于真正的dealloc 调用)





