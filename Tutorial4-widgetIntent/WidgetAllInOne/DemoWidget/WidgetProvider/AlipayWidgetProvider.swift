//
//  AlipayWidgetProvider.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 09/06/2022.
//

import WidgetKit
import SwiftUI

struct AlipayWidgetProvider: TimelineProvider {
    typealias Entry = AlipayWidgetEntry
    
    func placeholder(in context: Context) -> AlipayWidgetEntry {
        AlipayWidgetEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (AlipayWidgetEntry) -> Void) {
        let entry = AlipayWidgetEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<AlipayWidgetEntry>) -> Void) {
        let entry = AlipayWidgetEntry(date: Date())
        // refresh the data every two hours
        let expireDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(expireDate))
        completion(timeline)
    }
}

struct AlipayWidgetEntry: TimelineEntry {
    let date: Date
    
    
}

struct AlipayWidgetEntryView: View {
    var entry: AlipayWidgetProvider.Entry
    let mediumItem = AliPayWidgetMediumItem()
    
    var body: some View {
        AlipayWidgetMeidumView(mediumItem: mediumItem)
    }
}

struct AlipayWidget: Widget {
    let kind: String = "AlipayWidget"
    
    var title: String = "支付宝Widget"
    var desc: String = "支付宝Widget描述"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: AlipayWidgetProvider()) { entry in
            AlipayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(title)
        .description(desc)
        .supportedFamilies([.systemMedium])
    }
}
