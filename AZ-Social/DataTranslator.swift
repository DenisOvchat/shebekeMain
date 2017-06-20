//
//  DataTranslator.swift
//  AZ-Social
//
//  Created by  Denis Ovchar on 29.04.17.
//  Copyright © 2017  Denis Ovchar. All rights reserved.
//

import Foundation
class DataTranslator
{
    static func JSONDataToDictionary(data:Data)-> [String:Any]?
    {
        do {
            
            let parsedData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            return parsedData
        } catch let error as NSError {
            print(error)
            
            return nil
            
        }
    }
}
