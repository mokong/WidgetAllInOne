//
//  AlipayWidgetLunarView.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 09/06/2022.
//

import SwiftUI

struct AlipayWidgetLunarView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            
            ZStack {
                AliPayLunarSubview()
                    .hidden()
            }
            .background(.white)
            .opacity(0.27)
            .cornerRadius(2.0)
            
            AliPayLunarSubview()
        }
    }
}

struct AliPayLunarSubview: View {
    var body: some View {
        HStack {
            Image("alipay")
                .resizable()
                .frame(width: 16.0, height: 16.0)
                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))

            Text("支付宝")
                .font(Font.custom("Montserrat-Bold", size: 13.0))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 4.0, leading: -7.0, bottom: 4.0, trailing: 0.0))

            Text("今日宜")
                .font(Font.system(size: 10.0))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: 0.0, leading: -5.0, bottom: 0.0, trailing: 0.0))

            Image("right_Arrow")
                .resizable()
                .frame(width: 10, height: 10)
                .padding(EdgeInsets(top: 0.0, leading: -7.0, bottom: 0.0, trailing: 5.0))
        }
    }
}
