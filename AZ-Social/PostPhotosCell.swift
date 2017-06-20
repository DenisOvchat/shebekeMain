//
//  PostPhotosCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 26.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class PostPhotosCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var photoInfo:PictureFromNetInfo!
    {
            
        didSet
        {
            imageView.downloadedFrom(link: photoInfo.URLstring)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
