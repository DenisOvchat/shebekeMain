//
//  dialogVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 11.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class DialogVC:UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate
{
    
    
    var data:ProgramData=((UIApplication.shared.delegate) as! AppDelegate) .data
    var del=((UIApplication.shared.delegate) as! AppDelegate)
    
    var isPrivate=false
    
    @IBOutlet weak var tableView: UITableView!
    var user:dialogBody!
    
    var field=UITextView()
    var prevRectForField=CGRect()
    
    var but1=UIButton()
    var but2=UIButton()
    var but3=UIButton()
    let line=UIView()
    //var theRoom:XMPPRoom?
    var stickersView:UICollectionView!
    var chat:Chat!
    var usersBut = UIButton()
    var menuBut = UIButton()
    var keyboardHeight=CGFloat()
    var backBut = UIButton()
    //var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    var stickHeightLayoutConstraint: NSLayoutConstraint?
    var containerHeightLayoutConstraint: NSLayoutConstraint?
    var showedAdd = false
    /*override func viewDidLoad() {
     if (!isPrivate){
     }
     }*/
    override func loadView() {
        super.loadView()
        
        
        
        
        usersBut.setBackgroundImage(UIImage(named: "ic_users_list_menu"), for: UIControlState())
        usersBut.addTarget(self,
                           action: "showUsers:",
                           for: UIControlEvents.touchUpInside)
        usersBut.frame=CGRect(x: 0, y: 0           , width: 30, height: 30)
        
        menuBut.setBackgroundImage(UIImage(named: "ic_drawer"), for: UIControlState())
        menuBut.addTarget(self,
                          action: "showMenu:",
                          for: UIControlEvents.touchUpInside)
        menuBut.frame=CGRect(x: 0, y: 0           , width: 30, height: 30)
        //remindersBut.setAttributedTitle(NSMutableAttributedString(string:"Уведомления", attributes:[NSFontAttributeName : UIFont.boldSystemFont(ofSize: 13),NSForegroundColorAttributeName : UIColor(netHex: 0x939799)]), for: UIControlState())
        
        
        
       // automaticallyAdjustsScrollViewInsets = false
        tableView.delegate=self
        tableView.dataSource=self
        //tableView.frame=CGRect(x: 0, y: 0, width: Ss.X, height: Ss.Yy-35-data.bannerView.frame.height)
        //tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, al: 1)
        tableView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, al: 0)
        tableView.sectionFooterHeight =  0
        tableView.sectionHeaderHeight =  0
        tableView.tableHeaderView = nil
        tableView.tableFooterView?.frame = CGRect.zero
        
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40
        view.backgroundColor = UIColor.white
        
        //tableView.backgroundView = UIImageView(image: data.imags.getImage(name: "chat_background.png"))
        
        
        
        tableView.allowsSelection=false
        tableView.separatorStyle = .none
        var gest=UITapGestureRecognizer(target: self, action: "taped:")
        tableView.addGestureRecognizer(gest)
        
        field.frame=CGRect(x: 35, y: 0, width: Ss.X-70, height: 35)
        field.backgroundColor=UIColor(netHex: 0xE1E1E1)
        field.delegate = self
        field.textColor = UIColor(netHex: 0x56378F, alpha: 1)
        field.tintColor = UIColor(netHex: 0x56378F, alpha: 1)
        field.font = UIFont.systemFont(ofSize: 15)
        field.translatesAutoresizingMaskIntoConstraints = false
        
        line.frame=CGRect(x: 39, y: 32, width: Ss.X-78, height: 1.5)
        line.backgroundColor=UIColor(netHex: 0x56378F, alpha: 0.5)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        line.translatesAutoresizingMaskIntoConstraints = false
      
        but2.addTarget(self, action: "but2f:", for: UIControlEvents.touchUpInside)
        but2.setImage(UIImage(named:"ic_sticker"), for: UIControlState.normal)
        but2.frame=CGRect(x: 0, y: 0, width: 35, height: 35)
        but2.backgroundColor=UIColor(netHex: 0xE1E1E1)
        but2.translatesAutoresizingMaskIntoConstraints = false
        
        but3.addTarget(self, action: "but3:", for: UIControlEvents.touchUpInside)
        but3.setImage(UIImage(named:"ic_message_send"), for: UIControlState.normal)
        but3.frame=CGRect(x: Ss.X-35, y: 0, width: 35, height: 35)
        but3.backgroundColor=UIColor(netHex: 0xE1E1E1)
        but3.translatesAutoresizingMaskIntoConstraints = false
        
     
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: (Ss.X/2-90)/2, left: (Ss.X/2-90)/2, bottom: (Ss.X/2-90)/2, right: (Ss.X/2-90)/2)
        layout.itemSize = CGSize(width: 90, height: 90)
        
        
        stickersView = UICollectionView(frame: CGRect(x: 0, y: Ss.Yy, width: Ss.X, height: 243), collectionViewLayout: layout)
        stickersView.dataSource = self
        stickersView.delegate = self
        stickersView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "stickersCell")
        stickersView.tag=11
        stickersView.backgroundColor=UIColor(netHex: 0xE8ECEF)
        stickersView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout2.itemSize = CGSize(width: Ss.X/9, height: Ss.X/9)
        
        
        
        
        if(isPrivate)
        {
            user.chat.roomView=self
            chat = user.chat
            navigationItem.title=user.name! + " " + user.secondName!
            let im = UIImage(named: "ic_drawer_back")
            
          
            //navigationItem.setLeftBarButton(UIBarButtonItem(customView: backBut)
              //  , animated: false)
            // backBarButtonItem?.setBackButtonBackgroundImage(newin, for: UIControlState(), barMetrics: UIBarMetrics.compact)
            //  = newin
            // = UIBarButtonItem(customView: backBut)
            
        }
        else
        {
           /*
            // room.roomView=self
            navigationItem.title=room.xmppRoom.roomJID.user
            var menView = UIView(frame: CGRect(x: -Ss.MenuWidth, y: 0, width: Ss.X + Ss.MenuWidth * 2, height: Ss.Yy - data.bannerView.frame.height))
            menView.isUserInteractionEnabled = false
            menu = data.menu
            //   menutable(controller: self)
            usersTable=freindsTable(data: data, chat: room,roomController: self)
            // usersTable.isHidden=true
            del.getRooms(server: room.jid)
            
            menView.addSubview(menu!)
            
            
            //  selectRow(at: IndexPath(row: numberOfSelectedRoom!, section: 0), animated: false, scrollPosition: UITableViewScrollPosition.none)
            menView.addSubview(usersTable)
            view.addSubview(menView)
            r = GestureRecognizer(ViewForMenus: menView, controll: self)
            r?.setup()
            
            navigationItem.leftBarButtonItem=UIBarButtonItem(customView: menuBut)
            
            navigationItem.rightBarButtonItem=UIBarButtonItem(customView: usersBut)
 */
        }
        
        
        
        
        print(view.gestureRecognizers?.count)
        print("recogs")
        
        
        //   let   recognizer=UIPanGestureRecognizer(target: self, action: "recogn:")
        
        // recognizer?.delegate=self
        
        //   view.addGestureRecognizer((recognizer))
        
        
        
    }
   
   
    deinit {
        NotificationCenter.default.removeObserver(self)
        // room.xmppRoom.leave()
        //print("deini")
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
        
        let mes = chat.messages[indexPath.row]
        /*if (mes.isServerMessage)
        {
            let cell = UITableViewCell()
            cell.textLabel?.text = mes.text
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.textLabel?.textColor = UIColor(netHex: 0x56378F, alpha: 1)
            cell.backgroundColor=UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
            
            return cell
        }
        else{
            var cell=tableView.dequeueReusableCell(withIdentifier: "mesCell") as! DialogCell
            cell.mes  = chat.messages[indexPath.row]
            return cell
        }
        */
        var cell:DialogCell!
        if mes.isMine
        {
            cell = tableView.dequeueReusableCell(withIdentifier: "mesCell", for: indexPath) as! DialogCell
        }
        else
        {
           cell = tableView.dequeueReusableCell(withIdentifier: "foreignMesCell", for: indexPath) as! DialogCell
            
        }
            
        //var cell=tableView.dequeueReusableCell(withIdentifier: "mesCell") as! DialogCell
        cell.setCell(mes: chat.messages[indexPath.row])
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.messages.count
    }
  
    override func viewDidAppear(_ animated: Bool) {
        
        if(!isPrivate)
        {
        
            
            
        }
        else
        {
           /*
            
            let numRows = tableView.numberOfRows(inSection: 0)
            if numRows != 0{
                if user.unreadMessagesCount == 0
                {
                    tableView.scrollToRow(at: IndexPath(row: numRows - 1 , section: 0), at: UITableViewScrollPosition.bottom, animated: true)
                }
                else
                {
                    tableView.scrollToRow(at: IndexPath(row: numRows - user.unreadMessagesCount , section: 0), at: UITableViewScrollPosition.top, animated: true)
                }
                
            }
            
            user.unreadMessagesCount = 0
 */
            
        }
        // view.endEditing(true)
        //field.resignFirstResponder()
        //field.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        if(!isPrivate)
        {
            
            
            
        }
        
        
        print("tytytyt")
        //theRoom.
        
        
        //   theRoom.
        // let presence = XMPPElement(name: "presence")
        //presence.addAttribute(withName: to, stringValue: (theRoom?.roomJID.bare())!)
        //presence.addAttribute(withName: from, stringValue: <#T##String#>)
        /*let listElem = DDXMLElement(name: "iq")
         listElem.addAttribute(withName: "to", stringValue: (theRoom?.roomJID.bare())!)
         listElem.addAttribute(withName: "id", stringValue: (theRoom?.roomJID.bare())!)*/
    }
    
    
    
    
    @IBAction func but3(_ sender: AnyObject)
    {
        if field.text != ""
        {
            if(isPrivate)
            {
                let message = Message(sender: data.myProfile!, isMine: true, text: field.text, isRead: true, time: "11:20")
                chat.messages.append(message)
            }
            else
            {
/*
                let mes=Message(text: field.text!)
                room.messages.append(mes)
                */
            }
            //view.endEditing(true)
            field.text=""
            tableView.insertRows(at: [IndexPath(row: (tableView.numberOfRows(inSection: 0)), section: 0)], with: UITableViewRowAnimation.left)
            
            tableView.scrollToRow(at: NSIndexPath(row: (tableView.numberOfRows(inSection: 0)) - 1, section:0) as IndexPath, at: UITableViewScrollPosition.top, animated: true)
            
            minimizeContainer()
            //textViewDidChange(field)
        }
    }
    func minimizeTable(y:CGFloat)
    {
        // self.tableView.frame=CGRect(x: 0, y: 0, width: Ss.X, height: tableView.frame.maxY+y)
    }
  
    func hideKeyboards()
    {
        
        self.stickersView.center.y = -221.5
        self.view.endEditing(true)
        
        
        
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) {
        if(isStickShown())
        {
            but2f(view)
        }
    }
    
    @IBAction func but2f(_ sender: AnyObject)
    {
        if (field.isFirstResponder)
        {
            field.endEditing(true)
        }
        if(self.isStickShown())
        {
            
            stickHeightLayoutConstraint?.constant = 0
            //   self.moveContainer(y: +243)
        }
        else
        {
            
            stickHeightLayoutConstraint?.constant = -243
            // self.moveContainer(y: -243)
        }
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(rawValue: 7)
            , animations: {
                
                self.view.layoutIfNeeded()
                
        }, completion: { finished in
        })
        
        
    }
    func isStickShown() -> Bool {
        return false
            //((stickHeightLayoutConstraint?.constant)! < CGFloat(0.0) )
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = stickersView.dequeueReusableCell(withReuseIdentifier: "stickersCell", for: indexPath)
        //cell.reuseIdentifier = "stickersCell"
        if cell.contentView.subviews.count != 0
        {
            cell.contentView.subviews [ 0 ].removeFromSuperview()
        }
        
        let im = UIImage(named: ("doQGi8s0MzU.jpg"))
        
        let stickWidth = CGFloat((im?.cgImage?.width)!)  / CGFloat((im?.cgImage?.height)!) * (cell.contentView.frame.height)
        
        let fr = CGRect(x: (cell.contentView.frame.width - stickWidth)/2, y: 0, width: stickWidth, height: cell.contentView.frame.height)
        var stickbut:UIButton!
        
        
        stickbut=UIButton(frame: fr)
        //stickbut.tag = 12
        cell.contentView.addSubview(stickbut)
        stickbut.tag = indexPath.row+1
        
        
        stickbut.setImage(UIImage(named: ("st\(indexPath.row+1).png")), for: UIControlState.normal)
        stickbut.addTarget(self, action: "stickBut:", for: UIControlEvents.touchUpInside)
        
        //UIImageView(image: UIImage(named: "cordova.png"))
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    @IBAction func stickBut(_ sender: AnyObject)
    {
        /*
        let mes:XMPPMessage!
        if(isPrivate)
        {
            let mes=XMPPMessage(name: "message")
            
            //(from: DDXMLElement(name: "message", stringValue: user.jid))
            mes.addAttribute(withName: "from", stringValue: (del.xmppStream?.myJID.full())!)
            mes.addAttribute(withName: "to", stringValue: user.realJID)
            let q = DDXMLElement(name: "sticker")
            q.addAttribute(withName: "xmlns", stringValue: del.server + "/stickers")
            q.stringValue = "st\((sender as! UIButton).tag).png"
            
            mes.addChild(q)
            
            //mes?.addAttribute(withName: "nick", stringValue: data.userName)
            del.xmppStream?.send(mes)
            let message = Message(xmppmsg: mes,ismine: true)
            chat.messages.append(message)
        }
        else
        {
            mes = XMPPMessage(type: "chat", to: room.xmppRoom.roomJID)
            let q = DDXMLElement(name: "sticker")
            q.addAttribute(withName: "xmlns", stringValue: del.server + "/stickers")
            q.stringValue = "st\((sender as! UIButton).tag).png"
            
            mes?.addChild(q)
            mes.addAttribute(withName: "from", stringValue: (del.xmppStream?.myJID.full())!)
            
            print(mes)
            let message=Message(xmppmsg: mes!,ismine: true)
            
            room.xmppRoom.send(mes)
            //sendMessage(withBody: field.text)
            
            
            chat.messages.append(message)
            
            
            //tableView.reloadData()
        }
        
        DispatchQueue.main.async(){
            self.tableView?.beginUpdates()
            var ind = (self.tableView?.numberOfRows(inSection: 0))!
            while ind < self.chat.messages.count
            {
                self.tableView?.insertRows(at: [IndexPath(row: ind, section: 0)], with: UITableViewRowAnimation.right)
                
                ind+=1
            }
            self.tableView?.endUpdates()
            self.tableView?.scrollToRow(at: NSIndexPath(row: (self.tableView?.numberOfRows(inSection: 0))! - 1, section:0) as IndexPath, at: UITableViewScrollPosition.top, animated: true)
        }
        
       */
    }
    @IBAction func taped(_ sender: AnyObject)
    {
        view.endEditing(true)
        if(isStickShown())
        {
            stickHeightLayoutConstraint?.constant += 243
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(rawValue: 7)
                , animations: {
                    self.view.layoutIfNeeded()
                    //self.stickersView.center.y += 243
                    //self.moveContainer(y: +243)
                    
                    
            }, completion: { finished in
            })
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        field.endEditing(true)
        
        
        
        //  let name = room.users[(room.users[Array(room.users.keys)[(usersTable.indexPathForSelectedRow?.row)!]]?.jid)!]?.jid
        
        
        
    }
    func textViewDidChange(_ textView: UITextView) {
        var pos = field.endOfDocument
        var curRect = field.caretRect(for: pos)
        //field.scrollRectToVisible(<#T##rect: CGRect##CGRect#>, animated: <#T##Bool#>)
        if(curRect.origin.y > prevRectForField.origin.y)
        {
            
            
            containerHeightLayoutConstraint?.constant += (textView.font?.lineHeight)!
            
            
        }
        if(curRect.origin.y < prevRectForField.origin.y)
        {
            
            containerHeightLayoutConstraint?.constant -= (textView.font?.lineHeight)!
            
        }
        prevRectForField = curRect
        
    }
    func minimizeContainer()
    {
        containerHeightLayoutConstraint?.constant = 35
        var pos = field.endOfDocument
        prevRectForField = field.caretRect(for: pos)    }
    override func viewDidDisappear(_ animated: Bool) {
        print("dsrpd")
    }
    @IBAction func atachmentsPushed(_ sender: Any) {
    }
   
    @IBOutlet weak var sendMessagePushed: UIButton!
    
}

