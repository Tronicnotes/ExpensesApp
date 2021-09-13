//
//  EditTransactionView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct EditTransactionView: View {
    @EnvironmentObject private var transactionStore: TransactionStore
    @Binding var transactionData: Transaction.Data

    // MARK: - Content Builder
    var body: some View {
        Form {
            expenseDetailsSection
        }
        .onAppear {
            transactionStore.getCurrentConversionRate(conversionRate: $transactionData.conversionRate)
        }
    }
}

// MARK: - Displaying Views
private extension EditTransactionView {
    var expenseDetailsSection: some View {
        Section(header: Text("Expense Details"), footer: footerView) {
            TextField("Title", text: $transactionData.title)
            Picker("Category", selection: $transactionData.category) {
                ForEach(Category.allCases, id: \.self) { category in
                    CategoryRowView(category: category)
                }
            }
            HStack {
                TextField("Amount", value: $transactionData.amount, formatter: NumberFormatter.currencyFormatter())
                    .keyboardType(.numbersAndPunctuation)
                    .disableAutocorrection(true)
                Picker("Currency", selection: $transactionData.currencyType) {
                    ForEach(CurrencyType.allCases, id: \.self) {
                        Text($0.label)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            // Only allow selecting dates from today and prior
            DatePicker("Date", selection: $transactionData.date, in: ...Date())
        }
    }

    @ViewBuilder
    var footerView: some View {
        if transactionData.currencyType == .usd, let conversionRate = transactionData.conversionRate {
            Text("The conversion rate between USD to NZD at this time: \(conversionRate)")
        }
    }
}

struct EditTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        EditTransactionView(transactionData: .constant(Transaction.Data()))
            .environmentObject(TransactionStore())
    }
}
