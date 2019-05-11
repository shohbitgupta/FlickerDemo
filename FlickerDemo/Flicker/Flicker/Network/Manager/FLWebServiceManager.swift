//
//  FLWebServiceManager.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit

/**
 This Type to define different type of requests.
 */

enum RequestType : String {
    case GET
    case POST
    case PUT
    case DELETE
}

/**
 This Type is used for fetching, uploading data from or to any API from the server.
 */

final class FLWebServiceManager : FLURLSessionManager {
    
    static let sharedInstance = FLWebServiceManager()
    private var webServiceObjectInfo : [AnyHashable : FLWebServiceObject] = [:]
    private var activityCounter = 0

    private override init() {
        super.init()
    }
}

extension FLWebServiceManager : FLWebEngineDataDownloader {
    
    /**
     This method will be used for creating web request.
     - Parameter path: path is the end point from which we need to load the data from server.
     - Parameter param: param is json we need to give as request param.
     - Parameter headers: headers is the additional headers which are required for URL request.
     - Parameter type: type is the RequestType (i.e. GET, POST, DELETE, PUT etc.).
     - Parameter completion: completion is the callback once data is fetched.
     */
    
    func createDataRequest(withPath path : String, withParam param: [AnyHashable : Any]?, withCustomHeader headers : [String : String]? , withRequestType type : RequestType, withCompletion completion : @escaping (Any?, DataError?) -> Void)
    {
        switch type {
        case .GET:
            self.createRequest(withPath: path, withParam: param, withCustomHeader: headers, withRequestType: type, withCompletion: completion)

        default:
            print("TO DO")
        }
    }
    
    func cancelAllTasks() {
        let alltasks = webServiceObjectInfo.values
        for task in alltasks {
            task.dataTask.cancel()
            task.removeAllHandler()
        }
        webServiceObjectInfo.removeAll()
        activityCounter = 0
        updateNetworkActibityIndicator()
    }
}

// Private Method Extension

extension FLWebServiceManager {

    private func createRequest(withPath path : String, withParam param: [AnyHashable : Any]?, withCustomHeader headers : [String : String]? , withRequestType type : RequestType, withCompletion completion : @escaping (Any?, DataError?) -> Void)
    {
        if let serviceObj = webServiceObjectInfo[path] {
            let handler = FLWebServiceHandler(withCompletion: completion)
            serviceObj.addTaskHandler(handler: handler)
            return
        }
        
        let successBlock = { [weak self] (dataTask: URLSessionDataTask?, response : Any?) in
             guard let serviceObj = self?.webServiceObjectInfo[path] else {
                let error = DataError()
                completion(nil, error)
                return
            }
            
            guard let responseData = response as? Data else {
                let error = DataError()
                for handler in serviceObj.handlerList {
                    handler.completionBlock(nil, error)
                }
                self?.removeServiceObject(withIdentifier: path)
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                for handler in serviceObj.handlerList {
                    handler.completionBlock(jsonObject, nil)
                }
            } catch let myJSONError {
                let error = DataError()
                print(myJSONError)
                for handler in serviceObj.handlerList {
                    handler.completionBlock(nil, error)
                }
            }
            
            self?.removeServiceObject(withIdentifier: path)
        }
        
        let failureBlock = { [weak self] (dataTask: URLSessionDataTask?, error : Error?) in
            guard let serviceObj = self?.webServiceObjectInfo[path] else {
                let error = DataError()
                completion(nil, error)
                return
            }
            
            guard let dataError = error else {
                let error = DataError()
                for handler in serviceObj.handlerList {
                    handler.completionBlock(nil, error)
                }
                self?.removeServiceObject(withIdentifier: path)
                return
            }
            
            let error = DataError(withError: dataError)
            for handler in serviceObj.handlerList {
                handler.completionBlock(nil, error)
            }
            self?.removeServiceObject(withIdentifier: path)
        }
        
        switch type {
        case .GET:
            if let dataTask = self.getRequest(withURLStr: path, requestType: type, param: param, headers: headers, successHander: successBlock, failureHandler: failureBlock) {
                let webServiceObj = FLWebServiceObject(dataTask: dataTask, taskID: path)
                let handler = FLWebServiceHandler(withCompletion: completion)
                webServiceObj.addTaskHandler(handler: handler)
                addTask(serviceObject: webServiceObj, identifier: path)
            }
            
        case .POST:
            print("Not Required")
        case .DELETE:
            print("Not Required")
        case .PUT:
            print("Not Required")
        }
    }
    
    private func getRequest(withURLStr urlStr : String, requestType type: RequestType, param paramVal: [AnyHashable : Any]?, headers headerVal: [String : String]?, successHander successBlock: ((URLSessionDataTask?, Any?) -> Void)?, failureHandler failureBlock: ((URLSessionDataTask?, Error?) -> Void)?) -> URLSessionDataTask? {
        let dataTaskVal = dataTask(withURLStr: urlStr, requestType: type, param: paramVal, headers: headerVal, successHander: successBlock, failureHandler: failureBlock)
        dataTaskVal?.resume()
        return dataTaskVal
    }
    
    private func addTask(serviceObject : FLWebServiceObject, identifier : String) {
        if let _ = webServiceObjectInfo[identifier] {
            
        }
        else {
            webServiceObjectInfo[identifier] = serviceObject
            incrementActivityCount()
        }
    }
    
    private func removeServiceObject(withIdentifier identifier : String) {
        if let _ = webServiceObjectInfo[identifier] {
            webServiceObjectInfo.removeValue(forKey: identifier)
            decrementActivityCount()
        }
    }
    
    private func decrementActivityCount() {
        activityCounter -= 1
        if activityCounter < 0 {
            activityCounter = 0
        }
        updateNetworkActibityIndicator()
    }
    
    private func incrementActivityCount() {
        activityCounter += 1
        updateNetworkActibityIndicator()
    }
    
    private func updateNetworkActibityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = (activityCounter > 0)
    }
}

