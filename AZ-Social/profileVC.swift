//
//  profileVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 05.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class profileVC:UIViewController,UITableViewDelegate,UITableViewDataSource,LoaderDelegate,profileMainCellDelegate,PostEditDelegate
{
    internal func reloadPost(post: WallPost, cell: postCell) {
        
    }
    internal var profile: FullProfile!
    


    

    
    @IBOutlet weak var settingsBut: UIBarButtonItem!

    @IBOutlet weak var tableView: UITableView!
    
    var postsStorage = WallPostStorage()
    var isLoadingNewInTable = false
    var postsLoader:WallPostLoaderFromServerByProfile!
    
    
    
    var fiveFriends = [Person]()
    
    
    override func viewDidLoad() {
        
        
        profile = (UIApplication.shared.delegate as! AppDelegate).data.myProfile

        profile.postsStorage = postsStorage

        postsLoader = WallPostLoaderFromServerByProfile(named: "newsServerLoader", with: ServerManager.shared(named: "main")!, qos: .userInteractive,id: profile.id!)
        postsLoader.delegate = self
        postsStorage.assignLoader(named: "postsFromServer", loader: postsLoader)
        
        tableView.register(UINib(nibName: "AddPostCell", bundle: Bundle.main), forCellReuseIdentifier: "addPostCell")
        tableView.register(UINib(nibName: "ProfileMainCell", bundle: Bundle.main), forCellReuseIdentifier: "main")
        tableView.register(UINib(nibName: "WallPostCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "wallPostCell")
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.sectionFooterHeight =  0
        tableView.sectionHeaderHeight =  0
        tableView.tableHeaderView = nil
        tableView.tableFooterView?.frame = CGRect.zero
        
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        
        
        
        //postsLoader.load(count: 5)

        addFriend(id: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        /*  ServerManager.shared(named: "main")?.GETRequestByAdding(postfix: "/friends",
            complititionHandler:  { (data:Data?, response:URLResponse?, error:Error?) in
            
            
            
        }, withCookies: true)*/
 
        /* ServerManager.shared(named: "main")?.GETRequestByAdding(postfix: "/id1",
                                                                complititionHandler:  { (data:Data?, response:URLResponse?, error:Error?) in
                                                                    
                                                                    
                                                                    
        }, withCookies: true)
        */
    }
    override func viewWillAppear(_ animated: Bool) {
        postsLoader.load(count: 5)
    }
    override func loadView() {
       super.loadView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        profile = (UIApplication.shared.delegate as! AppDelegate).data.myProfile
        
       /* for i in 0...10
        {
            let fr = Person(name: "Стиви\(i)", secondName: "Джобс", pictUrl: "https://st.kp.yandex.net/images/actor_iphone/iphone360_93826.jpg", isOnline: true, id: i)
            profile.friends.append(fr)
            fiveFriends.append(fr)
            for j in 0...25
            {
                if j % 2 == 0
                {
                    
                    //fr.chat.messages.append( Message(sender: fr, isMine: false, text: "привет \(i) fdg\(j) dfg dfgdfg dsfg dfg sdfg sdfg sdfg sdfgsd fgs dfgsdf sfgd", isRead : true,time: "11:41"))
                }
                else
                {
                    //  fr.chat.messages.append( Message(sender: data.myProfile, isMine: true, text: "привет \(i)", isRead : true,time: "11:40"))
                }
                
            }
        }*/

    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "main") as! profileMainCell
            cell.profile = profile
            cell.delegate = self
            return cell
        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "addPostCell") as! AddPostCell
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "wallPostCell") as! postCell
            let post = postsStorage[indexPath.row]
            cell.delegate = self
            cell.post = (WallPost(with: post as! NSDictionary))
            return cell
            
            
        }
    }
   /* func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            
            return 529
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "newpost")
            return 44
            
        default: return 44
            
        }
    }*/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            
            
            return 1
        case 1:
            
            
            return 1
            
        default:
            return postsStorage.count
            
            
        }

        return postsStorage.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func didLoadEntities(Amount: UInt) {
        
        
    
         
      //  tableView.beginUpdates()
        //let paths = IndexPath.setOfIndexPaths(startRow: 2, count: Amount, in: 0)
      //  tableView.insertRows(at: paths, with: UITableViewRowAnimation.automatic)
        
        
        
        tableView.reloadSections(IndexSet(integersIn: 2...2), with: UITableViewRowAnimation.automatic)
      //  tableView.endUpdates()
 
    }
    @IBAction func toSettings(_ sender: Any) {
        performSegue(withIdentifier: "profileToSettings", sender: nil)
    }
    func goToInformation() {
        performSegue(withIdentifier: "toInformation", sender: nil)

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        if indexPath.section == 1
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddPostVC") as! AddPostVC
            vc.profile = profile
            show(vc, sender: self)
            
        }
        if indexPath.section == 2
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "WallPostVC") as! WallPostVC
            vc.post =  (tableView.cellForRow(at: indexPath) as! postCell).post


            show(vc, sender: self)
            
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dist = segue.destination as? InformationVC
        {
            dist.profile = profile
        }
        if let dist = segue.destination as? SettingsVC
        {
            dist.profile = profile
        }
        //tableView.indexPath(for: <#T##UITableViewCell#>)
       
    }
    func menuShow(cell: postCell) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let post = cell.post
        let indexPath = tableView.indexPath(for: cell )
        let data = ["id":post?.id]
        let deleteAction = UIAlertAction(title: "Удалить", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
            ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: "/blogs/posts", data: data, complititionHandler:  { (data:Data?, response:URLResponse?, error:Error?) in
                
                
                
                if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                    
                    if httpResponse.statusCode == 201
                    {
                        //self.delegate?.deletePost(cell: self)

                        DispatchQueue.main.async
                        {
                            [unowned self, indexPath]
                            in
                            
                            self.tableView.beginUpdates()
                            self.tableView.deleteRows(at: [indexPath!], with: .automatic)
                            self.postsStorage.deleteElementsAt(indexes: [indexPath!.row])
                            self.tableView.endUpdates()

                            
                        }
                    }
                    else
                    {
                        print("did not deletePost")
                    }
                    
                    
                }
                
            },withCookies: true,with:"DELETE")
        }
        let editAction = UIAlertAction(title: "Редактировать", style: UIAlertActionStyle.default) { (UIAlertAction)
            in

            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddPostVC") as! AddPostVC
            vc.profile = self.profile
            vc.post = post
            self.show(vc, sender: self)

        }
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel) { (UIAlertAction) in
            
        }
        
        alert.addAction(deleteAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true) { 
            
        }

    }
    func reloadPost(post: WallPost, cell: UITableViewCell) {
    
    }
}
