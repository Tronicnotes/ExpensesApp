//
//  Transaction.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import SwiftUI

enum CurrencyType: String, CaseIterable, Codable {
    case nzd, usd

    var label: String {
        return rawValue.uppercased()
    }
}

struct Transaction: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var category: Category
    var amountNZD: Double
    var amountUSD: Double?
    var currencyType: CurrencyType
    var conversionRate: Double?
    var date: Date

    init(title: String,
         category: Category,
         amountNZD: Double,
         amountUSD: Double? = nil,
         currencyType: CurrencyType = .nzd,
         conversionRate: Double? = nil,
         date: Date) {
        self.title = title
        self.category = category
        self.amountNZD = amountNZD
        self.amountUSD = amountUSD
        self.currencyType = currencyType
        self.conversionRate = conversionRate
        self.date = date
    }

    init(from data: Transaction.Data) {
        self.init(title: data.title,
                  category: data.category,
                  amountNZD: data.amountNZD,
                  amountUSD: data.amountUSD,
                  currencyType: data.currencyType,
                  conversionRate: data.conversionRate,
                  date: data.date)
    }
}

// MARK: - Helper Methods
extension Transaction {
    var formattedNZDAmount: String {
        amountNZD.formatCurrency() ?? 0.formatCurrency()!
    }

    var formattedUSDAmount: String? {
        amountUSD?.formatCurrencyWithISO("USD")
    }
}

// MARK: - Data Helper
extension Transaction {
    struct Data: Equatable {
        var title: String = ""
        var category: Category = .shopping
        var amountNZD: Double = 0
        var amountUSD: Double? = nil
        var currencyType: CurrencyType = .nzd
        var conversionRate: Double? = nil
        var date: Date = Date()
    }

    var data: Data {
        return Data(title: title,
                    category: category,
                    amountNZD: amountNZD,
                    amountUSD: amountUSD,
                    currencyType: currencyType,
                    conversionRate: conversionRate,
                    date: date)
    }

    mutating func update(from data: Data) {
        title = data.title
        category = data.category
        amountNZD = data.amountNZD
        amountUSD = data.amountUSD
        currencyType = data.currencyType
        conversionRate = data.conversionRate
        date = data.date
    }
}
