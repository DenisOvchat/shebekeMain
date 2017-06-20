//
//  CommentCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 14.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var imagevw: AvatarImage!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    var comment :Comment?
        {
        didSet(s){
            
            imagevw.setting(isonline: true, radius: 25)
            if let link = s?.sender?.pictUrl
            {
                imagevw.imageView.downloadedFrom(link: link)
                
            }
            imagevw.imageView.contentMode = .scaleAspectFit
            
            NameLabel.text = (s?.sender?.name)! + " " + (s?.sender?.secondName)!
            
            
            
            
        }
        
    }

    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
