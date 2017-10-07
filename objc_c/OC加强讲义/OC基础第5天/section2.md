##3、【理解】NSFileManager的文件或文件夹操作
####1、创建文件夹：
 * 创建文件夹(createIntermediates为YES代表自动创建中间的文件夹)

```objc
- (BOOL)createDirectoryAtPath:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes error:(NSError **)error;```

```objc
    // 1、创建文件夹的根路径
    NSString *documentsPath = @"/Users/sleepingsun/Desktop/";

    // 2、在根目录基础上，拼接要创建的文件夹名称
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];

    // 3、获得文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];


    /*
    4、创建文件夹
    1）第一个参数：创建文件夹的具体地址
    2）第二个参数：是否创建中间临时文件夹
       YES：连续创建文件夹
       NO ：如果有多个路径，中间文件夹不会自动生成，会创建失败。
    3）第三个参数：属性，默认选择nil
    4）没创建成功，返回的错误，此时选择nil
    */
    BOOL res = [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];

    // 5、判断文件夹是否创建成功
    if (res) {
        NSLog(@"文件夹创建成功");
    }else{
    NSLog(@"文件夹创建失败");
    }
```
#### 2、创建文件
 * NSData是用来存储二进制字节数据的

```objc
 - (BOOL)createFileAtPath:(NSString *)path contents:(NSData *)data attributes:(NSDictionary *)attr;
```



```objc
    // 创建文件
    // 1、创建文件夹的根路径
    NSString *documentsPath = @"/Users/sleepingsun/Desktop/";

    // 2、在根目录基础上，拼接要创建的文件夹名称
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];

    // 3、在已有文件夹的基础上，拼接文件名
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];

    // 4、获取文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // 5、创建文件
    // 1）内容：此处默认nil
    // 2）属性：默认nil
    BOOL res = [fileManager createFileAtPath:testPath contents:nil attributes:nil];
        if (res) {
            NSLog(@"文件创建成功: %@" ,testPath);
        }else {
            NSLog(@"文件创建失败");
    }

   //写文件
    NSString *documentsPath = @"/Users/sleepingsun/Desktop/";
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
    NSString *content=@"测试写入内容！";
    BOOL res=[content writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
    }else{
        NSLog(@"文件写入失败");
    }

// 读文件
    NSString *documentsPath = @"/Users/sleepingsun/Desktop/";
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];
//    NSData *data = [NSData dataWithContentsOfFile:testPath];
//    NSLog(@"文件读取成功: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *content=[NSString stringWithContentsOfFile:testPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"文件读取成功: %@",content);

```
#### 3、删除文件

```objc
    // 删除文件
    // 1、根目录
    NSString *documentsPath = @"/Users/sleepingsun/Desktop/";

    // 2、在根目录后边拼接文件夹名称
    NSString *testDirectory = [documentsPath stringByAppendingPathComponent:@"test"];

    // 3、在文件夹目录后边拼接文件名称
    NSString *testPath = [testDirectory stringByAppendingPathComponent:@"test.txt"];

    // 4、获得文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];

    // 5、用文件管理者删除指定路径的文件
    BOOL res=[fileManager removeItemAtPath:testPath error:nil];
    if (res) {
        NSLog(@"文件删除成功");
    }else{
        NSLog(@"文件删除失败");
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:testPath]?@"YES":@"NO");
    }
```
#### 4、拷贝

```objc
- (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
```
* 移动(剪切)

```objc
- (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
```
* 删除

```ojbc
- (BOOL)removeItemAtPath:(NSString *)path error:(NSError **)error;
```
