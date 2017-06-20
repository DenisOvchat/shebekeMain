//
//  FriendsLoaderFromServer.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 07.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class FriendsLoaderFromServer:Loader
{
    var serverManager:ServerManager!
    init(named:String,with serverManager:ServerManager,qos:DispatchQoS,id:Int? = nil) {
        super.init(named: named,qos:qos)
        self.serverManager = serverManager
    }
    
    func load(id:Int = -1)
    {
        let postfix = (id == -1) ? ("/friends"):("/friends?id=" + id.description)
        /*  queue?.async {
         self.array.removeAllObjects()
         let data = (UIApplication.shared.delegate as! AppDelegate).data
         
         for i in 0..<15
         {
         let post = WallPost(send: data.myProfile! , time: Date())
         post.body = "sd fds sdf sdfadsf sadf asddfsgad asdfsad fadfgasdf asd dfgasdfdsa gdfasd f"
         
         
         post.pictureInfos = [PictureFromNetInfo(URLstring: "http://www.cruzo.net/user/images/k/prv/dbb025264e7d1a35772dfa4387514de9_172.jpg", size: CGSize(width: 370, height: 480)),
         PictureFromNetInfo(URLstring: "http://www.cruzo.net/user/images/k/prv/dbb025264e7d1a35772dfa4387514de9_172.jpg", size: CGSize(width: 370, height: 480)),
         PictureFromNetInfo(URLstring: "http://bm.img.com.ua/nxs/img/prikol/images/large/1/2/308321_879397.jpg", size: CGSize(width: 625, height: 938))]
         
         self.array.add(post)
         }
         if let del = self.delegate
         {
         DispatchQueue.main.async {
         del.didLoadEntities(Amount: UInt(self.array.count))
         }
         
         
         }
         }
         */
    }
    func loadMoreToTheEnd(count:Int)
    {
        delegate?.didLoadEntitiesToTheEnd(Amount: UInt(count))
    }
    
}
class FriendsFinder:Loader
{
    var serverManager:ServerManager!

    init(named:String,with serverManager:ServerManager,qos:DispatchQoS,id:Int? = nil) {
        super.init(named: named,qos:qos)
        self.serverManager = serverManager
    }
    func find()
    {
    
    }
}
