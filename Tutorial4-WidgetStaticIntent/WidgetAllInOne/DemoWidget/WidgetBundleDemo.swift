//
//  WidgetBundleDemo.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 08/06/2022.
//

import SwiftUI
import WidgetKit

@main
struct WidgetBundleDemo: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        DemoWidget(title: "同步助手", desc: "这是QQ同步助手Widget")
        AlipayWidget(title: "支付宝", desc: "这是支付宝Widget")
        AlipayStaticIntentWidget(title: "支付宝StaticIntent", desc: "这是支付宝StaticIntent")
    }
}
