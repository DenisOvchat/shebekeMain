//
//  ComentsLoader.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 14.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class CommentsLoaderByPostId:Loader
{
    var postId:Int!
    
    var serverManager:ServerManager!
    init(named:String,with serverManager:ServerManager,qos:DispatchQoS,postId:Int) {
        super.init(named: named,qos:qos)
        self.serverManager = serverManager
        self.postId = postId
    }
    
    func load(count:Int)
    {
        queue?.sync {
            self.array.removeAllObjects()
            let data = (UIApplication.shared.delegate as! AppDelegate).data
            
            if postId == nil
            {
                if (UIApplication.shared.delegate as! AppDelegate).data.myProfile != nil
                {
                    self.postId = (UIApplication.shared.delegate as! AppDelegate).data.myProfile?.id
                }
                else
                {
                    return
                }
                
            }
            
            
            let postfix = "/blogs/comments?id=" + postId!.description
            ServerManager.shared(named: "main")?.GETRequestByAdding(postfix: postfix, complititionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                
                do{
                    weak var weakSelf = self
                    
                    if let JSONData = data { // Check 1.
                        if let arr = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as? NSMutableArray { // Check 2. and 3.
                            print("Dictionary received")
                            
                            for elem in arr
                            {
                                weakSelf?.array.add(elem)
                            }
                            
                            if let del = self.delegate
                            {
                                DispatchQueue.main.async {
                                    del.didLoadEntities(Amount: UInt(weakSelf!.array.count))
                                }
                                
                                
                            }
                            
                            
                            
                            
                        }
                        else {
                            
                            if let jsonString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                                
                                
                                
                                
                                print("JSON: \n\n \(jsonString)")
                            }
                            print("Can't parse JSON \(error)")
                        }
                    }
                    else {
                        fatalError("JSONData is nil")
                    }
                }catch{}
                
                
            })
            
            
            
            
            
        }
        
        
    }
    func loadMoreToTheEnd(count:Int)
    {
        delegate?.didLoadEntitiesToTheEnd(Amount: UInt(count))
    }
    
}
