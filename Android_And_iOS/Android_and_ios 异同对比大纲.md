[TOC]



# 背景

https://zh.wikipedia.org/wiki/Android

https://zh.wikipedia.org/wiki/IOS

以上维基百科的链接

------

# 开发语言

## Android

主流开发语言是java。需要 JDK 和 JRE 才能够进行编码。

## IOS

### objective-c

 objective-c 的各种资源相对丰富

### swift

 swift 个别的开源组件还没有支持

# 平台构架

## Android

> Android 是一种基于 Linux 的开放源代码软件栈，为广泛的设备和机型而创建。下图所示为 Android 平台的主要组件。

![android_软件栈](https://github.com/zhouXiaoBing/something-about-zxb/blob/master/Android_And_iOS/android_%E8%BD%AF%E4%BB%B6%E6%A0%88.png)

### Linux 内核

Android 平台的基础是 Linux 内核。例如，[Android Runtime (ART)](https://developer.android.com/guide/platform/index.html#art) 依靠 Linux 内核来执行底层功能，例如线程和低层内存管理。

使用 Linux 内核可让 Android 利用[主要安全功能](https://source.android.com/security/overview/kernel-security.html)，并且允许设备制造商为著名的内核开发硬件驱动程序。

### 硬件抽象层 (HAL)

[硬件抽象层 (HAL)](https://source.android.com/devices/index.html#Hardware%20Abstraction%20Layer) 提供标准界面，向更高级别的 [Java API 框架](https://developer.android.com/guide/platform/index.html#api-framework)显示设备硬件功能。HAL 包含多个库模块，其中每个模块都为特定类型的硬件组件实现一个界面，例如[相机](https://source.android.com/devices/camera/index.html)或[蓝牙](https://source.android.com/devices/bluetooth.html)模块。当框架 API 要求访问设备硬件时，Android 系统将为该硬件组件加载库模块。

### Android Runtime

对于运行 Android 5.0（API 级别 21）或更高版本的设备，每个应用都在其自己的进程中运行，并且有其自己的 [Android Runtime (ART)](http://source.android.com/devices/tech/dalvik/index.html) 实例。ART 编写为通过执行 DEX 文件在低内存设备上运行多个虚拟机，DEX 文件是一种专为 Android 设计的字节码格式，经过优化，使用的内存很少。编译工具链（例如 [Jack](https://source.android.com/source/jack.html)）将 Java 源代码编译为 DEX 字节码，使其可在 Android 平台上运行。

ART 的部分主要功能包括：

- 预先 (AOT) 和即时 (JIT) 编译
- 优化的垃圾回收 (GC)
- 更好的调试支持，包括专用采样分析器、详细的诊断异常和崩溃报告，并且能够设置监视点以监控特定字段

在 Android 版本 5.0（API 级别 21）之前，Dalvik 是 Android Runtime。如果您的应用在 ART 上运行效果很好，那么它应该也可在 Dalvik 上运行，但[反过来不一定](https://developer.android.com/guide/platform/verifying-apps-art.html)。

Android 还包含一套核心运行时库，可提供 Java API 框架使用的 Java 编程语言大部分功能，包括一些 [Java 8 语言功能](https://developer.android.com/guide/platform/j8-jack.html)。

### 原生 C/C++ 库

许多核心 Android 系统组件和服务（例如 ART 和 HAL）构建自原生代码，需要以 C 和 C++ 编写的原生库。Android 平台提供 Java 框架 API 以向应用显示其中部分原生库的功能。例如，您可以通过 Android 框架的 [Java OpenGL API](https://developer.android.com/reference/android/opengl/package-summary.html) 访问 [OpenGL ES](https://developer.android.com/guide/topics/graphics/opengl.html)，以支持在应用中绘制和操作 2D 和 3D 图形。

如果开发的是需要 C 或 C++ 代码的应用，可以使用 [Android NDK](https://developer.android.com/ndk/index.html) 直接从原生代码访问某些[原生平台库](https://developer.android.com/ndk/guides/stable_apis.html)。

### Java API 框架

您可通过以 Java 语言编写的 API 使用 Android OS 的整个功能集。这些 API 形成创建 Android 应用所需的构建块，它们可简化核心模块化系统组件和服务的重复使用，包括以下组件和服务：

- 丰富、可扩展的[视图系统](https://developer.android.com/guide/topics/ui/overview.html)，可用以构建应用的 UI，包括列表、网格、文本框、按钮甚至可嵌入的网络浏览器
- [资源管理器](https://developer.android.com/guide/topics/resources/overview.html)，用于访问非代码资源，例如本地化的字符串、图形和布局文件
- [通知管理器](https://developer.android.com/guide/topics/ui/notifiers/notifications.html)，可让所有应用在状态栏中显示自定义提醒
- [Activity 管理器](https://developer.android.com/guide/components/activities.html)，用于管理应用的生命周期，提供常见的[导航返回栈](https://developer.android.com/guide/components/tasks-and-back-stack.html)
- [内容提供程序](https://developer.android.com/guide/topics/providers/content-providers.html)，可让应用访问其他应用（例如“联系人”应用）中的数据或者共享其自己的数据

开发者可以完全访问 Android 系统应用使用的[框架 API](https://developer.android.com/reference/packages.html)。



## IOS

Apple 有一套完整的 App 构架，包含 macOS、iOS、tyOS、watchOS、Safari相关等。

独立的系统以及开发工具。以上的各套 OS 的文档有通用的部分，这里只提与 iOS 相关的。 

### UIKit(界面库)

UIKit 是 IOS 的基础部分，构建和管理图形，时间驱动和用户界面，

提供窗口和 View 构架用以实现用户界面，提供多点触控和其它输入类型的时间处理基础，

用户、系统、App 的交互，动画、文件管理、绘图和打印管理的支持、当前设备信息、

文本编辑和展示、App 插件支持以及资源管理。

> 重要提示：如无特殊指出 ，UIKit 的相关类仅来自于主线程和主分发队列（ main dispatch queue ）。
>
> 这种限制尤其适用于来自 UIResponder 的类和操作程序的用户界面。

### Foundation







# 应用组件

## Android

### Intent 和 intent 过滤器

`Intent` 是一个消息传递对象，您可以使用它从其他[应用组件](https://developer.android.com/guide/components/fundamentals.html#Components)请求操作。

尽管 Intent 可以通过多种方式促进组件之间的通信，主要用于：

1.启动activity

2.启动服务

3.传递广播

有显式 intent 和隐式 intent 的区别



https://developer.android.com/guide/components/intents-filters.html

#### 通用intent（多是一些系统自带的操作）

https://developer.android.com/guide/components/intents-common.html

### Activity

类比于UIviewController

https://developer.android.com/guide/components/activities.html

### Service（服务）

`Service` 是一个可以在后台执行长时间运行操作而不提供用户界面的应用组件。服务可由其他应用组件启动，而且即使用户切换到其他应用，服务仍将在后台继续运行。 此外，组件可以绑定到服务，以与之进行交互，甚至是执行进程间通信 (IPC)。 例如，服务可以处理网络事务、播放音乐，执行文件 I/O 或与内容提供程序交互，而所有这一切均可在后台进行

#### Bind Service （绑定服务）

#### AIDL

### ContentProvider（内容提供者）

### App Widget Host（应用小部件）

### 进程和线程

## iOS

#### App Structure（应用结构）

UIKit管理着应用与系统的交互并提供了相关类用于管理应用资料和资源文件。

##### Core App（核心应用）

##### Resource Management（资源管理）

##### App Extensions（应用插件）



#### User Interface（用户界面）

Views 用于展示屏幕上的内容使用户的交互更加容易；View controllers 帮助管理 Views 和用户界面的结构。

##### Views and Controls

展示内容到屏幕，并且定义内容允许的交互



#### Event Handling（事件处理）

#### Graphics、Drawing And Printing（图形、绘制、打印）

#### Text（文本）

#### Deprecated（已弃用的API）

#### Structures

#### Classes

#### Protocols

#### Reference



