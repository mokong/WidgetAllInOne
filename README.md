# WidgetAllInOne
iOS Widget all in one



# iOS Widget

## 背景

一开始是发现支付宝的 Widget 做的很好看，打算仿作一个，做的过程中才发现，原来 Widget 有这么多好玩的地方。所以，在这里记录分享一下：

<!--more-->

你知道如何创建类似于 QQ 同步助手的 Widget 吗？
<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2049.PNG" width="30%">
</figure>

你知道类似于东方财富的不同组 Widget 效果是怎么实现的吗？
<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2050.PNG" width="30%">
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2052.PNG" width="30%">
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2051.PNG" width="30%">
</figure>

你知道下图中支付宝Widget功能是怎么实现的吗？
<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2053.PNG" width="24%">
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2056.PNG" width="24%">
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2057.PNG" width="24%">
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/IMG_2058.PNG" width="24%">
<figure>

或者这么问，对于这几个的概念：`supportedFamilies`、`WidgetGroup`以及`Configurable Widget`是否知晓，如果都知道，那就不需要看本篇文章了。

- QQ 同步助手的Widget只显示一个Widget的效果，是设置了 Widget 的`supportedFamilies`只有systemMedium 样式；
- 东方财富的多组 Widget，是通过`WidgetGroup`实现的，可以设置多个Widget，每个 Widget 都可以设置自己的大中小；区分是否使用了 `WidgetGroup`，可以通过滑动时，Widget预览界面同步的文字是否跟着滑动来区分：同一个 Widget 的大中小不同样式，滑动时顶部的标题和描述是不会动的；不同组的 Widget，每个 Widget 都有自己的标题和描述，滑动时，文字是跟着一起滑动的。
- 支付宝的 Widget，使用了`Configurable Widget`，定义了`Enum`类型和自定义数据类型，设置Intent 的`Dynamic Options`和`Supports multiple values`。


## 开发

