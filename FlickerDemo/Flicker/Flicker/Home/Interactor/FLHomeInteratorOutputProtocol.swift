//
//  FLHomeInteratorOutputProtocol.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object home interactor to give output to presenter.
 */

enum FlickerDataFetchStatus {
    case success([FLDataProtocol])
    case noData(DataError)
    case error(DataError)
}

protocol FLHomeInteratorOutputProtocol : AnyObject {
    func flickerDataFetched(flickerData : FlickerDataFetchStatus)
}
