//
//  AlipayWidgetButtonItem.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 13/06/2022.
//

import Foundation

public enum ButtonType: String {
    case Scan = "扫一扫"
    case pay = "收付款"
    case healthCode = "健康码"
    case travelCode = "行程卡"
    case trip = "出行"
    case stuck = "卡包"
    case memberpoints = "会员积分"
    case yuebao = "余额宝"
}

extension ButtonType: Identifiable {
    public var id: String {
        return rawValue
    }
    
    public var displayName: String {
        return rawValue
    }
    
    public var urlStr: String {
        let imageUrl: (image: String, url: String) = imageAndUrl(from: self)
        return imageUrl.url
    }
    
    public var imageName: String {
        let imageUrl: (image: String, url: String) = imageAndUrl(from: self)
        return imageUrl.image
    }
    
    /// return (image, url)
    func imageAndUrl(from type: ButtonType) -> (String, String) {
        switch self {
        case .Scan:
            return ("widget_scan", "https://www.baidu.com/")
        case .pay:
            return ("widget_pay", "https://www.baidu.com/")
        case .healthCode:
            return ("widget_healthCode", "https://www.baidu.com/")
        case .travelCode:
            return ("widget_travelCode", "https://www.baidu.com/")
        case .trip:
            return ("widget_trip", "https://www.baidu.com/")
        case .stuck:
            return ("widget_stuck", "https://www.baidu.com/")
        case .memberpoints:
            return ("widget_memberpoints", "https://www.baidu.com/")
        case .yuebao:
            return ("widget_yuebao", "https://www.baidu.com/")
        }
    }
}

struct AlipayWidgetButtonItem {
    var title: String
    var imageName: String
    var urlStr: String
    var id: String {
        return title
    }
    
    static func generateWidgetBtnItem(from originalItem: AlipayWidgetButtonItem) -> AlipayWidgetButtonItem {
        let newItem = AlipayWidgetButtonItem(title: originalItem.title,
                                             imageName: originalItem.imageName,
                                             urlStr: originalItem.urlStr)
        return newItem
    }
}
