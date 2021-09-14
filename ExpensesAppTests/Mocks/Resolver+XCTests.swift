//
//  Resolver+XCTests.swift
//  ExpensesAppTests
//
//  Created by Kurt Mohring on 14/09/21.
//

import Foundation
import Resolver
@testable import ExpensesApp

extension Resolver {
    static var mock = Resolver(parent: .main)

    static func registerMocks() {
        root = Resolver.mock
        defaultScope = .application
        Resolver.register { MockedUserRepository() }
            .implements(UserSource.self)
        Resolver.register { MockedTransactionRepository() }
            .implements(TransactionSource.self)
    }
}
