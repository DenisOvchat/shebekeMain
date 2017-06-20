//
//  FriendsVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 08.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
import Foundation

class FriendsVC:UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate, UISearchResultsUpdating,LoaderDelegate
{
  
    
    @IBOutlet weak var tableView: UITableView!

    var data = (UIApplication.shared.delegate as! AppDelegate).data
    var searchController = UISearchController()
    var searchBar:UISearchBar!
    var searchActive : Bool = false
    //var filtered:[String] = []
    
    var friendsStorage = FriendsStorage()
    
    
    var fiveFriends=[Person]()
    var friendsFiltered=[String:[Person]]()
    var mode:Int = 0
    var isOpened = false
    
    var menuBut = UIButton()
    var infoBut = UIButton()
    let spinner = UIActivityIndicatorView()
    var hasLoaded = false
    //var latBigRange:NSRange = "A". ..."Z"
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        //        navigationItem.title = "Друзья"
        //self.edgesForExtendedLayout = UIRectEdge.all
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        // self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        
        //self.navigationItem.titleView = searchController.searchBar
        
        //self.definesPresentationContext = true
        
        
        //-(tabBarController?.tabBar.frame.height)!
        
        let addFriendsBut = UIButton()
        addFriendsBut.setTitle("Добавить", for: UIControlState.normal)
        
        
        
        
        /*
         menuBut.frame=CGRect(x: 0, y: 0, width: 25, height: 25)
         menuBut.setImage(UIImage(named: "list_view_1x") , for: UIControlState.normal)
         
         
         menuBut.addTarget(self,
         action: #selector(DictionaryViewController.menu(_:)),
         for: UIControlEvents.touchUpInside)
         
         
         
         infoBut.frame=CGRect(x: 0, y: 0, width: 25, height: 25)
         infoBut.setImage(UIImage(named: "info_1x") , for: UIControlState.normal)
         
         
         infoBut.addTarget(self,
         action: #selector(DictionaryViewController.info(_:)),
         for: UIControlEvents.touchUpInside)
         */
        // data.menu=menutable(data: data)
        
        
        searchBar = searchController.searchBar
        searchBar.delegate = self
        searchBar.placeholder="Поиск"
        searchBar.backgroundColor = UIColor(netHex: 0x00bed4)
        searchBar.barTintColor = UIColor(netHex: 0x00bed4)
        tabBarController?.tabBar.tintColor = UIColor(netHex: 0x00bed4)
        
