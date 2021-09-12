//
//  Date+Extensions.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

extension Date {
    func EEEEMMMDDYYYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE - MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
}
