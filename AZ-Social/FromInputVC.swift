//
//  FromInputVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 30.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class FromInputVC:UIViewController
{
    var rigistrationData:[String:Any]!
    
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    
    override func viewDidLoad() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        rigistrationData["country"] = countryField.text
        rigistrationData["city"] = cityField.text
        
        ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: "/persons/sign_up", data: rigistrationData, complititionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            
            
            
            if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                
                if httpResponse.statusCode == 201
                {
                    //self.didLogin(data: data)
                    
                    let url = NSURL(string: ServerManager.shared(named: "main")!.getDomain())
                    
                    
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url as! URL)
                    HTTPCookieStorage.shared.setCookies(cookies, for: url! as URL, mainDocumentURL: nil)
                    for cookie in cookies {
                        
                        
                        
                        var cookieProperties = [HTTPCookiePropertyKey: AnyObject]()
                        cookieProperties[HTTPCookiePropertyKey.name] = cookie.name as AnyObject?
                        cookieProperties[HTTPCookiePropertyKey.value] = cookie.value as AnyObject?
                        cookieProperties[HTTPCookiePropertyKey.domain] = cookie.domain as AnyObject?
                        cookieProperties[HTTPCookiePropertyKey.path] = cookie.path as AnyObject?
                        cookieProperties[HTTPCookiePropertyKey.version] = NSNumber(value: cookie.version)
                        cookieProperties[HTTPCookiePropertyKey.expires] = NSDate().addingTimeInterval(31536000)
                        
                        let newCookie = HTTPCookie(properties: cookieProperties )
                        HTTPCookieStorage.shared.setCookie(newCookie!)
                        
                        print("name: \(cookie.name) value: \(cookie.value)")
                    }
                }
                
                
            }
            
        })

        
       // (segue.destination as! PhotoInputVC).rigistrationData = rigistrationData
        
    }
    
}
