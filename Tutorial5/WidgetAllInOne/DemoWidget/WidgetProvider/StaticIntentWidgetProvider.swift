//
//  StaticIntentWidgetProvider.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 26/09/2022.
//

import Foundation
import WidgetKit
import SwiftUI

struct StaticIntentWidgetProvider: IntentTimelineProvider {
    
    typealias Entry = StaticIntentWidgetEntry
    typealias Intent = StaticConfigurationIntent
    
    // 将Intent中定义的按钮类型转为Widget中的按钮类型使用
    func buttonType(from configuration: Intent) -> ButtonType {
        switch configuration.btnType {
        case .scan:
            return .scan
        case .pay:
            return .pay
        case .healthCode:
            return .healthCode
        case .travelCode:
            return .travelCode
        case .trip:
            return .trip
        case .stuck:
            return .stuck
        case .memberpoints:
            return .memberpoints
        case .yuebao:
            return .yuebao
        case .unknown:
            return .unknown
        }
    }
    
    func placeholder(in context: Context) -> StaticIntentWidgetEntry {
        StaticIntentWidgetEntry(date: Date())
    }
    
    func getSnapshot(for configuration: StaticConfigurationIntent, in context: Context, completion: @escaping (StaticIntentWidgetEntry) -> Void) {
        let buttonType = buttonType(from: configuration)
        
        let entry = StaticIntentWidgetEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(for configuration: StaticConfigurationIntent, in context: Context, completion: @escaping (Timeline<StaticIntentWidgetEntry>) -> Void) {
        let entry = StaticIntentWidgetEntry(date: Date())
        // refresh the data every two hours
        let expireDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(expireDate))
        completion(timeline)
    }
}

struct StaticIntentWidgetEntry: TimelineEntry {
    let date: Date
    
}

struct StaticIntentWidgetEntryView: View {
    var entry: StaticIntentWidgetProvider.Entry
    let mediumItem = AliPayWidgetMediumItem()
    
    var body: some View {
        AlipayWidgetMeidumView(mediumItem: mediumItem)
    }
}

struct StaticIntentWidget: Widget {

    let kind: String = "StaticIntentWidget"
    
    var title: String = "StaticIntentWidget"
    var desc: String = "StaticIntentWidget描述"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: StaticConfigurationIntent.self,
                            provider: StaticIntentWidgetProvider()) { entry in
            StaticIntentWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(title)
        .description(desc)
        .supportedFamilies([.systemMedium])
    }
}
