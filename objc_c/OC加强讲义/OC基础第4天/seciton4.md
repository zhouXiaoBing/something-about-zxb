##10、【理解】NSArray的介绍和基本使用
* 1、【理解】NSArray的基本介绍
 * C语言中数组的弊端
        int array[4] = {10, 89, 27, 76};
 * 只能存放一种类型的数据
 * 不能很方便地动态添加数组元素
 * 不能很方便地动态删除数组元素
* 什么是NSArray ？
 * NSArray是OC中的数组类,使用起来更灵活，开发中建议尽量使用NSArray替代C语言中的数组.

* 2、【理解】NSArray常见的创建方式：

 ```objc
 + (instancetype)array;
 + (instancetype)arrayWithObject:(id)anObject;
 + (instancetype)arrayWithObjects:(id)firstObj, ...;
 + (instancetype)arrayWithArray:(NSArray *)array;

 + (id)arrayWithContentsOfFile:(NSString *)path;
 + (id)arrayWithContentsOfURL:(NSURL *)url;

 // 可以将一个NSArray保存到文件中
 - (BOOL)writeToFile:(NSString *)path  atomically:(BOOL)useAuxiliaryFile;
 - (BOOL)writeToURL:(NSURL *)url atomically:(BOOL)atomically;

 ```
* 3、【理解】NSArray的使用注意事项
 * 1> 只能存放任意OC对象, 并且是有顺序的。
 * 2> 不能存储非OC对象,比如int\float\double\char\enum\struct等。
 * 3> 它是不可变的,一旦初始化完毕后,它里面的内容就永远是固定的, 不能删除里面的元素, 也不能再往里面添加元素.

