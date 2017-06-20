//
//  registrationNavigationC.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 12.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class RegistrationNavigationC:UINavigationController,UINavigationControllerDelegate
{
    var pageControl:UIPageControl!
    var registrationWay = RegistrationType.phoneNumber

    
    override func viewDidLoad() {
        pageControl = UIPageControl()
        
        self.delegate = self
        
        pageControl.numberOfPages = 6
        pageControl.isHidden = true

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        
        navigationBar.addSubview(pageControl)
       
        view.layer.contents = UIImage(named: "ФонРегистрации.png")?.cgImage // 1
        view.layer.contentsGravity = kCAGravityResize
   //     navigationController?.view.insertSubview(im, at: 0)
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        if operation == .pop
        {
            if self.viewControllers.count == 2
            {
                pageControl.isHidden = true
            }
            else
            {

            }
            if self.viewControllers.count >= 3
            {
                pageControl.currentPage -= 1

            }

        }
        
        
        if operation == .push
        {
            if self.viewControllers.count == 3
            {
                pageControl.isHidden = false

            }
                
            if self.viewControllers.count >= 4
            {
                pageControl.currentPage += 1
                
            }

        }
        return RegistrationTransition()
    }
    /*func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        pageControl.currentPage += 1
    }*/
   
    override func viewWillLayoutSubviews() {
        pageControl.frame = CGRect(origin: CGPoint(x: (navigationBar.frame.width)/2, y: (navigationBar.frame.height)/2), size: CGSize.zero)
    }
    
}
