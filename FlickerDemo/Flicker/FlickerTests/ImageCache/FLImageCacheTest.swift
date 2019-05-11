//
//  FLImageCacheTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FLImageCacheTest: XCTestCase {

    var imageView : UIImageView!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        imageView = UIImageView(frame: CGRect.zero)
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        imageView = nil
        super.tearDown()
    }
    
    func testDownloadImage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let url = URL(string: "http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg") {
            let placeHolderImage = UIImage(named: "placeholder")
            let promise = expectation(description: "Completion handler invoked")
            var imageVal : UIImage?
            
            imageView.setImage(withUrl: url, ofSize: CGSize(width: 80, height: 80), withPlaceHolderImage: placeHolderImage, successCompletion: { (request, response, image) in
                imageVal = image
                promise.fulfill()
                
            }) { (request, response, error) in
                
            }
            
            waitForExpectations(timeout: 50, handler: nil)
            
            XCTAssertNotNil(imageVal, "Image Data response Found nil")
        }
    }
    
    func testDownloadImageFailure() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let url = URL(string: "http://farm1.static.com//23451156376_8983a8ebc7.jpg") {
            let placeHolderImage = UIImage(named: "placeholder")
            let promise = expectation(description: "Completion handler invoked")
            var errVal : Error?
            
            imageView.setImage(withUrl: url, ofSize: CGSize(width: 80, height: 80), withPlaceHolderImage: placeHolderImage, successCompletion: { (request, response, image) in
                
            }) { (request, response, error) in
                errVal = error
                promise.fulfill()
            }
            
            waitForExpectations(timeout: 50, handler: nil)
            
            XCTAssertNotNil(errVal, "Error Data response Found nil")
        }
    }
    
    func testDownloadImage1() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let url = URL(string: "http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg") {
            
            imageView.setImage(withUrl: url, ofSize: CGSize(width: 80, height: 80))
            
            XCTAssertNotNil(imageView.image, "Image Data response Found nil")
        }
    }
    
    func testDownloadImage2() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        if let url = URL(string: "http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg") {
            let placeHolderImage = UIImage(named: "placeholder")
            
            imageView.setImage(withUrl: url, ofSize: CGSize(width: 80, height: 80), withPlaceHolderImage: placeHolderImage)
                        
            XCTAssertNotNil(imageView.image, "Image Data response Found nil")
        }
    }
    
    func testSetImageDownloader() {
        imageView.imageDownloader = MockImageDwonloader()
        XCTAssertNotNil(imageView.imageDownloader, "Image Data Downloader Found nil")
    }
}
