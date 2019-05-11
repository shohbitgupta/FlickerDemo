//
//  FLURLSessionManager.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Type is used for fetching, uploading data from or to any API from the server.
 */

class FLURLSessionManager {
    
    private let urlSession : URLSession
    
    init() {
        let sessionConfig = URLSessionConfiguration.default
        let opQueue = OperationQueue()
        opQueue.maxConcurrentOperationCount = 1
        urlSession = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: opQueue)
    }
    
    init(withConfiguration config : URLSessionConfiguration) {
        let opQueue = OperationQueue()
        opQueue.maxConcurrentOperationCount = 1
        urlSession = URLSession(configuration: config, delegate: nil, delegateQueue: opQueue)
    }
    
    static func defaultURLSessionManager() -> FLURLSessionManager {
        return FLURLSessionManager()
    }
    
    static func sessionManager(withConfiguration sessionConfig : URLSessionConfiguration) -> FLURLSessionManager {
        return FLURLSessionManager(withConfiguration: sessionConfig)
    }
}

extension FLURLSessionManager : FLURLSessionManagerProtocol {
    
    @discardableResult
    func dataTask(withURLStr urlStr : String, requestType type: RequestType, param paramVal: [AnyHashable : Any]?, headers headerVal: [String : String]?, successHander successBlock: ((URLSessionDataTask?, Any?) -> Void)?, failureHandler failureBlock: ((URLSessionDataTask?, Error?) -> Void)?) -> URLSessionDataTask? {
        
        guard let urlReq = URL(string: urlStr) else {
            if let failure = failureBlock {
                failure(nil, DataError())
            }
            return nil
        }
        
        var request = URLRequest(url: urlReq)
        request.httpMethod = requestMethod(withRequestType: type)
        if let customHeader = headerVal {
            for (key, value) in customHeader {
                if let _ = request.value(forHTTPHeaderField: key) {
                }
                else {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        if let paramData = paramVal {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: paramData, options: JSONSerialization.WritingOptions(rawValue: 0))
            } catch let myJSONError {
                print(myJSONError)
                return nil
            }
        }
        
        var task : URLSessionDataTask?
        task = dataTask(withRequest: request) { (response, data, error) in
            if let dataError = error {
                if let failure = failureBlock {
                    failure(task, dataError)
                }
            }
            else {
                if let success = successBlock {
                    success(task, data)
                }
            }
        }
        
        return task
    }
    
    @discardableResult
    func dataTask(withRequest reuest : URLRequest, withCompletion completion : ((URLResponse?, Any?, Error?) -> Void)?) -> URLSessionDataTask {
        let dataTask = urlSession.dataTask(with: reuest) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let handler = completion {
                    handler(response, data, error)
                }
            }
        }
        return dataTask
    }
}

// Private Method Extension

extension FLURLSessionManager {
    
    private func requestMethod(withRequestType type : RequestType) -> String {
        return type.rawValue
    }
}

