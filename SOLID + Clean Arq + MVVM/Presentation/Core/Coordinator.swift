//
//  Coordinator.swift
//  SOLID Clean Arq
//
//  Created by ricardo sanchez on 10/9/25.
//

import UIKit

struct NoArgs {}

protocol Coordinator: AnyObject {
    associatedtype Args
    var navigationController: UINavigationController { get }
    var diContainer: DIContainer { get }
    func start(with args: Args)
    init(navigationController: UINavigationController, diContainer: DIContainer)
}
