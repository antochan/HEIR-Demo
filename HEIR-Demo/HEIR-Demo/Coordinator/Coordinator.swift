//
//  Coordinator.swift
//  HEIR-Demo
//
//  Created by Antonio Chan on 8/5/21.
//

import UIKit

public enum PresentationStyle {
    case push
    case replace
    case present
}

protocol Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeAllChildCoordinatorsWith<T>(type: T.Type)
    func removeAllChildCoordinators()
}
