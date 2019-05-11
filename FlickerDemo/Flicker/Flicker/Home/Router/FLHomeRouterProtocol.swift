//
//  FLHomeRouterProtocol.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object as router of creating, pushing and presenting view (view controller).
 */

protocol FLHomeRouterProtocol {
    static func initializeHomeController() -> ViewController
}
