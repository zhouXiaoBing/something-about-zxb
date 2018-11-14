### 内存泄漏的原因

#### java的内存分配策略

Java 程序运行时的内存分配策略有三种,分别是静态分配,栈式分配,和堆式分配，对应的，三种存储策略使用的内存空间主要分别是静态存储区（也称方法区）、栈区和堆区。

- **静态存储区（方法区）**

  主要存放静态数据、全局 static 数据和常量。这块内存在程序编译时就已经分配好，并且在整个运行期间都存在

- **栈区**

  当方法被执行时，方法体内的局部变量（包括基础数据类型、对象的引用）都在栈上创建，并在方法执行结束时这些局部变量所持有的内存将会被自动释放。因为栈内存分配运算处于 CPU 的指令集中，效率很高，但是分配的内容量有限

- **堆区**

  动态内存分配，通常就是指在程序运行时直接 new 出来的内存，也就是对象的实例。这部分内存在不使用时将会由 Java 垃圾回收机制来进行回收

#### 栈与对的区别

在方法定义内的（局部变量）一些基本类型的变量和对象的引用变量都是在方法的栈内存中分配。当在一个方法块中定义一个变量时，java 就会在栈内存中为该变量分配内存空间，当超过该变量的作用域以后，该变量也就无效了，分配给它的内存空间也将被释放掉，该内存空间可以被重新的使用。

堆内存用来存放所有由 new 创建的对象（包括对象中所有的成员变量）和数组。在堆中分配内存，将由 Java 垃圾回收机制自动管理。在堆中产生了一个数组或对象后，还可以在栈中定义一个特殊的变量，这个变量的取值等于数组或者对象在堆内存中的首地址，这个特殊的变量就是我们上面说的引用变量。我们可以通过引用变量来访问堆中的对象和数组

##### 举例：

```java
public class Sample {
    int s1 = 0 ;
    Sample  mSample1 = new Sample();
    public void method(){
        int s2 = 1;
        Sample  mSample2 = new Sample();
    }
}
Sample  mSample3 = new Sample();
/*
Sample 类的局部变量 s2 和引用变量 mSample2 都是存在于栈中，但是 mSample2 指向的对象是在堆中。mSample3 指向的对象实体存放于堆上，包括这个对象所有的成员变量 s1 和 mSample1，而它自己mSample3存在于栈中。
*/
```

##### 结论：

局部变量的基本数据类型和引用变量存储于栈中，引用变量的实体存储于堆中。——因为它们属于方法中的变量。生命周期随方法而结束

成员变量全部存储于堆中（包括基本数据类型，引用和引用的实体对象）-------因为它们归属于类，类对象终究是要被 new 出来的。

#### java是如何管理内存的

java 的内存管理就是对象的分配和释放的问题。在 java 中，程序员需要通过关键字 new 为每个对象申请内存空间（基本类型除外），所有的对象都是在堆内存（Heap）中分配空间。另外。对象的释放是由 GC 决定和执行的。 在 java 中，内存的分配是由程序完成的，而内存的释放由 GC 完成，这种收支两条线的方法确实简化了程序员的工作。但是同时，也加重了 JVM 的工作。这也是 java 程序运行比较慢的原因之一。因为 GC 为了能够正确释放对象，GC 必须监控每一个对象的运行状态，包括对象的申请、引用、被引用、赋值等，GC 都需要进行监控。

监视对象状态是为了更加准确的，及时3的释放对象，而释放对象的根本原则就是该对象不再被引用。

为了更好的理解 GC 的工作原理，我们可以将对象考虑为有向图的顶点，将引用关系考虑为图的有向边有向边从引用者指向被引用对象。另外，每个线程对象可以作为一个图的起始顶点，例如大多数程序从 main 进程开始执行，那么该图就是以 main 进程定点开始的一棵根树。在这个有向图中，根顶点可达的对象都是有效对象，GC 将不回收这些对象。如果某个对象（连通子图）与这个根顶点不可达（该图为有向图），那么我们认为这些对象不再被引用，可以被 GC 回收。以下，我们举例说明如何用有向图表示内存管理。对于程序的每一个时刻，我们都用一个有向图表示 JVM 的内存分配情况。

