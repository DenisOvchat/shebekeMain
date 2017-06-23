//
//  profileVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 05.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit

class profileVC:UITableViewController,LoaderDelegate,profileMainCellDelegate,PostEditDelegate
{
    
    internal var profile: FullProfile!
    
    @IBOutlet weak var settingsBut: UIBarButtonItem!

    
    var postsStorage = WallPostStorage()
    var postsLoader:WallPostLoaderFromServerByProfile!
    
    
    
    var fiveFriends = [Person]()
    
    
    override func viewDidLoad() {
        
        profile = (UIApplication.shared.delegate as! AppDelegate).data.myProfile
        setLoaderWithStorage()
        setTableView()


//        addFriend(id: 1)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        postsLoader.load(count: 5)
    }
  
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func didLoadEntities(Amount: UInt) {
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integersIn: 2...2), with: UITableViewRowAnimation.automatic)
        tableView.endUpdates()
    }
    func didLoadEntitiesToTheStart(Amount: UInt) {
        tableView.beginUpdates()
        let set = IndexPath.setOfIndexPaths(startRow: 0, count: Amount, in: 2)
        tableView.endUpdates()
    }
    func didLoadEntitiesToTheEnd(Amount: UInt) {
        tableView.beginUpdates()
        let set = IndexPath.setOfIndexPaths(startRow: UInt(tableView.numberOfRows(inSection: 2)) , count: Amount, in: 2)
        tableView.endUpdates()
    }
    func didDeleteEntities(views:[UIView]) {
        self.tableView.beginUpdates()
        var indexPaths = [IndexPath]()
        for view in views
        {
           if let cell = view as? UITableViewCell
           {
                if let ip = tableView.indexPath(for: cell )
                {
                    indexPaths.append(ip)

                }
            
            }
        }
      
        self.tableView.deleteRows(at: indexPaths, with: .automatic)
        self.tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if (indexPath.row ==  postsStorage.count-10) {
            print("schould load more")
            postsLoader.loadMoreToTheEnd(count: 10)
        }
        
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
    @IBAction func toSettings(_ sender: Any) {
        performSegue(withIdentifier: "profileToSettings", sender: nil)
    }
    func goToInformation() {
        performSegue(withIdentifier: "toInformation", sender: nil)
        
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
       
    }
    func menuShow(cell: postCell) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let post = cell.post
        let indexPath = tableView.indexPath(for: cell )
        let data = ["id":post?.id]
        let deleteAction = UIAlertAction(title: "Удалить", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
            self.postsLoader.deletePost(cell: cell)
            
            
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
    func setTableView()
    {
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
        
        
        tableView.estimatedSectionHeaderHeight = 0
    }
    func setLoaderWithStorage()
    {
        
        postsLoader = WallPostLoaderFromServerByProfile(named: "newsServerLoader", with: ServerManager.shared(named: "main")!, qos: .userInteractive,id: profile.id!)
        postsLoader.delegate = self

    }
    
}
