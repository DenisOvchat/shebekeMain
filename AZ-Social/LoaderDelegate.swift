//
//  LoaderDelegate.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 01.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
protocol LoaderDelegate:class {
   func didLoadEntitiesToTheEnd(Amount:UInt)

     func didLoadEntities(Amount:UInt)
     func didLoadEntitiesToTheStart(Amount:UInt)
     func didReloadEntities(indexes:[UInt])
     func didDeleteEntities(indexes:[UInt])
     func didAddEntities(indexes:[UInt])
    
}
extension LoaderDelegate{
    func didLoadEntitiesToTheEnd(Amount:UInt){}

    func didLoadEntities(Amount:UInt){}
    func didLoadEntitiesToTheStart(Amount:UInt){}
    func didReloadEntities(indexes:[UInt]){}
    func didDeleteEntities(indexes:[UInt]){}
    func didAddEntities(indexes:[UInt]){}

}
