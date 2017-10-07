##13、【理解】@property中的copy的关键字
#### 1、【理解】@property中的copy作用

```objc
分析代码:
//创建可变字符串
NSMutableString *str = [NSMutableString string]; //设定字符串的内容
str.string = @"zhangsan";
//创建对象
Person *person = [Person new]; //给person的实例变量赋值 person.name = str;
//修改字符串内容
[str appendString:@"xxxx"];
NSLog(@"name = %@",person.name); NSLog(@"str = %@",str);
// 输出结果：
name = zhangsanxxxx
str = zhangsanxxxx

这显然不符合我们的要求,因为str修改后,会影响person.name 的值 解决方法:
@property (nonatomic,copy) NSString *name;
set方法展开形式为:
- (void)setName:(NSString *)name
{
  if (_name != name)
{
  [_name release];
  [_name release];
  _name = [name mutableCopy];
} }
```

#### 2、【理解】@property内存管理策略选择
* @property内存管理策略的选择
 * 1.非ARC
    * 1> copy : 只用于NSString\block
    * 2> retain : 除NSString\block以外的OC对象
    * 3> assign:基本数据类型、枚举、结构体(非OC对象),当2个对象相互引用,一端用retain,一端用assign
 * 2.ARC
    * 1> copy : 只用于NSString\block
    * 2> strong : 除NSString\block以外的OC对象
    * 3> weak : 当2个对象相互引用,一端用strong,一端用weak
    * 4> assgin : 基本数据类型、枚举、结构体(非OC对象)

