//
//  StringUtility.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 18/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class StringUtility
{
    public static func trimString(text: String) -> String
    {
        return text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    public static func fromInBetween(text: String, lowerBoundString: String, upperBoundString: String) -> String?
    {
        let trimStartIndex = text.range(of: lowerBoundString)
        let trimEndIndex = text.range(of: upperBoundString)
        
        if let sIndex = trimStartIndex, let eIndex = trimEndIndex
        {
            return text.substring(with: Range(uncheckedBounds: (lower: sIndex.upperBound, upper: eIndex.lowerBound)))
        }
        return nil
    }
    
    public static func trimToEndOf(phrase: String, text: String) -> String
    {
        let trimStartIndex = text.range(of: phrase)
        if let startRange = trimStartIndex
        {
            return text.substring(from: startRange.upperBound)
        }
        return text
    }
    
    public static func trimFrom(phrase: String, text: String) -> String
    {
        let trimEndIndex = text.range(of: phrase)
        if let endRange = trimEndIndex
        {
            return text.substring(to: endRange.lowerBound)
        }
        return text;
    }
    
    
}
