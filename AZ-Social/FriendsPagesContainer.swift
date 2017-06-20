//
//  frPreSwipe.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 29.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import  UIKit

class FriendsPagesContainer:UIViewController
{
    override func viewDidLoad() {
        
        
        
        
        
        let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let navigationController = Controller()
        navigationController.loadView()
        view.backgroundColor = UIColor.red
        let b = tabBarController
      //  view.addSubview(navigationController.view)
       
        //show(navigationController, sender: nil)
       // present(navigationController, animated: false) {}
       // tabBarController?.tabBar.isHidden = false
        //show(navigationController, sender: nil)
      //  self.window?.rootViewController = navigationController
        //self.window?.makeKeyAndVisible()
    }
}
