//
//  FiveFriendsCollectionCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 27.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class FiveFriendsCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var avat: AvatarImage!
    @IBOutlet weak var name: UILabel!
    
    func setcell(friend:Person)
    {
        /*var nm = NSAttributedString(string: friend.name, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)])
         var sn = NSAttributedString(string: friend.secondName, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)])
         var st = NSMutableAttributedString(attributedString: nm)
         st.append(sn)
         self.name.attributedText = st*/
        //self.name.textColor = UIColor.blue
        
        
        self.name.text = friend.name
        //self.name.attributedText = st
       // self.name.textColor = UIColor.blue
        
        avat.setting(isonline: true, radius: 25)
        if let picturl = friend.pictUrl
        {
            avat.imageView.downloadedFrom(link: picturl)

        }
        if let url = friend.pictUrl
        {
            avat.imageView.downloadedFrom(link: url)
            avat.imageView.contentMode =  .scaleAspectFit
        }
        
        
        // imagevw.imageView.contentMode = .scaleAspectFit
        
    }

}
