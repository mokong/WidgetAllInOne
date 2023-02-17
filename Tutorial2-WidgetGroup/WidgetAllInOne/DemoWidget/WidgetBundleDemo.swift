//
//  WidgetBundleDemo.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 08/06/2022.
//

import SwiftUI
import WidgetKit

@main
struct WidgetBundleDemo: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        DemoWidget(title: "同步助手", desc: "这是QQ同步助手Widget")
        DemoWidget(title: "支付宝", desc: "这是支付宝Widget")
    }
}
