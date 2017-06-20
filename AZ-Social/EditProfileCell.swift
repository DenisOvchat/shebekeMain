//
//  EditProfileCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 11.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.


import UIKit

class EditProfileCell: UITableViewCell {
    
    @IBOutlet weak var containerView: containerViewForEditing!
    var textFields = [UITextField]()
    var dictinary:NSDictionary!
    var fieldNames = [String]()
    
    @IBOutlet weak var contHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        containerView.layer.borderWidth = 0.5
        containerView.layer.cornerRadius = 8
        containerView.layer.masksToBounds = true    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        for textField in textFields
        {
            textField.removeFromSuperview()
        }
    }
    func setCell(fieldsNames: [String],dict:NSDictionary)
    {
        containerView.number = fieldsNames.count
        self.fieldNames = fieldsNames
        dictinary = dict
        contHeightConstraint.constant = CGFloat(fieldNames.count) * 49

        //containerView.frame = CGRect(x: 0, y: 0, width: Int(contentView.frame.width - 30) , height: 49 * fieldsNames.count)
        
        
        
    }
    override func draw(_ rect: CGRect) {
        var currentTop:CGFloat = 0
        
        for i in 0..<fieldNames.count
        {
            
            let frame = CGRect(x: 13, y: currentTop, width: contentView.frame.width - 30, height: 49)
            let tf = UITextField(frame: frame)
            tf.placeholder = fieldNames[i]
            tf.placeHolderColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
            tf.text = dictinary[fieldNames[i]] as? String
            tf.font = UIFont.systemFont(ofSize: 16)
            
            let separator = UIView(frame: CGRect(x: 0, y: currentTop + 48.5, width: contentView.frame.width - 30, height: 0.5))
            separator.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
            textFields.append(tf)
            containerView.addSubview(tf)
            containerView.addSubview(separator)
            currentTop += 50
            
            
            
        }
        
        
    }
}
