//
//  FLImageDownloaderProtocol.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit

/**
 This Protocol is to provide requirements for making any object as image downlaod manager for fetching image from server.
 */

protocol FLImageDownloaderProtocol {
    func downLoadImage(withURLRequest request : URLRequest, downloadID identifier : String, ofSize newSize : CGSize, successCompletion : @escaping (URLRequest, URLResponse?, UIImage?) -> Void, failureCompletion : @escaping (URLRequest, URLResponse?, Error?) -> Void) -> FLImageDownloadStatus?
    func cancelDownload(forStatus downloadStatus : FLImageDownloadStatusProtocol)
    func getImage(forIdentifier identifier : String) -> UIImage?
    func clearAllCachedData()
}
