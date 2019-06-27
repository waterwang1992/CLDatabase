# <center>CoreData 迁移</center>

不赘述了, 可自行查看

##轻量级秦阿姨

[轻量级迁移 Using Lightweight Migration](https://developer.apple.com/documentation/coredata/using_lightweight_migration?language=objc)

- 删除实体、属性 或者 关系。
- 使用 renamingIdentifier 重新命名实体、属性 或者关系。
- 新添加一个 Optional 的属性。
- 新添加一个 Required 属性，但是必须有默认值。
- 把一个 Optional 属性改成带有默认值的 Required 属性。
- 把一个 非Option 的属性改成 Optional属性。
- 改变实体结构。
- 新添加父实体，把属性向父类移动或者将父类属性往子类中移。
- 把 对一 关系改成 对多 关系。
- 改变关系，从 non-ordered to-many 到 ordered to-many。

Confirming Whether Core Data Can Infer the Model
If you want to determine in advance whether Core Data can infer the mapping model between the source and destination models without actually doing the work of migration, you can use ___NSMappingModel___'s ___inferredMappingModelForSourceModel:destinationModel:error:__ method. The method returns the inferred model if Core Data is able to create it; otherwise, it returns nil.

If your data change exceeds the capabilities of automatic migration, you can perform a heavyweight migration (often referred to as manual migration).

## 重量级迁移(手动迁移)

[重量级迁移 Heavyweight Migration](https://developer.apple.com/documentation/coredata/heavyweight_migration?language=objc)


[简书 CoreData迁移攻略](https://www.jianshu.com/p/b222227836cf)



