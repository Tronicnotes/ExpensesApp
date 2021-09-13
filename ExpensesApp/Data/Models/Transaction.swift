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
    var amount: Double
    var currencyType: CurrencyType
    var conversionRate: Double?
    var date: Date

    init(title: String,
         category: Category,
         amount: Double,
         currencyType: CurrencyType = .nzd,
         conversionRate: Double? = nil,
         date: Date) {
        self.title = title
        self.category = category
        self.amount = amount
        self.currencyType = currencyType
        self.conversionRate = conversionRate
        self.date = date
    }

    init(from data: Transaction.Data) {
        self.init(title: data.title,
                  category: data.category,
                  amount: data.amount,
                  currencyType: data.currencyType,
                  conversionRate: data.conversionRate,
                  date: data.date)
    }
}

// MARK: - Helper Methods
extension Transaction {
    var formattedNZDAmount: String {
        if currencyType == .usd, let conversionRate = self.conversionRate {
            return (amount * conversionRate).formatCurrencyWithISO("NZD") ?? 0.formatCurrency()!
        } else {
            return amount.formatCurrency() ?? 0.formatCurrency()!
        }
    }

    var formattedUSDAmount: String? {
        guard currencyType == .usd else { return nil }
        return amount.formatCurrencyWithISO("USD")
    }
}

// MARK: - Data Helper
extension Transaction {
    struct Data: Equatable {
        var title: String = ""
        var category: Category = .shopping
        var amount: Double = 0
        var currencyType: CurrencyType = .nzd
        var conversionRate: Double? = nil
        var date: Date = Date()
    }

    var data: Data {
        return Data(title: title,
                    category: category,
                    amount: amount,
                    currencyType: currencyType,
                    conversionRate: conversionRate,
                    date: date)
    }

    mutating func update(from data: Data) {
        title = data.title
        category = data.category
        amount = data.amount
        currencyType = data.currencyType
        conversionRate = data.conversionRate
        date = data.date
    }
}
