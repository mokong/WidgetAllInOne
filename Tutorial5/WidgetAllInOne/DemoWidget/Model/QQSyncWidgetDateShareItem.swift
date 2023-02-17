//
//  QQSyncWidgetDateShareItem.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 07/06/2022.
//

import Foundation
import SwiftUI


class QQSyncWidgetDateShareItem: ObservableObject {
    
    @Published private var dateItem = QQSyncWidgetDateItem.generateItem()
    
    func dateShareStr() -> String {
        let resultStr = dateItem.month + "月 " + dateItem.week
        return resultStr
    }
    
    func dayStr() -> String {
        return dateItem.day
    }
 
    
    // MARK: action

}

