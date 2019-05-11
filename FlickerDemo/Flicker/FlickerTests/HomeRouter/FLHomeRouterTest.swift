//
//  FLHomeRouterTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FLHomeRouterTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitializeHomeController() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let view = ViewController()
        
        let presenter: FLHomePresenterInputProtocol & FLHomeInteratorOutputProtocol = MockPresenter()
        let interactor: FLHomeInteratorInputProtocol = MockInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        XCTAssertNotNil(view, "View Found nil")

    }
}
