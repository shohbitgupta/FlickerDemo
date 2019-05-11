//
//  FLURLSessionManagerProtocol.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Protocol is to provide requirements for making any object as session manager for fetching data from server.
 */

protocol FLURLSessionManagerProtocol {
    
    func dataTask(withURLStr urlStr : String, requestType type: RequestType, param paramVal: [AnyHashable : Any]?, headers headerVal: [String : String]?, successHander successBlock: ((URLSessionDataTask?, Any?) -> Void)?, failureHandler failureBlock: ((URLSessionDataTask?, Error?) -> Void)?) -> URLSessionDataTask?
    
    func dataTask(withRequest reuest : URLRequest, withCompletion completion : ((URLResponse?, Any?, Error?) -> Void)?) -> URLSessionDataTask
}
