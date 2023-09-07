//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI

@MainActor
public class NavigationController: UINavigationController {
    
    // MARK: - Internal Properties
    
    private(set) var transitions = [Transition]()
    
    // MARK: - Initialization
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    public func register(_ transition: Transition) {
        transitions.append(transition)
    }
    
    public func register(_ transitions: [Transition]) {
        self.transitions += transitions
    }
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        for transition in transitions {
            guard
                let from = (fromVC as? RouteProvider)?.route,
                let to = (toVC as? RouteProvider)?.route,
                transition.isEligible(from: from,to: to, operation: operation)
            else {
                continue
            }
                            
            return transition
        }
        
        return nil
    }
}
