//
//  FLHomeCollectionViewCell.swift
//  Flicker
//
//  Created by B0095764 on 1/20/19.
//  Copyright © 2019 Mine. All rights reserved.
//

import UIKit

/**
 This Type is used for view image data in collection view cell.
 */

class FLHomeCollectionViewCell: UICollectionViewCell, CellUpdateProtocol {

    @IBOutlet weak var cellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(withData data : FLDataProtocol?, withStatus status : Bool) {
        let placeHolderImage = UIImage(named: "placeholder")
        cellImageView.image = placeHolderImage
        if let url = data?.flickerImageURL {
            let size = cellImageView.bounds.size
            cellImageView.setImage(withUrl: url, ofSize : size, withPlaceHolderImage: placeHolderImage, successCompletion: { [weak self] (request, response, image) in
                self?.cellImageView.image = image
            }) { (request, response, error) in
                
            }
        }
    }
}
