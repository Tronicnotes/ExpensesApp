//
//  ProfileView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - Private Variables
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userStore: UserStore
    @State private var userData: User.Data = User.Data()

    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        return formatter
    }()

    // MARK: - Content Builder
    var body: some View {
        NavigationView {
            VStack {
                if isNewUser {
                    headerView
                }
                Form {
                    detailsSectionView
                    budgetSectionView
                    saveButtonView
                }
                .listStyle(GroupedListStyle())
                .navigationTitle(isNewUser ? "Welcome" : "Profile")
                .onAppear {
                    if let userData = userStore.user?.data {
                        self.userData = userData
                    }
                }
            }
        }
    }
}

// MARK: - Displaying Views
private extension ProfileView {
    var headerView: some View {
        VStack(alignment: .leading) {
            Text("MyBudget - the all-in-one budgeting app")
                .font(.title2)
                .padding(.bottom)
            Text("Before we continue, we need a couple of small details:")
        }
        .padding()
    }

    var detailsSectionView: some View {
        Section(header: Text("Details")) {
            generateNameTextField(label: "First name", value: $userData.firstName)
            generateNameTextField(label: "Last name", value: $userData.lastName)
        }
    }

    var budgetSectionView: some View {
        Section(header: Text("Budget"), footer: Text("Frequency indicates your budgeting period, and all expense calculations will be based on this. This can be adjusted at any time from the Profile page.")) {
            TextField("Budget", value: $userData.budget.value, formatter: currencyFormatter) { _ in
                print("changing text")
            } onCommit: {
                print("on commit")
            }.keyboardType(.numbersAndPunctuation)
            Picker("Frequency", selection: $userData.budget.frequency) {
                ForEach(BudgetFrequency.allCases, id: \.self) {
                    Text($0.label)
                }
            }
        }
    }


    @ViewBuilder
    var saveButtonView: some View {
        if userStore.user?.data != userData {
            Button {
                userStore.user?.update(from: userData)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text(isNewUser ? "Continue" : "Save")
            }
            .disabled(userData.firstName.isEmpty || userData.lastName.isEmpty || userData.budget.value == 0)
        }
    }
}

// MARK: - Helper Methods
private extension ProfileView {
    private var isNewUser: Bool {
        return userStore.user == nil
    }

    func generateNameTextField(label: String, value: Binding<String>) -> some View {
        TextField(label, text: value)
            .keyboardType(.namePhonePad)
            .disableAutocorrection(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserStore())
    }
}
