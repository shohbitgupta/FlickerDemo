//
//  FLImageDownloadStatus.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Type is used for status tracking for image download service.
 */

class FLImageDownloadStatus : FLImageDownloadStatusProtocol {
    
    let dataTask : URLSessionDataTask
    let downloadID : String
    
    required init(dataTask task : URLSessionDataTask, downloadID identifier : String) {
        dataTask = task
        downloadID = identifier
    }
}
