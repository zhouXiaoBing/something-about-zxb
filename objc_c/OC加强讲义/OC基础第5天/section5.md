##11、【理解】copy概念及入门
#### 1、【理解】copy的概念
 * Copy的字面意思是“复制”、“拷贝”，是一个产生副本的过程。
 * __常见的复制有：文件复制__


 * 作用：利用一个源文件产生一个副本文件
 * 特点：
   * 修改源文件的内容，不会影响副本文件
   * 修改副本文件的内容，不会影响源文件


* __ OC中的copy__
 * 作用：利用一个源对象产生一个副本对象
 * 特点：
   * 修改源对象的属性和行为，不会影响副本对象
   * 修改副本对象的属性和行为，不会影响源对象

#### 2、【理解】copy快速入门
 * 如何使用copy功能
   * 一个对象可以调用copy或mutableCopy方法来创建一个副本对象
  * copy : 创建的是不可变副本(如NSString、NSArray、NSDictionary)
  * mutableCopy :创建的是可变副本(如NSMutableString、NSMutableArray、NSMutableDictionary)

* 使用copy功能的前提
 * copy : 需要遵守NSCopying协议，实现copyWithZone:方法

 ```objc
 @protocol NSCopying
 - (id)copyWithZone:(NSZone *)zone;
@end
```
 * mutableCopy :需要遵守NSMutableCopying协议，实现mutableCopyWithZone:方法

 ```objc
 @protocol NSMutableCopying
 - (id)mutableCopyWithZone:(NSZone *)zone;
 @end
 ```


