//
//  SettingsCellWSwitch.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 02.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class SettingsCellWSwitch: UITableViewCell {
    let switcher = UISwitch()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryView = switcher
            switcher.addTarget(self, action: #selector(valueChanged), for: UIControlEvents.valueChanged)
        
        // Initialization code
    }
    var isOn:Bool = false
    {
        didSet{
            switcher.isOn = isOn
            accessoryView = switcher
        }
    }
    var changeValueHandler:((Bool)->Void)?
 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func valueChanged() {
        if let handler = changeValueHandler
        {
            handler(switcher.isOn)
        }
        
    }
}
