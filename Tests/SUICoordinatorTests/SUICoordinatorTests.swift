import XCTest
import SwiftUI
@testable import SUICoordinator

@MainActor final class SwiftUICoordinatorTests: XCTestCase {
    
    func testAddChildToCoordinator() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        let childCoordinator = MockCoordinator(parent: rootCoordinator, startRoute: .secondView)
        
        rootCoordinator.add(child: childCoordinator)
        rootCoordinator.add(child: childCoordinator)
        
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 1)
    }
    
    func testRemoveChildCoordinator() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        let childCoordinator = MockCoordinator(parent: rootCoordinator, startRoute: .secondView)
        
        rootCoordinator.add(child: childCoordinator)
        rootCoordinator.remove(coordinator: childCoordinator)
        
        XCTAssertEqual(rootCoordinator.childCoordinators.count, 0)
    }
    
    func testShowRouteThrowsError() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        XCTAssertNoThrow(try rootCoordinator.start())
        
        XCTAssertThrowsError(try rootCoordinator.show(route: .thirdView)) { error in
            guard let error = error as? NavigatorError else {
                XCTFail("Cannot cast to NavigatorError: \(error)")
                return
            }
            
            switch error {
            case .cantShow(let route as MockRoute):
                XCTAssertEqual(route, .thirdView)
            default:
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
    
    func testShowRouteNoThrow() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        XCTAssertNoThrow(try rootCoordinator.start())
    }
    
    func testSetRoutesSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        rootCoordinator.set(routes: [.secondView, .secondView])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func testAppendRoutesSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        rootCoordinator.append(routes: [.secondView, .firstView])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
    }
    
    func testPopToRootSuccess() {
        let rootCoordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        rootCoordinator.append(routes: [.secondView, .firstView])
        XCTAssertEqual(rootCoordinator.viewControllers.count, 2)
        rootCoordinator.popToRoot(animated: false)
        XCTAssertEqual(rootCoordinator.viewControllers.count, 1)
    }
    
    func testRegisterTransitionSuccess() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .firstView)
        let transitions = [MockTransition()]
        
        coordinator.navigationController.register(transitions)
        
        for (index, item) in coordinator.navigationController.transitions.enumerated() {
            guard let mockTransition = item as? MockTransition else {
                XCTFail("Cannot cast to MockTransition.")
                return
            }
            
            XCTAssertEqual(mockTransition, transitions[index])
        }
    }
}