以下右图就是左边程序运行到第六行的示意图。

![img](auto-orient.gif)

java 使用有向图的方式进行内存管理，可以消除引用循环的问题，例如有三个对象，相互引用，只要他们和根进程不可达，那么 GC 就可以回收它们的。这种方式的优点是管理内存的精度很高，但是效率很低。另外一种常用的内存管理技术使用计数器，例如 com 模型采用计数器方式管理构件，它与有向图相对，精度很低（很难处理循环引用的问题），但是执行效率高。

#### 什么是 java 中的内存泄漏

在 java 中，内存泄漏就是存在一些被分配的对象，这些对象有下面两个特点，首先，这些对象是可达的，即在有向图中，存在通路可以与其相连；其次，这些对象是无用的，即程序以后不会再使用这些对象。如果对象满足这两个条件，这些对象就可以判定为 java 中的内存泄漏，这些对象不会被 GC 所回收，然而它却占用内存。

#### Android 中内存泄漏的原因

Android 的内存泄漏和 java 是一样的，即某个对象已经不需要再用了，但是它却没有被系统所回收，一直在内存中占用着空间，而导致它无法被回收的原因大多数是由于它被一个生命周期更长的对象引用。其实要分析 Android 中的内存泄漏的原因非常简单，只要理解一句话，那就是生命周期较长的对象持有生命周期短的对象的引用

##### 单例造成的内存泄漏

假如这样一个单例

```java
public class SingleTon {
    
    private static SingleTon singleTon;

    private Context context;

    private SingleTon(Context context) {
        this.context = context;
    }

    public static SingleTon getInstance(Context context) {
        if (singleTon == null) {
            synchronized (SingleTon.class) {
                if (singleTon == null) {
                    singleTon = new SingleTon(context);
                }
            }
        }
        return singleTon;
    }

}
//链接：https://www.jianshu.com/p/abee7c186bfa
```

这是单例模式饿汉式的双重校验锁的写法，这里的 singleTon 持有 Context 对象，如果 Activity 中调用 getInstance 方法并传入 this 时，singleTon 就持有了此 Activity 的引用，当退出 Activity 时，Activity 就无法回收，造成内存泄漏，所以应该修改它的构造方法

```java
private SingleTon(Context context) {
    this.context = context.getApplicationContext();
}
```

通过 getApplicationContext 来获取 Application 的Context，让它被单例持有，这样退出 Activity 时，Activity 对象就能够正常被回收了，而 Application 的 Context 的生命周期和单例的声明周期是一致的，整个App 运行过程中都不会发生内存泄漏。

##### 非静态内部类造成的内存泄漏

我们知道非静态内部类会持有外部类的引用，如果这个非静态内部类的生命周期比他的外部类的生命周期长，那么当销毁外部类的时候，它无法被回收，就会造成内存泄漏

##### 外部类中持有非静态内部类的静态对象

假设 Activity 的代码是这样的

```java
public class MainActivity extends AppCompatActivity {
    
    private static Test test;
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        if (test == null) {
            test = new Test();
        }

    }
    
    private class Test {

    }
    
}
```

这个其实是和单例的原理是一样的，由于静态对象 test 的生命周期和整个应用的生命周期一致，而非静态内部类 Test 持有外部类 MainActivity 的引用，导致 MainActivity 退出的时候不能被回收，从而造成内存泄漏。或者 MainActivity 退出的时候不能被回收，从而造成内存泄漏，解决的办法也很简单，把 test 改成非静态，这样test 的生命周期和 MainActivity 是一样的了，就避免了内存泄漏。或者也可以把 Test 改成 静态内部类，让 test 不持有 MainActivity 的引用，不过一般没有这种操作

##### Handler 或 Runnable 作为非静态内部类

handler 和 runnable 都有定时器的功能，当它们作为非静态内部类的时候，同样会持有外部类的引用，如果它们的内部有操作的延迟，在延迟操作还没有发生的时候，销毁了外部类，那么外部类对象无法回收，从而造成内存泄漏 Activity 的代码

```java
public class MainActivity extends AppCompatActivity {
    
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                
            }
        }, 10 * 1000);
    }
}
```