            tableView.delegate=self
            tableView.dataSource=self
            tableView.rowHeight = 70
    
        

        
    }
    
    override func loadView() {
        super.loadView()
       
       // tableView.tableHeaderView = searchBar
        
        
      //  tableView.register(CustomCell.self, forCellReuseIdentifier: "glosCell")
      /*
        tableView.sectionIndexColor = UIColor(netHex: 0x00bed4)
        tableView.backgroundColor = UIColor(netHex: 0xedf1f2)
        //     tableView.sectionIndexBackgroundColor
        UITableViewHeaderFooterView.appearance().tintColor = UIColor(netHex: 0xedf1f2)
        tableView.tintColor = UIColor(netHex: 0xedf1f2)
 */
      
        
           /* setLoadingScreen()
            
            
            
            
            
            
            
            self.removeLoadingScreen()
            
            
            self.hasLoaded=true
            */
            
        
       

 
        
        
    
        
       
           // self.tableView.reloadData()
            
            for family: String in UIFont.familyNames
            {
                print("\(family)")
                for names: String in UIFont.fontNames(forFamilyName: family)
                {
                    print("== \(names)")
                }
            }
            
            
   /*         for s in self.data.alphabet
            {
                print(s)
            }
         */
        }
        
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadFriends()
        
        
        
        
        
      //  navigationController?.navigationBar.barTintColor = UIColor.green
        
       /* UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState
            , animations: {
                self.navigationController?.navigationBar.barTintColor = UIColor(netHex: 0x00bed4)
                
                self.navigationController?.navigationBar.barStyle = .black
                self.navigationController?.navigationBar.tintColor = UIColor.white
                
        }, completion: { finished in
        })
        */
    }
    /*override func viewWillDisappear(_ animated: Bool) {
       // navigationController?.hidesBarsOnSwipe = true
        
        navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: navigationController!.navigationBar.frame.width , height: 64)
       // navigationController?.navigationBar.barTintColor = UIColor.green
    }*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if (self.searchActive)
        {
            
        }
        else
        {
            if indexPath.section == 0
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "fiveFriendCell", for: indexPath) as! fiveFriendstableCell
                cell.setcell(friends: fiveFriends)
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as! cellFriend
                cell.setcell(friend: friendsStorage[indexPath.row,indexPath.section - 1]!)
                
                return cell
            }
        }
   
        
        return UITableViewCell()
        
        
        
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if searchActive{
            return ""
        }
        else
        {
            if section == 0
            {
                return ""
            }
            else
            {
                return friendsStorage.alphabet[section - 1]

            }
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if !hasLoaded
        {
            return 0
        }
        
        if searchActive{
            return 2
            
        }
        else
        {
            return friendsStorage.alphabet.count + 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !hasLoaded
        {
            return 0
        }
        if (searchActive)
        {
            if section == 0
            {
                
            }
            else
            {
                
            }
            
            return 0
            
        }
        else
        {
            if section == 0
            {
                    return 1
            }
            else
            {
                return friendsStorage.counts[section - 1]

            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 91
        }
        else
        {
            return 70
        }
    }
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        isOpened = true
        
        
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        
        // tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
    
        // tableView.indexPathForSelectedRow
        // tableView.allowsSelection = false
        
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if (searchActive)
        {
            return [""]
        }
        else
        {
            return friendsStorage.alphabet
        }
    }
    /*   func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
     
     }*/
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // searchActive = true;
        
        searchBar.setShowsCancelButton(true, animated: true)
        //closeBut.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // searchActive = false;
        //searchBar.cancel
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchBar.setShowsCancelButton(false, animated: true)
        DispatchQueue.main.async(){
            
            self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
        
        searchBar.text = ""
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*filtered = data.filter({ (text) -> Bool in
         let tmp: NSString = text
         let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
         return range.location != NSNotFound
         })*/
        /*
        DispatchQueue.main.async(){
            if searchText.characters.count != 0 {
                self.alphabetFiltered = [String]()
                //searchText = searchText.lowercased()
                var cnt = 0
                for firstCharString in self.alphabet
                {
                    
                    self.friendsFiltered[firstCharString]=self.friends[firstCharString]?.filter({ (term) -> Bool in
                        
                        
                        let tmp: NSString = ((term as Term).name as NSString)
                        let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                        return range.location != NSNotFound
                    })
                    if (self.friendsFiltered[firstCharString] != nil)
                    {
                        cnt+=(self.friendsFiltered[firstCharString]?.count)!
                        if((self.friendsFiltered[firstCharString]?.count)! != 0)
                        {
                            
                            self.alphabetFiltered.append(firstCharString)
                        }
                    }
                }
                print("ищу там\(cnt)")
                self.searchActive = true
                
                self.tableView.reloadData()
                
            }
            else
            {
                self.searchActive = false
                
                self.tableView.reloadData()
            }
            if self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) != nil{
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
                
            }
        }
        
        
        */
        
        
    }
    @IBAction func back(_ sender: AnyObject) {
        //performSegue(withIdentifier: "StartToReminders", sender: self)
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if(searchBar.isFirstResponder)
        {
            searchBar.resignFirstResponder()
            searchBar.setShowsCancelButton(false, animated: true)
            
        }
        
    }
    
   
    private func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (self.tableView.frame.width / 2) - (width / 2)
        let y = (self.tableView.frame.height / 2) - (height / 2) - (self.navigationController?.navigationBar.frame.height)!
        // Sets loading text
        
        
        // Sets spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.spinner.startAnimating()
        spinner.center=tableView.center
        
        self.tableView.addSubview(spinner)
        tableView.separatorStyle = .none
        
    }
    func showLoadingScreen()
    {
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        tableView.separatorStyle = .none
        
    }
    
    private func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        tableView.separatorStyle = .singleLine
    }
    
    
    func loadFriends(id:Int = -1)
    {
         let postfix = (id == -1) ? ("/friends"):("/friends?id=" + id.description)
        ServerManager.shared(named: "main")?.GETRequestByAdding(postfix: postfix, complititionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            
            do{
                if let JSONData = data { // Check 1.
                    if let dict = try JSONSerialization.jsonObject(with: JSONData, options: []) as? NSDictionary { // Check 2. and 3.
                        print("Dictionary received")
                        
                        
                        self.friendsStorage.set(with: dict)
                        self.hasLoaded = true
                        DispatchQueue.main.async {
                            self.tableView.reloadData()

                        }
                        
                    }
                    else {
                        
                        if let jsonString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                            
                            
                            
                            
                            print("JSON: \n\n \(jsonString)")
                        }
                        fatalError("Can't parse JSON \(error)")
                    }
                }
                else {
                    fatalError("JSONData is nil")
                }
            }catch{}

            
        })
   
    }
    
    
}
