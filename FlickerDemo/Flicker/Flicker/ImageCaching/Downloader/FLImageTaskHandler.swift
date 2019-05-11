//
//  FLImageTaskHandler.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit

/**
 This Type is used for webservice callback made to server.
 */

class FLImageTaskHandler : NSObject, FLImageTaskHandlerProtocol {
    
    private(set) var dwnldID : String
    private(set) var successCallBack : (URLRequest, URLResponse?, UIImage?) -> Void
    private(set) var failureCallBack : (URLRequest, URLResponse?, Error?) -> Void
    
    required init(downloadId identifier : String, success : @escaping (URLRequest, URLResponse?, UIImage?) -> Void, failure : @escaping (URLRequest, URLResponse?, Error?) -> Void) {
        dwnldID = identifier
        successCallBack = success
        failureCallBack = failure
    }
}
