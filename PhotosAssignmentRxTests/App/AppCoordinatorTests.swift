//
//  AppCoordinatorTests.swift
//  PhotosAssignmentTests
//
//  Created by Guru on 05/06/2022.
//

import XCTest
@testable import PhotosAssignment

class AppCoordinatorTest: XCTestCase {
    
    func test_appCoordinator_createRootViewController() {
        let coordinator = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        coordinator.start()
        XCTAssertNotNil(coordinator.rootNavigationController)
    }
}
