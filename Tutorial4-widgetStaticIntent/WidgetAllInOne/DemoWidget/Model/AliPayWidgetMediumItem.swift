//
//  AliPayWidgetMediumItem.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 08/09/2022.
//

import Foundation

class AliPayWidgetMediumItem: ObservableObject {
    @Published private var groupButtons: [[AlipayWidgetButtonItem]] = [[]]
    
    init() {
        self.groupButtons = AliPayWidgetMediumItem.createMeidumWidgetGroupButtons()
    }
    
    init(with widgetGroupButtons: [AlipayWidgetButtonItem]?) {
        guard let items = widgetGroupButtons else {
            self.groupButtons = AliPayWidgetMediumItem.createMeidumWidgetGroupButtons()
            return
        }
        
        var list: [[AlipayWidgetButtonItem]] = [[]]
        var rowList: [AlipayWidgetButtonItem] = []
        for i in 0..<items.count {
            let originalItem = items[i]
            let newItem = AlipayWidgetButtonItem.generateWidgetBtnItem(from: originalItem)
            if i != 0 && i % 2 == 0 {
                list.append(rowList)
                rowList = []
            }
            rowList.append(newItem)
        }
        
        if rowList.count > 0 {
            list.append(rowList)
        }
        self.groupButtons = list
    }
    
    private static func createMeidumWidgetGroupButtons() -> [[AlipayWidgetButtonItem]] {
        let scanType = ButtonType.scan
        let scanItem = AlipayWidgetButtonItem(title: scanType.rawValue,
                                              imageName: scanType.imageName,
                                              urlStr: scanType.urlStr)
        
        let payType = ButtonType.pay
        let payItem = AlipayWidgetButtonItem(title: payType.rawValue,
                                             imageName: payType.imageName,
                                             urlStr: payType.urlStr)
        
        let healthCodeType = ButtonType.healthCode
        let healthCodeItem = AlipayWidgetButtonItem(title: healthCodeType.rawValue,
                                                    imageName: healthCodeType.imageName,
                                                    urlStr: healthCodeType.urlStr)

        let travelCodeType = ButtonType.travelCode
        let travelCodeItem = AlipayWidgetButtonItem(title: travelCodeType.rawValue,
                                                    imageName: travelCodeType.imageName,
                                                    urlStr: travelCodeType.urlStr)
        return [[scanItem, payItem], [healthCodeItem, travelCodeItem]]
    }
    
    func dataButtonList() -> [[AlipayWidgetButtonItem]] {
        return groupButtons
    }
}
