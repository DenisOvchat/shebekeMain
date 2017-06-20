//
//  CustSegue.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 22.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import  UIKit
class CustSegue:UIStoryboardSegue
{
    
 
    override func perform() {
        // Assign the source and destination views to local variables.
        
        self.source.show(self.destination, sender: nil)
        
        var firstVCView = self.source.view as UIView!
        var secondVCView = self.destination.view as UIView!
        
        // Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Specify the initial position of the destination view.
        //secondVCView?.frame = CGRect(x:0.0, y:screenHeight, width:screenWidth, height:screenHeight)
        
        // Access the app's key window and insert the destination view above the current (source) one.
       // let window = UIApplication.shared.keyWindow
        //window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: -screenWidth, dy: 0))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: -screenWidth, dy: 0))!
            
        }) { (Finished) -> Void in
            
            
            //present(self.destination as UIViewController,
                            //                                animated: false,
            
            //
           // completion: nil)
            //super.perform()
            
        }
        
    }
}
