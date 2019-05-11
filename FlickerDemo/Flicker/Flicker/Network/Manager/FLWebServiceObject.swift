//
//  FLWebServiceObject.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Type is used for tracking webservice made to server.
 */

class FLWebServiceObject : FLWebServiceObjectProtocol {
    
    let dataTask : URLSessionDataTask
    private let taskID : String
    private(set) var handlerList : [FLWebServiceHandler] = []
    
    required init(dataTask task : URLSessionDataTask, taskID identifier : String) {
        dataTask = task
        taskID = identifier
    }
    
    func addTaskHandler(handler : FLWebServiceHandler) {
        if !handlerList.contains(handler) {
            handlerList.append(handler)
        }
    }
    
    func removeHander(handler : FLWebServiceHandler) {
        if handlerList.contains(handler) {
            handlerList = handlerList.filter{ $0 != handler }
        }
    }
    
    func removeAllHandler() {
        handlerList.removeAll()
    }
}
