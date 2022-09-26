//
//  QQSyncWidgetSmall.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 06/06/2022.
//

import SwiftUI

struct QQSyncWidgetSmall: View {
    @ObservedObject var dateShareItem: QQSyncWidgetDateShareItem

    var body: some View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()
            
            QQSyncDateShareView(dateShareItem: dateShareItem)
        }
    }
}
