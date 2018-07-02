## android 源码解读

### DownLoadManager

![downloadDemo](downloadDemo2.gif?x24892.png)

#### 一. DownloaderManager简单介绍

DownloadManager是系统开放给第三方应用使用的类，包含两个静态内部类DownloadManager.Query和DownloadManager.Request。**DownloadManager.Request用来请求一个下载，DownloadManager.Query用来查询下载信息**，这两个类的具体功能会在后面穿插介绍。

提供接口：

- **public long enqueue（Request request）**

  执行下载的方法，返回 **DownloaderId**，可用于后面查询下载信息。若网络不满足条件、Sdcard挂载中、超过最大并发数等异常会等待下载，正常则直接下载。 

- **public int remove(long ... ids)**

  删除下载，若下载中取消下载。会同时删除下载文件和记录

- **public Cursor query(Query query)**

  查询下载信息

- **public static Long getRecommendedMaxBytesOverMobile(Context context）**

  通过移动网络下载的最大字节数

- **public String getMimeTypeForDownloadedFile(long id)**

  得到下载的**mimeType**,

**其他：**通过查看代码我们可以发现还有个CursorTranslator私有静态内部类。这个类主要对Query做了一层代理。将DownloadProvider和DownloadManager之间做个映射。将DownloadProvider中的十几种状态对应到了DownloadManager中的五种状态，DownloadProvider中的失败、暂停原因转换为了DownloadManager的原因。

#### 二.下载管理示例

具体介绍下载代码

**1.AndroidManifest中添加权限**

```xml
<--AndroidManifest中添加权限-->
<<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

**2.调用DownloaderManager.Request开始下载**

```java
DownloadManager downloadManager = (DownloadManager)getSystemService(DOWNLOAD_SERVICE);
String apkUrl = "http://img.meilishuo.net/css/images/AndroidShare/Meilishuo_3.6.1_10006.apk";
DownloadManager.Request request = new DownloadManager.Request(Uri.parse(apkUrl));
request.setDestinationInExternalPublicDir("Trinea", "MeiLiShuo.apk");
// request.setTitle("MeiLiShuo");
// request.setDescription("MeiLiShuo desc");
// request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
// request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI);
// request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_HIDDEN);
// request.setMimeType("application/cn.trinea.download.file");
long downloadId = downloadManager.enqueue(request);
```

上面调用 **DownloaderManager** 的**enqueue** 接口进行下载，返回唯一的 **downloadId** 

**DownloadManager**.**Request**除了构造函数的**Uri**必须外，其他设置都为可选设置。下面逐个介绍下： **request**.**setDestinationInExternalPublicDir**(“**Trinea**”, “**MeiLiShuo**.**apk**”);表示设置下载地址为**sd**卡的**Trinea**文件夹，文件名为**MeiLiShuo**.**apk**。

setDestinationInExternalPublicDir源码

```java
public Request setDestinationInExternalPublicDir(String dirType, String subPath) {
	File file = Environment.getExternalStoragePublicDirectory(dirType);

	Xlog.v(XLOGTAG, "setExternalPublicDir: dirType " + 
			dirType + " subPath " + subPath + 
			"file" + file);

	if (file.exists()) {
		if (!file.isDirectory()) {
			throw new IllegalStateException(file.getAbsolutePath() +
					" already exists and is not a directory");
		}
	} else {
		if (!file.mkdir()) {
			throw new IllegalStateException("Unable to create directory: "+
					file.getAbsolutePath());
		}
	}
	setDestinationFromBase(file, subPath);
	return this;
}
```

从源码中我们可以看出下载完整目录为Environment.getExternalStoragePublicDirectory(dirType)。不过file是通过file.mkdir()创建的，这样如果上级目录不存在就会新建文件夹异常。所以下载前我们最好自己调用File的mkdirs方法递归创建子目录，如下：

```java
File folder = new File(folderName);
return (folder.exists() && folder.isDirectory()) ? true : folder.mkdirs();
/** 避免异常
java.lang.IllegalStateException: Unable to create directory: /storage/sdcard0/Trinea/aa
at android.app.DownloadManager$Request.setDestinationInExternalPublicDir(DownloadManager.java)
*/
```

其他的设置路径接口为setDestinationUri，setDestinationInExternalFilesDir，setDestinationToSystemCache。其中setDestinationToSystemCache仅限系统app使用。

- **request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_WIFI);**

  表示下载允许的网络类型，默认在任何网络下面都允许下载。有NETWORK_MOBILE,NETWORK_WIFI,NETWORK_BLUETOOTH三种及其组合可选。如果允许WiFi下载，而当前为移动网络，则会下载等待。

- **request.setAllowedOverRoaming(boolean allow)**

  移动网络情况下是否允许漫游。

- **request.setMimeType(“application/cn.trinea.download.file”);**

  设置下载文件的mineType。因为下载管理Ui中点击某个已下载完成文件及下载完成点击通知栏提示都会根据mimeType去打开文件，所以我们可以利用这个属性。比如上面设置了mimeType为application/cn.trinea.download.file，我们可以同时设置某个Activity的intent-filter为application/cn.trinea.download.file，用于响应点击的打开文件。

  ```xml
  <intent-filter>
  	<action android:name="android.intent.action.VIEW" />
   
  	<category android:name="android.intent.category.DEFAULT" />
   
  	<data android:mimeType="application/cn.trinea.download.file" />
  </intent-filter>
  ```

- **request.addRequestHeader(String header, String value)**

  添加请求下载的网络链接的http头，比如User-Agent，gzip压缩等

#### 3.下载进度状态监听及查询

```java
class DownloadChangeObserver extends ContentObserver {

	public DownloadChangeObserver(){
		super(handler);
	}

	@Override
	public void onChange(boolean selfChange) {
		updateView();
	}

}

public void updateView() {
	int[] bytesAndStatus = downloadManagerPro.getBytesAndStatus(downloadId);
	handler.sendMessage(handler.obtainMessage(0, bytesAndStatus[0], bytesAndStatus[1],
											  bytesAndStatus[2]));
}

private DownloadChangeObserver downloadObserver;

@Override
protected void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	setContentView(R.layout.download_manager_demo);
	……
	downloadObserver = new DownloadChangeObserver();
}

