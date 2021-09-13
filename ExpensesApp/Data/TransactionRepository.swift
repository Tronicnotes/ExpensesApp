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
    func saveTransactions(_ transactions: [Transaction]) -> AnyPublisher<Bool, Error>
}

struct TransactionRepository: TransactionSource {

    static var filePathComponent: String {
        return "transaction.data"
    }

    func getTransactions() -> AnyPublisher<[Transaction], Error> {
        return self.readLocalData() as AnyPublisher<[Transaction], Error>
    }

    func saveTransactions(_ transactions: [Transaction]) -> AnyPublisher<Bool, Error> {
        return self.saveLocalData(transactions) as AnyPublisher<Bool, Error>
    }
}
