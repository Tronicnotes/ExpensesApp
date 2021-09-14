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
        register { UserRepository() }
            .implements(UserSource.self)
        register { UserStore(repository: resolve()) }
            .scope(.application)
        // MARK: - Transaction Registrations
        register { Endpoint() }
        register { TransactionNetworkService(endpoint: resolve()) }
            .implements(TransactionNetworkSource.self)
        register { TransactionRepository(networkingService: resolve())}
            .implements(TransactionSource.self)
        register { TransactionStore(repository: resolve()) }
            .scope(.application)
    }
}
