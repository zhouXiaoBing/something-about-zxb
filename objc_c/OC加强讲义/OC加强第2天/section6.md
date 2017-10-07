##16、【掌握】block的概念及基本使用
#### 1、【了解】block的基本概念
##### 1、什么是block？
   * block是iOS中一种比较特殊的数据类型。
   * block是苹果官方特别推荐使用的数据类型，应用场景比较广泛。

##### 2、使用场合？
    * 1）动画
    * 2）多线程
    * 3）集合遍历
    * 4）网络请求回调
#####3、block的作用
    * 用来保存一段代码，可以在恰当的时间再取出来调用.


#### 2、【理解】block的基本用法
##### 1）简单的认识下block
  * 函数写法：
  ```objc
   void myBlock (){
    NSLog(@“******”);
    NSLog(@“******”);
    NSLog(@“******”);
    NSLog(@“******”);
  }
  ```
  * block写法：
```objc
void (^myBlock)() =  ^{
  NSLog(@“******”);
  NSLog(@“******”);
  NSLog(@“******”);
  NSLog(@“******”);
}；
myBlock();
```
  * block格式：
  ```objc
  void (^block名称)(参数列表) = ^(参数列表){
  // 代码实现；
  }
```
##### 2）定义block遍历，存储一段代码，这段代码的功能是能打印任意行数***
```
void (^ myBlock)(int) = ^(int numberOfLines){
  for(int i = 0; i < numberOfLines ; i ++){
     NSLog(@“******”);
    }
  }
```
##### 3）定义block，计算两个整数的和.
```
int (^ sumBlock)(int,int) = ^(int num1, int num2){
     return num1 + num2;
};
int c = sumBlock(10,20);
NSLog(@“%d”,c);
```
#####4）定义1个block，计算1个整数的平方
```
int (^squareBlock)(int);
squareBlock = ^(int sum){
   return sum * sum;
};
squareBlock(25);
```
