//
//  FLWebServiceObjectTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FLWebServiceObjectTest: XCTestCase {

    var object : FLWebServiceObject!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        object = nil
        super.tearDown()
    }

    func testAddHandler() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        createObject()
        let handler = FLWebServiceHandler { (data, error) in
            print("No Thing")
        }
        object.addTaskHandler(handler: handler)
    }
    
    func testRemoveHandler() {
        createObject()
        let handler = FLWebServiceHandler { (data, error) in
            print("No Thing")
        }
        object.addTaskHandler(handler: handler)
        object.removeHander(handler: handler)
    }
    
    func testRemoveAllHandler() {
        createObject()
        let handler = FLWebServiceHandler { (data, error) in
            print("No Thing")
        }
        object.addTaskHandler(handler: handler)
        object.removeAllHandler()
    }
    
    private func createObject() {
        let requestPath = "\(WebEngineConstant.flickerServicePath)?method=\(WebEngineConstant.flickerPhotoSearchMethod)&api_key=\(WebEngineConstant.flickerPhotoAPIKey)&format=\(WebEngineConstant.flickerPhotoFormat)&nojsoncallback=1&safe_search=1&text=kitten&page=1&per_page=20"
        if let url = URL(string: requestPath) {
            let dataTask = URLSession.shared.dataTask(with: url)
            object = FLWebServiceObject(dataTask: dataTask, taskID: requestPath)
        }
    }
}
