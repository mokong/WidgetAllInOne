//
//  DynamicIntentWidgetProvider.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 26/09/2022.
//


import Foundation
import WidgetKit
import SwiftUI

struct DynamicIntentWidgetProvider: IntentTimelineProvider {
    typealias Entry = DynamicIntentWidgetEntry
    typealias Intent = DynamicConfigurationIntent

    func placeholder(in context: Context) -> DynamicIntentWidgetEntry {
        DynamicIntentWidgetEntry(date: Date())
    }
    
    func getSnapshot(for configuration: DynamicConfigurationIntent, in context: Context, completion: @escaping (DynamicIntentWidgetEntry) -> Void) {
        let entry = DynamicIntentWidgetEntry(date: Date(), groupBtns: configuration.selectButtons)
        completion(entry)
    }
    
    func getTimeline(for configuration: DynamicConfigurationIntent, in context: Context, completion: @escaping (Timeline<DynamicIntentWidgetEntry>) -> Void) {
        let entry = DynamicIntentWidgetEntry(date: Date(), groupBtns: configuration.selectButtons)
        let expireDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(expireDate))
        completion(timeline)
    }
}


struct DynamicIntentWidgetEntry: TimelineEntry {
    let date: Date
    var groupBtns: [CustomButtonItem]?
}

struct DynamicIntentWidgetEntryView: View {
    var entry: DynamicIntentWidgetProvider.Entry
    
    var body: some View {
        AlipayWidgetMeidumView(mediumItem: AliPayWidgetMediumItem(with: entry.groupBtns))
    }
}

struct DynamicIntentWidget: Widget {

    let kind: String = "DynamicIntentWidget"
    
    var title: String = "DynamicIntentWidget"
    var desc: String = "快捷功能直达，且新增了自定义场景展示"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind,
                            intent: DynamicConfigurationIntent.self,
                            provider: DynamicIntentWidgetProvider()) { entry in
            DynamicIntentWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(title)
        .description(desc)
        .supportedFamilies([.systemMedium])
    }
}

