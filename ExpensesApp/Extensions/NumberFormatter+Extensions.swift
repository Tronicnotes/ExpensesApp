//
//  NumberFormatter+Extensions.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

extension NumberFormatter {
    static func currencyFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        return formatter
    }
}