开始前的说明：
如果要用到 APP 和 Widget 传值通信，比如支付宝中天气的显示，从 APP 定位获取的城市，保存到本地，从 Widget 中获取到本地保存的城市，再去获取天气。这中间的传值需要 APPGroup，如果不需要 APP 和 Widget 传值的，则不需要设置APPGroup；但是如果设置 APPGroup 的话，需要注意 Widget 和主 APP 的 APPGroup 要一致。APPGroup 的详细使用可参考[App之间的数据共享——App Group的配置](https://www.jianshu.com/p/94d4106b9298)，这里就不展开说明了。


### 创建 Widget

创建 Widget，选择 File -> New -> Target -> Widget Extension。

<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/create%20widget.png" width="70%">
</figure>

点击下一步，输入 Widget 的名字，取消勾选Include Configuration Intent。

<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/input%20widget%20name.png" width="70%">
</figure>

点击下一步，会出现是否切换 Target 的提示，如下，点击Activate，切换到 Widget Target；

<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/Activate.png" width="50%">
</figure>

上面的步骤点击 Activate或者取消都可以；点击 Activate 是 Xcode主动把 Target切换到 Widget，点击取消是保持当前 Target。随时可以手动切换。

<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/choose%20target.png">
</figure>

这样 Widget 就创建好了，来看下目前项目的结构，如下

<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/screenshot-20220511-174147.png">
</figure>

再来看下，Widget 中.swift 文件的代码，入口和代理方法都在这个类中：

其中分为几个部分，如下

- TimeLineProvider，protocol 类型定义了三个必须实现的方法，用于 Widget 的默认展示和何时刷新
  - `func placeholder(in context: Context) -> SimpleEntry`
  - `func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ())`这个方法定义Widget预览中如何展示，所以提供默认值要在这里
  - `func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ())`这个方法里，决定 Widget 何时刷新
- TimelineEntry，这个类也是必须实现的，里面的 Date 用于判断刷新时机，如果有自定义 Intent 的话，也是从这里传值到 View
- View，Widget的 View
- Widget，Widget 的 title 和 description，以及 supportedFamilies都在这里设置
- PreviewProvider，这个是SwiftUI 的预览，即边修改边看效果，可删除

看完上面可能还是一头雾水，不要紧，接着往下看，跟着做一两个 Widget 就明白每个部分的作用了。

### QQ 同步助手的 Widget


#### WidgetUI 创建

先来做一个最简单的 QQ 同步助手的 Widget，下载`Tutorial1`文件夹中的项目，打开，新建`SwiftUIView`，如下：
<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/20220601092226.png" width="70%">
</figure>

点击Next，文件名字输入`QQSyncWidgetView`，这里需要注意选中的 Target 是 Widget 的 Target，而不是主工程的，如下：
<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/20220601092644.png" width="70%">
</figure>

然后打开`QQSyncWidgetView`，文件内容如下：

``` Swift

//
//  QQSyncWidgetView.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 01/06/2022.
//

import SwiftUI

struct QQSyncWidgetView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct QQSyncWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        QQSyncWidgetView()
    }
}

```

其中，`QQSyncWidgetView`中是`SwiftUI` View 的代码，即要修改布局的地方；`QQSyncWidgetView_Previews`是控制预览 View 的，可以删除。然后来看要实现的 QQ 同步助手的 Widget包含有哪些内容：
<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/20220606100905.png" width="70%">
</figure>

如上可以分为三个部分，背景图片、左侧文字 View、右侧文字 View，背景图片和两个 View 之间前后关系用 ZStack 的实现，两个 View 之间左右关系用 HStack，View 里面的文字的上下布局是 VStack，测试用的资源文件放在`QQSyncImages`文件夹下。

`SwiftUI`的内容可以参考斯坦福老爷子的教程，链接如下：
- https://cs193p.sites.stanford.edu/

填充内容后大致如下：

``` Swift

struct QQSyncWidgetView: View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()
            
            // 左右两个 View
            HStack {
                Spacer()
                // 左 View
                VStack(alignment: .leading) {
                    Spacer()
                    Text("所有快乐都向你靠拢，所有好运都在路上。")
                        .font(.system(size: 19.0))
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.white)

                    Spacer()
                    
                    Text("加油，打工人！😄")
                        .font(.system(size: 16.0))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.white)
                    Spacer()
                }
                
                Spacer()
                
                // 右 View
                VStack {
                    Spacer()
                    Text("06")
                        .font(.system(size: 50.0))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: -10.0, leading: 0.0, bottom: -10.0, trailing: 0.0))
                    Text("06月 周一")
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.system(size: 14.0))
                        .foregroundColor(.white)
                    Spacer()
                    Text("去分享")
                        .fixedSize()
                        .font(.system(size: 14.0))
                        .padding(EdgeInsets(top: 5.0, leading: 20.0, bottom: 5.0, trailing: 20.0))
                        .background(.white)
                        .foregroundColor(.black)
                        .cornerRadius(12.0)
                    Spacer()
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0))
        }
    }

```

然后修改入口，打开`DemoWidget.swift`，其中`DemoWidgetEntryView`是组件显示的 View，所以这里修改为刚刚创建的`QQSyncWidgetView`，修改如下：

``` Swift

struct DemoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        QQSyncWidgetView()
    }
}

```

效果如下：

<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/20220606172505.png" width="70%">
</figure>


效果已经和 QQ 同步助手的类似，但是上面的代码还需要再优化一下，类太臃肿；可以把每个`VStack`单独封装成一个 view，也能方便复用。创建SwiftUIView 命名为`QQSyncQuoteTextView`用于Widget左半边 的 view 展示；创建右半边的 view 命名为`QQSyncDateShareView`，最终代码为：

`QQSyncQuoteTextView`类：

``` Swift

import SwiftUI

struct QQSyncQuoteTextView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("所有快乐都向你靠拢，所有好运都在路上。")
                .font(.system(size: 19.0))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)

            Spacer()
            
            Text("加油，打工人！😄")
                .font(.system(size: 16.0))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
            Spacer()
        }
    }
}

```

`QQSyncDateShareView`类：

``` Swift

import SwiftUI

struct QQSyncDateShareView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("06")
                .font(.system(size: 50.0))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: -10.0, leading: 0.0, bottom: -10.0, trailing: 0.0))
            Text("06月 周一")
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .font(.system(size: 14.0))
                .foregroundColor(.white)
            Spacer()
            Text("去分享")
                .fixedSize()
                .font(.system(size: 14.0))
                .padding(EdgeInsets(top: 5.0, leading: 20.0, bottom: 5.0, trailing: 20.0))
                .background(.white)
                .foregroundColor(.black)
                .cornerRadius(12.0)
            Spacer()
        }
    }
}

```

最后修改`QQSyncWidgetView`为：

``` Swift

import SwiftUI

struct QQSyncWidgetView: View {
    var body: some View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()
            
            // 左右两个 View
            HStack {
                // 左 View
                QQSyncQuoteTextView()
                                
                // 右 View
                QQSyncDateShareView()
            }
            .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0))
        }
    }
}

```

然后再运行，发现效果和之前相同，bingo。


#### 不同widget 尺寸设置

再来看【widget 大小的设置】，目前开发的 Widget 在 Medium 大小时， 显示是正好的，但是还有Small和Large的大小，显示都是不正常的，那这个是如何设置的呢？怎么针对不同大小，设置显示不同的内容？

设置不同大小不同内容的Widget，需要使用`WidgetFamily`，使用需要导入`WidgetKit`，比如设置Small 时 Meidum 的右半部分，Medium 时显示不变，要怎么做呢？

1. 在要设置的类中导入`WidgetKit`
2. 声明属性`@Environment(\.widgetFamily) var family: WidgetFamily`
3. 使用`Switch`枚举 `family`

注：
- `@Environment`是使用 `SwiftUI`本身预定义的key，更多关于`@Environment`的内容可以参考下面两个链接：
  - https://developer.apple.com/documentation/swiftui/environment
  - https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-environment-property-wrapper

具体代码如下：

``` Swift


import SwiftUI
import WidgetKit

struct QQSyncWidgetView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()
            switch family {
            case .systemSmall:
                QQSyncDateShareView()
            case .systemMedium:
                // 左右两个 View
                HStack {
                    // 左 View
                    QQSyncQuoteTextView()
                                        
                    // 右 View
                    QQSyncDateShareView()
                }
                .padding(EdgeInsets(top: 0.0, leading: 10.0, bottom: 0.0, trailing: 10.0))
//            case .systemLarge:
//                break
//            case .systemExtraLarge:
//                break
            default:
                QQSyncQuoteTextView()
            }
        }
    }
}

```

运行查看效果，如下：

<figure>
    <img src="https://raw.githubusercontent.com/mokong/BlogImages/main/img/20220606172328.png" width="70%">
</figure>

发现效果和预期一样，但是代码看起来真的有点丑，同样再优化一下，封装`QQSyncWidgetMedium`和`QQSyncWidgetSmall`两个类，如下：

``` Swift

import SwiftUI

struct QQSyncWidgetSmall: View {
    var body: some View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()
            
            QQSyncDateShareView()
        }
    }
}

```

``` Swift

import SwiftUI

struct QQSyncWidgetMedium: View {
    var body: some View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()

            // 左右两个 View
            HStack {
                // 左 View
                QQSyncQuoteTextView()

                Spacer()

                // 右 View
                QQSyncDateShareView()
            }
            .padding(EdgeInsets(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0))
        }
    }
}

```

然后修改`QQSyncWidgetView`，如下：

``` Swift


import SwiftUI
import WidgetKit

struct QQSyncWidgetView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    
    var body: some View {
        switch family {
        case .systemSmall:
            QQSyncWidgetSmall()
        case .systemMedium:
            QQSyncWidgetMedium()
//            case .systemLarge:
//                break
//            case .systemExtraLarge:
//                break
        default:
            QQSyncWidgetMedium()
        }
    }
}

```

再次运行，查看效果，还是预期的效果，但是代码看起来简洁明了了，如果想要添加 Large 的 View，只需要再定义`QQSyncWidgetLarge`类，然后在上面这个地方使用即可，方便快捷。

接着再来看笔者创建的项目，添加 Widget 时，`Small`、`Meidum`、`Large`都有，即使在上面的`Switch family`中注释掉了`Small`和`Larget`，预览时仍旧这两个尺寸仍旧在；而当添加QQ 同步助手的 Widget 时，可以看到它的 Widget 只有一个Medium尺寸的，这又是如何做到的呢？

这是通过 @main 入口处设置`supportedFamilies`属性实现的，`supportedFamilies`传入一个尺寸数组，传入几个尺寸则支持几个尺寸，而参照 QQ 同步助手的效果，只传入了`.systemMedium`尺寸，代码如下：

``` Swift

@main
struct DemoWidget: Widget {
    let kind: String = "DemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DemoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([WidgetFamily.systemMedium]) // 设置预览 widget 中支持的尺寸数组
    }
}

```


#### widget 日期更新

上面显示的部分已经完成，接下来，再来看【日期的设置】，目前的日期是固定的，如何让日期取用手机时间，要怎么做？

需要考虑的是：
- 日期从哪里来？—— 可以在 Extension 中，直接使用 Date()来获取到当前的日期
- 日期更新了怎么通知刷新？参考[cs193p-Developing Apps for iOS](https://cs193p.sites.stanford.edu/)，使用`ObservableObject`定义一个`@Published`修饰的属性，然后在使用的 View中使用`@ObservedObject`修饰的属性，这样当`@Published`修饰的属性有变化时，`@ObservedObject`修饰的属性就会变化，从而刷新界面。

代码实现如下：

首先创建swift 文件，注意，model 类创建使用的 swift，而 UI创建的类是 SwiftUI。

新建`String_Extensions.swift`，定义获取指定日期类型的字符串，代码如下：

``` Swift

import Foundation

enum DisplayDateType {
    case Year
    case Month
    case Day
    case hour
    case minute
    case second
}

extension String {
    func getFormatDateStr(_ type: DisplayDateType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        _ = calendar.component(.era, from: formatDate)
        let year = calendar.component(.year, from: formatDate)
        let month = calendar.component(.month, from: formatDate)
        let day = calendar.component(.day, from: formatDate)
        let hour = calendar.component(.hour, from: formatDate)
        let minute = calendar.component(.minute, from: formatDate)
        let second = calendar.component(.second, from: formatDate)
        switch type {
        case .Year:
            return String(format: "%.2zd", year)
        case .Month:
            return String(format: "%.2zd", month)
        case .Day:
            return String(format: "%.2zd", day)
        case .hour:
            return String(format: "%.2zd", hour)
        case .minute:
            return String(format: "%.2zd", minute)
        case .second:
            return String(format: "%.2zd", second)
        }
    }

    
    func getWeekday() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let formatDate = dateFormatter.date(from: self) else { return "" }
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: formatDate)
        switch weekDay {
        case 1:
            return "周日"
        case 2:
            return "周一"
        case 3:
            return "周二"
        case 4:
            return "周三"
        case 5:
            return "周四"
        case 6:
            return "周五"
        case 7:
            return "周六"
        default:
            return ""
        }
    }
}

```

新建`QQSyncWidgetDateItem.swift`类，用于获取年、月、日、周、时、分、秒的 String

``` Swift

import Foundation

struct QQSyncWidgetDateItem {
    var year: String
    var month: String
    var day: String
    
    var week: String
    
    var hour: String
    var minute: String
    var second: String
    
    static func generateItem() -> QQSyncWidgetDateItem {
        let dateStr = date2String(date: Date())
        
        let year = dateStr.getFormatDateStr(DisplayDateType.Year)
        let month = dateStr.getFormatDateStr(DisplayDateType.Month)
        let day = dateStr.getFormatDateStr(DisplayDateType.Day)
        
        let week = dateStr.getWeekday()
        
        let hour = dateStr.getFormatDateStr(DisplayDateType.hour)
        let minute = dateStr.getFormatDateStr(DisplayDateType.minute)
        let second = dateStr.getFormatDateStr(DisplayDateType.second)
        
        let item = QQSyncWidgetDateItem(year: year,
                                     month: month,
                                     day: day,
                                     week: week,
                                     hour: hour,
                                     minute: minute,
                                     second: second)
        return item
    }
    
    static func date2String(date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
}

```

新建`QQSyncWidgetDateShareItem.swift`，类似于 Util，把 model 转为 view 直接能显示的逻辑和响应点击的逻辑都可以放入这个类

``` Swift

import Foundation
import SwiftUI


class QQSyncWidgetDateShareItem: ObservableObject {
    
    @Published private var dateItem = QQSyncWidgetDateItem.generateItem()
    
    
    func dateShareStr() -> String {
        let resultStr = dateItem.month + "月 " + dateItem.week
        return resultStr
    }
    
    func dayStr() -> String {
        return dateItem.day
    }
    
    // MARK: action

}

```

然后修改`QQSyncDateShareView`类，添加`QQSyncWidgetDateShareItem`属性，固定的日期改为从`QQSyncWidgetDateShareItem`获取

``` Swift

import SwiftUI

struct QQSyncDateShareView: View {
    @ObservedObject var dateShareItem: QQSyncWidgetDateShareItem
    
    var body: some View {
        VStack {
            Spacer()
            Text(dateShareItem.dayStr())
                .font(.system(size: 50.0))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: -10.0, leading: 0.0, bottom: -10.0, trailing: 0.0))
            Text(dateShareItem.dateShareStr())
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .font(.system(size: 14.0))
                .foregroundColor(.white)
            Spacer()
            Text("去分享")
                .fixedSize()
                .font(.system(size: 14.0))
                .padding(EdgeInsets(top: 5.0, leading: 20.0, bottom: 5.0, trailing: 20.0))
                .background(.white)
                .foregroundColor(.black)
                .cornerRadius(12.0)
            Spacer()
        }
    }
}

```

然后修改有调用`QQSyncDateShareView`的地方，`QQSyncWidgetSmall`、`QQSyncWidgetMedium`中都添加属性声明代码，并且修改传入参数；然后修改有引用这两个类的地方即`QQSyncWidgetView`，也添加属性声明修改传入参数；最后再修改`DemoWidget`类中使用了`DemoWidgetEntryView`的地方，修改为如下：

``` Swift

struct DemoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        QQSyncWidgetView(dateShareItem: QQSyncWidgetDateShareItem())
    }
}

```

最后修改刷新时机，即何时刷新 widget 数据，是`TimeLineProvider`中的`getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ())`方法控制的，修改成每隔2个小时刷新。

``` Swift

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entry = SimpleEntry(date: Date())
        // refresh the data every two hours
        let expireDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(expireDate))
        completion(timeline)
    }

```

然后运行调试，修改日期，就会发现，widget 展示的日期数据随着手机日期的修改也跟着变了，done。

#### widget 网络数据逻辑

对比 QQ 同步助手的 Widget，可以发现，每隔一段时间，图片和文字就自动变化了一次。接下来一起看下这个效果怎么做，背景图片的变化和文字的变化类似都是网络请求，然后更新数据，这里就仅以文字的更新作为示例。

首先找一个随机名言的接口，可以参考https://github.com/vv314/quotes，这里选择里面一言的接口，接口为：https://v1.hitokoto.cn/。接口找好之后，来看下 widget 网络请求怎么实现。

新建 Network 文件夹，在 Network文件夹下新建`NetworkClient.swift`，用于封装`URLSession`网络请求，代码如下：

``` Swift

import Foundation

public final class NetworkClient {
    private let session: URLSession = .shared
    
    enum NetworkError: Error {
        case noData
    }
    
    func executeRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}

```

在 Network文件夹下新建`URLRequest+Quote.swift`，用于生成Quote 的 URLRequest，代码如下：

``` Swift

import Foundation

extension URLRequest {
    private static var baseURLStr: String { return "https://v1.hitokoto.cn/" }
    
    static func quoteFromNet() -> URLRequest {
        .init(url: URL(string: baseURLStr)!)
    }
}

```

然后参照返回数据格式，创建返回的 model 类，创建`QuoteResItem.swift`，返回数据中只用到了 hitokoto字段，所以只需要定义这个字段即可，代码如下：

``` Swift

import Foundation

struct QuoteResItem: Codable {
    /**
     "id": 6325,
     "uuid": "2017e206-f81b-48c1-93e3-53a63a9de199",
     "hitokoto": "自责要短暂，不过要长久铭记。",
     "type": "h",
     "from": "当你沉睡时",
     "from_who": null,
     "creator": "沈时筠",
     "creator_uid": 6568,
     "reviewer": 1,
     "commit_from": "web",
     "created_at": "1593237879",
     "length": 14
     */
    var hitokoto: String

    // 默认生成对象
    static func generateItem() -> QuoteResItem {
        let item = QuoteResItem(hitokoto: "所有快乐都向你靠拢，所有好运都在路上")
        return item
    }
}

```

再在在 Network文件夹下新建`QuoteService.swift`，定义外部调用的接口，内部封装请求逻辑，代码如下：

``` Swift

import Foundation

public struct QuoteService {
    static func getQuote(client: NetworkClient, completion: ((QuoteResItem) -> Void)?) {
        quoteRequest(.quoteFromNet(),
                     on: client,
                     completion: completion)
    }
    
    private static func quoteRequest(_ request: URLRequest,
                                     on client: NetworkClient,
                                     completion: ((QuoteResItem) -> Void)?) {
        client.executeRequest(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let quoteItem = try decoder.decode(QuoteResItem.self, from: data)
                    completion?(quoteItem)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

```

然后添加调用的入口，在添加调用之前，需要考虑下使用的场景，和日期相同，定义一个 Published修饰的属性，然后在使用的地方，使用定义@ObservedObject修饰的属性来监听变化。

创建`QQSyncWidgetQuoteShareItem.swift`，用于处理 Quote的数据，代码如下：

``` Swift

import Foundation

class QQSyncWidgetQuoteShareItem: ObservableObject {
    @Published private var quoteItem = QuoteResItem.generateItem()
    
    func quoteStr() -> String {
        return quoteItem.hitokoto
    }
    
    func updateQuoteItem(_ item: QuoteResItem) {
        self.quoteItem = item
    }
}

```

在`QQSyncQuoteTextView.swift`中添加属性，并修改使用，代码如下

``` Swift

import SwiftUI

struct QQSyncQuoteTextView: View {
    @ObservedObject var quoteShareItem: QQSyncWidgetQuoteShareItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(quoteShareItem.quoteStr())
                .font(.system(size: 19.0))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)

            Spacer()
            
            Text("加油，打工人！😄")
                .font(.system(size: 16.0))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
            Spacer()
        }
    }
}

```

然后修改`QQSyncWidgetMedium.swift`和`QQSyncWidgetView.swift`中的报错，和上面类似，添加`@ObservedObject var quoteShareItem: QQSyncWidgetQuoteShareItem`，修改传入参数。

最后再修改`DemoWidget.swift`
- 修改`SimpleEntry`，添加定义的`QQSyncWidgetQuoteShareItem`属性
- 修改`DemoWidgetEntryView`，添加传入参数`entry.quoteShareItem`
- 修改`Provider`
  - `placeholder(in context: Context) -> SimpleEntry`添加传入参数，使用默认值
  - `getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ())`添加传入参数，使用默认值
  - `getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ())`方法——添加网络请求的调用，用网络返回对象生成对应的`QQSyncWidgetQuoteShareItem`，传入参数使用生成的 item

代码如下：

``` Swift

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quoteShareItem: QQSyncWidgetQuoteShareItem())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), quoteShareItem: QQSyncWidgetQuoteShareItem())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        QuoteService.getQuote(client: NetworkClient()) { quoteResItem in
            let quoteShareItem = QQSyncWidgetQuoteShareItem()
            quoteShareItem.updateQuoteItem(quoteResItem)
            let entry = SimpleEntry(date: Date(), quoteShareItem: quoteShareItem)
            // refresh the data every two hours
            let expireDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
            let timeline = Timeline(entries: [entry], policy: .after(expireDate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    
    var quoteShareItem: QQSyncWidgetQuoteShareItem
}

struct DemoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        QQSyncWidgetView(dateShareItem: QQSyncWidgetDateShareItem(), quoteShareItem: entry.quoteShareItem)
    }
}

```

调试查看效果，可以看到显示的文案已经改变，说明已经使用了网络返回的数据；还可以测试一下 widget 刷新的时机，上面的代码中设置了每隔两个小时刷新一下，所以可以把手机时间调后两个小时，然后再来查看下 widget 效果，可以发现文字发生了改变，说明刷新了数据，赞，完成。


最终完整效果如下：

![最终效果](https://raw.githubusercontent.com/mokong/BlogImages/main/img/RPReplay_Final1654600687.gif)

完整代码已放在：[Github](https://github.com/mokong/WidgetAllInOne)中 `Tutorial2-QQ 同步助手 widget`，链接：https://github.com/mokong/WidgetAllInOne


下一篇， 会先讲 WidgetGroup 的使用，然后再讲怎么实现一个支付宝 Widget效果。


## 参考

- [cs193p-Developing Apps for iOS](https://cs193p.sites.stanford.edu/)
- [Environment](https://developer.apple.com/documentation/swiftui/environment)
- [What is the @Environment property wrapper?](https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-environment-property-wrapper)
- [App之间的数据共享——App Group的配置](https://www.jianshu.com/p/94d4106b9298)
- [Making a Configurable Widget](https://developer.apple.com/documentation/widgetkit/making-a-configurable-widget)
- [Create a Tube Status home-screen Widget for iOS 14](https://www.oliverbinns.co.uk/2020/06/27/create-a-tube-status-home-screen-widget-for-ios-14/)
- [Reorderable intent configuration widget iOS](https://stackoverflow.com/questions/65558991/reorderable-intent-configuration-widget-ios)

