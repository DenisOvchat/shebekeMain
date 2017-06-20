//
//  customCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 10.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import  UIKit
class cellFriend:UITableViewCell
{
    
    @IBOutlet weak var avat: AvatarImage!
    @IBOutlet weak var name: UILabel!
    
    
    
    
    
    func setcell(friend:Person)
    {
        avat.imageView.contentMode =  .scaleAspectFit

        UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)
        UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)

        var nm = NSAttributedString(string: friend.name!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15, weight: UIFontWeightMedium)])
        var sn = NSAttributedString(string: " " + friend.secondName!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)])
        var st = NSMutableAttributedString(attributedString: nm)
        st.append(sn)
        self.name.attributedText = st
        //self.name.textColor = UIColor.blue
        
        avat.setting(isonline: true, radius: 25)
        if let url = friend.pictUrl
        {
            avat.imageView.downloadedFrom(link: url)

        }
        avat.imageView = UIImageView()
    }
    
}
