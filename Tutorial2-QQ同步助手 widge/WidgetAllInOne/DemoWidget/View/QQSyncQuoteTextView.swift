//
//  QQSyncQuoteTextView.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 06/06/2022.
//

import SwiftUI

struct QQSyncQuoteTextView: View {
    @ObservedObject var quoteShareItem: QQSyncWidgetQuoteShareItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(quoteShareItem.quoteStr())
                .font(.system(size: 19.0))
                .fontWeight(.semibold)
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)

            Spacer()
            
            Text("加油，打工人！😄")
                .font(.system(size: 16.0))
                .minimumScaleFactor(0.5)
                .foregroundColor(.white)
            Spacer()
        }
    }
}
