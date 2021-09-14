//
//  UserInteractorTests.swift
//  ExpensesAppTests
//
//  Created by Kurt Mohring on 12/09/21.
//

import XCTest
import Combine
import Resolver
@testable import ExpensesApp

class UserInteractorTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        Resolver.registerMocks()
        cancellables = []
    }

    func testLoadUserData() {
        let expectation = XCTestExpectation()
        let userStore: UserStore = Resolver.resolve()

        let interactor: UserInteractor = Resolver.resolve()
        interactor.loadUserData(finishedLoading: .constant(true))
        userStore.$user
            .dropFirst()
            .sink { user in
                if user != nil {
                    expectation.fulfill()
                } else {
                    XCTFail()
                }
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.5)
    }

    func testSaveNewUser() {
        let expectation = XCTestExpectation()
        let userStore: UserStore = Resolver.resolve()
        let interactor: UserInteractor = Resolver.resolve()
        interactor.saveUser(User.Data())
        userStore.$user.sink { user in
            if user != nil {
                expectation.fulfill()
            } else {
                XCTFail()
            }
        }
        .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.5)
    }
}
