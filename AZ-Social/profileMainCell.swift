//
//  profileMainCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 11.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class profileMainCell:UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegate
{
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var isOnlineLabel: UILabel!
    @IBOutlet weak var oldcityLabel: UILabel!
    @IBOutlet weak var mapandinfoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var onMapButton: UIButton!
    @IBOutlet weak var InformationButton: UIButton!
    @IBOutlet weak var onMapTopConstraint: NSLayoutConstraint!
    
    var delegate:profileMainCellDelegate?
    override func awakeFromNib() {
        selectionStyle = .none
        
    }
    
    var profile:FullProfile!
    {
        didSet{
            //profile = friend
            
            mapandinfoView.layer.borderColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1).cgColor
            
            
            onMapButton.titleLabel?.textAlignment = .center
            onMapButton.titleLabel?.textAlignment = .center
            InformationButton.imageView?.center.x = InformationButton.bounds.width / 2
            InformationButton.imageView?.center.x = InformationButton.bounds.width / 2

            
            
            topImageView.downloadedFrom(link: profile.topImageUrl!)
            if let picturl = profile.pictUrl
            {
                avatarImage.downloadedFrom(link: picturl)

            }
            avatarImage.contentMode = .scaleAspectFill
            avatarImage.layer.cornerRadius = 60
            avatarImage.layer.masksToBounds = true
            avatarImage.layer.borderWidth = 2
            avatarImage.layer.borderColor = UIColor.white.cgColor


            nameLabel.text = profile.name! + " " + profile.secondName!
            if profile.isOnline
            {
                isOnlineLabel.text = "Online"
                isOnlineLabel.textColor = UIColor(red: 0, green: 146, blue: 176, al: 1)
            }
            else
            {
                isOnlineLabel.text = "Offline"
                isOnlineLabel.textColor = UIColor(red: 155, green: 155, blue: 155, al: 1)
            }
            //oldcityLabel.text = friend.WhereFrom
            
            
          
            oldcityLabel.text = profile.age! + " лет, " + profile.city!
            
            
            if (profile.isMine)
            {
                onMapTopConstraint.constant = 10
            }
            else
            {
                onMapTopConstraint.constant = 66
            }
            let nib = UINib(nibName: "FiveFriendsCollectionCell", bundle: nil)
            
            collectionView.register(nib, forCellWithReuseIdentifier: "collectionCell")

            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
          //  collectionView.collectionV
        }
    }
    
    
   
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! FiveFriendsCollectionCell
        cell.setcell(friend: profile.friends[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profile.friends.count >= 8 ? 8 :profile.friends.count
    }
    
    @IBAction func imformationPushed(_ sender: Any) {
        if let del = delegate
        {
            del.goToInformation()
        }
        
    }
  
    
}
    
protocol profileMainCellDelegate
{
    func goToInformation()
}
extension profileMainCellDelegate
{
    func goToInformation(){}

}

    

