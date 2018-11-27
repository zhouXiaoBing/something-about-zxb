## 基础语法

### 数据

#### 常用变量

```swift
/*
 输出:
 C: printf("Hello, World!");
 OC:NSLog(@"Hello, World!");
 Swift1.2:println("Hello, World!")
 Swift3.0:print("Hello, World!")
 */
print("Hello, World!")
/*
 “使用let来声明常量，使用var来声明变量”
 变量:
 OC:
 >先定义再初始化
 int num;
 num = 10;
 >定义的同时初始化
 int num2 = 20;
 Swift:
 >先定义再初始化
 var num
 报错: 没有指定数据类型(type annotation missing in pattern), 在Swift中如果想要先定义一个变量, 以后使用时再初始化必须在定义时告诉编译器变量的类型(类型标注)
 */
var num: Int
num = 10;
/*
 >定义的同时初始化
 在Swift中如果定义的同时初始化一个变量,可以不用写数据类型, 编译期会根据初始化的值自动推断出变量的类型(其它语言是没有类型推断的)
 以后在开发中如果在定义的同时初始化就没有必要指定数据类型, 除非需要明确数据类型的长度或者定义时不初始化才需要指定数据类型
 */
var num2:Int = 20
var num3 = 20
/*
 “你可以用任何你喜欢的字符作为常量和变量名，包括 Unicode 字符：”
 “常量与变量名不能包含数学符号，箭头，保留的（或者非法的）Unicode 码位，连线与制表符。也不能以数字开头，但是可以在常量与变量名的其他地方包含数字。”
 错误:
 var 3x = 10
 var x+-3 = 10
 */
var 🐥 = 100
var 嘿嘿 = 200
/*
 常量:
 OC: const int num = 10;
 Swift: let num = 10
 
 错误:
 let num : Int
 Swift中的常量必须在定义时初始化(OC可以不初始化), 否则会报错
 常量的用途: 某些值以后不需要改变, 例如身份证
 */
let num4 = 10
```

#### 基本数据类型

```swift
import Foundation
/*
 基本数据类型
 OC:
 整型  int intValue = 10;
 浮点型 double doubleValue = 10.10; float floatValue = 5.1;
 长 long
 短 short
 有符号 signed
 无符号 unsigned
 各种类型的数据的取值范围在不同位的编译器下取值范围不同
 Swift:注意关键字大写
 */
//整型
var intValue:Int = 10
//浮点型
var intValue1:Double = 10.10 // 表示64位浮点数
var intValue2:Float = 8.9    // 表示32位浮点数
//如果按照长度划分,Swift中的长短比OC更加精确
var intValue3:Int8 = 6
var intValue4:Int16 = 7
var intValue5:Int32 = 8
var intValue6:Int64 = 9
//有符号无符号, 默认是有符号的(UInt8/UInt16/UInt32/UInt64)
var uintValue7:UInt = 10
//注意：无符号的数比有符号的取值范围更大, 因为符号位也用来存值
//Swift是类型安全的语言, 如果取值错误会直接报错, 而OC不会
/*
 取值不对
 OC:unsigned int intValue = -10; 不会报错
 Swift:var intValue:UInt = -10 会报错
 溢出:
 OC:int intValue = INT_MAX + 1; 不会报错
 Swift:var intValue:UInt = UInt.max + 1 会报错
 */
/*
 数据类型的相互赋值(隐式类型转换)
 OC可以
 int intValue = 10;
 double doubleValue = intValue;
 Swift:不可以
 var intValue:Int = 10
 var doubleValue:Double = intValue
 在Swift中“值永远不会被隐式转换为其他类型”(OC中可以隐式类型转换), 以上语句会报错
 */
```

#### 类型转换

```swift
/*
 Swift不允许隐式类型转换, 但可以使用显示类型转换(强制类型转换)
 OC:
 int intValue = 10;
 double doubleValue = (double)intValue;
 
 Swift:
 */
var intValue:Int = 10
var doubleValue:Double
doubleValue = Double(intValue)
// 注意:Double()并不会修改intValue的值, 而是通过intValue的值生成一个临时的值赋值给doubleValue
print(intValue)
print(doubleValue)
```

#### Bool类型

```swift
import Foundation
/*
 C语言和OC并没有真正的Bool类型
 C语言的Bool类型非0即真
 OC语言的Bool类型是typedef signed char BOOL;
 Swift引入了真正的Bool类型
 Bool true false
 */
let isOpen = true
// let isOpen = 1;
// Swift中的if的条件只能是一个Bool的值或者是返回值是Bool类型的表达式(==/!=/>/<等等)
// OC中if可以是任何整数(非0即真), 但是存在的问题是可能将判断写错, 写成赋值 if(isOpen = 2), 在开发中为了避免这个问题有经验的程序员会这样写 if(2 == isOpen) 来避免这个问题. 在Swift中很好的解决了这个问题
if isOpen
{
    print("打开")
}else
{
    print("关闭")
}
```

