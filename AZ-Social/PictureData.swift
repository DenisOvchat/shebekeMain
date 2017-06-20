//
//  PictureData.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 26.05.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import UIKit

class PictureFromNetInfo
{
    internal var _URLstring:String!
    internal var _size:CGSize!
    var size:CGSize {return _size}
    var URLstring:String!
    {return _URLstring}
    
    init(URLstring:String, size:CGSize) {
        self._size = size
        self._URLstring = URLstring
    }
}
