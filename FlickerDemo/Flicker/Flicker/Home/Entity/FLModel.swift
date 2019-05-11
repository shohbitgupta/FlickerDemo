//
//  FLModel.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit

/*
 {
 "id": "23451156376",
 "owner": "28017113@N08",
 "secret": "8983a8ebc7",
 "server": "578",
 "farm": 1,
 "title": "Merry Christmas!",
 "ispublic": 1,
 "isfriend": 0,
 "isfamily": 0
 }
 */

/**
 This Type is used for model objects of Flicker image objects.
 */

class FLModel : DataInitializer, FLDataProtocol {
    
    private let modeId : String?
    private let owner : String?
    private let secret : String?
    private let server : String?
    private let farm : Int?
    private let title : String
    private let ispublic : Bool?
    private let isfriend : Bool?
    private let isfamily : Bool?

    var flickerImageURL : URL? {
        return URL(string: "http://farm\(farm ?? 0).static.flickr.com/\(server ?? "")/\(modeId ?? "")_\(secret ?? "").jpg")
    }
        
    /**
     This method will be used for initializing Planet object from JSON object.
     - Parameter data: data is the JSON object.
     */
    
    required init(withData data : [AnyHashable : Any]) {
        modeId = data["id"] as? String
        owner = data["owner"] as? String
        secret = data["secret"] as? String
        server = data["server"] as? String
        farm = data["farm"] as? Int
        title = data["title"] as? String ?? Constants.noData
        ispublic = data["ispublic"] as? Bool
        isfriend = data["isfriend"] as? Bool
        isfamily = data["isfamily"] as? Bool
    }
}
