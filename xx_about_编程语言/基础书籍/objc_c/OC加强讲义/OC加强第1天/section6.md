##16、【掌握】autorelease基本使用
####1.自动释放池及autorelease介绍
* 1.自动释放池
 * (1)在iOS程序运行过程中,会创建无数个池子,这些池子都是以栈结构(先进后出)存在的。
 * (2)当一个对象调用autorelease时,会将这个对象放到位于栈顶的释放池中

* 2.自动释放池的创建方式

```objc
 (1)iOS 5.0以前的创建方式
     NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
     // 代码
     [pool release];  //[pool drain];用于mac

 (2)iOS5.0以后
 @autoreleasepool
 {
   //开始代表创建自动释放池
 } //结束代表销毁自动释放池

```
* 3.autorelease
 * 是一种支持引用计数的内存管理方式
 * 它可以暂时的保存某个对象(object),然后在内存池自己的排干(drain)的时候对其中的每个对象发送release消息。
 * 注意,这里只是发送release消息,如果当时的引用计数(reference-counted)依然不为0,则该对象依然不会被释放。可以用该方法来保存某个对象,也要注意保存之后要释放该对象。


#### 2、【理解】为什么会有autorelease？
* OC的内存管理机制中比较重要的一条规律是:谁申请,谁释放

 * 考虑这种情况,如果一个方法需要返回一个新建的对象,该对象何时释放?
 * 方法内部是不会写release来释放对象的,因为这样做会将对象立即释放而返回一个空对象;

 * 调用者也不会主动释放该对象的,因为调用者遵循“谁申请,谁释放”的原则。那么这个时候,就发生了内存泄露。

* 不使用autorelease存在的问题
 * 针对这种情况,Objective-C的设计了autorelease,既能确保对象能正确释放,又能返回有效的对象。

* 使用autorelease的好处
 * (1)不需要再关心对象释放的时间
 * (2)不需要再关心什么时候调用release

####3.autorelease基本用法

* 基本用法
 * (1)会将对象放到一个自动释放池中
 * (2)当自动释放池被销毁时,会对池子里的所有对象做一次release
 * (3)会返回对象本身
 * (4)调用完autorelease方法后,对象的计数器不受影响(销毁时影响)

 * 在autorelease的模式下,下述方法是合理的,即可以正确返回结果,也不会造成内存泄露。

```objc
ClassA *Func1()
{
  ClassA *obj = [[[ClassA alloc]init]autorelease];
  return obj;
  }
```

#### 4、autorelease的原理？
 * autorelease实际上只是把对release的调用延迟了,对于每一个Autorelease,系统只是把该Object放入了当前的Autorelease pool中,当该pool被释放时,该pool中的所有Object会被调用Release。

#### 5、autorelease什么时候被释放？
* 对于autorelease pool本身,会在如下两个条件发生时候被释放
 * 1)手动释放Autorelease pool
 * 2)Runloop结束后自动释放

 * 对于autorelease pool内部的对象
 * 在引用计数的retainCount=0的时候释放。
