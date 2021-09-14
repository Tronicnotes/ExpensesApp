//
//  MainView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Resolver
import SwiftUI

struct MainView: View {

    @Environment(\.scenePhase) private var scenePhase
    @InjectedObject private var userStore: UserStore
    @Injected private var transactionInteractor: TransactionInteractor
    @Injected private var userInteractor: UserInteractor
    @State private var showCreateUserScreen = false
    @State private var finishedLoading = false

    var body: some View {
        TabView {
            DashboardView().tabItem {
                Label("Dashboard", systemImage: "house")
            }
            TransactionListView().tabItem {
                Label("Transactions", systemImage: "list.bullet")
            }
            EditProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .onAppear {
            transactionInteractor.fetchTransactions()
            userInteractor.loadUserData(finishedLoading: $finishedLoading)
        }
        .onChange(of: finishedLoading) { _ in
            showCreateUserScreen = userStore.user == nil
        }
        .fullScreenCover(isPresented: $showCreateUserScreen) {
            EditProfileView()
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                transactionInteractor.saveTransactions()
                userInteractor.saveUserData()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
