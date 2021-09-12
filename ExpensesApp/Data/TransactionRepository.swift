//
//  TransactionRepository.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import Combine

protocol TransactionSource {
    func getTransactions() -> AnyPublisher<[Transaction], Error>
}

struct TransactionRepository: TransactionSource {
    func getTransactions() -> AnyPublisher<[Transaction], Error> {
        let transactions = [
            Transaction(title: "Countdown", category: .groceries, amountNZD: 300, date: Date()),
            Transaction(title: "Timberland", category: .shopping, amountNZD: 175, date: Date()),
            Transaction(title: "Sal's Pizza", category: .food, amountNZD: 300, date: Date())
        ]
        return Just(transactions)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
