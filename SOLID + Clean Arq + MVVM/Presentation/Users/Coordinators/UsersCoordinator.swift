//
//  UsersCoordinator.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

extension Coordinator where Args == NoArgs {
    func start() {
        start(with: NoArgs())
    }
}

class UsersCoordinator: Coordinator {
    typealias Args = NoArgs
    let navigationController: UINavigationController
    let diContainer: DIContainer

    required init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }

    func start(with args: NoArgs) {
        let viewModel = diContainer.makeUsersViewModel(coordinator: self)
        let viewController = UsersViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }

    func navigateToUserDetails(for user: User) {
        let userDetailsCoordinator = UserDetailsCoordinator(navigationController: navigationController, diContainer: diContainer)
        userDetailsCoordinator.start(with: user)
    }
}
