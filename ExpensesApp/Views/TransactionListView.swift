//
//  TransactionListView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct TransactionListView: View {

    @EnvironmentObject private var transactionStore: TransactionStore

    // MARK: - Content Builder
    var body: some View {
        NavigationView {
            listView
                .navigationTitle("Transactions")
        }
    }
}

// MARK: - Displaying Views
private extension TransactionListView {
    @ViewBuilder
    var listView: some View {
        if transactionStore.transactions.count > 0 {
            List {
                ForEach(transactionStore.groupedTransactions.sorted(by: { $0.key < $1.key }), id: \.key) { date, transactions in
                    Section(header: Text(date.EEEEMMMDDYYYY())) {
                            ForEach(transactions, id: \.self) { transaction in
                                TransactionRowView(transaction: transaction)
                            }
                        }
                }
            }
            .listStyle(GroupedListStyle())
        } else {
            VStack {
                Text("There are no transactions to display")
            }
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
            .environmentObject(TransactionStore())
    }
}
