//
//  FLWebEngineDataDownloader.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2018 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object as webservice manager for fetching data from server.
 */

protocol FLWebEngineDataDownloader {
    func createDataRequest(withPath path : String, withParam param: [AnyHashable : Any]?, withCustomHeader headers : [String : String]?, withRequestType type : RequestType, withCompletion completion : @escaping (Any?, DataError?) -> Void)
    func cancelAllTasks()
}
