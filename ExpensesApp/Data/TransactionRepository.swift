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
            Transaction(title: "Countdown", category: Category(name: "Groceries", imageAsset: "bag", color: .red), amountNZD: 300, date: Date()),
            Transaction(title: "Timberland", category: Category(name: "Shopping", imageAsset: "bag", color: .green), amountNZD: 175, date: Date()),
            Transaction(title: "Sal's Pizza", category: Category(name: "Food", imageAsset: "bag", color: .red), amountNZD: 300, date: Date())
        ]
        return Just(transactions)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
