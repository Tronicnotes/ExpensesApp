//
//  Transaction.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable, Hashable {
    var id = UUID()
    let title: String
    let category: Category
    let amountNZD: Double
    let amountUSD: Double?
    let date: Date

    init(title: String,
         category: Category,
         amountNZD: Double,
         amountUSD: Double? = nil,
         date: Date) {
        self.title = title
        self.category = category
        self.amountNZD = amountNZD
        self.amountUSD = amountUSD
        self.date = date
    }
}

extension Transaction {
    var formattedNZDAmount: String {
        amountNZD.formatCurrency() ?? 0.formatCurrency()!
    }

    var formattedUSDAmount: String? {
        amountUSD?.formatCurrencyWithISO("USD")
    }
}

struct Category: Hashable {
    let name: String
    let imageAsset: String
    let color: Color
}

