//
//  DialogCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 28.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class DialogCell:UITableViewCell
{
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var cloud: UIView!
    
    @IBOutlet weak var txtLabel: UILabel!
    
    func setCell(mes:Message)
    {
        
        
        txtLabel.text = mes.text
        time.text = mes.time
        //txtLabel.backgroundColor = UIColor.blue
        
        cloud.layer.masksToBounds = true
        cloud.layer.cornerRadius = 18
        
    }
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
     }
    
}
