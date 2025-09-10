//
//  UsersViewModel.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import Foundation

class UsersViewModel {
    var onStateChange: ((State) -> Void)?

    enum State {
        case loading
        case loaded([User])
        case error(String)
    }

    private let getUsersUseCase: GetUsersUseCase
    weak var coordinator: UsersCoordinator?

    init(getUsersUseCase: GetUsersUseCase, coordinator: UsersCoordinator) {
        self.getUsersUseCase = getUsersUseCase
        self.coordinator = coordinator
    }

    func viewDidLoad() {
        onStateChange?(.loading)
        getUsersUseCase.execute { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.onStateChange?(.loaded(users))
                case .failure(let error):
                    self?.onStateChange?(.error(error.localizedDescription))
                }
            }
        }
    }

    func didSelectUser(_ user: User) {
        coordinator?.navigateToUserDetails(for: user)
    }
}
