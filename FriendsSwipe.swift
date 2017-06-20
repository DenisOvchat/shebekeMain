//
//  FriendsSwipe.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 29.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit
import RGPageViewController
class Controller: RGPageViewController, RGPageViewControllerDataSource, RGPageViewControllerDelegate {
    
    override var pagerOrientation: UIPageViewControllerNavigationOrientation {
        return .horizontal
    }
    
    override var tabbarPosition: RGTabbarPosition {
        return .top
    }
    override var tabMargin: CGFloat {
        return 30
    }
    override var tabbarStyle: RGTabbarStyle {
        return .blurred
    }
    
    override var tabIndicatorColor: UIColor {
        return UIColor(red: 0, green: 148, blue: 176, al: 1)
    }
    
    override var barTintColor: UIColor? {
        return self.navigationController?.navigationBar.barTintColor
    }
    
    override var tabStyle: RGTabStyle {
        return .inactiveFaded
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.currentTabIndex = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.currentTabIndex = 0
    }
    
    
    override func loadView() {
        
        super.loadView()
    
    }
    
    
    var tabTitles: NSArray = NSArray()
    var tabs:[UIViewController] = []
    override func viewDidLoad() {
        //self.navigationBar.frame = CGRect(x: 0, y: 0, width: navigationBar.frame.width , height: 88)
        super.viewDidLoad()
        self.title = "Друзья"
        //self.tabBar.backgroundColor = UIColor.white
        datasource = self
        delegate = self
        let stb = UIStoryboard(name: "Main", bundle: nil)
        
        let screenSize: CGRect = UIScreen.main.bounds

        
        let page_one = stb.instantiateViewController(withIdentifier: "fr1")
        let page_two = stb.instantiateViewController(withIdentifier: "fr2")
        
        page_one.title = "Все"
        page_two.title = "online"
        tabs.append(page_one)
        tabs.append(page_two)
        
        //barTintColor =
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: "addFriends:"), animated: true)
        
      /*  setViewControllerArray([page_one, page_two])
        setFirstViewController(0)
        equalSpaces = true
        UIColor(red: 195, green: 195, blue: 195, al: 1)
        UIColor(red: 0, green: 148, blue: 176, al: 1)
        
       // setButtons(UIFont.systemFont(ofSize: 14), color: UIColor(red: 195, green: 195, blue: 195, al: 1)
//)
        setButtonsOffset(-60, bottomOffset: 0)
        setButtonsWithSelectedColor(UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), color:         UIColor(red: 195, green: 195, blue: 195, al: 1)
            , selectedColor:         UIColor(red: 0, green: 148, blue: 176, al: 1))
        
        

        setSelectionBar(screenSize.width / 2 - 30, height: 3, color:  UIColor(red: 0, green: 148, blue: 176, al: 1))
        */
        


    }
   
    
    
    func numberOfPages(for pageViewController: RGPageViewController) -> Int {
        return 2
    }
    func pageViewController(_ pageViewController: RGPageViewController, tabViewForPageAt index: Int) -> UIView {
        let title: String = tabs[index].title!
        let label: UILabel = UILabel()
        
        label.text = title
        
        label.sizeToFit()
        
        return label
    }
    func pageViewController(_ pageViewController: RGPageViewController, viewControllerForPageAt index: Int) -> UIViewController? {
        return tabs[index]

    }
    func pageViewController(_ pageViewController: RGPageViewController, widthForTabAt index: Int) -> CGFloat {
       return UIScreen.main.bounds.width / 2 - 30
    }
    func pageViewController(_ pageViewController: RGPageViewController, heightForTabAt index: Int) -> CGFloat {
        return 30
    }
    @IBAction func addFriends(_ sender: AnyObject) {
        let stb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = stb.instantiateViewController(withIdentifier: "AddFriends")
        show(vc, sender: self)
        
    }
    
    
}

