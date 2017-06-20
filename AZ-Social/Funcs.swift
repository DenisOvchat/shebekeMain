//
//  Funcs.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 08.03.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit

class ProgramData
{
        //  var termsP:UnsafeMutablePointer < [String:[Term]] >
    // var alphabetP:UnsafeMutablePointer < [String] >
   // var publications=[Publication]()
    //var changes = [[[valChange]]]()
    //var MaxsAndMins = [[[String:CGFloat]]]()
    var settings=Settings()
    //var iap = IAP()
    var myProfile:FullProfile?
    
    init()
    {
        /*myProfile = FullProfile(mine: true, name: "Илон", secondName: "Маск", pictUrl: "http://rutesla.com/wp-content/uploads/2014/03/ilon-mask.jpg", isOnline: true, id: 0)
        myProfile.BirhDay = Date(timeIntervalSince1970: 100000)
        myProfile.WhereFrom = "Москва"
        myProfile.topImageUrl =   "https://www.votpusk.ru/story/edit/foto/large/31418.jpg"*/
        //termsP = UnsafePointer < [String:[Term]] >(&terms)
        //alphabetP = UnsafePointer < [String] >(&alphabet)
    }
}
class Settings
{
    
}

class Ss
{
    let screenSize: CGRect = UIScreen.main.bounds
    
    static var X:CGFloat=1.0
    static var Y:CGFloat=1.0
    static var cellHeightMul:CGFloat=0.0
    static var Yy:CGFloat=0.0
    static var topBarHeights:CGFloat=0.0
    static var statusBar:CGFloat=0.0
    static var rowHeight:CGFloat=0.0
    static var defaultInset:CGFloat=0.0
    static var MenuInset:CGFloat=44
    static var BannerHeight:CGFloat=0.0
    
    // static var font:UIFont
    init()
    {
        let screenSize: CGRect = UIScreen.main.bounds
        
    }
    //static let newspictsize:CGSize=
}
class menus
{
    static let Settings1 = [["1"],["2","3","4","5"],["6"]]
    static let Privatnost = ["1","2","3","4","5","6","7","8","9","10","11"]
    //static let
}
func matches(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range)}
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, al: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: al)
    }
    
    convenience init(netHex:Int, alpha:CGFloat=1.0) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, al: alpha)
    }
}
extension UILabel {
    func prepareAndResizeLabel( _ origin:CGPoint,vertically:Bool, knownDimension:CGFloat,text: String, theFont:UIFont) -> CGFloat
    {
        var constraintSize=CGSize()
        var frame=CGRect()
        var unknownDim:CGFloat!
        if(vertically)
        {
            constraintSize = CGSize(width: knownDimension, height: CGFloat.greatestFiniteMagnitude)
            frame=text.boundingRect(with: constraintSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: theFont], context: nil)
            unknownDim = frame.height
            
        }
        else
        {
            constraintSize = CGSize(width: CGFloat.greatestFiniteMagnitude,height: knownDimension)
            frame=text.boundingRect(with: constraintSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: theFont], context: nil)
            unknownDim = frame.width
            
        }
        self.lineBreakMode = .byWordWrapping
        self.frame=CGRect(origin: origin, size: frame.size)
        self.text=text
        self.numberOfLines=0
        
        self.font=theFont
        return unknownDim
        
    }
    func getSizeForLabel( knownDimension:CGFloat,text: String, theFont:UIFont) -> CGFloat
    {
        var constraintSize=CGSize()
        var frame=CGRect()
        var unknownDim:CGFloat!
        
        constraintSize = CGSize(width: knownDimension, height: CGFloat.greatestFiniteMagnitude)
        frame=text.boundingRect(with: constraintSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: theFont], context: nil)
        unknownDim = frame.height
        
        
        
        self.text=text
        
        return unknownDim
        
    }
    
}

class dialogues
{
    var array = [dialogBody]()
    var dictionary = [Int:dialogBody]()

    func add(friend:dialogBody,forKey:Int)
    {
        array.append(friend)
        dictionary[forKey] = friend
    }
    func remove(forKey:Int)
    {
        array.remove(at: array.index{$0 === dictionary[forKey]}!)
        
        dictionary[forKey] = nil
    }
    
    
}
extension IndexPath{
    static func setOfIndexPaths(startRow:UInt,count:UInt,in section:UInt) -> [IndexPath]
    {
        var paths = [IndexPath]()
        for i in startRow..<startRow + count
        {
            paths.append(IndexPath(row: Int(i), section: Int(section)))
        }
        return paths
    }
    static func setOfIndexPaths(startSection:UInt,count:UInt,row:UInt) -> [IndexPath]
    {
        var paths = [IndexPath]()
        for i in startSection..<startSection + count
        {
            paths.append(IndexPath(row: Int(row), section: Int(i)))
        }
        return paths
    }
}

