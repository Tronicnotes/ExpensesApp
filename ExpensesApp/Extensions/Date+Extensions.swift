//
//  Date+Extensions.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation

// MARK: - Date Formats
extension Date {
    func EEEEMMMDDYYYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE - MMM dd, yyyy"
        return dateFormatter.string(from: self)
    }

    func MMMDDHMM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, h:mm a"
        return dateFormatter.string(from: self)
    }

    func YYYYMMDD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.string(from: self)
    }
}

// MARK: - Date Utils
extension Date {
    func startOfMonth() -> Date {
        let monthComponents = Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))
        return Calendar.current.date(from: monthComponents)!
    }

    func startOfWeek() -> Date {
        let weekComponents = Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Calendar.current.startOfDay(for: self))
        return Calendar.current.date(from: weekComponents)!
    }

    func startOfFortnight() -> Date {
        let startOfFirstFortnight = self.startOfMonth()
        let startOfSecondFornight = Calendar.current.date(byAdding: .weekOfMonth, value: 2, to: startOfFirstFortnight)!
        let range = startOfFirstFortnight...startOfSecondFornight
        return range.contains(self) ? startOfFirstFortnight : startOfSecondFornight
    }
}
