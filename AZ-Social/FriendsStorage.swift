//
//  FriendsStorage.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 08.06.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//
import UIKit
class FriendsStorage
{
    private var dictionary = NSDictionary()
    private var _alphabet = [String]()
    private var _counts = [Int]()
    var alphabet:[String]{
        get{
            return _alphabet
        }
    }
    var counts:[Int]{
        get{
            return _counts
        }
    }
    init()
    {
        
    }
    
    func set(with dictionary:NSDictionary)
    {
        self.dictionary = dictionary
        _alphabet  = [String]()
        _counts = [Int]()
        
        for p in dictionary
        {
            _alphabet.append(p.key as! String)
            
            if let arr = p.value as? NSArray
            {
                _counts.append(arr.count)
            }
            else
            {
                _counts.append(0)

            }
            
            
            
        }
        
    }
    subscript(row:Int,  section:Int ) -> Person?
    {
      
        if let arr = dictionary[_alphabet[section ]] as? NSArray
        {
            if arr.count > row && row >= 0
            {
                return Person(with: arr[row] as! NSDictionary)
            }
            else{
                return nil
            }
        }
        else{
            return nil
        }
    }
}
