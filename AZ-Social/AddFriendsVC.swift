//
//  AddFriendsVC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 09.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class AddFriendsVC:UITableViewController,UISearchBarDelegate
{
    @IBOutlet weak var searchBar: UISearchBar!
    var shouldShowSearchResults = false
    
    var friendsStorage = FriendsStorage()
    var currentTask:URLSessionDataTask?
    
    override func viewDidLoad() {
        searchBar.delegate = self
    }
    
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
       // searchActive = false;
        searchBar.setShowsCancelButton(false, animated: true)
        DispatchQueue.main.async(){
            
            self.tableView.reloadData()
        }
        searchBar.resignFirstResponder()
        
        searchBar.text = ""
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //  searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if currentTask != nil
        {
           currentTask?.cancel()
        }
        
        let dict:[String:Any] = [:]
        let postfix = ("/people")
        currentTask = ServerManager.shared(named: "main")?.POSTJSONRequestByAdding(postfix: postfix,data:dict, complititionHandler: { (data:Data?, response:URLResponse?, error:Error?) in
            
            do{
                if let JSONData = data { // Check 1.
                    if let dict = try JSONSerialization.jsonObject(with: JSONData, options: []) as? NSDictionary { // Check 2. and 3.
                        print("Dictionary received")
                        
                        
                        self.friendsStorage.set(with: dict)
                        //  self.tableView.reloadData()
                    }
                    else {
                        
                        if let jsonString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                            
                            
                            
                            
                            print("JSON: \n\n \(jsonString)")
                        }
                        print("Can't parse JSON \(error)")
                    }
                }
                else {
                    print("JSONData is nil")
                }
            }catch{}
            
            
        })

        
       
        
        
        
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
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
