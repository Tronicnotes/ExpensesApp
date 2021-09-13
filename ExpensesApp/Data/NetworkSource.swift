//
//  NetworkSource.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 13/09/21.
//

import Foundation
import Combine

struct Endpoint {
    // FIXME: - Don't store this locally for Production, use CI/CD pipeline to inject this.
    let apiKey = "80a4fb9217efd8c78b82271c5d868334"
    let currencyEndpoint = "http://api.currencylayer.com"
}

protocol NetworkSource {
    func createRequest(from url: String, queryParamenters: [String: String]) -> URLRequest
    func execute<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, Error>
}

extension NetworkSource {
    func createRequest(from url: String, queryParamenters: [String: String]) -> URLRequest {
        var urlComponents = URLComponents(string: url)!
        urlComponents.queryItems = queryParamenters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return URLRequest(url: urlComponents.url!)
    }

    func execute<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap {
                return $0.data
            }
            .decode(type: decodingType, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
