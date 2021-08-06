//
//  AppCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

final class AppCoordinator: RootCoordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    // MARK: - Properties
    let window: UIWindow?
    
    // MARK: - Coordinator
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let window = window else { return }
        let navigationController = UINavigationController()
        
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
