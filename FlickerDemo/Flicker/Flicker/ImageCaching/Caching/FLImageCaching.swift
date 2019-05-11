//
//  FLImageCaching.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC.runtime

/**
 This extension has been made on UIImageView to call direct methods for image downloads for image url.
 */

extension UIImageView : FLImageCacheProtocol {
    
    var imageDownloader: FLImageDownloaderProtocol {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.downloaderName) as? FLImageDownloader else {
                    return FLImageDownloader.sharedDownloader
                }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.downloaderName, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var imageDownloadStatus: FLImageDownloadStatusProtocol? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.downloadStatus) as? FLImageDownloadStatus else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.downloadStatus, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setImage(withUrl imageURL : URL, ofSize newSize : CGSize) {
        setImage(withUrl: imageURL, ofSize: newSize, withPlaceHolderImage: nil)
    }
    
    func setImage(withUrl imageURL : URL, ofSize newSize : CGSize, withPlaceHolderImage placeHolderImage : UIImage?) {
        setImage(withUrl: imageURL, ofSize: newSize, withPlaceHolderImage: placeHolderImage, successCompletion: nil, failureCompletion: nil)
    }
    
    func setImage(withUrl imageURL : URL, ofSize newSize : CGSize, withPlaceHolderImage placeHolderImage : UIImage?, successCompletion successCallback : ((URLRequest, URLResponse?, UIImage?) -> Void)?, failureCompletion failureCallback : ((URLRequest, URLResponse?, Error?) -> Void)?)  {
        
        if checkDownloadInProgress(forPath: imageURL.absoluteString) {
            return
        }
        
        cancelDownload()
        
        var request = URLRequest(url: imageURL)
        request.addValue("image/*", forHTTPHeaderField: "Accept")
        
        if let cachedImage = imageDownloader.getImage(forIdentifier: imageURL.absoluteString) {
            if let success = successCallback {
                success(request, nil, cachedImage)
            }
            else {
                self.image = cachedImage
            }
        }
        else {
            if let imageVal = placeHolderImage {
                self.image = imageVal
            }

            let downloadId = UUID().uuidString
            
            let downloadStatus = imageDownloader.downLoadImage(withURLRequest: request, downloadID: downloadId, ofSize : newSize, successCompletion: { [weak self] (request, response, image) in
                if self?.imageDownloadStatus?.downloadID == downloadId {
                    if let success = successCallback {
                        success(request, response, image)
                    }
                    else if let imageVal = image {
                        self?.image = imageVal
                    }
                    self?.clearDownloadStatus()
                }
            }) { [weak self] (request, response, error) in
                if self?.imageDownloadStatus?.downloadID == downloadId {
                    if let failure = failureCallback {
                        failure(request, nil, error)
                    }
                    else if let imageVal = placeHolderImage {
                        self?.image = imageVal
                    }
                    self?.clearDownloadStatus()
                }
            }
            
            imageDownloadStatus = downloadStatus
        }
    }
    
    private func checkDownloadInProgress(forPath path : String) -> Bool {
        if let originalUrlStr = self.imageDownloadStatus?.dataTask.originalRequest?.url?.absoluteString, originalUrlStr == path {
            return true
        }
        return false
    }
    
    private func cancelDownload() {
        if let status = imageDownloadStatus {
            imageDownloader.cancelDownload(forStatus: status)
            clearDownloadStatus()
        }
    }
    
    private func clearDownloadStatus() {
        if let _ = imageDownloadStatus {
            imageDownloadStatus = nil
        }
    }
    
    private struct AssociatedKeys {
        static var downloaderName = "img_dwnld_name"
        static var downloadStatus = "img_dwnld_status"
    }
}