上面的代码，Handler 和 Runnable 作为匿名内部类，都会持有 MainActivity 的引用，而它内部有一个 10s 的定时器，如果 MainActivity 在10s 以内关闭了，那么由于 Handler 和 Runnable 的生命周期比 MainActivity 长，会导致MainActivity 无法被回收，从而导致内存泄漏。

那么这里避免内存泄漏的套路就是把 Handler 和 Runnable 定义为静态内部类，这样就不会再持有 MainActivity 的引用了，从而避免了内存泄漏

```java
public class MainActivity extends AppCompatActivity {

    private Handler handler;

    private Runnable runnable;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        handler = new TestHandler();
        runnable = new TestRunnable();
        handler.postDelayed(runnable, 10 * 1000);
    }

    private static class TestHandler extends Handler {

    }

    private static class TestRunnable implements Runnable {
        @Override
        public void run() {
            Log.d(TAG, "run: ");
        }
    }
    
    private static final String TAG = "MainActivity";
}

```

最好再在 onDestroy 调用的时候 调用 Handler 的 removeCallbacks 方法来移除 Message，这样不但避免了内存泄漏，而且在退出 Activity 的时候取消了定时器，保证 10s 以后也不会执行 run 方法

```java
@Override
protected void onDestroy() {
    super.onDestroy();
    handler.removeCallbacks(runnable);
}
```

还有一种情况是 Handler 和 Runnable 中持有 Context 对象，那么即使使用静态内部类，还是会发生内存泄漏

```java
public class MainActivity extends AppCompatActivity {

    private Handler handler;

    private Runnable runnable;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        handler = new TestHandler(this);
        runnable = new TestRunnable();
        handler.postDelayed(runnable, 10 * 1000);
    }

    private static class TestHandler extends Handler {
        private Context context;
        private TestHandler(Context context) {
            this.context = context;
        }
    }

    private static class TestRunnable implements Runnable {
        @Override
        public void run() {
            Log.d(TAG, "run: ");
        }
    }

    private static final String TAG = "MainActivity";
}
```

使用 leakcanary 工具会发现依然会发生内存泄漏，而造成内存泄漏的原因和之前用非静态内部类是一样的，那么为什么会出现这样的情况呢？

这是由于 Handler 持有了 Context 对象，而这个 Context 对象是通过 TestHandler 的构造方法传入的，它是一个 MainActivity 对象，也就是说，虽然 TestHandler 作为静态内部类不会持有外部类 MainActivity 的引用，但是我们在调用痛的构造方法的时候，自己传入了 MainActivity 的对象，从而 Handler 对象持有了 MainActivity 的引用， Handler 的生命周期比 MainActivity 的声明周期长，因此会造成内存泄漏，这种情况可以使用弱引用的方式来引用 Context 来避免内存泄漏

```java
public class MainActivity extends AppCompatActivity {

    private Handler handler;

    private Runnable runnable;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        handler = new TestHandler(new WeakReference<Context>(this));
        runnable = new TestRunnable();
        handler.postDelayed(runnable, 10 * 1000);
    }

    private static class TestHandler extends Handler {
        private Context context;
        private TestHandler(WeakReference<Context> weakContext) {
            context = weakContext.get();
        }
    }

    private static class TestRunnable implements Runnable {
        @Override
        public void run() {
            Log.d(TAG, "run: ");
        }
    }

    private static final String TAG = "MainActivity";
}
```

##### 其他内存泄漏的情况

还有一些内存泄漏的情况，比如 broadcastReceiver 未取消注册，InputStream 未关闭，这类内泄漏非常简单，只要在平时写代码的时候朵朵注意就可以避免。

##### 总结

造成 Android 内存泄漏的原因就是生命周期较长的对象持有了生命周期较短的对象的引用，只要理解了这一点，内存泄漏的问题就是迎刃而解了。

#### 应用

在 MVP 构架中，通常 Presenter 要同时持有 View 和 Model 的引用，如果在 Activity 退出的时候， Presenter 正在进行一个耗时操作，那么 Presenter 的生命周期比 Activity 长，导致 Activity 无法回收，造成内存泄漏

### 检测工具

#### LeakCanary使用方法

##### 1、开始使用：

在 build.gradle 中加入引用，不同的编译使用不同的引用

