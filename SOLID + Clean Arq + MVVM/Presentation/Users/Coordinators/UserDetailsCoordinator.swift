//
//  UserDetailsCoordinator.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

class UserDetailsCoordinator: Coordinator {
    typealias Args = User

    let navigationController: UINavigationController
    let diContainer: DIContainer

    required init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }

    func start(with user: User) {
        let viewModel = diContainer.makeUserDetailsViewModel(user: user)

        let viewController = UserDetailsViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: true)
    }
}
