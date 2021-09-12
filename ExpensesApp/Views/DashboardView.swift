//
//  ContentView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct DashboardView: View {

    @ObservedObject private var viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel = DashboardViewModel()) {
        self.viewModel = viewModel
    }

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
            Text("Hi, \(viewModel.profileName)")
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
                Text(viewModel.currentBudgetRemaining)
                    .font(.title)
                Text("(\(viewModel.budgetFrequency.label))")
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
                    print("See all pressed")
                } label: {
                    Text("See more")
                        .font(.callout)
                }
            }
            if viewModel.transactions.count > 0 {
                ForEach(viewModel.transactions) { transaction in
                    TransactionRowView(transaction: transaction)
                }
            } else {
                Text("There are no recorded transactions yet")
                    .font(.caption)
                    .padding(.top)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
