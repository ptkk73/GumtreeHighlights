//
//  FilterPropertiesLayout.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 28/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation



class FilterPropertiesModel : NSObject, NSCoding
{
    struct PropertyKeys
    {
        static let minPrice = "minPrice"
        static let maxPrice = "maxPrice"
        static let phrase = "phrase"
    }
    
 
    // MARK: NSCoding
 
    public func encode(with aCoder: NSCoder)
    {
        
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        
    }
}
