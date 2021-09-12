//
//  CreateUserView.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import SwiftUI

struct CreateUserView: View {
    // MARK: - Private Variables
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject private var userStore: UserStore
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var budgetValue = ""
    @State private var selectedBudgetFrequency: BudgetFrequency = .fortnightly

    // MARK: - Content Builder
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    headerView
                    detailsView
                }
                .padding(16)
            }
            Spacer()
            continueButtonView
                .padding([.horizontal, .bottom], 16)
        }
    }
}

// MARK: - Displaying Views
private extension CreateUserView {
    var headerView: some View {
        VStack {
            Text("Welcome to MyBudget, the all-in-one budgeting app")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.bottom)
            Text("Before we continue, we need a couple of small details")
                .multilineTextAlignment(.center)
        }
    }

    var detailsView: some View {
        VStack(alignment: .leading) {
            generateTextField(label: "First name:", value: $firstName)
            generateTextField(label: "Last name:", value: $lastName)
            generateTextField(label: "Budget amount:", value: $budgetValue, keyboardType: .numberPad)
            Text("Please select your preferred budget frequency:")
                .fixedSize(horizontal: false, vertical: true)
            Picker("", selection: $selectedBudgetFrequency) {
                ForEach(BudgetFrequency.allCases, id: \.self) {
                    Text($0.label)
                }
            }
        }
    }

    var continueButtonView: some View {
        Button {
            saveUserData()
        } label: {
            Text("Continue")
        }
        .disabled(firstName.isEmpty || lastName.isEmpty || budgetValue.isEmpty || Double(budgetValue) == nil)
        .buttonStyle(DefaultButtonStyle())
    }
}

// MARK: - Helper Methods
private extension CreateUserView {
    func generateTextField(label: String, value: Binding<String>, keyboardType: UIKeyboardType = .namePhonePad) -> some View {
        HStack {
            Text(label)
            TextField("", text: value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(keyboardType)
                .disableAutocorrection(true)
        }
    }

    func saveUserData() {
        let budget = Budget(value: Double(budgetValue)!, frequency: selectedBudgetFrequency)
        let user = User(firstName: firstName, lastName: lastName, budget: budget)
        userStore.user = user
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}
