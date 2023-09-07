//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI
@testable import SUICoordinator

class MockCoordinator: Router {
    
    var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: NavigationController
    let startRoute: MockRoute
    
    init(parent: Coordinator?, startRoute: MockRoute) {
        self.parent = parent
        self.navigationController = NavigationController()
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        
    }
}

extension MockCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: MockRoute) -> some View {
        switch route {
        case .firstView:
            MockFirstView()
        case .secondView:
            MockSecondView()
        default:
            EmptyView()
        }
    }
}
