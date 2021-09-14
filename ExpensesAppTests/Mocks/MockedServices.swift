//
//  MockedServices.swift
//  ExpensesAppTests
//
//  Created by Kurt Mohring on 14/09/21.
//

import Foundation
import Combine
@testable import ExpensesApp

class MockedUserRepository: UserSource {
    func getUser() -> AnyPublisher<User, Error> {
        return Just(User(from: User.Data()))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func saveUser(_ user: User) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    static var filePathComponent: String {
        return "mockedPath"
    }
}

class MockedTransactionRepository: TransactionSource {
    func getTransactions() -> AnyPublisher<[Transaction], Error> {
        return Just([Transaction(from: Transaction.Data())])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func saveTransactions(_ transactions: [Transaction]) -> AnyPublisher<Void, Error> {
        return Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchConversionRates(for date: Date) -> AnyPublisher<CurrencyConversionRates, Error> {
        return Just(CurrencyConversionRates(quotes: ["USDNZD": 30]))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    static var filePathComponent: String { return "mockedPath" }
}
