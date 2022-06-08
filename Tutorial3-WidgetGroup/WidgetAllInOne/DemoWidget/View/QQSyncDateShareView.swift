//
//  QQSyncDateShareView.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 06/06/2022.
//

import SwiftUI

struct QQSyncDateShareView: View {
    @ObservedObject var dateShareItem: QQSyncWidgetDateShareItem
    
    var body: some View {
        VStack {
            Spacer()
            Text(dateShareItem.dayStr())
                .font(.system(size: 50.0))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(EdgeInsets(top: -10.0, leading: 0.0, bottom: -10.0, trailing: 0.0))
            Text(dateShareItem.dateShareStr())
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .font(.system(size: 14.0))
                .foregroundColor(.white)
            Spacer()
            Text("去分享")
                .fixedSize()
                .font(.system(size: 14.0))
                .padding(EdgeInsets(top: 5.0, leading: 20.0, bottom: 5.0, trailing: 20.0))
                .background(.white)
                .foregroundColor(.black)
                .cornerRadius(12.0)
            Spacer()
        }
    }
}

