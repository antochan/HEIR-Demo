//
//  RootCoordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

protocol RootCoordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    func start()
}
