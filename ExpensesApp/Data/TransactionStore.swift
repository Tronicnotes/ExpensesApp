//
//  TransactionStore.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

class TransactionStore: ObservableObject {
    typealias GroupedTransactions = [Date: [Transaction]]
    @Published var transactions: [Transaction] = [] {
        didSet {
            groupTransactions()
        }
    }
    @Published var groupedTransactions: GroupedTransactions = [:]
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
