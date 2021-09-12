//
//  Double+Extensions.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

extension Double {
    func formatCurrency() -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value: self))
    }

    func formatCurrencyWithISO(_ code: String) -> String? {
        guard let formattedValue = self.formatCurrency() else { return nil }
        return "\(formattedValue) \(code.uppercased())"
    }
}
