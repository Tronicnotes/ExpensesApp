//
//  TransactionRepository.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import Combine

protocol TransactionSource: LocalSource {
    func getTransactions() -> AnyPublisher<[Transaction], Error>
    func saveTransactions(_ transactions: [Transaction]) -> AnyPublisher<Void, Error>
    func fetchConversionRates(for date: Date) -> AnyPublisher<CurrencyConversionRates, Error>

}

struct TransactionRepository: TransactionSource {

    private let networkingService: TransactionNetworkSource

    init(networkingService: TransactionNetworkSource = TransactionNetworkService()) {
        self.networkingService = networkingService
    }

    func getTransactions() -> AnyPublisher<[Transaction], Error> {
        return self.readLocalData() as AnyPublisher<[Transaction], Error>
    }

    func saveTransactions(_ transactions: [Transaction]) -> AnyPublisher<Void, Error> {
        return self.saveLocalData(transactions)
    }

    func fetchConversionRates(for date: Date) -> AnyPublisher<CurrencyConversionRates, Error> {
        return self.networkingService.fetchConversionRates(for: date)
    }
}

extension TransactionRepository {
    static var filePathComponent: String {
        return "transaction.data"
    }
}