#### 元祖

```swift
import Foundation

/*
 元组:
 在其它语言中很早就是有元组这个概念, 但是对于OC程序员来说这是一个新的概念
 将多个相同或者不同类型的值用一个小括号括起来就是一个元组
 */
let student = ("xiaohange",30,99.8)
print(student)
print(student.0)
print(student.1)
print(student.2)
/*
元组其实和结构体很像, 只是不需要提前定义类型, 那么如果不定义类型元组是什么类型呢?
元组其实是符合类型, 小括号可以写任意类型
*/

let student1:(String, Int, Double) = ("hello",30,19.9)
/*
元组的其他定义方式:指明应用元组元素的名称
*/
let student2 = (name:"hi",age:20,core:99.2)
print(student2.name)
print(student2.age)
print(student2.core)
/*
元组的其他定义方式:
通过指定的名称提取元组对应的值, 会将对应位置的值赋值给对应位置的名称
*/
let (name, age, score) = ("xioahan", 30 ,99.9)
print(name)
print(age)
print(score)
/*
 如果不关心元组中的某个值可以利用_通配符来忽略提取
*/
let (name1, age1, _) = ("hello", 30, 99.9)
print(name1)
print(age1)
/*
 以前没有元组之前C和OC语言是通过传入指针或者凡是结构体的方式来返回多个值的,而有了元组之后就可以实现让一个函数返回多个值
 */
// 补充:
/** 元组的定义 **/
// 一元元组, 会将编译器优化为其实际元素的类型.举例:
var t1 : (String) = ("我是字符串") // 等同于下面一行
//var t1 : String = "我是字符串"
//可以缺省类型 var t1 = "我是字符串"
//注意!!!: 由于t1实际为String类型, 因此t1.0的访问会报错
// 元组支持嵌套
var t_t : (String, (String, Int)) = ("基本信息",("小韩哥", 25))
// 可以将元组的类型重定义为一个类型名
typealias namedFinshesType = (first:String, second:String, third:String)
let namedFinshes : namedFinshesType = ("aaa", "bbb", "ccc")
/** 元组的数据访问 **/
// 当元素未命名时, 采用自然顺序访问, 序号从0开始
var t2 = ("小韩哥", 25)
var names = t2.0
var ages = t2.1
print("name: \(names),age: \(ages)") // 打印:name: 小韩哥,age: 25
// 当元素命名时, 可以用命名访问数据, 当然仍可以使用序号进行访问
var t3 = (name:"小韩哥", age: 26)
names = t3.0 // 或者 names = t3.name
ages = t3.1 //  或者 ages = t3.age
print("name: \(names),age: \(ages)") // 打印:name: 小韩哥,age: 26
// 可以用多个变量同时进行访问
var t4 = (name:"小韩哥", 22)
var (name3, age3) = t4 // 即可同时获取name, age
var (name4, _) = t4 // 不需要时参数可以缺省
// 另外注意, 元组为数值类型, 因此元组的拷贝是值拷贝
var t5 = (name:"小韩哥", 23)
var t5_copy = t5
t5.name = "李白"
print("\(t5_copy.name)") // 打印: 小韩哥
// 关于元组的访问级别
/*
 * 元组的访问级别取决于它包含的元素，比如元组里的元素都是private级别的，那么该元组也是private级别的。
 * 遵循最小的原则，也就是说如果一个元组中有两个元素，一个为private级别，另一个为public级别，那么该元组遵循最小原则，它的访问级别为private。
 */
// 元素的数据修改
// 虽然元组的数据不能增删, 但是修改还是可以的
var t6 = (name:"小韩哥", 26)
t6.name = "李白"
print("\(t6.name)") // 打印:李白
t6 = ("韩较瘦", 25)
print("\(t6.name)") // 打印:韩较瘦
// 但是数据类型不能改变
//t6.name = 30 // 报错!
// 如果是常量定义, 元组的数据不能改变
let t7 = (name:"小韩哥", 23)
//t7.name = "李白" // 报错!
// 当然,如果指定数据类型为Any, 这种情况下数据可以改变类型
var t_any : (String, Any) = ("小韩哥", 25)
t_any.1 = "可以改变为String" // Any不限定数据类型
/** 元组与Array, Dictionary的组合定义**/
// 数组嵌套元素
var moneyArray:[(Int,String)] = [(20,"Cidy"), (18,"Nickle"), (14, "Quarter")]
// 字典嵌套元组
var userInfoDic:[String:(Int,String)] = ["cidy":(20,"girl"), "nickl":(15,"boy")]
print(userInfoDic) // 打印:["cidy": (20, "girl"), "nickl": (15, "boy")]
/** 元组的常见使用场景 **/
// 非常适用于Dictionary遍历
// 官方文档例子:
var airports: [String:String] = ["YYZ": "toronto", "DUB": "Dublin"]
// 遍历airports
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// 非常适合用于Array的enumerated()
// 官方文档例子:
var shoppingList = ["Eggs", "Milk"]
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}
// 适合函数返回多元数据
func userInfoOne() ->(String, Int) {
    return ("小韩哥", 26)
}
// 函数也可以返回可选元组, 即可以返回nil
func userInfoTwo() ->(String, Int)? {
    return nil
}
// 当然也可以部分元素为可选
func userInfoThree() -> (String?,Int) {
    return (nil, 26)
}
// 甚至可以用来给函数传递多元参数
// 定义一个函数, 有number和text两个参数
func doSomething(number: Int, text: String) {
    print("\(number) : \(text)")
}
// 正常调用方式
doSomething(number: 1, text: "one")
// 元组调用方式
let tupleVar = (1, "one")
//doSomething(tupleVar) 已废弃
/** 高级实例 **/
// 模拟情绪数据
var emoyions : [(type: String, strength: Int)] = [("happy",0),("scared",0),("tender",0)]

// 我想遍历数组, 然后对 happy进行+1, 我应该怎么做
for (index, emo) in emoyions.enumerated() {
    if emo.type == "happy" {
        emoyions[index] = (type: emo.type, strength: emo.strength+1)
    }
}
print(emoyions) // 打印:[(type: "happy", strength: 1), (type: "scared", strength: 0), (type: "tender", strength: 0)]

// 高级用法 - 解决同一个问题
// 这里用到了map, 具体方法可以看后面RxSwift中关于map的讲解, 这里不做解释
emoyions = emoyions.map {
    emo in
    if emo.type == "happy" {
        return (type:emo.type, strength:emo.strength+1)
    } else {
        return emo
    }
}
```

