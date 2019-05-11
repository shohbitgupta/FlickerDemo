//
//  FLHomeCollectionCellTest.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19. 

//  Copyright © 2019 Mine. All rights reserved.
//

import XCTest
@testable import Flicker

class FLHomeCollectionCellTest: XCTestCase {

    var cell : FLHomeCollectionViewCell!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cell = nil
        super.tearDown()
    }

    func testUpdateCell() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        createCell()
        let jsonObject = self.getJSONObject(fromFile: "FlickerData")
        let flkrModel : FLDataProtocol? = jsonObject != nil ? FLModel(withData: jsonObject!) : nil
        cell.updateCell(withData: flkrModel, withStatus: true)
    }
    
    func testUpdateCellWithIconImage() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        createCell()
        let jsonObject = self.getJSONObject(fromFile: "FlickerData")
        let flkrModel : FLDataProtocol? = jsonObject != nil ? FLModel(withData: jsonObject!) : nil
        cell.updateCell(withData: flkrModel, withStatus: false)
    }
    
    private func createCell() {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.register(UINib(nibName: MockViewConstant.MockCellConstant.cellNibName, bundle: nil), forCellWithReuseIdentifier: MockViewConstant.MockCellConstant.cellID)
        let indexPath = IndexPath(row: 0, section: 1)
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MockViewConstant.MockCellConstant.cellID, for: indexPath) as! FLHomeCollectionViewCell
        cell = itemCell
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

    private struct MockViewConstant {
        struct MockCellConstant {
            static let cellID = "FLHomeCollectionCellID"
            static let cellNibName = "FLHomeCollectionViewCell"
        }
    }
}
