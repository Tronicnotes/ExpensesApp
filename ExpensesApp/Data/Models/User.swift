//
//  User.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    var budget: Budget

    init(firstName: String,
         lastName: String,
         budget: Budget) {
        self.firstName = firstName
        self.lastName = lastName
        self.budget = budget
    }

    init(from data: User.Data) {
        self.init(firstName: data.firstName, lastName: data.lastName, budget: Budget(from: data.budget))
    }
}

extension User {
    struct Data: Equatable {
        var firstName: String = ""
        var lastName: String = ""
        var budget: Budget.Data = Budget.Data()

        static func == (lhs: User.Data, rhs: User.Data) -> Bool {
            return lhs.firstName == rhs.firstName &&
                lhs.lastName == rhs.lastName &&
                lhs.budget == rhs.budget
        }
    }

    var data: Data {
        return Data(firstName: firstName, lastName: lastName, budget: budget.data)
    }

    mutating func update(from data: Data) {
        firstName = data.firstName
        lastName = data.lastName
        budget.update(from: data.budget)
    }
}