```gradle
 dependencies {
   debugCompile 'com.squareup.leakcanary:leakcanary-android:1.3'
   releaseCompile 'com.squareup.leakcanary:leakcanary-android-no-op:1.3'
 }//可能还存在一个testCompile
```

在 application 中

```java
public class ExampleApplication extends Application {

  @Override public void onCreate() {
    super.onCreate();
    LeakCanary.install(this);
  }
}
```

如果检测到有内存泄漏，LeakCanary 就会显示一个通知

###### LeakCanary.install(this) 源码

```java
/**
   * Creates a {@link RefWatcher} that works out of the box, and starts watching activity
   * references (on ICS+).
   */
  public static RefWatcher install(Application application) {
    return install(application, DisplayLeakService.class,
        AndroidExcludedRefs.createAppDefaults().build());
  }
//重载的另一个函数 如下
/**
   * Creates a {@link RefWatcher} that reports results to the provided service, and starts watching
   * activity references (on ICS+).
   */
  public static RefWatcher install(Application application,
      Class<? extends AbstractAnalysisResultService> listenerServiceClass,
      ExcludedRefs excludedRefs) {
    //判断是否在Analyzer进程里
    if (isInAnalyzerProcess(application)) {
      return RefWatcher.DISABLED;
    }
    enableDisplayLeakActivity(application);
    HeapDump.Listener heapDumpListener =
        new ServiceHeapDumpListener(application, listenerServiceClass);
    RefWatcher refWatcher = androidWatcher(application, heapDumpListener, excludedRefs);
    ActivityRefWatcher.installOnIcsPlus(application, refWatcher);
    return refWatcher;
  }
/*
因为 LeakCanary 会开启一个远程 Service 用来分析每次内存泄漏，鹅软Android的应用每次开启进程都会调用 Application 的 onCreate 方法，因此有必要先预判此次 Application 启动是不是在 analyze Service 启动时，
*/
/*
判断Application是否是在service进程里面启动，最直接的方法就是判断当前进程名和service所属的进程是否相同。当前进程名的获取方式是使用ActivityManager的getRunningAppProcessInfo方法，找到进程pid与当前进程pid相同的进程，然后从中拿到processName. service所属进程名。获取service应处进程的方法是用PackageManager的getPackageInfo方法。
*/
public static boolean isInServiceProcess(Context context, Class<? extends Service> serviceClass) {
    PackageManager packageManager = context.getPackageManager();
    PackageInfo packageInfo;
    try {
      packageInfo = packageManager.getPackageInfo(context.getPackageName(), GET_SERVICES);
    } catch (Exception e) {
      Log.e("AndroidUtils", "Could not get package info for " + context.getPackageName(), e);
      return false;
    }
    String mainProcess = packageInfo.applicationInfo.processName;

    ComponentName component = new ComponentName(context, serviceClass);
    ServiceInfo serviceInfo;
    try {
      serviceInfo = packageManager.getServiceInfo(component, 0);
    } catch (PackageManager.NameNotFoundException ignored) {
      // Service is disabled.
      return false;
    }

    if (serviceInfo.processName.equals(mainProcess)) {
      Log.e("AndroidUtils",
          "Did not expect service " + serviceClass + " to run in main process " + mainProcess);
      // Technically we are in the service process, but we're not in the service dedicated process.
      return false;
    }

    //查找当前进程名
    int myPid = android.os.Process.myPid();
    ActivityManager activityManager =
        (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
    ActivityManager.RunningAppProcessInfo myProcess = null;
    for (ActivityManager.RunningAppProcessInfo process : activityManager.getRunningAppProcesses()) {
      if (process.pid == myPid) {
        myProcess = process;
        break;
      }
    }
    if (myProcess == null) {
      Log.e("AndroidUtils", "Could not find running process for " + myPid);
      return false;
    }

    return myProcess.processName.equals(serviceInfo.processName);
  }
```

###### RefWatcher 

RefWatcher 是 LeakCanary 检测内存泄漏的发起点。使用方法为，在生命周期即将结束的时候调用

```java
RefWatcher.watch(Object object)
```

为了达到检测的目的，RefWatcher 需要

