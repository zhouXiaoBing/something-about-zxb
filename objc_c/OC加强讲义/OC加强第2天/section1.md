##1、【理解】autorelease注意及应用场景
#### 1、autorelease使用注意
#####1）并不是放到自动释放池中，都会自动加入到自动释放池
* 1.1） 因为没有调用autorelease方法，所以对象没有加入到自动释放池.
```objc
int main(){
   @autoreleasepool{
    Student *s = [[Student alloc] init];
    [s release]; // 正常释放
   }
  return 0;
 }

 ```
* 1.2）在自动释放池的外部发送autorelease不会被加入到自动释放池中。
```objc
int main(){
   @autoreleasepool{

   }
   // 发送autorelease消息的对象，放到制动释放池外部
   // 此时无法被自动释放
  Student *s = [[[Student alloc] init] autorelease];
  return 0;
 }
 ```
* 1.3）不管对象是在自动释放池里创建，还是自动释放池外创建，只要在自动释放池内写1个[s autorelease];s就会被放到自动释放池中，注意：autorelease是一个方法，且只有在自动释放池中使用才有效。
```objc
int main(){
     // 不管在自动释放池内部还是外部创建
     Student *s = [[Student alloc] init];
     @autoreleasepool{
         [s autorelease]; // 此时s加入到释放池
   }
   return 0;
 }
 ```
* 2）自动释放池的嵌套使用
 * 自动释放池是栈结构。
 * 栈：先进后出。后进先出，
![](image2/01.png)
```objc
int main(int argc, const char * argv[]) {
    @autoreleasepool {
               // 第一个池子，里面创建no的1学生
                Student *s = [[[Student alloc] init] autorelease];
                s.no = 1;
        @autoreleasepool {
                // 第二个池子，里面创建no2的学生
                   Student *s2 = [[[Student alloc] init] autorelease];
                   s2.no = 2;
            @autoreleasepool {
                // 第二个池子，里面创建no3的学生
                        Student *s3 = [[[Student alloc] init] autorelease];
                        s3.no = 3;
            }
        }
    }
    return 0;
}
```
  * 释放顺序：s3,s2,s1
* 3）自动释放池中不适合放占用内存空间较大的对象
 * 1> 尽量避免对大内存使用该方法，对于这种延迟释放机制，尽量少用
 * 2> 不要把大量循环操作放到同1个自动释放池中，这样会造成内存峰值的上升。

####2、autorelease错误用法
* 1、连续调用多次autorelease。
```objc
    @autoreleasepool {

        Student *s = [[[Student alloc] autorelease] autorelease];// 调用了两次autorelease，对象过度释放。

    }
```

* 2、对象创建在释放池外，但是在释放池内进行autorelease后，在释放池外，又进行了release。

```objc
   int main(int argc, const char * argv[]) {

      Student *s = [[Student alloc] init];

      @autoreleasepool {

         [s autorelease];// 此时出池子后，对象可以被释放

      }
         [s release];// 对象被释放后再次调用释放，会出错。


    return 0;
 }
 ```
* 3、alloc之后调用了autorelease，之后又调用release。

```objc
  int main(int argc, const char * argv[]) {

     @autoreleasepool {

        Student *s = [[[Student alloc] init] autorelease];
        [s release];
     }

    return 0;
}
```
* 4、alloc之后调用release。
```objc
  int main(int argc, const char * argv[]) {

     @autoreleasepool {
   // 因为release没有返回值，所以这样调用是错误的。
        Student *s = [[[Student alloc] init] release];
     }

    return 0;
}
```

