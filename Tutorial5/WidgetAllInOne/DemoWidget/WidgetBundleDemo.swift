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
        DynamicIntentWidget()
    }
}
