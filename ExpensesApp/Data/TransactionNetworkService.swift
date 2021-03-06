//
//  TransactionNetworkService.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 13/09/21.
//

import Foundation
import Combine

protocol TransactionNetworkSource: NetworkSource {
    func fetchConversionRates(for date: Date) -> AnyPublisher<CurrencyConversionRates, Error>
}

struct TransactionNetworkService: TransactionNetworkSource {
    private let endpoint: Endpoint
    private let getConversionRatePath = "/historical"

    init(endpoint: Endpoint = Endpoint()) {
        self.endpoint = endpoint
    }

    func fetchConversionRates(for date: Date) -> AnyPublisher<CurrencyConversionRates, Error> {
        let request = self.createRequest(from: endpoint.currencyEndpoint + getConversionRatePath,
                                         queryParamenters: [
                                            "access_key": endpoint.apiKey,
                                            "date": date.YYYYMMDD(),
                                            "currencies": "NZD",
                                            "format": "1"
                                         ])
        return self.execute(request, decodingType: CurrencyConversionRates.self)
    }
}
