//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

@MainActor
public protocol NavigationRoute {
    /// This title can be used to set the navigation bar title when the route is shown.
    var title: String? { get }
    /// Transition action to be used when the route is shown.
    /// This can be a push action, a modal presentation, or `nil` (for child coordinators).
    var action: TransitionAction? { get }
}
