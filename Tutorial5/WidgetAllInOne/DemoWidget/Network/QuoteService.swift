//
//  QuoteService.swift
//  DemoWidgetExtension
//
//  Created by Horizon on 07/06/2022.
//

import Foundation

public struct QuoteService {
    static func getQuote(client: NetworkClient, completion: ((QuoteResItem) -> Void)?) {
        quoteRequest(.quoteFromNet(),
                     on: client,
                     completion: completion)
    }
    
    private static func quoteRequest(_ request: URLRequest,
                                     on client: NetworkClient,
                                     completion: ((QuoteResItem) -> Void)?) {
        client.executeRequest(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let quoteItem = try decoder.decode(QuoteResItem.self, from: data)
                    completion?(quoteItem)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
