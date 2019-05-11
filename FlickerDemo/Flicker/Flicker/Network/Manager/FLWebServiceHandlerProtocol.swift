//
//  FLWebServiceHandlerProtocol.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object as callback object for webservice made to server.
 */

protocol FLWebServiceHandlerProtocol {
     init(withCompletion completion : @escaping (Any?, DataError?) -> Void)
}
