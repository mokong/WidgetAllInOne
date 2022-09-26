//
//  IntentHandler.swift
//  WidgetIntentExtension
//
//  Created by Horizon on 26/09/2022.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: DynamicConfigurationIntentHandling {
    func provideSelectButtonsOptionsCollection(for intent: DynamicConfigurationIntent, searchTerm: String?, with completion: @escaping (INObjectCollection<CustomButtonItem>?, Error?) -> Void) {
        let typeList: [ConfigrationButtonType] = [.scan, .pay, .healthCode, .trip, .travelCode, .stuck, .memberpoints, .yuebao]
        let itemList = generateItemList(from: typeList)
        completion(INObjectCollection(items: itemList), nil)
    }
    
    func defaultSelectButtons(for intent: DynamicConfigurationIntent) -> [CustomButtonItem]? {
        let defaultBtnTypeList: [ConfigrationButtonType] = [.scan, .pay, .healthCode, .trip]
        let defaultItemList = generateItemList(from: defaultBtnTypeList)
        return defaultItemList
    }
    
    fileprivate func generateItemList(from typeList: [ConfigrationButtonType]) -> [CustomButtonItem] {
        let defaultItemList = typeList.map({
            let formatBtnType = buttonType(from: $0)
            let item = CustomButtonItem(identifier: formatBtnType.id,
                                        display: formatBtnType.displayName)
            item.buttonType = $0
            item.urlStr = formatBtnType.urlStr
            item.imageName = formatBtnType.imageName
            return item
        })
        return defaultItemList
    }
    
    // 将Intent中定义的按钮类型转为Widget中的按钮类型使用
    func buttonType(from configurationType: ConfigrationButtonType) -> ButtonType {
        switch configurationType {
        case .scan:
            return .scan
        case .pay:
            return .pay
        case .healthCode:
            return .healthCode
        case .travelCode:
            return .travelCode
        case .trip:
            return .trip
        case .stuck:
            return .stuck
        case .memberpoints:
            return .memberpoints
        case .yuebao:
            return .yuebao
        case .unknown:
            return .unknown
        }
    }
}
