//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI

public typealias NavigationOperation = UINavigationController.Operation

public protocol Transition: UIViewControllerAnimatedTransitioning {
    func isEligible(from fromRoute: NavigationRoute, to toRoute: NavigationRoute, operation: NavigationOperation) -> Bool
}
