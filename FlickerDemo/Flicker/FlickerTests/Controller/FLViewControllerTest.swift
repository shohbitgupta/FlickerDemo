//
//  FLViewControllerTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FLViewControllerTest: XCTestCase {

    var controller : ViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        controller = (mainstoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController)
        _ = controller.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        controller = nil
        super.tearDown()
    }

    func testShowFlickerImages() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let jsonObject = self.getJSONObject(fromFile: "FlickerDataList")
        var list : [FLDataProtocol]?
        if let dataObjectInfo = jsonObject, let photosInfo = dataObjectInfo["photos"] as? [AnyHashable : Any], let dataList = photosInfo["photo"] as? [Any] {
            let builder = DataBuilder<FLModel>()
            list = builder.getParsedDataList(withData: dataList)
            controller.showFlickerImages(imageList: list)
        }
    }
    
    func testShowError() {
        controller.showError(errorMessage: Constants.defaultErrorMessage)
    }
    
    private var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
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
