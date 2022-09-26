//
//  QQSyncWidgetQuoteShareItem.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 07/06/2022.
//

import Foundation

class QQSyncWidgetQuoteShareItem: ObservableObject {
    @Published private var quoteItem = QuoteResItem.generateItem()
    
    func quoteStr() -> String {
        return quoteItem.hitokoto
    }
    
    func updateQuoteItem(_ item: QuoteResItem) {
        self.quoteItem = item
    }
}
