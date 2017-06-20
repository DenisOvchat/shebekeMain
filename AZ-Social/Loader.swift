//
//  Loader.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 01.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
class Loader {
    var array:NSMutableArray!
  //  :[Entity]!
    var delegate:LoaderDelegate!
    private var name:String
    var queue:DispatchQueue?
    init(named:String,qos:DispatchQoS) {
        name = named
        queue = DispatchQueue(label: named, qos: qos)
    }
    func assignArray(array:NSMutableArray)
    {
        self.array = array
    }
    func assignQueue(queue:DispatchQueue)
    {
        self.queue = queue
    }
    
    
}
