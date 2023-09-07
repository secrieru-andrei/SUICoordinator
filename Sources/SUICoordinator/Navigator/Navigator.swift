//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI

public typealias Router = Coordinator & Navigator

@MainActor
public protocol Navigator: ObservableObject {
    associatedtype Route: NavigationRoute

    var navigationController: NavigationController { get }
    /// The starting route of the navigator.
    var startRoute: Route { get }
    
    /// This method should be called to start the flow  and to show the view for the `startRoute`.
    func start() throws
    /// It creates a view for the route and adds it to the navigation stack.
    func show(route: Route) throws
    /// Creates views for routes, and replaces the navigation stack with the specified views.
    func set(routes: [Route], animated: Bool)
    /// Creates views for routes, and appends them on the navigation stack.
    func append(routes: [Route], animated: Bool)
    /// Pops the top view from the navigation stack.
    func pop(animated: Bool)
    /// Pops all the views on the stack except the root view.
    func popToRoot(animated: Bool)
    /// Dismisses the view.
    func dismiss(animated: Bool)
}

// MARK: - Extensions

public extension Navigator where Self: Coordinator, Self: RouterViewFactory {
    
    // MARK: - Public properties

    var viewControllers: [UIViewController] {
        return navigationController.viewControllers
    }

    var topViewController: UIViewController? {
        return navigationController.topViewController
    }

    var visibleViewController: UIViewController? {
        return navigationController.visibleViewController
    }
    
    // MARK: - Public methods

    func start() throws {
        try show(route: startRoute)
    }

    func show(route: Route) throws {
        let view = self.view(for: route)
            .ifLet(route.title) { view, value in
                view.navigationTitle(value)
            }
        
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = RouteHostingController(
            rootView: viewWithCoordinator,
            route: route
        )
        
        switch route.action {
        case .push(let animated):
            navigationController.pushViewController(viewController, animated: animated)
        case .present(let animated, let modalPresentationStyle, let completion):
            present(viewController: viewController, animated: animated, modalPresentationStyle: modalPresentationStyle, completion: completion)
        case .none:
            throw NavigatorError.cantShow(route)
        }
    }

    func set(routes: [Route], animated: Bool = true) {
        let views = views(for: routes)
        navigationController.setViewControllers(views, animated: animated)
    }

    func append(routes: [Route], animated: Bool = true) {
        let views = views(for: routes)
        navigationController.setViewControllers(self.viewControllers + views, animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated)
        }
        navigationController.popToRootViewController(animated: animated)
    }

    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }

    // MARK: - Private methods

    private func views(for routes: [Route]) -> [UIHostingController<some View>] {
        return routes.map({ route in
            let view = self.view(for: route)
                .navigationTitle(route.title ?? "")
            return RouteHostingController(rootView: view.environmentObject(self), route: route)
        })
    }

    private func present(
        viewController: UIViewController,
        animated: Bool,
        modalPresentationStyle: UIModalPresentationStyle,
        completion: (() -> Void)?
    ) {
        viewController.modalPresentationStyle = modalPresentationStyle
        navigationController.present(viewController, animated: animated, completion: completion)
    }
}

//MARK: - Handling navigation error
public enum NavigatorError: Error {
    case cantShow(NavigationRoute)
}

