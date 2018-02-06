####4、【理解】block作为函数的返回值
* 1、使用typedef定义一个新的类型

```objc
//给block起一个别名
typedef int(^newType)(int num1,int num2);

```
* 2、使用新类型作为函数的返回值

```objc
//定义一个返回值是block类型的函数
newType test(){

//定义一个newType 类型的block变量
newType work1=^(int x,int y)
{
return x+y;
};
return work1;
}
```
* 3）定义变量接收函数返回的值(block类型)
* 4）调用block

```objc
//在main函数中调用返回值是newType类型的函数

// 定义block类型的变量n
newType n = test();

// 调用block，输出结果
NSLog(@"n = %d",n(10,20));
```


