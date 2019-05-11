//
//  FLImageDownloaderTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FLImageDownloaderTest: XCTestCase {

    var imageDownloader : FLImageDownloader!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        imageDownloader = nil
        super.tearDown()
    }

    func testImageDownlad() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        imageDownloader = FLImageDownloader.sharedDownloader

        if let imageUrl = URL(string: "http://farm8.static.flickr.com/578/23451156376_8983a8ebc7.jpg") {
            
            var request = URLRequest(url: imageUrl)
            request.addValue("image/*", forHTTPHeaderField: "Accept")
            let downloadId = UUID().uuidString
            let size = CGSize(width: 80, height: 80)
            
            let promise = expectation(description: "Completion handler invoked")
            var imageVal : UIImage?
            
            let _ = imageDownloader.downLoadImage(withURLRequest: request, downloadID: downloadId, ofSize: size, successCompletion: { (request, response, image) in
                imageVal = image
                promise.fulfill()
            }) { (request, response, error) in
                
            }
            
            waitForExpectations(timeout: 50, handler: nil)
            
            XCTAssertNotNil(imageVal, "Image Data response Found nil")
        }
    }
    
    func testClearAllCachedData() {
        imageDownloader = FLImageDownloader.sharedDownloader
        imageDownloader.clearAllCachedData()
    }

    func testCancelDownload() {
        imageDownloader = FLImageDownloader.sharedDownloader

        let requestPath = "http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg"
        if let url = URL(string: requestPath) {
            let downloadId = UUID().uuidString
            var request = URLRequest(url: url)
            request.addValue("image/*", forHTTPHeaderField: "Accept")
            let size = CGSize(width: 80, height: 80)
            
            let downloadStatus = imageDownloader.downLoadImage(withURLRequest: request, downloadID: downloadId, ofSize: size, successCompletion: { (request, response, image) in
            }) { (request, response, error) in
                
            }
            
            if let status = downloadStatus {
                imageDownloader.cancelDownload(forStatus: status)
            }
        }
        
    }
}
