//
//  TransactionDetailsView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct TransactionDetailsView: View {
    // MARK: - Private Variables
    @Environment(\.presentationMode) private var presentationMode
    @State private var transactionData = Transaction.Data()
    @State private var editScreenPresented = false
    private let categoryAvatarSize: CGFloat = 32

    // MARK: - Public Variables
    @Binding var transaction: Transaction

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
                    .navigationBarTitle(transaction.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        editScreenPresented = false
                        transactionData = transaction.data
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
            generateInfoField(title: "Category") {
                CategoryRowView(category: transaction.category, textColor: .secondary)
            }
            if let formattedUSDAmount = transaction.formattedUSDAmount {
                generateInfoField(title: "Amount", value: formattedUSDAmount)
                generateInfoField(title: "Amount(NZD)", value: transaction.formattedNZDAmount)
            } else {
                generateInfoField(title: "Amount", value: transaction.formattedNZDAmount)
            }
            generateInfoField(title: "Date", value: transaction.date.MMMDDHMM())
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
        generateInfoField(title: title) {
            Text(value)
                .foregroundColor(.secondary)
        }
    }

    func generateInfoField<Content: View>(title: String,
                                          @ViewBuilder content: () -> Content) -> some View {
        HStack {
            Text(title)
            Spacer()
            content()
        }
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(transaction: .constant(Transaction(from: Transaction.Data())))
    }
}
