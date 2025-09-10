//
//  DIContainer.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

class DIContainer {
    // MARK: - Data Layer
    private lazy var apiClient = APIClient()
    private lazy var userRepository: UserRepository = APIUserRepository(apiClient: apiClient)

    // MARK: - Domain Layer
    private lazy var getUsersUseCase = GetUsersUseCase(repository: userRepository)

    // MARK: - Presentation Layer
    func makeUsersCoordinator(navigationController: UINavigationController) -> UsersCoordinator {
        return UsersCoordinator(navigationController: navigationController, diContainer: self)
    }

    func makeUsersViewModel(coordinator: UsersCoordinator) -> UsersViewModel {
        return UsersViewModel(getUsersUseCase: getUsersUseCase, coordinator: coordinator)
    }

    func makeUserDetailsViewModel(user: User) -> UserDetailsViewModel {
        return UserDetailsViewModel(user: user)
    }
}
