//
//  LentaVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 08.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import  UIKit

class LentaVC:UIViewController,UITableViewDataSource,UITableViewDelegate,LoaderDelegate
{
    var postsStorage = WallPostStorage()
    var isLoadingNewInTable = false
    var postsLoader:WallPostLoaderFromServerLenta!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
     override func loadView() {
        super.loadView()
        
        
        
        
        
        postsLoader = WallPostLoaderFromServerLenta(named: "newsServerLoader", with: ServerManager.shared(named: "main")!, qos: .userInteractive)
        postsLoader.delegate = self
        postsStorage.assignLoader(named: "postsFromServer", loader: postsLoader)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WallPostCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "wallPostCell")
        
        tableView.register(UINib(nibName: "AddPostCell", bundle: Bundle.main), forCellReuseIdentifier: "addPostCell")

        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
       // NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        
    }
    
    override func viewDidLoad() {
       // postsLoader.load(count: 5)

    }
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let beginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
           /* if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.tableViewBottomConstraint?.constant = 0.0
            } else {
                self.tableViewBottomConstraint?.constant = 200
                    //(endFrame?.minY)!-(beginFrame?.minY)!
            }*/
            
            self.tableViewBottomConstraint?.constant =  view.frame.height - (tabBarController?.tabBar.frame.height)! - (endFrame?.minY)!
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: animationCurve,
                           animations: {
                            
                            self.view.layoutIfNeeded()
                            print(duration)
                            print((endFrame?.minY))
                            print(animationCurve)
                            
                            
                            
                            
                            // self.tableView.frame=CGRect(x: 0, y: 0, width: Ss.X, height: (endFrame?.minY)!-150)
                            //self.container.center.y=(endFrame?.minY)!-150+19
                            
                            //  self.keyboardHeight = (endFrame?.minY)!-(beginFrame?.minY)!
                            
                            // self.moveContainer(y: (endFrame?.minY)!-(beginFrame?.minY)!)
            },
                           completion: nil)
            
            
        }
    }
 /*   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 55
        }
        else {
            return 0
        }
    }
*/
    @IBAction func didTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.row ==  postsStorage.count-10) {
            print("schould load more")
            postsLoader.loadMoreToTheEnd(count: 10)
        }
        
        if (indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addPostCell") as! AddPostCell
            return cell

        }
        else
        {
           let cell = tableView.dequeueReusableCell(withIdentifier: "wallPostCell") as! postCell
            if let post = postsStorage[indexPath.row] as? NSDictionary
            {
                cell.post = (WallPost(with: post ))

            }
            return cell

        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddPostVC")
            show(vc!, sender: self)
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if let addPostDest = (segue.destination as! AddPostVC)
        {
            AddPostVC
        }*/
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        else
        {
            return postsStorage.count
        }
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        postsLoader.load(count: 5)
    }
    func didLoadEntitiesToTheEnd(Amount: Int) {
        
    }
    func didLoadEntitiesToTheStart(Amount: Int) {
        
    }
    func didLoadEntities(Amount: UInt) {
        
        
        
        
        //  tableView.beginUpdates()
        //let paths = IndexPath.setOfIndexPaths(startRow: 2, count: Amount, in: 0)
        //  tableView.insertRows(at: paths, with: UITableViewRowAnimation.automatic)
        tableView.reloadSections(IndexSet(integersIn: 1...1), with: UITableViewRowAnimation.automatic)
        //  tableView.endUpdates()
        
    }
    func didReloadEntities(indexes:[Int])
    {}
    func didDeleteEntities(indexes:[Int])
    {}
    func didAddEntities(indexes:[Int])
    {}
    
}
