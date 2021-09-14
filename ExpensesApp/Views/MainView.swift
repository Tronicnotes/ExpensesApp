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
    @State private var tabSelection = 1

    var body: some View {
        TabView(selection: $tabSelection) {
            DashboardView(tabSelection: $tabSelection).tabItem {
                Label("Dashboard", systemImage: "house")
            }
            .tag(1)
            TransactionListView().tabItem {
                Label("Transactions", systemImage: "list.bullet")
            }
            .tag(2)
            EditProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }
            .tag(3)
        }
        .onAppear {
            transactionInteractor.fetchTransactions()
            userInteractor.loadUserData()
//            showCreateUserScreen = uszerStore.user == nil
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
