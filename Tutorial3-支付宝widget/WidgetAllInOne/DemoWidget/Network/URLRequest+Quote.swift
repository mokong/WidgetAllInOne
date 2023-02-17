//
//  URLRequest+Quote.swift
//  DemoWidgetExtension
//
//  Created by MorganWang on 07/06/2022.
//

import Foundation

extension URLRequest {
    private static var baseURLStr: String { return "https://v1.hitokoto.cn/" }
    
    static func quoteFromNet() -> URLRequest {
        .init(url: URL(string: baseURLStr)!)
    }
}
