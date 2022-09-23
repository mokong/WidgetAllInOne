//
//  StaticAlipayTimelineProvider.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 23/09/2022.
//

import Foundation
import SwiftUI
import WidgetKit

struct StaticAlipayTimelineProvider: IntentTimelineProvider {
    typealias Entry = AlipayWidgetEntry
    
    typealias Intent = FuncSelectIntent
    
    // 将Intent中定义的枚举和Widget工程中定义的枚举对应起来
    // 这两个定义的名字不能相同，否则会提示重复定义错误
    func buttonType(from configuration: Intent) -> ButtonType {
        switch configuration.btnType {
        case .unknown:
            return ButtonType.unknown
        case .scan:
            return ButtonType.scan
        case .pay:
            return ButtonType.pay
        case .healthCode:
            return ButtonType.healthCode
        case .travelCode:
            return ButtonType.travelCode
        case .trip:
            return ButtonType.trip
        case .stuck:
            return ButtonType.stuck
        case .memberpoints:
            return ButtonType.memberpoints
        case .yuebao:
            return ButtonType.yuebao
        }
    }
        
    func placeholder(in context: Context) -> Entry {
        AlipayWidgetEntry(date: Date())
    }
    
    func getSnapshot(for configuration: Intent, in context: Context, completion: @escaping (Entry) -> Void) {
        let buttonType = buttonType(from: configuration)
        let entry = AlipayWidgetEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(for configuration: Intent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = AlipayWidgetEntry(date: Date())
        // refresh the data every two hours
        let expireDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
        let timeline = Timeline(entries: [entry], policy: .after(expireDate))
        completion(timeline)
    }
}

struct AlipayStaticIntentWidget: Widget {
    let kind: String = "AlipayStaticIntentWidget"
    
    var title: String = "支付宝StaticIntent"
    var desc: String = "支付宝StaticIntent描述"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: "AlipayStaticIntentWidget",
                            intent: FuncSelectIntent.self,
                            provider: StaticAlipayTimelineProvider()) { entry in
            AlipayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(title)
        .description(desc)
        .supportedFamilies([.systemMedium])
    }
}
