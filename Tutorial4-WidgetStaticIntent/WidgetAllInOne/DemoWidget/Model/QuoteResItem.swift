//
//  QuoteResItem.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 07/06/2022.
//

import Foundation

struct QuoteResItem: Codable {
    /**
     "id": 6325,
     "uuid": "2017e206-f81b-48c1-93e3-53a63a9de199",
     "hitokoto": "自责要短暂，不过要长久铭记。",
     "type": "h",
     "from": "当你沉睡时",
     "from_who": null,
     "creator": "沈时筠",
     "creator_uid": 6568,
     "reviewer": 1,
     "commit_from": "web",
     "created_at": "1593237879",
     "length": 14
     */
    var hitokoto: String
    
    static func generateItem() -> QuoteResItem {
        let item = QuoteResItem(hitokoto: "所有快乐都向你靠拢，所有好运都在路上")
        return item
    }
}
