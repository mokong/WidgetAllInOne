//
//  AlipayWidgetButton.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 13/06/2022.
//

import SwiftUI

struct AlipayWidgetButton: View {
    var buttonItem: AlipayWidgetButtonItem
    let btnWH: CGFloat = 60.0
    let imageWH: CGFloat = 24.0
    
    var body: some View {
        Link(destination: URL(string: buttonItem.urlStr)!) {
            ZStack {
                Color.white
                    .frame(width: btnWH, height: btnWH)
//                    .background(.white)
                    .opacity(0.1)
                    .cornerRadius(8.0)
                
                VStack {
                    Image(buttonItem.imageName)
                        .resizable()
                        .frame(width: imageWH, height: imageWH, alignment: .center)
                    Text(buttonItem.title)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(.system(size: 12.0))
                        .foregroundColor(.white)
                }
            }
        }
    }
}
