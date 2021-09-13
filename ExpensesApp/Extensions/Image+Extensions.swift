//
//  Image+Extensions.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import SwiftUI

extension Image {
    init!(assetIdentifier: MyBudget) {
        self.init(assetIdentifier.rawValue)
    }
}

extension Image {
    enum MyBudget: String {
        case billsIcon, drinksIcon, foodIcon, fuelIcon, groceriesIcon, rentIcon, shoppingIcon, travelIcon, otherIcon
    }
}
