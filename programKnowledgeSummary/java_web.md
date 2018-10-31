#### Properties 配置文件说明

Properties类对应.properties文件。文件内容是键值对，键值对之间使用"="或空格隔开。开头是"#"的表示注释

​	Properties类在加载.properties文件时使用的iso8859-1的编码。所以这个文件中的中文要特殊处理：如果这个配置文件中有中文就必须要进行转义，使用native2ascii.exe命令操作:

**native2ascii d:/my.properties d:/my2.properties**

​	使用Properties类中的load(InputStream) 方法可以加载配置文件，使用其中的store(OutputStream) 方法可以保存配置到指定文件。

​	更多的信息可以看Properties类的API文档。

#### 加载配置文件

```java
public static void testLoadProperties() throws Exception {
	Properties properties = new Properties();

	InputStream in = new FileInputStream("E:/itcast/config.properties");
	properties.load(in); // 加载
	in.close();

	System.out.println(properties);
}
```

#### 写配置文件

```java
public static void testStoreProperties() throws Exception {
	// 准备配置信息
	Properties properties = new Properties();
	properties.setProperty("name", "李四");
	properties.setProperty("age", "20");

	// 准备
	OutputStream out = new FileOutputStream("d:/my.properties");
	String comments = "这是我的配置文件";

	// 写出去
	properties.store(out, comments);
	out.close();
}
```

#### 使用 properties 类 

```java
public class DBUtil {
	
	static Properties properties = new Properties();
	
	static{
		try {
			Class clazz = DBUtil.class;
			InputStreamReader fileReader =
			new InputStreamReader(clazz.getResourceAsStream("/db.properties"));
			properties.load(fileReader);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static String getUserName(){
		String userName =properties.getProperty("userName");
		return userName;
	}
	
	public static String getPassword(){
		return	properties.getProperty("password");
	}
	public static void main(String[] args) {
		System.out.println("用户名："+ getUserName());
		System.out.println("密码: "+  getPassword());
	}
}
```

### 文件路径

#### 绝对路径

以根目录或某盘符开头的路径（或者说完整的路径）

例如：

-  c:/a.txt （Windows操作系统中）

-  c:/xxx/a.txt （Windows操作系统中）

-  /var/xx/aa.txt （Linux操作系统中）

 **绝对路径的问题:** 比如C:\abc\a.properties文件路径，该路径在windows上执行没有 问题，但是如果把该项目移动到linux上面执行 ，该路径就会出现问题了，因为在linux上面没有c盘的，只有根目录\。

#### 相对路径

相对于当前路径的一个路径。例如当前文件夹为c:/abc时：相对路径a.txt表示c:/abc/a.txt，相对路径xx/a.txt = c:/abc/xx/a.txt

-  .  表示当前文件夹

-  .. 表示上级文件夹	

相对路径存在的问题:相对路径是相对于目前执行class文件的时候，控制台所在的路径，这样子也会导致出现问题。

#### java 程序中的相对路径

**在 java 中使用 File 是写相对路径，是指对于执行 java 命令当前所在的文件夹**

测试代码

```java
public class PathTest {
	public static void main(String[] args) throws Exception {
		System.out.println(new File("a.txt").getAbsolutePath());
	}
}
```

**在Eclipse中，当前路径是工程的根目录**

#### classpath 路径

> 在Java程序中，一般情况下使用绝对路径还是相对路径都不太合适，因为Java程序的jar包所放的位置不确定，执行java程序时当前的路径也不确定，所以不合适。一般在Java程序中我们会把资源放到classpath中，然后使用classpath路径查找资源。

Classpath路径：就是使用classpath目前的路径。

#### 获取 classpath 中的资源（InputStreem）

```java
public static void main(String[] args) throws Exception {
	Class clazz = new ClassPathTest().getClass();
	
	// 开头的'/'表示classpath的根目录，这个是表示从classpath的根目录中开始查找资源
	InputStream in = clazz.getResourceAsStream("/cn/itcast/my.properties");

	// 如果开头没有'/'，表示从当前这个class所在的包中开始查找
	InputStream in2 = clazz.getResourceAsStream("my.properties");
```

