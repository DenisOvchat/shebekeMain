//
//  loginVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 15.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class LoginVC:UIViewController
{
    let data = (UIApplication.shared.delegate as! AppDelegate).data
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func loadView() {
        super.loadView()
        
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let loged:Bool=true
    

        
        ServerManager.shared(named: "main")?.GETRequestByAdding(postfix: "",
                                                                complititionHandler:
            { (data:Data?, response:URLResponse?, error:Error?) in
                
                
                
                if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                    
                    if httpResponse.statusCode == 200
                    {
                        didLogin(data: data)
                        
                        
                    }
                    
                    
                }
                
        }, withCookies: true)
        

        if loged
        {
            
           // self.window = UIWindow(frame: UIScreen.main.bounds)
            
            
//            performSegue(withIdentifier: "toApp", sender: nil)

        }
        else
        {
            
        }
        
    }
    @IBAction func taped(_ sender: Any) {
        view.endEditing(true)
        
    }
    
    @IBAction func logingAction(_ sender: Any) {
        
        
        let data = ["email":loginField.text,"password":passwordField.text]
        
        
        
        ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: "/persons/sign_in", data: data, complititionHandler:  { (data:Data?, response:URLResponse?, error:Error?) in
            
            
            
            if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                
                if httpResponse.statusCode == 202
                {
                    didLogin(data: data)
                    
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
        
    }
    
    
               
    
            
            
    
        
    

    
    
}
func didLogin(data:Data?)
{
    
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let initialViewController = storyboard.instantiateViewController(withIdentifier: "TBC")
    
    
    //self.appDelegate.window?.makeKeyAndVisible()
    
    
    //self.appDelegate.data.myProfile = p
    
    
    var error: NSError?
    do{
        if let JSONData = data { // Check 1.
            if let dict = try JSONSerialization.jsonObject(with: JSONData, options: []) as? NSDictionary { // Check 2. and 3.
                print("Dictionary received")
                
                (UIApplication.shared.delegate as! AppDelegate).data.myProfile = FullProfile(with: dict)
                
                
                
            }
            else {
                
                if let jsonString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                    
                    
                    
                    
                    print("JSON: \n\n \(jsonString)")
                }
                print("Can't parse JSON \(error)")
            }
        }
        else {
            print("JSONData is nil")
        }
    }catch{}
    
    
    DispatchQueue.main.async {
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = initialViewController
        
    }
    
}
