##5、【理解】NSRange使用
* 1、【理解】NSRange的使用
* NSRange是Foundation框架中比较常用的结构体, 它的定义如下:

```objc
typedef struct _NSRange {
    NSUInteger location;
    NSUInteger length;
} NSRange;
```
*  NSUInteger的定义

```objc
typedef unsigned int NSUInteger;

```
* NSRange用来表示事物的一个范围,通常是字符串里的字符范围或者数组里的元素范围。
 * NSRange有2个成员

 ```objc
NSUInteger location : 表示该范围的起始位置
NSUInteger length : 表示该范围内的长度

 比如@“I love iOS”中的@“iOS”可以用location为7，length为3的范围来表示.
 ```

* 2、【理解】NSRange创建的几种方式
* 有3种方式创建一个NSRange变量
 * 方式1
```objc
NSRange range;
range.location = 7;
range.length = 3;```
 * 方式2
```objc
NSRange range = {7, 3};
// 或者
NSRange range = {.location = 7,.length = 3};
```
 * 方式3 : 使用NSMakeRange函数
```objc
NSRange range = NSMakeRange(7, 3);```

