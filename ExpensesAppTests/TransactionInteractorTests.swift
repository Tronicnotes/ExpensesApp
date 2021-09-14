//
//  TransactionInteractorTests.swift
//  ExpensesAppTests
//
//  Created by Kurt Mohring on 14/09/21.
//

import XCTest
import Combine
import Resolver
import SwiftUI
@testable import ExpensesApp

class TransactionInteractorTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Resolver.registerMocks()
        cancellables = []
    }

    func testLoadUserData() {
        let expectation = XCTestExpectation()
        let transactionStore: TransactionStore = Resolver.resolve()
        XCTAssertTrue(transactionStore.transactions.count == 0)
        let interactor: TransactionInteractor = Resolver.resolve()
        interactor.fetchTransactions()
        transactionStore.$transactions
            .dropFirst()
            .sink { transactions in
                if transactions.count == 1 {
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.5)
        XCTAssertTrue(transactionStore.transactions.count == 1)
    }

    func testDeleteTransaction() {
        let transactionStore: TransactionStore = Resolver.resolve()
        transactionStore.transactions.append(Transaction(from: Transaction.Data()))
        XCTAssertTrue(transactionStore.transactions.count == 1)
        let interactor: TransactionInteractor = Resolver.resolve()
        let components = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        let date = Calendar.current.date(from: components)!
        interactor.deleteTransaction(at: IndexSet([0]), for: date)
        XCTAssertTrue(transactionStore.transactions.count == 0)
    }

    func testFetchConversionRate() {
        let expectation = XCTestExpectation()
        let interactor: TransactionInteractor = Resolver.resolve()
        let conversionRateBinding = Binding<Double?> {
            return nil
        } set: { value in
            if value == 30 {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        interactor.fetchConversionRate(for: Date(),
                                       conversionRate: conversionRateBinding)
        wait(for: [expectation], timeout: 0.5)
    }
}
