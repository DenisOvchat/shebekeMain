//
//  WallPostVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 13.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class WallPostVC:UIViewController,UITableViewDelegate,UITableViewDataSource,LoaderDelegate
{
    
    var commentsStorage = WallPostStorage()
    var isLoadingNewInTable = false
    var commentsLoader:CommentsLoaderByPostId!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var commentField: UITextField!
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    var post:WallPost!
    deinit {
        NotificationCenter.default.removeObserver(self)

        
    }
    override func viewDidLoad() {
        
        
        
        commentsLoader = CommentsLoaderByPostId(named: "CommentsLoader", with: ServerManager.shared(named: "main")!, qos: .userInteractive,postId: post.id! )
        commentsLoader.delegate = self
        commentsStorage.assignLoader(named: "postsFromServer", loader: commentsLoader)
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WallPostCellTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "wallPostCell")
        
        tableView.register(UINib(nibName: "CommentCell", bundle: Bundle.main), forCellReuseIdentifier: "Comment")
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none

        
        
        
    }
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let beginFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            let dif = -(endFrame?.minY)!+(beginFrame?.minY)!
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant += dif
            } else {
                self.keyboardHeightLayoutConstraint?.constant += dif            }
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: animationCurve,
                           animations: {
                            
                            self.view.layoutIfNeeded()
                            print(duration)
                            print((endFrame?.minY))
                            print(animationCurve)
                            if self.tableView.contentSize.height - self.tableView.contentOffset.y - self.tableView.frame.height < -dif
                            {
                                self.tableView.contentOffset.y-=self.tableView.contentSize.height - self.tableView.contentOffset.y - self.tableView.frame.height
                            }
                            else{
                                self.tableView.contentOffset.y += dif
                            }
                            
                            // self.tableView.frame=CGRect(x: 0, y: 0, width: Ss.X, height: (endFrame?.minY)!-150)
                            //self.container.center.y=(endFrame?.minY)!-150+19
                            
                            //  self.keyboardHeight = (endFrame?.minY)!-(beginFrame?.minY)!
                            
                            // self.moveContainer(y: (endFrame?.minY)!-(beginFrame?.minY)!)
            },
                           completion: nil)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.section ==  commentsStorage.count-10) {
            print("schould load more")
            commentsLoader.loadMoreToTheEnd(count: 10)
        }
        
        if (indexPath.section == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wallPostCell") as! postCell
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wallPostCell") as! CommentCell
            if let comment = commentsStorage[indexPath.row] as? NSDictionary
            {
                cell.comment = (Comment(with: comment ))
                
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
            return commentsStorage.count
        }
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        commentsLoader.load(count: 5)
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
    
    @IBAction func addComent(_ sender: Any) {
        let data = ["post_id":post?.id,"text":commentField.text] as [String : Any]
        
        
        
        ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: "/blogs/posts", data: data, complititionHandler:  { (data:Data?, response:URLResponse?, error:Error?) in
            
            
            
            if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                
                if httpResponse.statusCode == 201
                {
                    DispatchQueue.main.async
                        {
                            self.navigationController!.popViewController(animated: true)
                            
                    }
                }
                else
                {
                    print("did not add post")
                }
                
                
            }
            
        },withCookies: true,with:"PUT")

    }
}
