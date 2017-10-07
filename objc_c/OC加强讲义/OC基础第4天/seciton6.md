##16、【理解】NSDictionary的介绍及使用
* 1、什么是NSDictionary？
 * NSDictionary翻译过来叫做”字典”
 * 日常生活中, “字典”的作用:通过一个拼音或者汉字,就能找到对应的详细解释。
* 2、NSDictionary的作用:
 * 类似通过一个key,就能找到对应的value。
 * NSDictionary是不可变的,一旦初始化完毕,里面的内容就无法修改。

* 3、NSDictionary的创建

```objc
+ (instancetype)dictionary;
+ (instancetype)dictionaryWithObject:(id)object forKey:(id <NSCopying>)key;
+ (instancetype)dictionaryWithObjectsAndKeys:(id)firstObject, ...;
+ (id)dictionaryWithContentsOfFile:(NSString *)path;
+ (id)dictionaryWithContentsOfURL:(NSURL *)url;
```
* 4、NSDictionary的常见使用
 * 返回字典的键值对数目
        - (NSUInteger)count;
 * 根据key取出value
        - (id)objectForKey:(id)aKey;

* 5、NSDictionary的遍历
 * 1> 快速遍历
        for (NSString *key in dict) { }
 * 2> block遍历
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) { }];


