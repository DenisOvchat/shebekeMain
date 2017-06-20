//
//  5freindsTableCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 05.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//


import Foundation
import  UIKit
class fiveFriendstableCell:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var avat: AvatarImage!
    @IBOutlet weak var name: UILabel!
    var fiveFriends:[Person]!
    @IBOutlet weak var collectionView: UICollectionView!
    func setcell(friends:[Person])
    {
        let nib = UINib(nibName: "FiveFriendsCollectionCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "collectionCell")

        collectionView.delegate = self
        collectionView.dataSource = self
        fiveFriends = friends
        collectionView.reloadData()
        
        //collectionView.setsize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! FiveFriendsCollectionCell
        cell.setcell(friend: fiveFriends[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fiveFriends.count >= 8 ? 8 :fiveFriends.count
    }

    
    
}
