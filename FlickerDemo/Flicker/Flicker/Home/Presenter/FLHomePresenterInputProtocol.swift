//
//  FLHomePresenterInputProtocol.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit

/**
 This Protocol is to provide requirements for making any object home presenter to give input to view.
 */

protocol FLHomePresenterInputProtocol : AnyObject {
    var view : FLHomePresenterOutputProtocol? { get set }
    var numberOfItemsPerRow : Int { get }
    var interactor : FLHomeInteratorInputProtocol? { get set }
    func getFlickerImages(withQuery text : String?, withPageNumber page : Int)
    func numberOfItems(forScreenSize size : CGSize, itemSize : CGSize)
    func itemSize(withScreenWidth width : CGFloat) -> CGSize
}
