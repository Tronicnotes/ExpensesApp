//
//  TransactionDetailsView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct TransactionDetailsView: View {
    @Binding var transaction: Transaction
    @State private var transactionData = Transaction.Data()
    @State private var editScreenPresented = false
    private let categoryAvatarSize: CGFloat = 32

    // MARK: - Content Builder
    var body: some View {
        Form {
            expenseDetailsSection
        }
        .onAppear {
            transactionData = transaction.data
        }
        .navigationTitle(transaction.title)
        .navigationBarItems(trailing: Button("Edit") {
            editScreenPresented = true
        })
        .fullScreenCover(isPresented: $editScreenPresented) {
            NavigationView {
                EditTransactionView(transactionData: $transactionData)
                    .navigationBarItems(leading: Button("Cancel") {
                        editScreenPresented = false
                    }, trailing: Button("Save") {
                        editScreenPresented = false
                        transaction.update(from: transactionData)
                    }
                    .disabled(transactionData == transaction.data)
                    )
            }
        }
    }
}

// MARK: - Displaying Views
private extension TransactionDetailsView {
    var expenseDetailsSection: some View {
        Section(header: Text("Expense Details"), footer: footerView) {
            generateInfoField(title: "Title:", value: transaction.title)
            generateInfoField(title: "Category:", value: transaction.category.label)
            if let formattedUSDAmount = transaction.formattedUSDAmount {
                generateInfoField(title: "Amount:", value: formattedUSDAmount)
            } else {
                generateInfoField(title: "Amount:", value: transaction.formattedNZDAmount)
            }
            generateInfoField(title: "Date:", value: transaction.date.EEEEMMMDDYYYY())
        }
    }

    @ViewBuilder
    var footerView: some View {
        if let conversionRate = transactionData.conversionRate {
            Text("The conversion rate between USD to NZD at this time was: \(conversionRate)")
        }
    }
}

// MARK: - Helper Methods
private extension TransactionDetailsView {
    func generateInfoField(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}

//struct TransactionDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionDetailsView(transactionData: .constant(Transaction.Data()))
//    }
//}
