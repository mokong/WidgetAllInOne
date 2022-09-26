//
//  QQSyncWidgetView.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 01/06/2022.
//

import SwiftUI
import WidgetKit

struct QQSyncWidgetView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    @ObservedObject var dateShareItem: QQSyncWidgetDateShareItem
    @ObservedObject var quoteShareItem: QQSyncWidgetQuoteShareItem

    var body: some View {
        switch family {
        case .systemSmall:
            QQSyncWidgetSmall(dateShareItem: dateShareItem)
        case .systemMedium:
            QQSyncWidgetMedium(dateShareItem: dateShareItem, quoteShareItem: quoteShareItem)
//            case .systemLarge:
//                break
//            case .systemExtraLarge:
//                break
        default:
            QQSyncWidgetMedium(dateShareItem: dateShareItem, quoteShareItem: quoteShareItem)
        }
    }
}
