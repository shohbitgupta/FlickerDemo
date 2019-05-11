//
//  FLHomeInteratorInputProtocol.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object home interactor to give input to presenter.
 */

protocol FLHomeInteratorInputProtocol : AnyObject {
    var presenter : FLHomeInteratorOutputProtocol? { get set }
    func fetchFlickerData(withQuery text : String?, withPageNumber page : Int, itemsPerPage itemCount : Int)
    func cancellAllDownloads()
    func clearAllCachedData()
}
