//
//  FLHomeInteractor.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation

/**
 This Type is used for interactor for home controller to talk to server or data provider for fetching data and pass it to presenter.
 */

class FLHomeInteractor : FLHomeInteratorInputProtocol {
    
    weak var presenter : FLHomeInteratorOutputProtocol?
    var webServiceManager : FLWebEngineDataDownloader = FLWebServiceManager.sharedInstance
    var imageDownloader : FLImageDownloaderProtocol = FLImageDownloader.sharedDownloader
    
    func cancellAllDownloads() {
        webServiceManager.cancelAllTasks()
    }
    
    func clearAllCachedData() {
        imageDownloader.clearAllCachedData()
    }
    
    func fetchFlickerData(withQuery text : String?, withPageNumber page : Int, itemsPerPage itemCount : Int) {
        
        guard let query = text else {
            cancellAllDownloads()
            return
        }
        
        if query.count == 0 {
            cancellAllDownloads()
        }
        else {
            let count = itemCount > 0 ? itemCount : 20
            
            let requestPath = "\(WebEngineConstant.flickerServicePath)?method=\(WebEngineConstant.flickerPhotoSearchMethod)&api_key=\(WebEngineConstant.flickerPhotoAPIKey)&format=\(WebEngineConstant.flickerPhotoFormat)&nojsoncallback=1&safe_search=1&text=\(query)&page=\(page)&per_page=\(count)"
            
            webServiceManager.createDataRequest(withPath: requestPath, withParam: nil, withCustomHeader: nil, withRequestType: .GET) { [weak self] (data, error) in
                if let dataVal = data {
                    DispatchQueue.global().async {
                        
                        var list : [FLDataProtocol]?
                        
                        if let dataObjectInfo = dataVal as? [AnyHashable : Any], let photosInfo = dataObjectInfo["photos"] as? [AnyHashable : Any], let dataList = photosInfo["photo"] as? [Any] {
                            let builder = DataBuilder<FLModel>()
                            list = builder.getParsedDataList(withData: dataList)
                        }
                        
                        DispatchQueue.main.async {
                            if let dataList = list {
                                self?.presenter?.flickerDataFetched(flickerData: .success(dataList))
                            }
                            else {
                                let noDataError = DataError()
                                noDataError.errorMessage = Constants.noResultsErrorMessage
                                self?.presenter?.flickerDataFetched(flickerData: .noData(noDataError))
                            }
                        }
                    }
                }
                else {
                    let err = error ?? DataError()
                    self?.presenter?.flickerDataFetched(flickerData: .error(err))
                }
            }
        }
    }
}
