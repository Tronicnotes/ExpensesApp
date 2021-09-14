//
//  ExpensesApp+Resolver.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 14/09/21.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // MARK: - User Registrations
        register { UserStore() }
            .scope(.application)
        register { UserRepository() }
            .implements(UserSource.self)
        register { RealUserInteractor(repository: resolve(), userStore: resolve()) }
            .implements(UserInteractor.self)
        // MARK: - Transaction Registrations
        register { TransactionStore() }
            .scope(.application)
        register { Endpoint() }
        register { TransactionNetworkService(endpoint: resolve()) }
            .implements(TransactionNetworkSource.self)
        register { TransactionRepository(networkingService: resolve())}
            .implements(TransactionSource.self)
        register { RealTransactionInteractor(repository: resolve(), transactionStore: resolve()) }
            .implements(TransactionInteractor.self)
    }
}
