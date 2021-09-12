//
//  ContentView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct DashboardView: View {
    // MARK: - Private Variables
    @EnvironmentObject private var userStore: UserStore
    @EnvironmentObject private var transactionStore: TransactionStore

    // MARK: - Public Variables
    @Binding var tabSelection: Int

    // MARK: - Content Builder
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    headerView
                    currentBudgetView
                    recentTransactionsView
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
                Text(calculateCurrentBalanceRemaining())
                    .font(.title)
                Text(budgetFrequencyLabel)
                    .font(.caption)
            }
            Spacer()
        }
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 24, leading: 16, bottom: 24, trailing: 16))
        .background(Color.gray)
        .cornerRadius(4)
        .shadow(color: .black.opacity(0.3), radius: 10, x: 1, y: 1)
    }

    var recentTransactionsView: some View {
        VStack(alignment: .center) {
            HStack {
                Text("Recent transactions")
                Spacer()
                Button {
                    tabSelection = 2
                } label: {
                    Text("See more")
                        .font(.callout)
                }
            }
            if transactionStore.transactions.count > 0 {
                ForEach(transactionStore.transactions) { transaction in
                    TransactionRowView(transaction: transaction)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 1, y: 1)
                }
            } else {
                Text("There are no recorded transactions yet")
                    .font(.caption)
                    .padding(.top)
            }
        }
    }
}

// MARK: - Private Helpers
private extension DashboardView {
    func calculateCurrentBalanceRemaining() -> String {
        guard let user = userStore.user else { return "" }
        return user.budget.value.formatCurrency() ?? 0.formatCurrency()!
    }

    var budgetFrequencyLabel: String {
        guard let user = userStore.user else { return "" }
        return "(\(user.budget.frequency.label))"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(tabSelection: .constant(1))
            .environmentObject(UserStore())
            .environmentObject(TransactionStore())
    }
}
