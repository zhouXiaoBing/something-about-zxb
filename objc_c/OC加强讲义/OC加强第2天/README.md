####1. 内存管理的范围
* 所有的OC对象(继承自NSObject类)

####2. 我们如何对OC对象进行内存管理?
* 通过操作对象的"引用计数器"

####3. 引用计数器
#####什么是引用计数器?
* 1> 每个OC对象都有自己的引用计数器
* 2> 它是一个整数(long类型, 占用8个字节)
* 3> 从字面上, 可以理解为"对象被引用的次数"
* 4> 也可以理解为: 它表示有多少人正在用这个对象

#####引用计数器的作用?
*  系统通过"引用计数器"来判断当前对象是否可以被释放
对象的"引用计数器"的操作方式
 * 1> retain, +1
 * 2> release, -1
 * 3> retainCount, 获取对象引用计数器的值

####4. dealloc方法
* 当对象即将被销毁, 系统自动给对象发送一条dealloc消息
* 因此, 从dealloc方法有没有被调用,就可以判断出对象是否被销毁
* 重写了dealloc方法, 必须调用[super dealloc],并且放在最后面调用,不要自己直接调用dealloc方法

####5. 野指针\空指针\僵尸对象
* 僵尸对象: 已经被销毁的对象(不能再使用的对象)
* 野指针: 指向僵尸对象(不可用内存)的指针
* 空指针: 没有指向存储空间的指针(里面存的是nil, 也就是0)
* 注意: 给空指针发消息是没有任何反应的, 不会提示出错 nil Nil NULL [NSNULL null];

####6. 多对象内存管理
```objc
set方法的内存管理
 -(void)setCar:(Car*)car{
    if( _car != car){
       [_car release];
       _car = [car retain];
    }
 }

```

* dealloc方法的内存管理

```objc
-(void)dealloc{
   [_car release];
   [super dealloc];
}
```

####7. 苹果官方的内存管理原则:

* 谁创建谁release,
* 如果你通过alloc、new或copy、mutableCopy来创建一个对象
* 那么你必须调用release或autorelease
* 谁retain谁release
* 只要你调用了retain, 就必须调用一次release

####8. @property的修饰关键字

#####1> 控制set方法的内存管理

* retain: release旧值,retain新值(用于OC对象),要配合nonatomic使用
* assign: 直接赋值,不做任何内存管理(默认,用于非OC对象类型)
* copy: release旧值, copy新值(一般用于NSString *)

##### 2>控制是否需要生成set方法
* readwrite: 同时生成set方法和get方法(默认)
* readonly: 只会生成get方法

#####3> 多线程管理
* atomic: 性能低(默认)
* nonatomic: 性能高(为iOS系统开发软件建议使用,为mac开发软件可以使用atomic)

#####4> 控制set方法和get方法的名称
* setter: 设置set方法的名称, 一定有个冒号:
* getter: 设置get方法的名称

####9. @class用法
* 为什么要使用@class .h
 * 通过@class解决循环依赖问题

####10. 内存管理时的循环retain问题
* 解决办法: 一端用retain、一端用assign
* 注意: 使用了assign后, dealloc中就不需要release了

####11.自动释放池简介
#####1.自动释放池的创建
* 第一种

```objc
     NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
     // 代码
     [pool release];  //[pool drain];用于mac
```
* 第二种
```ojbc
@autoreleasepool
 {
   //开始代表创建自动释放池
 } //结束代表销毁自动释放池
```

#####2.自动释放池的好处
* 不需要关心释放时间
* 不需要关系什么时候release

#####3.autorelease基本用法
* (1)会将对象放到一个自动释放池中
* (2)当自动释放池被销毁时,会对池子里的所有对象做一次release
* (3)会返回对象本身
* (4)调用完autorelease方法后,对象的计数器不受影响(销毁时影响)
