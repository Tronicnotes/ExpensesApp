//
//  TransactionRowView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    private let avatarSize: CGFloat = 40

    // MARK: - Content Builder
    var body: some View {
        HStack(spacing: 0) {
            categoryAvatar
                .padding(.trailing, 8)
            detailsView
            Spacer()
            amountView
        }
        .padding(8)
    }
}

// MARK: - Displaying Views
private extension TransactionRowView {
    var categoryAvatar: some View {
        ZStack(alignment: .center) {
            Circle()
                .foregroundColor(transaction.category.color)
            Image(assetIdentifier: transaction.category.imageAsset)
                .resizable()
                .scaledToFit()
                .padding(8)
        }
        .frame(width: avatarSize, height: avatarSize)
    }

    var detailsView: some View {
        VStack(alignment: .leading) {
            Text(transaction.title)
                .font(.body)
            Text(transaction.category.label)
                .font(.caption)
        }
    }

    var amountView: some View {
        VStack(alignment: .trailing) {
            if let formattedUSDAmount = transaction.formattedUSDAmount {
                Text("-\(formattedUSDAmount)")
                    .bold()
                Text("-\(transaction.formattedNZDAmount)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            } else {
                Text("-\(transaction.formattedNZDAmount)")
                    .bold()
            }
        }
    }
}

struct TransactionRowView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(transaction: Transaction(title: "Countdown",
                                                    category: .shopping,
                                                    amount: 300,
                                                    currencyType: .usd,
                                                    conversionRate: 1.4,
                                                    date: Date()))
    }
}
