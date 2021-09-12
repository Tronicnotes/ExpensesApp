//
//  TransactionStore.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import Combine

class TransactionStore: ObservableObject {
    @Published var transactions: [Transaction] = []

    private let repository: TransactionSource
    private var cancellable: AnyCancellable?

    init(repository: TransactionSource = TransactionRepository()) {
        self.repository = repository
        fetchTransactions()
    }

    func fetchTransactions() {
        cancellable = repository.getTransactions().sink {
            if case let .failure(error) = $0 {
                print(error)
            }
        } receiveValue: { transactions in
            self.transactions = transactions
        }
    }
}
