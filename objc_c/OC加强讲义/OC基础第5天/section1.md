##1、【理解】NSFileManager介绍和用法
##### 1、NSFileManager介绍
* 什么是NSFileManager？
 * 顾名思义，NSFileManager是用来管理文件系统的。
 * 它可以用来进行常见的文件、文件夹操作。
 * NSFileManager使用了单例模式
 * 使用defaultManager方法可以获得那个单例对象
        [NSFileManager defaultManager]


#####2、NSFileManager用法（常见的判断）
* 2.1、判断文件或者文件夹是否存在
       -(BOOL)fileExistsAtPath:(NSString *)path;
* 2.2、判断文件、文件夹是否存在，是否为文件夹
       -(BOOL)fileExistsAtPath:(NSString *)path
* 2.3、path这个文件、文件夹是否可读
       - (BOOL)isReadableFileAtPath:(NSString *)path;
* 2.4、path这个文件、文件夹是否可写
       - (BOOL)isWritableFileAtPath:(NSString *)path;
* 2.5、path这个文件、文件夹是否可删除
       - (BOOL)isDeletableFileAtPath:(NSString *)path;

* 2.6、path这个文件是否可执行（不常用）
       - (BOOL)isExecutableFileAtPath:(NSString *)path;
* 2.7、案例：

```objc
// 1、判断文件或者文件夹是否存在
  NSFileManager *manage = [NSFileManager defaultManager];
  BOOL exist = [manage fileExistsAtPath:@"/Users/sleepingsun/Desktop/工作"];


// 2、path这个文件、文件夹是否存在，isDirectory代表是否为文件夹
   NSFileManager *manage = [NSFileManager defaultManager];
   BOOL dir = NO;

   // 后边判断时，可以通过dir的地址，去更改dir的值
   BOOL exist = [manage fileExistsAtPath:@"/Users/sleepingsun/Desktop/2.0.png" isDirectory:&dir];


// 3、path这个文件、文件夹是否可读
    // 1、文件地址
    NSString *testPath = @"/Users/sleepingsun/Desktop/test";

    // 2、获得文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 3、判断文件夹是否可读
    BOOL temp = [fileManager isReadableFileAtPath:testPath];

    NSLog(@"文件是否可读：%d",temp);



// 4、path这个文件、文件夹是否可写

    // 1、文件地址
    NSString *testPath = @"/Users/sleepingsun/Desktop/test";

    // 2、获得文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // 3、判断文件夹是否可写
    BOOL temp = [fileManager isWritableFileAtPath:testPath];

    NSLog(@"文件是否可写：%d",temp);



// 5、path这个文件、文件夹是否可删除
- (BOOL)isDeletableFileAtPath:(NSString *)path;

// 6、path这个文件是否可执行（不常用）
- (BOOL)isExecutableFileAtPath:(NSString *)path;

```

