//
//  FLHomePresenter.swift
//  Flicker
//
//  Created by B0203470 on 6/05/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import Foundation
import UIKit

/**
 This Type is used for presenter for home controller to talk to interactor for fetching data and showing the data to view.
 */

class FLHomePresenter : FLHomePresenterInputProtocol, FLHomeInteratorOutputProtocol {
    
    weak var view : FLHomePresenterOutputProtocol?
    var interactor : FLHomeInteratorInputProtocol?
    private var dataListVal = [FLDataProtocol]()
    private var searchtext : String?
    private var numberOfItems : Int = 0
    
    var numberOfItemsPerRow : Int {
        return PresenterConstant.numberOfItemsPerRow
    }

    func getFlickerImages(withQuery text : String?, withPageNumber page : Int) {
        if let previouslySearchTest = searchtext, let currentText = text, previouslySearchTest != currentText {
            showEmptyData(withPageNumber: page)
        }
        
        searchtext = text
        
        if let str = text {
            if str.count > 0 {
                interactor?.fetchFlickerData(withQuery: str, withPageNumber: page, itemsPerPage: numberOfItems)
            }
        }
        else {
            showEmptyData(withPageNumber: page)
        }
    }
    
    func flickerDataFetched(flickerData : FlickerDataFetchStatus) {
        switch flickerData {
        case .success(let dataList):
            if dataList.count > 0 {
                dataListVal.append(contentsOf: dataList)
            }
            view?.showFlickerImages(imageList: dataListVal)
        case .noData(let error):
            dataListVal.removeAll()
            view?.showError(errorMessage: error.errorMessage)
        case .error(let error):
            dataListVal.removeAll()
            view?.showError(errorMessage: error.errorMessage)
        }
    }
    
    func itemSize(withScreenWidth width : CGFloat) -> CGSize {
        let itemWidth = Int(Double(width)/Double(numberOfItemsPerRow))
        let itemHeight = itemWidth
        let itemSize = CGSize(width: itemWidth, height: itemHeight)
        return itemSize
    }
    
    func numberOfItems(forScreenSize size : CGSize, itemSize : CGSize) {
        let width = size.width
        let height = size.height
        let itemCountPerRow = Int(width/itemSize.width)
        numberOfItems = itemCountPerRow * Int(height/itemSize.width) + 2
    }
}

// Private Method Extension

extension FLHomePresenter {
    
    private struct PresenterConstant {
        static let numberOfItemsPerRow = 3
    }
    
    private func showEmptyData(withPageNumber page : Int) {
        dataListVal.removeAll()
        interactor?.cancellAllDownloads()
        interactor?.clearAllCachedData()
        view?.showError(errorMessage: Constants.noResultsErrorMessage)
        view?.showFlickerImages(imageList: nil)
    }
}
