//
//  TableViewCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 03.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos




class AddPostCell: UITableViewCell {
    


    
    
    
    var attachments = [Attachment]()
    
    let attachmentUpdatesQueue = DispatchQueue(label: "lab", qos: .utility)
    
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var separator1: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        separator.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        separator1.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor

        selectionStyle = .none
        
        
        //register(AttachmentCellCollectionViewCell.self, forCellWithReuseIdentifier: "attachmentCell")
        //register(UINib(nibName: "AttachmentCellCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "attachmentCell")
        //textView.contentHorizontalAlignment = .fill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
    
}

