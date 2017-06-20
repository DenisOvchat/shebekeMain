//
//  ServerManager.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 29.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation




class ServerManager
{
    
    private var serverDomain:String = "2323123123123"
    
    private static var instances=[String:ServerManager]()
    
    
    
    
    func GETRequestByAdding(postfix:String,complititionHandler: ((Data?,URLResponse? ,Error? ) -> Void)?,withCookies:Bool = true)
    {
        
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
            
            
            let url = NSURL(string: serverDomain + postfix)
            
            let request = NSMutableURLRequest(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
            
            if withCookies
            {
                let cookieJar = HTTPCookieStorage.shared
               if let d = cookieJar.cookies(for:         URL(string: "http://188.225.38.189")!)
               {
                    if d.count != 0
                    {
                        request.addValue((d[0].value), forHTTPHeaderField: "X-CSRFToken")
                    
                    }
               /* for cookie in d{
                    
                    // if cookie.name == "MYNAME" {
                    
                    let cookieValue = cookie.value
                    print("COOKIE name = \(cookie.commentURL)")
                    
                    print("COOKIE name = \(cookie.name)")
                    
                    print("COOKIE VALUE = \(cookieValue)")
                    // }
                    request.addValue(cookie.name + " = " + cookie.value, forHTTPHeaderField: "Cookie")
                }*/
                }
                //for cookie in d!{
                
                
              //  }
                
                
                
                
                
            }
            
            request.httpMethod = "GET"
            
            do {
                let postDataTask = session.dataTask(with: request as URLRequest) { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                    
                    
                    print("___________________")
                    print("RECV:")
                    if (response != nil)
                    {
                        print (response)
                        
                    }
                    if (data != nil)
                    {
                        print("WITHDATA:")
                        print(print (NSString(data: data!, encoding: String.Encoding.utf8.rawValue)))
                        
                    }
                    
                    print("++++++++++++++++++++")
                    
                    if  complititionHandler != nil {
                        complititionHandler!(data,response,error)
                        
                    }
                    
                }
                print("___________________\n")
                print("SEND:")
                print(request.url)
                print(request.allHTTPHeaderFields)
                
                //print (NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue))
                postDataTask.resume()
                
            } catch { }
        
    }
    static func shared(named:String)->ServerManager?
    {
        return ServerManager.instances[named]
    }
    static func addServerManager(named:String,domain:String)
    {
        let manager = ServerManager()
        manager.serverDomain = domain
        ServerManager.instances[named] = manager
    }
    static func deliteServerManager(named:String)
    {
        ServerManager.instances[named] = nil
    }
    func getDomain()->String
    {
        return serverDomain
    }
    
    func POSTJSONRequestByAdding(postfix:String,data:[String:Any],complititionHandler: ((Data?,URLResponse? ,Error? ) -> Void)?,withCookies:Bool = true, with method:String = "POST") -> URLSessionDataTask
    {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        
        let url = NSURL(string: serverDomain + postfix)
        
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
        
        if withCookies
        {
            let cookieJar = HTTPCookieStorage.shared
            let d = cookieJar.cookies(for: URL(string: "http://188.225.38.189")!
            )
        
            /*for cookie in d!{
                
                // if cookie.name == "MYNAME" {
                
                let cookieValue = cookie.value
                print("COOKIE name = \(cookie.commentURL)")
                
                print("COOKIE name = \(cookie.name)")
                
                print("COOKIE VALUE = \(cookieValue)")
                // }
                request.addValue(cookie.name + " = " + cookie.value, forHTTPHeaderField: "Cookie")
            }
            */
            if let d = cookieJar.cookies(for:         URL(string: "http://188.225.38.189")!)
            {
                if d.count != 0
                {
                    request.addValue((d[0].value), forHTTPHeaderField: "X-CSRFToken")
                    
                }
            }
            
            
            
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method
        var postDataTask = URLSessionDataTask()
        
        do {
            let postData = try JSONSerialization.data(withJSONObject: data, options:JSONSerialization.WritingOptions.prettyPrinted)
            request.httpBody = postData
            
            postDataTask = session.dataTask(with: request as URLRequest) { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                

                print("___________________")
                print("RECV:")
                if (response != nil)
                {
                    print (response)

                }
                if (data != nil)
                {
                    print("WITHDATA:")
                    print(print (NSString(data: data!, encoding: String.Encoding.utf8.rawValue)))
                    
                }
                
                print("++++++++++++++++++++")
                
                if  complititionHandler != nil {
                    complititionHandler!(data,response,error)

                }
                
            }
            print("___________________\n")
            print("SEND:")
            print(request.url)
            print(request.httpMethod)
            print(request.allHTTPHeaderFields)
            
            print (NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue))
            postDataTask.resume()
            
        } catch { }
          return postDataTask
    }
    
    
    
    func POSTFormRequestByAdding(postfix:String,data:Data,complititionHandler: ((Data?,URLResponse? ,Error? ) -> Void)?,withCookies:Bool = true, with method:String = "POST")
    {
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        
        let url = NSURL(string: serverDomain + postfix)
        
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 60)
        
        if withCookies
        {
            let cookieJar = HTTPCookieStorage.shared
            let d = cookieJar.cookies(for: URL(string: "http://188.225.38.189")!
            )
            
            for cookie in d!{
                
                // if cookie.name == "MYNAME" {
                
                let cookieValue = cookie.value
                print("COOKIE name = \(cookie.commentURL)")
                
                print("COOKIE name = \(cookie.name)")
                
                print("COOKIE VALUE = \(cookieValue)")
                // }
                request.addValue(cookie.name + " = " + cookie.value, forHTTPHeaderField: "Cookie")
            }
            
            if let d = cookieJar.cookies(for:         URL(string: "http://188.225.38.189")!)
            {
                if d.count != 0
                {
                    request.addValue((d[0].value), forHTTPHeaderField: "X-CSRFToken")
                    
                }
            }
            
            
            
        }
        
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = method
        let boundary = generateBoundaryString()
        let fullData = photoDataToFormData(data: data as NSData,boundary:boundary,fileName:"avatar")
        
        request.setValue("multipart/form-data; boundary=" + boundary,
                          forHTTPHeaderField: "Content-Type")
        
        // REQUIRED!
        request.setValue(String(fullData.length), forHTTPHeaderField: "Content-Length")
        
        request.httpBody = fullData as Data
        request.httpShouldHandleCookies = false
        
        let queue = DispatchQueue.global()
        
       /* NSURLConnection.sendAsynchronousRequest(
            request as URLRequest,
            queue: queue,
            completionHandler:complititionHandler)*/
    
        
        
            let postDataTask = session.dataTask(with: request as URLRequest) { (data:Data?, response:URLResponse?, error:Error?) -> Void in
                
                
                print("___________________")
                print("RECV:")
                if (response != nil)
                {
                    print (response)
                    
                }
                if (data != nil)
                {
                    print("WITHDATA:")
                    print(print (NSString(data: data!, encoding: String.Encoding.utf8.rawValue)))
                    
                }
                
                print("++++++++++++++++++++")
                
                if  complititionHandler != nil {
                    complititionHandler!(data,response,error)
                    
                }
                
            }
            print("___________________\n")
            print("SEND:")
            print(request.url)
            print(request.allHTTPHeaderFields)
            
            print (NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue))
            postDataTask.resume()
            
            }
}
func photoDataToFormData(data:NSData,boundary:String,fileName:String) -> NSData {
    let fullData = NSMutableData()
    
    // 1 - Boundary should start with --
    let lineOne = "--" + boundary + "\r\n"
    fullData.append(lineOne.data(using: String.Encoding.utf8, allowLossyConversion: false)!)
   
    
    // 2
    let lineTwo = "Content-Disposition: form-data; name=\"image\"; filename=\"" + fileName + "\"\r\n"
    NSLog(lineTwo)
    fullData.append(lineTwo.data(
        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    // 3
    let lineThree = "Content-Type: image/jpg\r\n\r\n"
    fullData.append(lineThree.data(
        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    // 4
    fullData.append(data as Data)
    
    // 5
    let lineFive = "\r\n"
    fullData.append(lineFive.data(
        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    // 6 - The end. Notice -- at the start and at the end
    let lineSix = "--" + boundary + "--\r\n"
    fullData.append(lineSix.data(
        using: String.Encoding.utf8,
        allowLossyConversion: false)!)
    
    return fullData
}

func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}
