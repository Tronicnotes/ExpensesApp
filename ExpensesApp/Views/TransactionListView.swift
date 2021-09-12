//
//  TransactionListView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct TransactionListView: View {

    @EnvironmentObject private var transactionStore: TransactionStore
    @State private var addTransactionPresented = false
    @State private var newTransactionData = Transaction.Data()
    private let addButtonSize: CGFloat = 20

    // MARK: - Content Builder
    var body: some View {
        NavigationView {
            listView
                .navigationTitle("Transactions")
                .navigationBarItems(trailing: newTransactionButton)
        }
        .sheet(isPresented: $addTransactionPresented) {
            NavigationView {
                EditTransactionView(transactionData: $newTransactionData)
                    .navigationBarItems(leading: Button("Cancel") {
                        addTransactionPresented = false
                    }, trailing: Button("Add") {
                        let newTransaction = Transaction(from: newTransactionData)
                        transactionStore.transactions.append(newTransaction)
                        addTransactionPresented = false
                        newTransactionData = Transaction.Data()
                    }
                    .disabled(newTransactionData.title.isEmpty ||
                                newTransactionData.amountNZD == 0 ||
                                (newTransactionData.amountUSD != nil && newTransactionData.amountUSD == 0))
                    )
            }
        }
    }
}

// MARK: - Displaying Views
private extension TransactionListView {
    @ViewBuilder
    var listView: some View {
        if transactionStore.transactions.count > 0 {
            List {
                ForEach(transactionStore.groupedTransactions.sorted(by: { $0.key > $1.key }), id: \.key) { date, transactions in
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

    var newTransactionButton: some View {
        Button {
            addTransactionPresented = true
        } label: {
            Image(systemName: "plus")
                .resizable()
                .frame(width: addButtonSize, height: addButtonSize)
        }
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
            .environmentObject(TransactionStore())
    }
}
