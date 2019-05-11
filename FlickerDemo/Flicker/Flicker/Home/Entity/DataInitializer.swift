//
//  DataInitializer.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for initializing any application object such as Planet.
 */

protocol DataInitializer {
    init(withData data : [AnyHashable : Any])
}
