//
//  MockClasses.swift
//  FlickerTests
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit
@testable import Flicker

class MockView: FLHomePresenterOutputProtocol {
    func showFlickerImages(imageList : [FLDataProtocol]?) {
        
    }
    
    func showError(errorMessage : String) {
        
    }
}

class MockInteractor: FLHomeInteratorInputProtocol {
    
    weak var presenter : FLHomeInteratorOutputProtocol?
    
    var webServiceManager : FLWebEngineDataDownloader = MockWebserviceManager()
    
    var imageDownloader : FLImageDownloaderProtocol = MockImageDwonloader()
    
    func fetchFlickerData(withQuery text : String?, withPageNumber page : Int, itemsPerPage itemCount : Int) {
        
        guard let query = text else {
            cancellAllDownloads()
            return
        }
        
        if query.count == 0 {
            cancellAllDownloads()
        }
        else {
            let requestPath = "\(WebEngineConstant.flickerServicePath)?method=\(WebEngineConstant.flickerPhotoSearchMethod)&api_key=\(WebEngineConstant.flickerPhotoAPIKey)&format=\(WebEngineConstant.flickerPhotoFormat)&nojsoncallback=1&safe_search=1&text=\(query)&page=\(page)&per_page=20"
            
            webServiceManager.createDataRequest(withPath: requestPath, withParam: nil, withCustomHeader: nil, withRequestType: .GET) { [weak self] (data, error) in
                if let dataVal = data {
                    var list : [FLDataProtocol]?
                    
                    if let dataObjectInfo = dataVal as? [AnyHashable : Any], let photosInfo = dataObjectInfo["photos"] as? [AnyHashable : Any], let dataList = photosInfo["photo"] as? [Any] {
                        let builder = DataBuilder<FLModel>()
                        list = builder.getParsedDataList(withData: dataList)
                    }
                    
                    if let dataList = list {
                        self?.presenter?.flickerDataFetched(flickerData: .success(dataList))
                    }
                    else {
                        let noDataError = DataError()
                        noDataError.errorMessage = Constants.noResultsErrorMessage
                        self?.presenter?.flickerDataFetched(flickerData: .noData(noDataError))
                    }
                }
                else {
                    let err = error ?? DataError()
                    self?.presenter?.flickerDataFetched(flickerData: .error(err))
                }
            }
        }
    }
    
    func cancellAllDownloads() {
        webServiceManager.cancelAllTasks()
    }
    
    func clearAllCachedData() {
        imageDownloader.clearAllCachedData()
    }
}

class MockWebserviceManager: FLWebEngineDataDownloader {
    
    var taskInfo = [AnyHashable : FLWebServiceObject]()
    
    func createDataRequest(withPath path : String, withParam param: [AnyHashable : Any]?, withCustomHeader headers : [String : String]?, withRequestType type : RequestType, withCompletion completion : @escaping (Any?, DataError?) -> Void) {
        let jsonObject = self.getJSONObject(fromFile: "FlickerDataList")
        completion(jsonObject, nil)
    }
    
    func cancelAllTasks() {
        taskInfo.removeAll()
    }
    
    private func getJSONObject(fromFile fileName : String) -> [AnyHashable : Any]? {
        guard let pathURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: pathURL, options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [AnyHashable : Any] {
                return jsonResult
            }
            else {
                return nil
            }
        } catch {
            // handle error
            return nil
        }
    }
}

class MockImageDwonloader: FLImageDownloaderProtocol {
    
    func downLoadImage(withURLRequest request : URLRequest, downloadID identifier : String, ofSize newSize : CGSize, successCompletion : @escaping (URLRequest, URLResponse?, UIImage?) -> Void, failureCompletion : @escaping (URLRequest, URLResponse?, Error?) -> Void) -> FLImageDownloadStatus? {
        return nil
    }
    
    func cancelDownload(forStatus downloadStatus : FLImageDownloadStatusProtocol) {
        
    }
    
    func getImage(forIdentifier identifier : String) -> UIImage? {
        return nil
    }
    
    func clearAllCachedData() {
        
    }
}

class MockPresenter: FLHomeInteratorOutputProtocol, FLHomePresenterInputProtocol {
    
    var view : FLHomePresenterOutputProtocol?
    var interactor : FLHomeInteratorInputProtocol?
    var numberOfItemsPerRow: Int{
        return 3
    }
    
    func getFlickerImages(withQuery text : String?, withPageNumber page : Int) {
        
    }
    
    func flickerDataFetched(flickerData : FlickerDataFetchStatus) {
        
    }
    
    func numberOfItems(forScreenSize size : CGSize, itemSize : CGSize) {
        
    }
    
    func itemSize(withScreenWidth width : CGFloat) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

class ErrorObject: Error {
    
}
