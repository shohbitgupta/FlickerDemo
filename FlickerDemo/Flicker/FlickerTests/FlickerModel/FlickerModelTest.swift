//
//  FlickerModelTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FlickerModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitializer() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let jsonObject = self.getJSONObject(fromFile: "FlickerData")
        let flkrModel : FLDataProtocol? = jsonObject != nil ? FLModel(withData: jsonObject!) : nil
        
        XCTAssertNotNil(flkrModel, "Flicker Model Found nil")
        XCTAssertNotNil(flkrModel?.flickerImageURL, "Flicker Image URL Found nil")
    }
    
    func testGetFlickerImageUrl() {
        let jsonObject = self.getJSONObject(fromFile: "FlickerData")
        let flkrModel : FLDataProtocol? = jsonObject != nil ? FLModel(withData: jsonObject!) : nil
        let imageURL = flkrModel?.flickerImageURL
        
        XCTAssertNotNil(flkrModel, "Flicker Model Found nil")
        XCTAssertNotNil(imageURL, "Flicker Image URL Found nil")
    }
    
    private func getJSONObject(fromFile fileName : String) -> [AnyHashable : Any]? {
        guard let pathURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: pathURL, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [AnyHashable : Any] {
                return jsonResult
            }
            else {
                return nil
            }
        } catch {
            // handle error
            return nil
        }
    }

}
