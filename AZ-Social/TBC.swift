//
//  TBC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 29.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import  UIKit
class TBC:UITabBarController
{
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let c = Controller()
            //storyboard?.instantiateViewController(withIdentifier: "addFriend")
        
        let navigationController = storyboard!.instantiateViewController(withIdentifier: "navForFriends") as! UINavigationController
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.viewControllers = [c]
            //Controller()]
       // navigationController.navigationBar.barStyle = .default
        //navigationController.navigationBar.tintColor = UIColor.blue
        navigationController.title = "Друзья"
        navigationController.tabBarItem.image = UIImage(named: "invalidName-1")
        navigationController.tabBarItem.title = "Друзья"
       // navigationController.navigationBar.tintColor = UIColor.white
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.backgroundColor = UIColor.white
        viewControllers?.insert(navigationController, at: 3)
        
 
        
        
    }
    
}
