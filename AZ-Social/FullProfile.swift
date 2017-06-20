//
//  FullProfile.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 24.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class FullProfile:Person
{
    var postsStorage = WallPostStorage()

    var BirhDay:Date?
        {
        get{
            
            if let birthString:String = dictionary["birthday"] as? String
            {
                let formatter = DateFormatter()
                formatter.calendar = Calendar(identifier: .iso8601)
                //formatter.locale = Locale(identifier: "en_US_POSIX")
                //formatter.timeZone = TimeZone(secondsFromGMT: 0)
                formatter.dateFormat = "yyyy-MM-dd"
                return formatter.date(from: birthString)
            }
            else
            {
                return nil
            }
        }
    }
    var BirhDayString:String?
        {
        get{
            
            if let birthString:String = dictionary["birthday"] as? String
            {
                let formatter = DateFormatter()
                formatter.calendar = Calendar(identifier: .iso8601)
                formatter.dateFormat = "ddMMMMYYYY"
                return formatter.string(from: BirhDay!)
            }
            else
            {
                return ""
            }
        }
    }
    var city:String?
    {
        get{
            return dictionary["city"] as? String
        }
    }
    var country:String?
    {
        get
        {
            return dictionary["country"] as? String
        }
        
    }
    var school:String?
    {
        get{
            return dictionary["school"] as? String
    
        }
    }
    var university:String?
        {
        get{
            return dictionary["university"] as? String
            
        }
    }

    var profession:String?
        {
        get{
            return dictionary["profession"] as? String
            
        }
    }
    var workPlace:String?
    {
        get{
            return dictionary["work_place"] as? String
            
        }
    }

    var phone:String?
        {
        get{
            return dictionary["phone"] as? String
        }
    }
 
    var mail:String?
    {
        get{
            return dictionary["email"] as? String
            
        }
    }

    var type:String?
        {
        get{
            return dictionary["school"] as? String
            
        }
    }

    var isMine:Bool
        {
        get{
            return  dictionary["id"] as! Int == (UIApplication.shared.delegate as! AppDelegate).data.myProfile!.id
            
        }
    }

    var topImageUrl:String?
        {
        get{
            return dictionary["background"] as? String
        }
    }
    var isJuristic:Bool
    {
        get
        {
            if let val = dictionary["is_juristic"] as? Bool
            {
                return val 
            }
           return false
        }
    }

    var posts=[WallPost]()
       /* {
            get{
                return dictionary["school"] as? String
                
            }
    }*/

    var age:String?
    {
        get
        {
            let now = Date()
            
            if let birthday: Date = self.BirhDay
            {
                let calendar = Calendar.current
                let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
                let age = ageComponents.year!
                return age.description
                
            }
            else{
                return nil
            }
        }
    }
    
    var friends=[Person]()
   /* init(mine:Bool,name:String,secondName:String,pictUrl:String,isOnline:Bool,id:Int)
    {
     
        /*isMine = mine
        super.init(name: name, secondName: secondName, pictUrl: pictUrl, isOnline: isOnline, id: id)*/
        
    }*/
    
}
