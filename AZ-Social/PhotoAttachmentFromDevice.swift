//
//  PhotoAttachment.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 04.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import Photos

class PhotoAttachmentFromDevice:Attachment
{
    var phAsset :PHAsset
    private let phManager = PHImageManager()
    
    
    
    override func set(imageView: UIImageView) {
        self.phManager.requestImageData(for: self.phAsset, options: nil, resultHandler: { (data:Data?, str:String?, orientation:UIImageOrientation, arg:[AnyHashable : Any]?) -> Void in
            print(data)
            
           
            
            if data != nil{
                
                    
                    
                    
                    
                    
                    let jpeg = UIImageJPEGRepresentation(UIImage(data: data!)!, 1)
                    
                    ServerManager.shared(named: "main")?.POSTFormRequestByAdding(postfix: "/persons/files", data: jpeg!, complititionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                        
                        
                        
                        if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                            do
                            {
                      
                                if httpResponse.statusCode == 201
                                {
                                    
                                    if let JSONData = data { // Check 1.
                                        if let dict = try JSONSerialization.jsonObject(with: JSONData, options: []) as? NSDictionary { // Check 2. and 3.
                                            print("Dictionary received")
                                            
                                            self.id = dict.value(forKey: "id") as! Int?
                                            
                                            //  self.tableView.reloadData()
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
                                }
                           
                            }
                            catch{}
                                
                                DispatchQueue.main.async
                                    {
                                        
                                }
                            }
                            else
                            {
                                print("did not get file")
                            }
                            
                            
                        
                        
                    },withCookies: true,with:"PUT")
                    
                    
                
                
                
                
                DispatchQueue.main.async {
                    
                    
                    
                    
                    
                    imageView.image = UIImage(data: data!)!
                    
                }
            }
            
            
            
        })

        
        
    }
    
    init(with asset:PHAsset) {
        phAsset = asset
        
        super.init()
        //super.image = image
    }
}
