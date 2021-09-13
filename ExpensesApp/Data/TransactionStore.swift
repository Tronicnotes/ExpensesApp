//
//  TransactionStore.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import Combine

class TransactionStore: ObservableObject {
    typealias GroupedTransactions = [Date: [Transaction]]
    @Published var transactions: [Transaction] = [] {
        didSet {
            groupTransactions()
        }
    }
    @Published var groupedTransactions: GroupedTransactions = [:]

    private let repository: TransactionSource
    private var cancellable: AnyCancellable?

    // MARK: - Initialiser
    init(repository: TransactionSource = TransactionRepository()) {
        self.repository = repository
        fetchTransactions()
    }

    // MARK: - Public Methods
    func fetchTransactions() {
        cancellable = repository.getTransactions()
            .sink {
                if case let .failure(error) = $0 {
                    print(error)
                }
            } receiveValue: { [weak self] transactions in
                self?.transactions = transactions
            }
    }

    func saveTransactions() {
        cancellable = repository.saveTransactions(transactions)
            .sink {
                if case let .failure(error) = $0 {
                    print(error)
                }
            } receiveValue: { _ in
                print("Successfully saved transactions")
            }
    }
}

// MARK: - Private Methods
private extension TransactionStore {
    func groupTransactions() {
        groupedTransactions = Dictionary(grouping: transactions) { transaction -> Date in
            let components = Calendar.current.dateComponents([.day, .year, .month], from: transaction.date)
            return Calendar.current.date(from: components) ?? transaction.date
        }
    }
}
