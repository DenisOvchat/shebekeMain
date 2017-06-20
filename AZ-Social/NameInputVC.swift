//
//  NameInputVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 30.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class NameInputVC:UIViewController
{
    
    var rigistrationData:[String:Any]!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var secondNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        rigistrationData["first_name"] = firstNameField.text
        rigistrationData["last_name"] = secondNameField.text
        rigistrationData["password"] = passwordField.text

        (segue.destination as! BirthdayInputVC).rigistrationData = rigistrationData

    }
    
}
