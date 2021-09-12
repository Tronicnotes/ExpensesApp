//
//  Budget.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

enum BudgetFrequency: CaseIterable {
    case monthly, fortnightly, weekly

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
    var value: Double
    var frequency: BudgetFrequency

    init(value: Double, frequency: BudgetFrequency) {
        self.value = value
        self.frequency = frequency
    }

    init(from data: Budget.Data) {
        self.init(value: data.value, frequency: data.frequency)
    }
}

extension Budget {
    struct Data: Equatable {
        var value: Double = 0
        var frequency: BudgetFrequency = .monthly

        static func == (lhs: Budget.Data, rhs: Budget.Data) -> Bool {
            return lhs.value == rhs.value &&
                lhs.frequency == rhs.frequency
        }
    }

    var data: Data {
        Data(value: value, frequency: frequency)
    }

    mutating func update(from data: Data) {
        value = data.value
        frequency = data.frequency
    }
}
