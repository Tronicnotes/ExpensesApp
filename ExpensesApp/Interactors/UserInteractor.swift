//
//  UserInteractor.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 14/09/21.
//

import Foundation
import Combine

protocol UserInteractor {
    func loadUserData()
    func saveUser(_ data: User.Data)
    func saveUserData()
}

class RealUserInteractor: UserInteractor {
    // MARK: - Private Variables
    private let repository: UserSource
    private let userStore: UserStore
    private var cancellable = Set<AnyCancellable>()

    // MARK: - Initialiser
    init(repository: UserSource, userStore: UserStore) {
        self.repository = repository
        self.userStore = userStore
    }

    // MARK: - Public Methods
    func loadUserData() {
        repository.getUser()
            .receive(on: RunLoop.main)
            .sink {
                if case let .failure(error) = $0 {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] user in
                self?.userStore.user = user
            }
            .store(in: &cancellable)
    }

    func saveUser(_ data: User.Data) {
        if userStore.user == nil {
            userStore.user = User(from: data)
        } else {
            userStore.user?.update(from: data)
        }
    }

    func saveUserData() {
        if let user = userStore.user {
            repository.saveUser(user)
                .sink {
                    if case let .failure(error) = $0 {
                        print(error.localizedDescription)
                    }
                } receiveValue: { _ in
                    print("Successfully saved user")
                }
                .store(in: &cancellable)
        }
    }
}
