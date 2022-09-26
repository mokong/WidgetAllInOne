//
//  AlipayWidgetGroupButtons.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 13/06/2022.
//

import SwiftUI

struct AlipayWidgetGroupButtons: View {
    var buttonList: [[AlipayWidgetButtonItem]]
    
    var body: some View {
        VStack() {
            ForEach(0..<buttonList.count, id: \.self) { index in
                HStack {
                    ForEach(buttonList[index], id: \.id) { buttonItem in
                        AlipayWidgetButton(buttonItem: buttonItem)
                    }
                }
            }
        }
    }
}
