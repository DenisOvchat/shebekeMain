//
//  postCell.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 12.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//




import Foundation
import TRMosaicLayout
import UIKit
protocol PostEditDelegate
{
    var profile:FullProfile! {get set}
    func menuShow(cell:postCell)
    func reloadPost(post:WallPost,cell:postCell)
}
class postCell:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource
{
    
    @IBOutlet weak var avat: AvatarImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBOutlet weak var bodyContentView: UIView!
    
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate:PostEditDelegate?
    
    var collectionSizes=[CGSize]()
    
    override func awakeFromNib() {

        separator.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1).cgColor
        selectionStyle = .none
        
        
    }
    var post:WallPost!
    {
        didSet{
            if let url = post.sender?.pictUrl
            {
                avat.imageView.downloadedFrom(link: url)
                avat.setting(isonline: (post.sender?.isOnline)!, radius: 20)
            }
            if ( post.sender?.name != nil && post.sender?.secondName != nil)
            {
                nameLabel.text = (post.sender?.name)! + " " + (post.sender?.secondName)!

            }
            
            if let postTime = post.time
            {
                let now = Date()
                let dif = now.timeIntervalSince(postTime)
                
                var formatter = DateFormatter()
                if dif > 172800
                {
                    formatter.dateFormat = "dd MM YYYY HH:mm"
                    timeLabel.text = formatter.string(from: postTime)
                }
                else
                {
                    if dif > 86400
                    {
                        formatter.dateFormat = "вчера HH:mm"
                        timeLabel.text = formatter.string(from: postTime)
                    }
                    else
                    {
                        if dif > 3600
                        {
                            formatter.dateFormat = "сегодня HH:mm"
                            timeLabel.text = formatter.string(from: postTime)
                        }
                        else
                        {
                            if dif > 60
                            {
                                timeLabel.text = Int(dif/60).description + "минут назад"
                            }
                            else
                            {
                                timeLabel.text = "только что"
                            }
                        }
                    }
                }
            }
            
            
            bodyLabel.text = post.body
            
            if post.pictureInfos != nil
            {
                let nib = UINib(nibName: "PostPhotosCell", bundle: nil)

                collectionView.register(nib, forCellWithReuseIdentifier: "photoCell")
                collectionView.delegate = self
                collectionView.dataSource = self
                collectionView.reloadData()
                
            }
            else
            {
                if post.map != nil
                {
                    
                }
            }
            
            
            
        
            
            
            
            
            
            
            
            
            //collectionView.flow
            //collectionView.setsize
            //let layout = UICollectionViewFlowLayout()
            
            //layout.scrollDirection = .vertical
            //collectionView.lay
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PostPhotosCell
        
        if let info = post.pictureInfos?[indexPath.row]
        {
            cell.photoInfo = info
            
        }
        //cell.backgroundColor = UIColor.black
        //  cell.setcell(friend: profile.friends[indexPath.row])
        return cell
    }
    
    
    
   /* func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PostPhotosCell
        
        if let info = post.pictureInfos?[indexPath.row]
        {
            cell.photoInfo = info

        }
        //cell.backgroundColor = UIColor.black
      //  cell.setcell(friend: profile.friends[indexPath.row])
        return cell
    }*/
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post.pictureInfos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
       // let size = post.pictureInfos?[indexPath.row].size
        
        UIScreen.main.bounds.width
        let picDimension = UIScreen.main.bounds.width / 4.0
        return CGSize(width: picDimension, height: picDimension)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
 
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
  
    @IBAction func menuShow(_ sender: Any) {
        
        
        delegate?.menuShow(cell: self)
        
    }
    
    
}


