//
//  Budget.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

enum BudgetFrequency: CaseIterable {
    case fortnightly, monthly, weekly

    var label: String {
        switch self {
        case .fortnightly:
            return "Fortnightly"
        case .monthly:
            return "Monthly"
        case .weekly:
            return "Weekly"
        }
    }
}

struct Budget {
    let value: Double
    let frequency: BudgetFrequency
}
