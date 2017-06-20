//
//  Attachment.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 04.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class Attachment
{
    private var body:[String:Any]!
    var id:Int?
    func set(imageView:UIImageView)
    {
        DispatchQueue.main.async {
            imageView.image = UIImage(named: "ФонРегистрации.png")

        }
        
    }
     var title:String?
}
