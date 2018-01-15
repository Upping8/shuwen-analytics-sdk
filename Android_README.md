Analytics SDK on Android, part of the project named "Basset Hound".
The dog is a metaphor of the SDK, which is alert, agile while keeps in small shape.

# 如何接入
在项目根build.gradle中配置新华智云的Maven仓库：
```
allprojects {
    repositories {
        // 新华智云Maven仓库
        maven {
            url 'http://116.62.222.54/repository/maven-releases/'
        }
        // 阿里百川Maven仓库，包含analytics-sdk的依赖引用
        maven {
            url 'http://repo.baichuan-android.taobao.com/content/groups/BaichuanRepositories/'
        }
    }
}
```
在app模块的build.gradle中添加依赖：
```
compile 'com.shuwen.analytics:analytics-sdk:1.1.4'
```
# 使用指南
## 初始化SDK
在Application.onCreate()中，须尽早执行初始化：
```
// 使用默认配置
SHWAnalytics.init(application);
```
或，如果要使用自定义配置：
```
SHWAnalyticsConfig config = new SHWAnalyticsConfig.Builder()
    .bufferNumEventsLimit(100)
    .captureCrash(true)
    .detectSessionEvents(true)
    .detectPageEvents(true)
    // more configs ....
    .build();
SHWAnalytics.init(application, config);
```

## 动态权限
在6.0及以上的Android系统中，由于系统API的限制，需要由App来代理申请如下动态权限：
- android.permission.ACCESS_FINE_LOCATION
- android.permission.READ_PHONE_STATE

## 记录事件的方式
默认配置下，SDK会自动统计每个页面的启动和退出。但如果在SHWAnalyticsConfig中关闭了session和page事件的自动侦测，则需要自行调用：
```
SHWAnalytics.recordSessionStart(); // App从后台切前台，(该接口立即上传日志信息到服务器)
SHWAnalytics.recordSessionStop(); // App从前台切后台，(该接口立即上传日志信息到服务器)
SHWAnalytics.recordPageStart(name); // App的一个页面开始展现
SHWAnalytics.recordPageStop(name); // App的一个页面退出
```

如果App有用户登陆体系，则可以借助巴吉度的分析能力对用户行为进行追踪(该接口立即上传日志信息到服务器)：
```
recordProfileSignedIn(provider, uid); // 用户登陆后调用，provider为登陆服务提供商名称，可为null
recordProfileSignedOff(provider, uid); // 用户登出后调用
```

可自定义事件-：（不会立即上传到服务器，会优先缓存到本地文件中）
```
recordEvent(key);
recordEvent(key, properties);
recordEvent(key, properties, value);
recordEvent(key, properties, value, duration);
```
可自定义事件二：（白名单事件接口，根据参数（isImmediateReport）控制是否要立即上传到服务器）
```
recordEvent(key，isImmediateReport);
recordEvent(key, properties，isImmediateReport);
recordEvent(key, properties, value，isImmediateReport);
recordEvent(key, properties, value, duration，isImmediateReport);
```

## SHWAnalyticsConfig配置
```
SHWAnalyticsConfig config = new SHWAnalyticsConfig.Builder()
    /* App在前台时上报的频率（毫秒）*/
    .uploadIntervalForeground(15_000L)
    /* App在后台时上报的频率（毫秒）*/
    .uploadIntervalBackground(60_000L * 15)
    /* 内存缓存事件的条数，若超过则存入本地存储 */    
    .memoryEventNumThreshold(15)
    /* 内存缓存的容量（bytes），若超过则存入本地存储 */
    .memorySizeThreshold(3_000L)
    /* 单个本地存储的上限（bytes），超过上限则进入上报队列 */
    .storageSizeThreshold(100_000L)
    /* 是否打印log，默认false */
    .printLog(false)
    /* 是否自动侦测会话启动和停止，默认true */
    .detectSessionEvents(true)
    /* 是否自动侦测页面启动和停止，默认true */
    .detectPageEvents(true)
    .build();
SHWAnalytics.init(application, config);
```