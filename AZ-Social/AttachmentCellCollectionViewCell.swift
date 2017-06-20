//
//  AttachmentCellCollectionViewCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 03.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class AttachmentCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var attachment:Attachment?
    {
        didSet{
                attachment?.set(imageView: imageView)
            }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    @IBAction func deleteAttachment(_ sender: Any) {
        
    }
}
