//
//  QQSyncWidgetMedium.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 06/06/2022.
//

import SwiftUI

struct QQSyncWidgetMedium: View {
    @ObservedObject var dateShareItem: QQSyncWidgetDateShareItem
    @ObservedObject var quoteShareItem: QQSyncWidgetQuoteShareItem
    
    var body: some View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()

            // 左右两个 View
            HStack {
                // 左 View
                QQSyncQuoteTextView(quoteShareItem: quoteShareItem)
                
                Spacer()
                
                // 右 View
                QQSyncDateShareView(dateShareItem: dateShareItem)
            }
            .padding(EdgeInsets(top: 0.0, leading: 20.0, bottom: 0.0, trailing: 20.0))
        }
    }
}
