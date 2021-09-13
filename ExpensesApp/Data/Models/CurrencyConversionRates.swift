//
//  CurrencyConversionRates.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 13/09/21.
//

import Foundation

struct CurrencyConversionRates: Codable {
    let quotes: [String : Double]

    var currentUSDToNZDRate: Double? {
        return quotes["USDNZD"]
    }
}
