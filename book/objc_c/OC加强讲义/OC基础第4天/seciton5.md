##15、【理解】NSMutableArray及基本使用
* 1、【理解】NSMutableArray 介绍
 * NSMutableArray是NSArray的子类。NSArray是不可变的,一旦初始化完毕后, 它里面的内容就永远是固定的,不能删除里面的元素,也不能再往里面添加元素。
 * NSMutableArray是可变的, 随时可以往里面添加\更改\删除元素

* 2、NSMutableArray添加元素
 * 添加一个元素
        - (void)addObject:(id)object;
 * 添加otherArray的全部元素到当前数组中
        - (void)addObjectsFromArray:(NSArray *)array;
 * 在index位置插入一个元素
        - (void)insertObject:(id)anObject atIndex:(NSUInteger)index;

* 3、NSMutableArray删除元素
 * 删除最后一个元素
        - (void)removeLastObject;
 * 删除所有的元素
        - (void)removeAllObjects;
 * 删除index位置的元素
        - (void)removeObjectAtIndex:(NSUInteger)index;
 * 删除特定的元素
        - (void)removeObject:(id)object;
 * 删除range范围内的所有元素
        - (void)removeObjectsInRange:(NSRange)range;
* 4、NSMutableArray替换元素
 * 用anObject替换index位置对应的元素
        - (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
 * 交换idx1和idx2位置的元素
        - (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
* 5、NSMutableArray简写
 * 设置元素
    * 以前
          [array replaceObjectAtIndex:0 withObject:@"Jack"];
    * 现在
          array[0] = @"Jack";
