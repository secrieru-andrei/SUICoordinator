//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import Foundation
@testable import SUICoordinator

enum MockRoute: NavigationRoute {
    case firstView
    case secondView
    case thirdView
    
    var title: String? {
        switch self {
        case .firstView:
            return "MockFirstView"
        case .secondView:
            return "MockSecondView"
        case .thirdView:
            return "MockThirdView"
        }
    }

    var action: TransitionAction? {
        switch self {
        case .thirdView:
            return nil
        default:
            return .push(animated: true)
        }
    }
}
