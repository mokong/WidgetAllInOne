//
//  AlipayWidgetMeidumView.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 13/06/2022.
//

import SwiftUI

struct AlipayWidgetMeidumView: View {
    @ObservedObject var mediumItem: AliPayWidgetMediumItem

    var body: some View {
        ZStack {
            // 背景图片
            Image("widget_background_test")
                .resizable()
            HStack {
                AlipayWidgetWeatherDateView()
                
                Spacer()
                
                AlipayWidgetGroupButtons(buttonList: mediumItem.dataButtonList())
            }
            .padding()
        }
    }
}
