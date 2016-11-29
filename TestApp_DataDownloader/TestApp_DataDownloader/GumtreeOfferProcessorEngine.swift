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
        if let trimmed = StringUtility.fromInBetween(text: html, lowerBoundString: "class=\"vip-content-header\"", upperBoundString: "<div class=\"vip-seller-forms-container\"")
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
    
    private(set) public var ESTIMATED_PRICE_REGEX = "\\n[^\\n]*[\\d]+.?(zł|zl|pln|PLN|\\+)[^\\n]*\\n"
    private(set) public var ESTIMATED_PRICE_REGEX2 = "(\\n|\\.\\s|\\d+)[^\\n\\.]*(czynsz|[\\d]+.?(zł|zl|pln|PLN|\\+))[^\\n]*(\\n|\\.\\s)"
    private func extractEstimatedPriceFromDescription(description: String) -> String?
    {
        let matches = StringUtility.getRegexMatches(pattern: ESTIMATED_PRICE_REGEX2, text: description)
        if matches.count > 0
        {
            return (matches.filter
            {
                !$0.lowercased().contains("price") && !$0.lowercased().contains("fees")
            }).reduce("")
            {
                return "\(StringUtility.trimString(text: $0)) \(StringUtility.trimString(text: $1))"
            }
        }
        else
            {return nil}
    }
    
    private func parseDescription(html: String)
    {
        if let descriptionText = StringUtility.removeHTMLTags(html: html, convertLineBreaksToNewLines: true)
        {
            let description = StringUtility.trimString(text: descriptionText)
            offerModel.description = description
            offerModel.estimatedPriceString = extractEstimatedPriceFromDescription(description: description)
        }
    }
    
    private func parse(html: String)
    {
        var htmlContent = trimUnnecessaryData(html: html)
        parseImagesData(html: htmlContent)
        
        
        htmlContent = StringUtility.trimToEndOf(phrase: "<div class=\"description\" >", text: htmlContent)
        
        
        
        parseDescription(html: htmlContent)

        
    }
}
