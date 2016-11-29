//
//  GumtreeURLBuilder.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 24/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class GumtreeURLBuilder
{
    static let categoryPart = "s-mieszkania-i-domy-do-wynajecia"
    static let cityPart = "krakow"
    static let someWeirdStringPart = "v1c9008l3200208p1"
    
    static func build(filterData: GumtreeFilterData) -> String
    {
        var url = GumtreeConfig.GUMTREE_URL + "/"
        + categoryPart + "/"
        + cityPart + "/"
            + buildSearchPhrase(text: filterData.text ?? "")
        + someWeirdStringPart
        
        url += "?pr=\(filterData.priceFrom ?? ""),\(filterData.priceTo ?? "")"
        
        return url
    }
    
    static func buildSearchPhrase(text: String) -> String
    {
        if text.characters.count > 0, let escapedWhitespace = StringUtility.replaceRegex(pattern: "\\s", replaceString: "+", text: text)
        {
            return escapedWhitespace + "/"
        }
        return ""
    }
}
