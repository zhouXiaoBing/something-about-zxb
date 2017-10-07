##1、【掌握】NSString介绍及基本使用
##### 1、NSString介绍和使用
   * 一个NSString对象就代表一个字符串（文字内容）
   * 一般称NSString为字符串类。

   * 文字内容普遍都是用NSString来表示的。
![](image4/字符串.png)
##### 2、NSString创建方法
 * 1）直接创建字符串（常量字符串）：

 ```objc
 NSString *s = @"itcast";
 NSString *s1 = @"itcast";

 // 输出地址相同
 NSLog(@"s - %p",s);
 NSLog(@"s1 - %p",s1);
```
```objc
 2015-09-24 11:55:41.693 04-01-NSString[1998:64888] s - 0x100004238
2015-09-24 11:55:41.694 04-01-NSString[1998:64888] s1 - 0x100004238

 ```

 * 2）格式化（拼接）字符串（堆区）：

  ```objc
 NSString *s = [NSString stringWithFormat:@"itcast"];
 NSString *s1 = [NSString stringWithFormat:@"itcast"];

 // 输出地址不同
 NSLog(@"s - %p",s);
 NSLog(@"s1 - %p",s1);
```
```objc
 2015-09-24 11:56:40.521 04-01-NSString[2016:65559] s - 0x74736163746965
 2015-09-24 11:56:40.522 04-01-NSString[2016:65559] s1 - 0x74736163746965
```

 * 3）转换C语言字符串

  ```objc
    char *s = "itcast";
    NSString *s1 = [NSString stringWithUTF8String:s];

    NSLog(@"s--%p--%s",s,s);
    NSLog(@"s1--%p--%@",s1,s1);
```
```objc
2015-09-24 11:59:54.666 04-01-NSString[2064:66588] s--0x100003b25--itcast
2015-09-24 11:59:54.669 04-01-NSString[2064:66588] s1--0x74736163746965--itcast
  ```

 * 4）从文件中读取：
 * 编码：
  * 英文：iso-8859-1
  * 中文：GB2312 < GBK <  GB18030表示汉字多少
  * utf - 8 ：基本包含世界上常见的语言

*  把字符串写入文件中

```objc
    NSString *content = @"公子羽是个帅气个姑娘";

    NSError *error = nil;

    // 注意：此时的one文件夹必须存在，否则写入失败。
    // 如果one文件夹存在，write.txt会自动被创建。
    [content writeToFile:@"/Users/sleepingsun/Desktop/one/write.txt" atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error != nil) {
        NSLog(@"错误信息：%@",error.localizedDescription);
    }else{
        NSLog(@"恭喜！写入成功！");
    }
```
```objc
2015-09-24 14:50:44.452 04-01-NSString[2486:86357] 错误信息：The folder “write.txt” doesn’t exist.
```


*  从文件中读取字符串

```objc
    NSError *error = nil;
    NSString *readFile = [NSString stringWithContentsOfFile:@"/Users/sleepingsun/Desktop/readFile.txt" encoding:NSUTF8StringEncoding error:&error];

    if (error == nil) {
        NSLog(@"%@",readFile);
    }else{
        NSLog(@"%@",error.localizedDescription);
    }
```
```objc
2015-09-24 14:28:22.793 04-01-NSString[2165:74406] 公子羽是个帅气的姑娘！
  ```


