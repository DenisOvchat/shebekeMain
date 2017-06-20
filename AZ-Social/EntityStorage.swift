//
//  EntityStorage.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 29.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
import UIKit

class EntitiesStorage
{
    
    private var entitiesArray:NSMutableArray
    
    private var loaders = [String:Loader]()
    var isLoadingNewElements:Bool = false
    
    var dispatchQeeue:DispatchQueue?
    init(entitiesArray:NSMutableArray)
    {
        self.entitiesArray = entitiesArray
    }
    func assignLoader(named:String,loader:Loader)->Bool
    {
        if(loaders[named] == nil){
            loader.assignArray(array: entitiesArray)
            loaders[named] = loader
            return true
        }
        else
        {
            return false
            print("Loader with this name already assigned")
        }
    }
    
    var count:Int
    {
        get
        {
            return entitiesArray.count
        }
    }
    
    
    
    func SwapElements()
    {
        
    }
    
    subscript(index: Int) -> Any?
    {
        get {
            
                return entitiesArray[index]
            
            
        }
     
    }
    
    func deleteElementsAt(indexes:[Int])
    {
        
    }
    
    
    
    
    
    
}
