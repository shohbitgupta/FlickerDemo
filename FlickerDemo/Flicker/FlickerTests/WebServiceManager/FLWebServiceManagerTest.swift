//
//  FLWebServiceManagerTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker


class FLWebServiceManagerTest: XCTestCase {

    var serviceManager : FLWebServiceManager!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        serviceManager = FLWebServiceManager.sharedInstance
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        serviceManager = nil
        super.tearDown()
    }
    
    func testCreateRequestMethod() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let requestPath = "\(WebEngineConstant.flickerServicePath)?method=\(WebEngineConstant.flickerPhotoSearchMethod)&api_key=\(WebEngineConstant.flickerPhotoAPIKey)&format=\(WebEngineConstant.flickerPhotoFormat)&nojsoncallback=1&safe_search=1&text=kitten&page=1&per_page=20"
        
        let promise = expectation(description: "Completion handler invoked")
        var dataResponse : Any?
        serviceManager.createDataRequest(withPath: requestPath, withParam: nil, withCustomHeader: nil, withRequestType: .GET) { (data, error) in
            dataResponse = data
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 50, handler: nil)
        
        XCTAssertNotNil(dataResponse, "Network Data response Found nil")
    }
    
    func testCreateRequestFailureMethod() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let requestPath = "https://api.com/services/rest/?method=\(WebEngineConstant.flickerPhotoSearchMethod)&api_key=\(WebEngineConstant.flickerPhotoAPIKey)&format=\(WebEngineConstant.flickerPhotoFormat)&nojsoncallback=1&safe_search=1&text=kitten&page=1&per_page=20"
        
        let promise = expectation(description: "Completion handler invoked")
        var err : DataError?
        serviceManager.createDataRequest(withPath: requestPath, withParam: nil, withCustomHeader: nil, withRequestType: .GET) { (data, error) in
            err = error
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 50, handler: nil)
        
        XCTAssertNotNil(err, "Network Data Error Found nil")
    }
    
    func testCancelAllTasks() {
        serviceManager.cancelAllTasks()
    }

}