#### 可选值

```swift
/*
可选值: optionals 有两种状态:
1.有值 2.没有值, 没有值就是nil
*/

//有值
var optValue1: Int? = 9
//没有值
var optValue2: Int?
var optValue3: Int? = nil

/*
可选值可以用if语句来进行判断
*/
var optValue4: Int?
if optValue4 != nil
{
    print(optValue4)
}else
{
    print(optValue1)
}

/*
提取可选类型的值(强制解析)
会将optValue中的整型值强制拿出来赋值给result, 换言之就是告诉编译器optValue一定有值, 因为可选类型有两种状态 有值和没有值, 所以告诉编译器到底有没有值
需要注意的是如果强制解析optValue, 但是optValue中没有值时会引发一个运行时错误
*/
var optValue5: Int? = 10
var result1: Int = optValue5!
print(result1)

//报错:
//var optValue6: Int?
//var result2: Int = optValue6!
//print(result2)

/*
可选绑定:
为了安全的解析可选类型的值, 一般情况下使用可选绑定
如果optValue没有值就不会做任何操作, 如果opValue有值会返回并将optValue的值赋值给result执行大括号中的内容
*/
var optValue7: Int? = 11
if let result3 = optValue7
{
    print(result3)
}
```

#### 字符和字符串

```swift
import Foundation
/*
 字符:
 OC: char charValue = 'a';
*/
var charVlaue1: Character = "a"
/*
Swift和OC字符不一样
1.Swift是用双引号
2.Swift中的字符类型和OC也不一样, OC中的字符占一个字节, 因为它自包含ASCII表中的字符, 而Swift中的字符除了可以存储ASCII表中的字符还可以存储unicode字符
例如中文:
OC:char charValue = '韩'
Swift: var charValue: Character = "韩" // 正确
OC的字符是遵守ASCII标准的,Swift的字符是遵守unicode标准的, 所以可以存放实际上所有国家的字符(大部分)
*/
var charValue2: Character = "韩" //正确
/*
注意:双引号中只能放一个字符, 如下是错误写法
var charValue: Character = "abc"
*/
/*
字符串:
字符是单个字符的集合, 字符串十多个字符的集合, 想要存放多个字符需要使用字符串
C:
char *stringValue = "ab"
char stringStr = "ab"
OC:
NSString *stringArr = "ab";
*/
var stringValue1 = "ab"
/*
C语言中的字符串是以\0结尾的,例如:
char *sringValue = "abc\0def"
printf("%s", stringValue);
打印结果为: abc
OC语言中的字符串也是以\0结尾的, 例如:
NSString *StringValue = @"abc\0def";
printf("%@", stringValue);
打印结果为: abc
*/
var stringValue2 = "abc\0def"
print(stringValue2)
// 打印结果为:abcdef
// 从此可以看出Swift中的字符串和C语言/OC语言中的字符串是不一样的
```

