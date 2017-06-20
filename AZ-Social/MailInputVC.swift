//
//  MailInputVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 30.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class MailInputVC:UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var field: UITextField!
    var rigistrationData:[String:Any] = [String:Any]()

    override func viewDidLoad() {
        field.keyboardType = .decimalPad
        field.delegate =  self
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField == field)
        {
            /*var rng=range
            /* if string == "" && Int((textField.text! as NSString).character(at: range.location)) == nil && range.location > 0
             {
             rng = NSMakeRange(range.location - 1, range.length)
             }*/
            let newString = (textField.text! as NSString).replacingCharacters(in: rng, with: string)
            let components = newString.components(separatedBy: (NSCharacterSet.decimalDigits.inverted))
            //  componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            let decimalString = components.joined(separator: "") as NSString
            let length = decimalString.length
            let hasLeadingOne = length > 0 && decimalString.character(at: 0) == (1 as unichar)
            
            
            
            
            if length == 0 || (length > 4 && !hasLeadingOne) || length > 5
            {
                let newLength = (textField.text! as NSString).length + (string as NSString).length - rng.length as Int
                
                
                return (newLength > 4) ? false : true
            }
            
            var index = 0 as Int
            let formattedString = NSMutableString()
            
            if hasLeadingOne
            {
                formattedString.append("1 ")
                index += 1
            }
            
            if length - index > 1
            {
                let prefix = decimalString.substring(with: NSMakeRange(index, 1))
                formattedString.appendFormat("%@-", prefix)
                index += 1
                
                if length - index > 1
                {
                    let prefix = decimalString.substring(with: NSMakeRange(index, 1))
                    formattedString.appendFormat("%@-", prefix)
                    index += 1
                    if length - index > 1
                    {
                        let prefix = decimalString.substring(with: NSMakeRange(index, 1))
                        formattedString.appendFormat("%@-", prefix)
                        index += 1
                        
                    }
                }
            }
            
            
            let remainder = decimalString.substring(from: index)
            formattedString.append(remainder)
            textField.text = formattedString as String*/
            return true
        }
        else
        {
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let data = ["email":field.text]
        
        
        ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: "/persons/verification", data: data, complititionHandler: nil)
        rigistrationData["email"] = field.text
        (segue.destination as! PhoneCodeInputVC).rigistrationData = rigistrationData

    }
    
}
