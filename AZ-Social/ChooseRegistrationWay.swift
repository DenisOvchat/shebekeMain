//
//  ChooseRegistrationWay.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 12.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class ChooseRegistrationWay:UIViewController
{
    
    var registrationWay = RegistrationType.phoneNumber
    var registrationNavigationController = RegistrationNavigationC()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   /*     if let dest = (segue.destination as? OnPagesVC  )
        {
            dest.registrationType = registrationWay
        }*/
        
    }
    
    override func viewDidLoad() {
        
        
    }
    
    
    
}
