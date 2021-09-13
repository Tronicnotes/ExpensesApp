//
//  UserStore.swift
//  ExpensesApp
//
//  Created by Kurt Mohring on 12/09/21.
//

import Foundation
import Combine

class UserStore: ObservableObject {
    @Published var user: User?
    private let repository: UserSource
    private var cancellable: AnyCancellable?

    // MARK: - Initialiser
    init(repository: UserSource = UserRepository()) {
        self.repository = repository
        loadUser()
    }

    // MARK: - Public Methods
    func loadUser() {
        cancellable = repository.getUser()
            .sink {
                if case let .failure(error) = $0 {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] user in
                self?.user = user
            }
    }

    func saveUser() {
        if let user = self.user {
            cancellable = repository.saveUser(user)
                .sink {
                    if case let .failure(error) = $0 {
                        print(error.localizedDescription)
                    }
                } receiveValue: { _ in
                    print("Successfully saved user")
                }
        }
    }
}
