//
//  dialogsCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 25.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class DialogsCell:UITableViewCell
{
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var message: UILabel!
    
    @IBOutlet weak var imagevw: AvatarImage!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var checkMark: UIImageView!
    override func awakeFromNib() {
        selectionStyle = .none
    }
    
    var man :dialogBody?
    {
        set(s){
            countLabel.layer.cornerRadius = 10.5
            countLabel.layer.masksToBounds = true
            imagevw.setting(isonline: true, radius: 25)
            if let link = s?.pictUrl
            {
                imagevw.imageView.downloadedFrom(link: link)

            }
            imagevw.imageView.contentMode = .scaleAspectFit
            
            NameLabel.text = (s?.name)! + " " + (s?.secondName)!
            
            if s!.chat.messages.count > 0
            {
                let mes = s?.chat.messages[s!.chat.messages.count - 1]
                message.text = mes!.text
                timeLabel.text = mes!.time
                
                if mes!.isMine
                {
                    if mes!.isRed
                    {
                        checkMark.isHidden = true

                    }
                    else
                    {
                        
                        checkMark.isHidden = false
                    }
                    countLabel.isHidden = true

                }
                else
                {
                    if s!.chat.newMessagesCount == 0
                    {
                        countLabel.isHidden = true
                    }
                    else
                    {
                        countLabel.isHidden = false
                        countLabel . text = s!.chat.newMessagesCount.description
                    }
                }
            }
            
            
        }
        get{
            return nil
        }
    }
    
   /* required init?(coder aDecoder: NSCoder) {
       // self = super.init(coder: aDecoder)
        
       
    }*/
    
}
