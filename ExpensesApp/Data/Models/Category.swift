//
//  Category.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import SwiftUI

enum Category: String, CaseIterable, Codable {
    case bills, drinks, food, fuel, groceries, rent, shopping, travel, other

    var label: String{
        return self.rawValue.capitalized
    }

    var imageAsset: Image.MyBudget {
        switch self {
        case .bills:
            return .billsIcon
        case .drinks:
            return .drinksIcon
        case .food:
            return .foodIcon
        case .fuel:
            return .fuelIcon
        case .groceries:
            return .groceriesIcon
        case .rent:
            return .rentIcon
        case .shopping:
            return .shoppingIcon
        case .travel:
            return .travelIcon
        case .other:
            return .otherIcon
        }
    }

    var color: Color {
        switch self {
        case .bills:
            return Color(.systemBlue)
        case .drinks:
            return Color(.systemPink)
        case .food:
            return Color(.systemOrange)
        case .fuel:
            return Color(.systemRed)
        case .groceries:
            return Color(.systemGreen)
        case .rent:
            return Color(.systemYellow)
        case .shopping:
            return Color(.systemIndigo)
        case .travel:
            return Color(.systemTeal)
        case .other:
            return Color(.systemGray)
        }
    }
}
