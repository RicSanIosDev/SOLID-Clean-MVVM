//
//  UserDetailsCoordinator.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

class UserDetailsCoordinator: Coordinator {
    // ¡Aquí está la clave! Este coordinator necesita un 'User' para empezar.
    typealias Args = User

    let navigationController: UINavigationController
    let diContainer: DIContainer

    required init(navigationController: UINavigationController, diContainer: DIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }

    // El método 'start' ahora recibe un objeto 'User'.
    func start(with user: User) {
        // 1. Creamos un ViewModel para los detalles, pasándole el usuario.
        let viewModel = diContainer.makeUserDetailsViewModel(user: user)

        // 2. Creamos el ViewController.
        let viewController = UserDetailsViewController(viewModel: viewModel)

        // 3. Lo mostramos en la pantalla.
        navigationController.pushViewController(viewController, animated: true)
    }
}
