//
//  WallPostServerLoader.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 01.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class WallPostLoaderFromServerByProfile:Loader
{
    var id:Int!
    
    var serverManager:ServerManager!
    init(named:String,with serverManager:ServerManager,qos:DispatchQoS,id:Int) {
        super.init(named: named,qos:qos)
        self.serverManager = serverManager
        self.id = id
    }
    
    func load(count:Int)
    {
          queue?.sync {
            self.array.removeAllObjects()
            let data = (UIApplication.shared.delegate as! AppDelegate).data
            
            if id == nil
            {
                if (UIApplication.shared.delegate as! AppDelegate).data.myProfile != nil
                {
                    self.id = (UIApplication.shared.delegate as! AppDelegate).data.myProfile?.id
                }
                else
                {
                    return
                }
                
            }
            
            
            let postfix = "/blogs/posts?id=" + id!.description
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



class WallPostLoaderFromServerLenta:Loader
{
    
    var serverManager:ServerManager!
    init(named:String,with serverManager:ServerManager,qos:DispatchQoS,id:Int? = nil) {
        super.init(named: named,qos:qos)
        self.serverManager = serverManager
        
    }
    
    func load(count:Int)
    {
        queue?.sync {
            self.array.removeAllObjects()
            let data = (UIApplication.shared.delegate as! AppDelegate).data
            
            
            let postfix = "/news"
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


class WallPostLoaderFromDatabase:Loader
{
    func loadMore(count:Int) {
        
    }
}

