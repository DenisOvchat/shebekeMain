//
//  pageViewController.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 15.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
class PageViewController:UIPageViewController,UIPageViewControllerDataSource
{
    var vcs = [UIViewController]()
    var index = 1
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController(int: 1),
                self.newColoredViewController(int: 2),
                self.newColoredViewController(int: 3)]
    }()
    
    private func newColoredViewController(int:Int) -> UIViewController {
        return (storyboard?.instantiateViewController(withIdentifier: "\(int)"))!
    }
    
    override func viewDidLoad() {
        //    transitionStyle = .scroll
        //  vcs = [(storyboard?.instantiateViewController(withIdentifier: "1"))!,(storyboard?.instantiateViewController(withIdentifier: "2"))!,(storyboard?.instantiateViewController(withIdentifier: "3"))!]
        dataSource = self
        
        let firstViewController = newColoredViewController(int: 2)
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true,
                           completion: nil)
        
        storyboard?.instantiateViewController(withIdentifier: "1")
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if index == 0
        {
            return nil
            
        }
        else
        {
            index -= 1
            return newColoredViewController(int: index+1)
            
        }
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if index == 2
        {
            return nil
            
        }
        else
        {
            index += 1
            return newColoredViewController(int: index+1)
        }
    }
    
    
    
}
