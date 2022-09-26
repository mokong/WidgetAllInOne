//
//  AlipayWidgetWeatherDateView.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 09/06/2022.
//

import SwiftUI

struct AlipayWidgetWeatherDateView: View {    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            Text("多云 28℃")
                .font(.title)
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 4.0, trailing: 0.0))

            Text("06/09 周四 上海市")
                .lineLimit(1)
                .font(.body)
                .foregroundColor(.white)
                .minimumScaleFactor(0.5)
                .padding(EdgeInsets(top: 0.0, leading: 0.0, bottom: 4.0, trailing: 0.0))

            AlipayWidgetLunarView()

            Spacer()
        }
    }
}
