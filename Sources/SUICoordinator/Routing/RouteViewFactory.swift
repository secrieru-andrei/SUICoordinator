//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI

@MainActor
public protocol RouterViewFactory {
    associatedtype V: View
    associatedtype Route: NavigationRoute
    
    @ViewBuilder
    func view(for route: Route) -> V
}
