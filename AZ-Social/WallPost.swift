//
//  WallPost.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 29.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class WallPost:NSObject
{
    private var dictionary = NSDictionary()
    var id:Int?
    {
        get
        {
            let nm = dictionary["id"]
            
            return nm as? Int
        }
        
    }
    private var _sender:Person?
    var sender:Person?
    {
        get
        {
            if _sender != nil {
                return _sender
            }
            else
            {
                if let persDict = dictionary["author"] as? NSDictionary
                {
                    let pers = Person(with: persDict )
                    _sender = pers
                    return pers
                    
                }
                else
                {
                    return nil
                }
            }
            
            
            
        }
    }
    var body:String?
        {
        get
        {
            let txt = dictionary["text"]
            
            return txt as? String
        }
        
    }
    var map:MapDirection?
    var pictureInfos:[PictureFromNetInfo]?
    var time:Date?
    
    init(with dictionary:NSDictionary)
    {
        
        self.dictionary = dictionary
    }
    
}


