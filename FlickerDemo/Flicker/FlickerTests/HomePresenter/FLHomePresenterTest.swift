//
//  FLHomePresenterTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker


class FLHomePresenterTest: XCTestCase {

    var homePresenter : FLHomePresenter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        homePresenter = FLHomePresenter()
        homePresenter.interactor = MockInteractor()
        homePresenter.interactor?.presenter = homePresenter
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homePresenter = nil
        super.tearDown()
    }

    func testGetFlickerImages() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let serachText = "kitten"
        let page = 1
        homePresenter.getFlickerImages(withQuery: serachText, withPageNumber: page)
    }
    
    func testFlickerDataFetched() {
        let jsonObject = self.getJSONObject(fromFile: "FlickerData")
        let flkrModel : FLDataProtocol = FLModel(withData: jsonObject ?? [:])
        let flickerData : FlickerDataFetchStatus = .success([flkrModel])
        homePresenter.flickerDataFetched(flickerData: flickerData)
    }
    
    func testFlickerNoDataFetched() {
        let flickerData : FlickerDataFetchStatus = .noData(DataError())
        homePresenter.flickerDataFetched(flickerData: flickerData)
    }
    
    func testFlickerDataFetchedError() {
        let flickerData : FlickerDataFetchStatus = .error(DataError())
        homePresenter.flickerDataFetched(flickerData: flickerData)
    }
    
    func flickerDataFetched(flickerData : FlickerDataFetchStatus) {
        
        let mockView = MockView()
        switch flickerData {
        case .success(let dataList):
            mockView.showFlickerImages(imageList: dataList)
        case .noData(let error):
            mockView.showError(errorMessage: error.errorMessage)
        case .error(let error):
            mockView.showError(errorMessage: error.errorMessage)
        }
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
