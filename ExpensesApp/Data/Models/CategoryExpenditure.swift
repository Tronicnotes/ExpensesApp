//
//  CategoryExpenditure.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 14/09/21.
//

import Foundation

struct CategoryExpenditure: Hashable {
    let category: Category
    let totalAmount: Double
    let percentageOfBudget: Double
}

// MARK: - Helper Variables
extension CategoryExpenditure {
    var totalAmountLabel: String {
        return "-\(totalAmount.formatCurrency()!)"
    }

    var percentageLabel: String {
        return "\(String(format: "%.2f", percentageOfBudget.round(to: 2)))%"
    }
}
