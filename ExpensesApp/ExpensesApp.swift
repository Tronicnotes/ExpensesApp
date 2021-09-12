//
//  ExpensesAppApp.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

@main
struct ExpensesAppApp: App {

    @State private var tabSelection = 1
    private let userStore = UserStore()
    private let transactionStore = TransactionStore()

    var body: some Scene {
        WindowGroup {
            TabView(selection: $tabSelection) {
                DashboardView(tabSelection: $tabSelection).tabItem {
                    Label("Dashboard", systemImage: "house")
                }
                .tag(1)
                TransactionListView().tabItem {
                    Label("Transactions", systemImage: "list.bullet")
                }
                .tag(2)
            }
            .environmentObject(userStore)
            .environmentObject(transactionStore)
        }
    }
}
