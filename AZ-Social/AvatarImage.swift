//
//  AvatarImage.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 10.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class AvatarImage:UIView
{
    //var isOnline:Bool = false
   // var size:CGFloat = 0.0
    var statusView = UIView()
    var imageView = UIImageView()
    func setting(isonline:Bool,radius:CGFloat)
    {
        backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
        imageView.frame = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        imageView.layer.cornerRadius = radius
        imageView.layer.masksToBounds = true
        statusView.frame = CGRect(x: radius + radius * sqrt(1/2) - 4, y: radius + radius * sqrt(1/2) - 4, width: 7, height: 7)
        statusView.layer.cornerRadius = 3.5
        statusView.layer.borderWidth = 1
        statusView.backgroundColor = UIColor(red: 0, green: 148, blue: 176, al: 1)
        statusView.layer.borderColor = UIColor.white.cgColor
        //imageView.contentMode = .
        
        addSubview(imageView)
        addSubview(statusView)
       // statusView . isHidden = !isOnline
    }
    
    
}
