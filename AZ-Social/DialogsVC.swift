//
//  DialogsVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 25.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class DialogsVC:UIViewController,UITableViewDelegate,UITableViewDataSource
{
    var data = (UIApplication.shared.delegate as! AppDelegate).data
    @IBOutlet weak var tableView: UITableView!
    var dialogs = dialogues()
    override func loadView() {
       // let b = storyboard?.instantiateViewController(withIdentifier: "fr2")
       // show(b!, sender: nil)
        for i in 0...10
        {
            let fr = dialogBody(name: "Cтиви", secondName: "Джобс", pictUrl: "https://st.kp.yandex.net/images/actor_iphone/iphone360_93826.jpg", isOnline: true, id: i)
            fr.chat.newMessagesCount = 1
            dialogs.add(friend: fr, forKey: 400 - i)
            for j in 0...25
            {
                if j % 2 == 0
                {
                    
                    fr.chat.messages.append( Message(sender: fr, isMine: false, text: "Привет Стив", isRead : true,time: "11:41"))
                }
                else
                {
                    fr.chat.messages.append( Message(sender: data.myProfile!, isMine: true, text: "О привет, Джобс", isRead : true,time: "11:40"))
                }
               
            }
        }
        
        super.loadView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DCell") as! DialogsCell
        cell.man = dialogs.array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dialogs.array.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDialog", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDialog"
        {
            let dist = segue.destination as! DialogVC
            dist.isPrivate = true
            
            dist.chat = dialogs.array[(tableView.indexPathForSelectedRow?.row)!].chat
            dist.user = dialogs.array[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
}
