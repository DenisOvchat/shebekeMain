//
//  containerViewForEditing.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 12.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit
class containerViewForEditing:UIView
{
    var number:Int = 0
    
    override func draw(_ rect: CGRect) {
        var currentTop:CGFloat = 0
        for i in 0..<number
        {
        
            if i != 0
            {
                
                var aPath = UIBezierPath()
                
                aPath.move(to: CGPoint(x:13, y:currentTop))
                
                aPath.addLine(to: CGPoint(x:frame.width - 30, y:currentTop))
                
                aPath.close()
                
                aPath.lineWidth = 0.5
                
                UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1).set()
                
                aPath.stroke()
                
                aPath.fill()
                
            }
            
        }
    }
    
    
    
}