```java
//执行内存泄漏检测的 executer  
private final Executor watchExecutor;
//用于查询是否正在调试中，调试中不会进行内存泄漏检测
private final DebuggerControl debuggerControl;
//用于在内存泄漏钱，再给一次 GC 的机会
private final GcTrigger gcTrigger;
//用于在产生内存泄漏时执行dump 内存heap
private final HeapDumper heapDumper;
//持有那些待检测以及产生内存泄漏的引用的key
private final Set<String> retainedKeys;
//用来判断弱引用所持有的对象是否 GC
private final ReferenceQueue<Object> queue;
//用于分析产生的 dump 文件，找到内存泄漏的原因
private final HeapDump.Listener heapdumpListener;
//用于排除某些系统 bug 导致的内存泄漏
private final ExcludedRefs excludedRefs;
```

接下来我们看看 watch 函数背后是如何利用这些工具，生成内存泄漏分析报告的

```java
public void watch(Object watchedReference, String referenceName) {
    checkNotNull(watchedReference, "watchedReference");
    checkNotNull(referenceName, "referenceName");
    //如果处于debug模式，则直接返回
    if (debuggerControl.isDebuggerAttached()) {
      return;
    }
    //记住开始观测的时间
    final long watchStartNanoTime = System.nanoTime();
    //生成一个随机的key，并加入set中
    String key = UUID.randomUUID().toString();
    retainedKeys.add(key);
    //生成一个KeyedWeakReference
    final KeyedWeakReference reference =
        new KeyedWeakReference(watchedReference, key, referenceName, queue);
    //调用watchExecutor，执行内存泄露的检测 核心函数
    watchExecutor.execute(new Runnable() {
      @Override public void run() {
        ensureGone(reference, watchStartNanoTime);
      }
    });
  }
```

所以最后的核心函数是在ensureGone这个runnable里面。要理解其工作原理，就得从keyedWeakReference说起

###### WeakReference与ReferenceQueue

从 watche 函数中可以看到，每次检测对象内存是否泄漏的时候，我们都会生成一个 keyReferenceQueue，这个类其实就是一个 WeakReference，只不过额外附带了一个 key  和 name 

```java
final class KeyedWeakReference extends WeakReference<Object> {
  public final String key;
  public final String name;

  KeyedWeakReference(Object referent, String key, String name,
      ReferenceQueue<Object> referenceQueue) {
    super(checkNotNull(referent, "referent"), checkNotNull(referenceQueue, "referenceQueue"));
    this.key = checkNotNull(key, "key");
    this.name = checkNotNull(name, "name");
  }
}
```

在构造时，我们需要传入一个 ReferenceQueue，这个ReferenceQueue是直接传入了 WeakReference中，关于这个类，有兴趣的可以直接看 Reference 的源码，我们需要知道的是，每次 WeakReference 所指向的对象被 GC 后，这个弱引用都会被放入这个与之相关联的 ReferenceQueue 队列中。

我们这里贴一下核心代码

```java
private static class ReferenceHandler extends Thread {

        ReferenceHandler(ThreadGroup g, String name) {
            super(g, name);
        }

        public void run() {
            for (;;) {
                Reference<Object> r;
                synchronized (lock) {
                    if (pending != null) {
                        r = pending;
                        pending = r.discovered;
                        r.discovered = null;
                    } else {
                        //....
                        try {
                            try {
                                lock.wait();
                            } catch (OutOfMemoryError x) { }
                        } catch (InterruptedException x) { }
                        continue;
                    }
                }

                // Fast path for cleaners
                if (r instanceof Cleaner) {
                    ((Cleaner)r).clean();
                    continue;
                }

                ReferenceQueue<Object> q = r.queue;
                if (q != ReferenceQueue.NULL) q.enqueue(r);
            }
        }
    }

    static {
        ThreadGroup tg = Thread.currentThread().getThreadGroup();
        for (ThreadGroup tgn = tg;
             tgn != null;
             tg = tgn, tgn = tg.getParent());
        Thread handler = new ReferenceHandler(tg, "Reference Handler");
        /* If there were a special system-only priority greater than
         * MAX_PRIORITY, it would be used here
         */
        handler.setPriority(Thread.MAX_PRIORITY);
        handler.setDaemon(true);
        handler.start();
    }
```

