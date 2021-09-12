//
//  ExpensesAppApp.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

@main
struct ExpensesAppApp: App {
    @State private var showCreateUserScreen = false
    private let userStore = UserStore()
    private let transactionStore = TransactionStore()

    var body: some Scene {
        WindowGroup {
            DashboardView()
                .environmentObject(userStore)
                .environmentObject(transactionStore)
                .fullScreenCover(isPresented: $showCreateUserScreen) {
                    CreateUserView()
                        .environmentObject(userStore)
                        .environmentObject(transactionStore)
                }
                .onAppear {
                    showCreateUserScreen = userStore.user == nil
                }
        }
    }
}
