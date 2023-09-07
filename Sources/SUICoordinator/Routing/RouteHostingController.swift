//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI

@MainActor
public class RouteHostingController<Content: View>: UIHostingController<Content>, RouteProvider {
    
    // MARK: - Public properties
    
    public let route: NavigationRoute
    
    // MARK: - Initialization
    
    init(rootView: Content, route: NavigationRoute) {
        self.route = route
        super.init(rootView: rootView)
    }

    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
