//
//  ExpensesApp.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

@main
struct ExpensesApp: App {

    private let userStore = UserStore()
    private let transactionStore = TransactionStore()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(userStore)
                .environmentObject(transactionStore)
        }
    }
}
