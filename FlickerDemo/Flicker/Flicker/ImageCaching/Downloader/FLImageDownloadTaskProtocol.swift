//
//  FLImageDownloadTaskProtocol.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object as webservice object for tracking webservice made to server.
 */

protocol FLImageDownloadTaskProtocol {
    init(dataTask task : URLSessionDataTask, taskID identifier : String)
    func addTaskHandler(handler : FLImageTaskHandler)
    func removeHandler(handler : FLImageTaskHandler)
}
