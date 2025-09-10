//
//  SceneDelegate.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let diContainer = DIContainer()
    var mainCoordinator: UsersCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        NavigationAppearance.configure()

        let navigationController = UINavigationController()
        mainCoordinator = diContainer.makeUsersCoordinator(navigationController: navigationController)
        mainCoordinator?.start()

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
