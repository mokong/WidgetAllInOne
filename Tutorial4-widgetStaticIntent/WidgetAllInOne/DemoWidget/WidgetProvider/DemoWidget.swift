//
//  DemoWidget.swift
//  DemoWidget
//
//  Created by MorganWang on 10/05/2022.
//

import WidgetKit
import SwiftUI

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

struct DemoWidget: Widget {
    let kind: String = "DemoWidget"

    var title: String = "My Widget"
    var desc: String = "This is an example widget."
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DemoWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(title)
        .description(desc)
        .supportedFamilies([WidgetFamily.systemMedium])
    }
}
