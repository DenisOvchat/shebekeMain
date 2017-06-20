//
//  onPagesVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 15.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class RegistrationData
{
    var mail:String?
    var code:String?
    var password:String!
    var type:String!
    var firstName:String!
    var secondName:String!
    var birthday:Int!
    var gender:String!
    var avat:Data?
    var backGround:Data?
    var phone:String?
    
}

enum RegistrationType
{
    case phoneNumber,email
}


class PhoneInputVC:UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var field: UITextField!
    let data = (UIApplication.shared.delegate as! AppDelegate).data
    let regex = ""
    var registrationType = RegistrationType.phoneNumber
    override func loadView() {
        super.loadView()
        
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        field.keyboardType = .decimalPad
        field.delegate =  self
        
        
         //navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0, green: 0, blue: 60, alpha: 0)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {

        
        /* let loged:Bool=false
        if loged
        {
            let pgs = storyboard?.instantiateViewController(withIdentifier: "PageController")
            addChildViewController(pgs!)
            //view.addSubview((pgs?.view)!)
            view.insertSubview((pgs?.view)!, at: 0)
            didMove(toParentViewController: self)
        }
        else
        {
            performSegue(withIdentifier: "login", sender: nil)
            
            
        }
     */   
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        switch registrationType
        {
            case .phoneNumber:
                if (textField == field)
                {
                    var rng=range
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
                    
                    if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
                    {
                        let newLength = (textField.text! as NSString).length + (string as NSString).length - rng.length as Int
                        
                        
                        return (newLength > 10) ? false : true
                    }
                    if((length==10))
                    {
                        field.resignFirstResponder()
                    }
                    var index = 0 as Int
                    let formattedString = NSMutableString()
                    
                    if hasLeadingOne
                    {
                        formattedString.append("1 ")
                        index += 1
                    }
                    if (length - index) > 3
                    {
                        let areaCode = decimalString.substring(with: NSMakeRange(index, 3))
                        formattedString.appendFormat("(%@)", areaCode)
                        index += 3
                    }
                    if length - index > 3
                    {
                        let prefix = decimalString.substring(with: NSMakeRange(index, 3))
                        formattedString.appendFormat("%@-", prefix)
                        index += 3
                        
                        if length - index > 2
                        {
                            let prefix = decimalString.substring(with: NSMakeRange(index, 2))
                            formattedString.appendFormat("%@-", prefix)
                            index += 2
                        }
                    }
                    
                    
                    let remainder = decimalString.substring(from: index)
                    formattedString.append(remainder)
                    textField.text = formattedString as String
                    return false
                }
                else
                {
                    return true
            }

        case .email:
            return true
            
            
        default:
            break
        }
            }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //(segue.destination as! PhoneCodeInputVC).pgCont = pgCont
        
        
        
       // segue.destination.modalTransitionStyle = .partialCurl
    }
    
    
}








