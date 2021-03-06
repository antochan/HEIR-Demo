//
//  AppCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit
import Firebase

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
        navigationController.isHeroEnabled = true
        
        let authCoordinator = AuthCoordinator(navigationController: navigationController,
                                              authService: AuthService(),
                                              userService: UserService())
        authCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
