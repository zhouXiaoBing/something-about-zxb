####1、【掌握】block的typedef
```objc
int ( ^minusBlock)(int,int) = ^(int num1,int num2){
  return num1 - num2;
};
```
* 定义1个叫做:MyBlock的数据类型，它存储的代码必须返回int，，必须接受2个int类型参数
```objc
typedef int(^MyBlock)(int,int);
```
* 重命名之后，可这样使用：
```objc
MyBlock minusBlock = ^(int num1,int num2){
  return num1 - num2;
};
```



