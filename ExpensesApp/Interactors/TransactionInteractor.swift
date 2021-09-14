//
//  TransactionInteractor.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 14/09/21.
//

import Foundation
import Combine
import SwiftUI

protocol TransactionInteractor {
    func fetchTransactions()
    func deleteTransaction(at indexSet: IndexSet, for key: Date)
    func saveTransactions()
    func getCurrentConversionRate(conversionRate: Binding<Double?>)
}

class RealTransactionInteractor: TransactionInteractor {
    private let repository: TransactionSource
    private let transactionStore: TransactionStore
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Initialiser
    init(repository: TransactionSource, transactionStore: TransactionStore) {
        self.repository = repository
        self.transactionStore = transactionStore
    }

    // MARK: - Public Methods
    func fetchTransactions() {
        repository.getTransactions()
            .receive(on: RunLoop.main)
            .sink {
                if case let .failure(error) = $0 {
                    print(error)
                }
            } receiveValue: { [weak self] transactions in
                self?.transactionStore.transactions = transactions
            }
            .store(in: &cancellable)
    }

    func deleteTransaction(at indexSet: IndexSet, for key: Date) {
        if let indexElement = indexSet.first,
           let transaction = transactionStore.groupedTransactions[key]?[indexElement],
           let index = transactionStore.transactions.firstIndex(of: transaction) {
            transactionStore.transactions.remove(at: index)
        }
    }

    func saveTransactions() {
        repository.saveTransactions(transactionStore.transactions)
            .sink {
                if case let .failure(error) = $0 {
                    print(error)
                }
            } receiveValue: { _ in
                print("Successfully saved transactions")
            }
            .store(in: &cancellable)
    }

    func getCurrentConversionRate(conversionRate: Binding<Double?>) {
        repository.fetchConversionRates()
            .sink {
                if case let .failure(error) = $0 {
                    print(error)
                }
            } receiveValue: { currencyConversionRates in
                conversionRate.wrappedValue = currencyConversionRates.currentUSDToNZDRate
            }
            .store(in: &cancellable)
    }
}
