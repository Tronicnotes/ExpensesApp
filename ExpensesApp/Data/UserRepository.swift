//
//  UserRepository.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 13/09/21.
//

import Foundation
import Combine

protocol UserSource: LocalSource {
    func getUser() -> AnyPublisher<User, Error>
    func saveUser(_ user: User) -> AnyPublisher<Void, Error>
}

struct UserRepository: UserSource {

    static var filePathComponent: String {
        return "user.data"
    }

    func getUser() -> AnyPublisher<User, Error> {
        return self.readLocalData() as AnyPublisher<User, Error>
    }

    func saveUser(_ user: User) -> AnyPublisher<Void, Error> {
        return self.saveLocalData(user) as AnyPublisher<Void, Error>
    }
}
