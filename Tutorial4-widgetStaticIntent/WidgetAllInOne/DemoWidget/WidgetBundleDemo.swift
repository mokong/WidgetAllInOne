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
        StaticIntentWidget()
    }
}
