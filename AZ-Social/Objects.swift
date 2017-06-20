//
//  Objects.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 08.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit



class MapDirection
{
    
}



class Chat
{
    var messages=[Message]()
    var newMessagesCount = 0
    var roomView:DialogVC?
}
class dialogBody:Person
{
    var chat = Chat()
    
    override init(name:String,secondName:String,pictUrl:String,isOnline:Bool,id:Int) {
        super.init(name: name, secondName: secondName, pictUrl: pictUrl, isOnline: isOnline, id: id)
       /*   self.name = name
        self.pictUrl = pictUrl
        self.isOnline = isOnline
        self.secondName = secondName
        self.id = id*/
    }
}


class Message
{
    var sender:Person
    var isMine:Bool
    var text:String
    var picturesURLs:[String]?
    var isRed:Bool = false
    var time:String
    var isServerMessage = false
    init(sender:Person,isMine:Bool,text:String,isRead:Bool,time:String) {
        self.sender = sender
        self.isMine = isMine
        self.text = text
        isRed = isRead
        self.time = time
    }
}
