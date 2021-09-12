//
//  DashboardViewModel.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import Combine

enum BudgetFrequency {
    case fornightly, monthly, weekly

    var label: String {
        switch self {
        case .fornightly:
            return "Fortnightly"
        case .monthly:
            return "Monthly"
        case .weekly:
            return "Weekly"
        }
    }
}

class DashboardViewModel: ObservableObject {
    @Published var profileName: String = "Kurt"
    @Published var currentBudgetRemaining: String = "$1,340.33"
    @Published var budgetFrequency: BudgetFrequency = .monthly
    @Published var transactions: [Transaction] = []

    private let repository: TransactionSource
    private var cancellable: AnyCancellable?

    init(repository: TransactionSource = TransactionRepository()) {
        self.repository = repository
        onStart()
    }

    func onStart() {
        fetchTransactions()
    }
}

private extension DashboardViewModel {
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
