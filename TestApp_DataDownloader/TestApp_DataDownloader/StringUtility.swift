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
    
    public static func getRegexMatches(pattern: String, text: String) -> [String]
    {
        if let regex = try? NSRegularExpression(pattern: pattern,
                                                options: [])
        {
            let nsText = (text as NSString)
            let range = NSMakeRange(0, text.utf16.count)
            return regex.matches(in: text, options: [], range: range).map
            {
                nsText.substring(with: $0.range)
            }
        }
        return []
    }
    
    public static func replaceRegex(pattern: String, replaceString: String, text: String) -> String?
    {
        if let regex = try? NSRegularExpression(pattern: pattern,
                                                options: [])
        {
            
            let range = NSMakeRange(0, text.utf16.count)
            let modString = regex.stringByReplacingMatches(in: text,
                                                           options: [],
                                                           range: range,
                                                           withTemplate: replaceString)
            return modString
        }
        else
        {
            return nil
        }
    }
    
    
    public static func removeHTMLTags(html: String, convertLineBreaksToNewLines: Bool = false) -> String?
    {
        var htmlToProcess = html
        if convertLineBreaksToNewLines
        {
            if let modifiedHTML = replaceRegex(pattern: "<[^>]*(br|p)[^>]*>", replaceString: "\r\n", text: html)
                {htmlToProcess = modifiedHTML}
        }
        
        return replaceRegex(pattern: "<[^>]+>", replaceString: "", text: htmlToProcess)
    }
    
    
}
