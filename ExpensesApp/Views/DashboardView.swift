//
//  DashboardView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Resolver
import SwiftUI

struct DashboardView: View {
    // MARK: - Private Variables
    @InjectedObject private var userStore: UserStore
    @InjectedObject private var transactionStore: TransactionStore

    // MARK: - Public Variables
    @Binding var tabSelection: Int

    // MARK: - Content Builder
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerView
                    currentBudgetView
                    topExpendituresView
                }
                .padding(16)
            }
            .navigationTitle("MyBudget")
        }
    }
}

// MARK: - Displaying Views
private extension DashboardView {
    var headerView: some View {
        VStack(alignment: .leading) {
            Text("Hi, \(userStore.user?.firstName ?? "John")")
                .font(.title)
            Text("View your current budget, top expenditures, and latest transactions right here.")
                .font(.caption)
        }
    }

    var currentBudgetView: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text("Current budget remaining")
                    .font(.caption2)
                Text(remainingBudget.formatCurrency()!)
                    .font(.title)
                Text(budgetFrequencyLabel)
                    .font(.caption)
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        .background(remainingBudget > 0 ? Color(.systemGreen) : Color(.systemRed))
        .cornerRadius(4)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 1, y: 1)
    }

    @ViewBuilder
    var topExpendituresView: some View {
        if topExpenditures.count > 0 {
            VStack(alignment: .leading) {
                Text("Top Expenditures")
                VStack(spacing: 8) {
                    ForEach(topExpenditures, id: \.self) { expenditure in
                        CategoryExpenditureRow(expediture: expenditure)
                    }
                }
            }
        }
    }
}

// MARK: - Private Helpers
private extension DashboardView {
    func binding(for transaction: Transaction) -> Binding<Transaction> {
        guard let transactionIndex = transactionStore.transactions.firstIndex(where: { $0.id == transaction.id }) else {
            fatalError("Cannot locate transaction within the array")
        }
        return $transactionStore.transactions[transactionIndex]
    }

    var remainingBudget: Double {
        if let user = userStore.user {
            var earliestDate = Date()
            switch user.budget.frequency {
            case .monthly:
                earliestDate = Date().startOfMonth()
            case .fortnightly:
                earliestDate = Date().startOfFortnight()
            case .weekly:
                earliestDate = Date().startOfWeek()
            }
            return transactionStore.transactions
                .filter({ $0.date >= earliestDate })
                .map { $0.nzdAmount }
                .reduce(user.budget.value) { $0 - $1 }
        }
        return 0
    }

    var topExpenditures: [CategoryExpenditure] {
        if let user = userStore.user {
            var earliestDate = Date()
            switch user.budget.frequency {
            case .monthly:
                earliestDate = Date().startOfMonth()
            case .fortnightly:
                earliestDate = Date().startOfFortnight()
            case .weekly:
                earliestDate = Date().startOfWeek()
            }
            let recentTransactions = transactionStore.transactions
                .filter({ $0.date >= earliestDate })
            let groupedCategories = Dictionary(grouping: recentTransactions) { $0.category }
            return groupedCategories.map { category, transactions -> CategoryExpenditure in
                let totalAmount = transactions
                    .map { $0.nzdAmount }
                    .reduce(0) { $0 + $1 }
                return CategoryExpenditure(category: category,
                                           totalAmount: totalAmount,
                                           percentageOfBudget: (totalAmount/user.budget.value)*100)
            }
        }
        return []
    }

    var budgetFrequencyLabel: String {
        guard let user = userStore.user else { return "" }
        return "(\(user.budget.frequency.label))"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(tabSelection: .constant(1))
    }
}
