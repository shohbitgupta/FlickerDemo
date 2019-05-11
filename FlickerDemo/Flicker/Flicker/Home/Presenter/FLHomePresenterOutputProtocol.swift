//
//  FLHomePresenterOutputProtocol.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object home presenter to give out to view.
 */

protocol FLHomePresenterOutputProtocol : AnyObject {
    func showFlickerImages(imageList : [FLDataProtocol]?)
    func showError(errorMessage : String)
}
