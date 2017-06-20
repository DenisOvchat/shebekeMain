//
//  AddPostVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 08.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

protocol AttachmentsDelegate {
    func deleteAttachment(for indexPath: IndexPath)
    
}


class AddPostVC: UIViewController,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var fromBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    
    
    @IBOutlet weak var attachmentsCollection: UICollectionView!
    @IBOutlet weak var attachmentsHeightConstraint: NSLayoutConstraint!
    
    let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: "readyPushed")
    
    var tableView:UITableView?
    
    var attachments = [Attachment]()
    
    let attachmentUpdatesQueue = DispatchQueue(label: "lab", qos: .utility)
    var profile:FullProfile?
    var post:WallPost?
    @IBOutlet weak var separator: UIView!
    
    override func viewDidLoad() {
        if post != nil
        {
            textView.text = post?.body
        }
        attachmentsHeightConstraint.constant = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        textView.delegate = self
        attachmentsCollection.delegate = self
        attachmentsCollection.dataSource = self
        attachmentsCollection.register(UINib(nibName: "AttachmentCellCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "attachmentCell")
        navigationItem.setRightBarButton(barButtonItem, animated: true)
        /*if let nav = navigationController
        {
            let readyBut = UIButton()
            readyBut.setTitle("готово", for: UIControlState.normal)
            
            
            navigationController?.navigationItem.setRightBarButton(barButtonItem, animated: true)
        }*/
    }
    func readyPushed()
    {
       // ["block":,"text":]
        if post != nil
        {
            let data = ["text":textView.text] as [String : Any]
            
            
            
            ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: "/blogs/posts?id=" + (post!.id?.description)!, data: data, complititionHandler:  { (data:Data?, response:URLResponse?, error:Error?) in
                
                
                
                if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                    
                    if httpResponse.statusCode == 202
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
                
            },withCookies: true,with:"PATCH")

        }
        
        
        
        let data = ["blog_id":profile?.id,"text":textView.text] as [String : Any]
        
        
        
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
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
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
            
            self.fromBottomConstraint?.constant =  view.frame.height - (tabBarController?.tabBar.frame.height)! - (endFrame?.minY)!
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
   
    
    func textViewDidChange(_ textView: UITextView) {
        guard tableView != nil else
        {
            return
        }
        let currentOffset = tableView?.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView?.beginUpdates()
        tableView?.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView?.setContentOffset(currentOffset!, animated: false)
    }
    
    
    @IBAction func addAttachmentsPushed(_ sender: Any) {
        let alertView = UIAlertController(title: "attach", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let addPhotoAction = UIAlertAction(title: "Фото", style: UIAlertActionStyle.default) { (UIAlertAction) in
            guard self.tableView != nil else
            {
                return
            }
            let photosSelectVC = BSImagePickerViewController()
            (self.tableView?.delegate as! UIViewController).bs_presentImagePickerController(photosSelectVC, animated: true,
                                                                                            select: { (asset: PHAsset) -> Void in
                                                                                                // User selected an asset.
                                                                                                // Do something with it, start upload perhaps?
            }, deselect: { (asset: PHAsset) -> Void in
                // User deselected an assets.
                // Do something, cancel upload?
            }, cancel: { (assets: [PHAsset]) -> Void in
                // User cancelled. And this where the assets currently selected.
            }, finish: { (assets: [PHAsset]) -> Void in
                
                let phManager = PHImageManager()
                DispatchQueue.main.async {
                    var indexPaths = [IndexPath]()
                    let phManager = PHImageManager()

                    for asset in assets
                    {
                        
                        let attachment = PhotoAttachmentFromDevice(with: asset)
                        self.attachments.append(attachment)
                        
                        phManager.requestImageData(for: asset, options: nil, resultHandler: { (data:Data?, str:String?, orientation:UIImageOrientation, arg:[AnyHashable : Any]?) -> Void in
                            print(data)
                            
                            
                            
                            if data != nil{
                                
                                
                                
                                
                                    
                                    
                                let jpeg = UIImageJPEGRepresentation(UIImage(data: data!)!, 1)
                                    
                                ServerManager.shared(named: "main")?.POSTFormRequestByAdding(postfix: "/persons/files", data: jpeg!, complititionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
                                    
                                    
                                    
                                    if let httpResponse = response as? HTTPURLResponse, let fields = httpResponse.allHeaderFields as? [String : String] {
                                        
                                        if httpResponse.statusCode == 201
                                        {
                                            DispatchQueue.main.async
                                            {
                                                    
                                            }
                                        }
                                        else
                                        {
                                            print("did not add file")
                                        }
                                        
                                        
                                    }
                                    
                                },withCookies: true,with:"PUT")

                                    
                                
                            }
                            
                            
                            
                        })

                        
                        //  var data = NSMutableDictionary()
                        // data.setValue(String(data: jpeg!, encoding: String.Encoding.utf8), forKey: "avatar")
                        // var data = ("avatar" + "=" + String(data: jpeg!, encoding: String.Encoding.utf8)!).data(using: String.Encoding.utf8)
                        
                        
                    }
                    
                    for i in 0..<assets.count
                    {
                        indexPaths.append(IndexPath(row: self.attachmentsCollection.numberOfItems(inSection: 0) + i , section: 0))
                        
                        
                    }
                    
                    
                    
                    
                    self.attachmentsCollection.insertItems(at: indexPaths )
                    self.attachmentsHeightConstraint.constant = self.attachmentsCollection.contentSize.height
                    print(self.attachmentsCollection.contentSize.height)
                    //self.setNeedsLayout()
                
                    
                    // self.coll
                    
                }
                
                
                // User finished with these assets
            }, completion: nil)
            
        }
        let addCoordinatesAction = UIAlertAction(title: "местоположение", style: UIAlertActionStyle.default) { (UIAlertAction) in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive) { (UIAlertAction) in
            
        }
        alertView.addAction(addPhotoAction)
        alertView.addAction(addCoordinatesAction)
        alertView.addAction(cancelAction)
        (self.tableView?.delegate as! UIViewController).present(alertView, animated: true, completion: nil)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return attachments.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = attachmentsCollection.dequeueReusableCell(withReuseIdentifier: "attachmentCell",for: indexPath) as! AttachmentCellCollectionViewCell
        
        //cell.backgroundColor = UIColor.black
        cell.attachment = attachments[indexPath.row]
        cell.tag = indexPath.row
        // Configure the cell
        return cell
    }
    /*func deleteAttachment(for indexPath: IndexPath) {
     DispatchQueue.global().async {
     self.attachments.remove(at: indexPath.row)
     
     self.attachmentsCollection.deleteItems(at: [indexPath])
     }
     
     
     }*/
    
    @IBAction func deleteAttachment(_ sender: AttachmentCellCollectionViewCell) {
        attachmentUpdatesQueue.async {
            self.attachments.remove(at: sender.tag)
            
            self.attachmentsCollection.deleteItems(at: [IndexPath(row: sender.tag, section: 0)])
            self.attachmentsHeightConstraint.constant = self.attachmentsCollection.contentSize.height
            //self.setNeedsLayout()
        }
        
    }
    
}
