//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import Foundation

//MARK: - Coordinator protocol
@MainActor
public protocol Coordinator: AnyObject {
    /// Property to store reference to the parent coordinator if there are more than one
    var parent: Coordinator? { get }
    ///  Keep reference to all child coordinators
    var childCoordinators: [Coordinator] { get set }
    
    /// Handle coordinator action
    func handle(_ action: CoordinatorAction)
    /// Add new child coordinator into the list
    func add(child: Coordinator)
    /// Remove coordinator from the coordinators list
    func remove(coordinator: Coordinator)
}

// MARK: - Extensions
public extension Coordinator {
    func add(child: Coordinator) {
        if !childCoordinators.contains(where: { $0 === child }) {
            childCoordinators.append(child)
        }
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

//MARK: - Coordinator's Actions Protocol
public protocol CoordinatorAction {}

/// Coordinator main actions
public enum Action: CoordinatorAction {
    case done(Any)
    case cancel(Any)
}