@Override
protected void onResume() {
	super.onResume();
	/** observer download change **/
	getContentResolver().registerContentObserver(DownloadManagerPro.CONTENT_URI, true,
												 downloadObserver);
}

@Override
protected void onPause() {
	super.onPause();
	getContentResolver().unregisterContentObserver(downloadObserver);
}
```

其中我们会监听Uri.parse("content://downloads/my_downloads").然后查询下载进度和状态，发送handle更新，handle中的处理就是设置进度条和状态等。其中 DownloaderManagerPro.getBytesAndStatus的主要代码如下，可以直接引入

```java
public int[] getBytesAndStatus(long downloadId) {
	int[] bytesAndStatus = new int[] { -1, -1, 0 };
	DownloadManager.Query query = new DownloadManager.Query().setFilterById(downloadId);
	Cursor c = null;
	try {
		c = downloadManager.query(query);
		if (c != null && c.moveToFirst()) {
			bytesAndStatus[0] = c.getInt(c.getColumnIndexOrThrow(DownloadManager.COLUMN_BYTES_DOWNLOADED_SO_FAR));
			bytesAndStatus[1] = c.getInt(c.getColumnIndexOrThrow(DownloadManager.COLUMN_TOTAL_SIZE_BYTES));
			bytesAndStatus[2] = c.getInt(c.getColumnIndex(DownloadManager.COLUMN_STATUS));
		}
	} finally {
		if (c != null) {
			c.close();
		}
	}
	return bytesAndStatus;
}
```

从上面代码可以看出我们主要调用 DownloadManager.Query()进行查询。DownloadManager.Query为下载管理对外开放的信息查询类，主要包括以下接口：

setFilterById(long… ids)根据下载id进行过滤
setFilterByStatus(int flags)根据下载状态进行过滤
setOnlyIncludeVisibleInDownloadsUi(boolean value)根据是否在download ui中可见进行过滤。

orderBy(String column, int direction)根据列进行排序，不过目前仅支持DownloadManager.COLUMN_LAST_MODIFIED_TIMESTAMP和DownloadManager.COLUMN_TOTAL_SIZE_BYTES排序。

#### 4.下载成功监听

下载完成后，下载管理器会发出DownloadManager.ACTION_DOWNLOAD_COMPLETE这个广播，并传递downloadId作为参数。通过接受广播我们可以打开对下载完成的内容进行操作。代码如下

```java
class CompleteReceiver extends BroadcastReceiver {

	@Override
	public void onReceive(Context context, Intent intent) {
		// get complete download id
		long completeDownloadId = intent.getLongExtra(DownloadManager.EXTRA_DOWNLOAD_ID, -1);
		// to do here
	}
};

private CompleteReceiver       completeReceiver;
@Override
protected void onCreate(Bundle savedInstanceState) {
	super.onCreate(savedInstanceState);
	setContentView(R.layout.download_manager_demo);

	…
	completeReceiver = new CompleteReceiver();
	/** register download success broadcast **/
	registerReceiver(completeReceiver,
					 new IntentFilter(DownloadManager.ACTION_DOWNLOAD_COMPLETE));
}

@Override
protected void onDestroy() {
	super.onDestroy();
	unregisterReceiver(completeReceiver);
}
```

http://www.trinea.cn/android/android-downloadmanager/

序列化的作用