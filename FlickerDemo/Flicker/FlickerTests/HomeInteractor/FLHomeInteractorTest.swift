//
//  FLHomeInteractorTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FLHomeInteractorTest: XCTestCase {

    var homeInteractor : FLHomeInteractor!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        homeInteractor = FLHomeInteractor()
        homeInteractor.webServiceManager = MockWebserviceManager()
        homeInteractor.imageDownloader = MockImageDwonloader()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        homeInteractor = nil
        super.tearDown()
    }
    
    func testCancelAllDownloads() {
        homeInteractor.cancellAllDownloads()
    }
    
    func testClearAllCachedData() {
        homeInteractor.clearAllCachedData()
    }
    
    func testFetchFlickerData() {
        let text : String? = "kitten"
        let page : Int = 1
        homeInteractor.fetchFlickerData(withQuery: text, withPageNumber: page, itemsPerPage: 20)
    }
}
