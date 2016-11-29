//
//  GumtreeFilterData.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 24/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class GumtreeFilterData : NSObject, NSCoding
{
    static let DATAFILE_NAME = "gumtreeFilters"
    
    var priceFrom: String? = nil
    var priceTo: String? = nil
    var text: String? = nil

    struct PropertyKeys
    {
        static let priceFrom = "priceFrom"
        static let priceTo = "priceTo"
        static let text = "text"
    }
    
    public override init()
    {
        
    }
    
    // MARK: NSCoding
    
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(priceFrom, forKey: PropertyKeys.priceFrom)
        aCoder.encode(priceTo, forKey: PropertyKeys.priceTo)
        aCoder.encode(text, forKey: PropertyKeys.text)
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        priceFrom = aDecoder.decodeObject(forKey: PropertyKeys.priceFrom) as? String
        priceTo = aDecoder.decodeObject(forKey: PropertyKeys.priceTo) as? String
        text = aDecoder.decodeObject(forKey: PropertyKeys.text) as? String
    }
    
    static func saveData(filters: [GumtreeFilterData]) -> Bool
    {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(filters, toFile: GumtreeFilterData.ArchiveURL.path)
        if !isSuccessfulSave {
            print("Failed to save data for \(DATAFILE_NAME)...")
        }
        return isSuccessfulSave
    }
    
    static func loadData() -> [GumtreeFilterData]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: GumtreeFilterData.ArchiveURL.path) as? [GumtreeFilterData]
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent(DATAFILE_NAME)
}
