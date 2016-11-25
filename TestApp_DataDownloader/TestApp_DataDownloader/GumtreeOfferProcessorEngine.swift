//
//  GumtreeOfferProcessorEngine.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 23/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class GumtreeOfferProcessorEngine
{
    let rawContent: String
    let url: String
    
    var offerModel = GumtreeOfferModel()
    
    init(htmlContent: String, url: String)
    {
        self.rawContent = htmlContent
        self.url = url
    
        parse(html: htmlContent)
    }
    
    private func trimUnnecessaryData(html: String) -> String
    {
        if let trimmed = StringUtility.fromInBetween(text: html, lowerBoundString: "class=\"vip-content-header\"", upperBoundString: "class=\"vip-seller-forms-container\"")
        {
            return trimmed.removeUnicodeChars()
        }
        return html
    }
    
    private func parseImagesData(html: String)
    {
        if let imagesDictionaryString = StringUtility.fromInBetween(text: html, lowerBoundString: "id=\"vip-gallery-data", upperBoundString: "]\",\"alt")
        {
            let largeDictionaryString = StringUtility.trimToEndOf(phrase: "\"large\":\"[", text: imagesDictionaryString)
            if largeDictionaryString.characters.count != imagesDictionaryString.characters.count
            {
                let largePhotosArray = largeDictionaryString.components(separatedBy: ", ")
                for item in largePhotosArray
                {
                    let processed = StringUtility.trimFrom(phrase: "?set_id", text: item)
                    if processed.hasSuffix("JPG") && processed.hasPrefix("https")
                    {

                        offerModel.images.append(processed)

                    }
                }
            }
        }
    }
    
    private func parse(html: String)
    {
        var htmlContent = trimUnnecessaryData(html: html)
        parseImagesData(html: html)
        
    }
}
