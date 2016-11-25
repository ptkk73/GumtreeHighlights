//
//  GumtreeProcessorEngine.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 18/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class GumtreeHighlightProcessorEngine
{

    
    var rawContent: String
    var gumtreeHighlights : [GumtreeHighlightModel] = []
    
    init(htmlContent: String)
    {
        rawContent = htmlContent
        parseHTMLContent(data: rawContent)
    }
    
    private func trimUnnecessaryData(html: String) -> String
    {
        if let trimmed = StringUtility.fromInBetween(text: html, lowerBoundString: "<div class=\"view\">", upperBoundString: "<div class=\"rtemp-cont")
        {
            return trimmed.removeUnicodeChars()
        }
        return html
    }
    
    private func splitItems(html: String) -> [String]
    {
        var array = html.components(separatedBy: "<li class=\"result")
        array.remove(at: 0)
        return array
    }
    
    private func parseImageURL(html: String) -> String
    {
        
        let parsedImg = StringUtility.fromInBetween(text: html, lowerBoundString: "<img src=\"", upperBoundString: "\" alt")
        if let parsed = parsedImg
        {
            let processed = StringUtility.trimToEndOf(phrase: "data-src=\"", text: parsed)
            if processed.hasSuffix("JPG") == false
            {
                return StringUtility.trimFrom(phrase: "?set_id", text: processed)
            }
            return processed
        }
        
        return ""
    }
    
    private func parsePhotosCount(html: String, model: GumtreeHighlightModel)
    {
        if let photoString = StringUtility.fromInBetween(text: html, lowerBoundString: "pht-cnt\">", upperBoundString: "</div>")
        {
            if let lastComponent = photoString.components(separatedBy: " ").last
            {
                model.photosCount = Int(lastComponent)
            }
        }
    }
    
    private func parseTitleAndURL(html: String, model: GumtreeHighlightModel)
    {
        if let excerpt = StringUtility.fromInBetween(text: html, lowerBoundString: "href=\"", upperBoundString: "</a>")
        {
            model.articleURL = GumtreeConfig.GUMTREE_URL + StringUtility.trimFrom(phrase: "\">", text: excerpt)
            model.title = StringUtility.trimToEndOf(phrase: "\">", text: excerpt)
        }
    }
    
    private func parseDescription(html: String, model: GumtreeHighlightModel)
    {
        if let excerpt = StringUtility.fromInBetween(text: html, lowerBoundString: "class=\"description", upperBoundString: "class=\"info\"")
        {
            if let desc = StringUtility.fromInBetween(text: excerpt, lowerBoundString: ">", upperBoundString: "</div>")
            {
                model.description = StringUtility.trimString(text: desc)
            }
        }
    }
    
    private func parsePrice(html: String, model: GumtreeHighlightModel)
    {
        if let excerpt = StringUtility.fromInBetween(text: html, lowerBoundString: ">", upperBoundString: "</")
        {
            model.price = excerpt
        }
    }
    
    private func parseTime(html: String, model: GumtreeHighlightModel)
    {
        if let excerpt = StringUtility.fromInBetween(text: html, lowerBoundString: "<span>", upperBoundString: "</span>")
        {
            model.timeString = excerpt
        }
    }
    
    private func buildHighlightModel(itemHtml: String) -> GumtreeHighlightModel
    {
        let highlightModel = GumtreeHighlightModel();
        highlightModel.id = StringUtility.fromInBetween(text: itemHtml, lowerBoundString: "data-criteoadid=\"", upperBoundString: "\">")
        
        highlightModel.imgURL = parseImageURL(html: itemHtml)
        
        var html = StringUtility.trimToEndOf(phrase:"\" alt", text: itemHtml)
        
        parsePhotosCount(html: html, model: highlightModel)
        
        html = StringUtility.trimToEndOf(phrase:"</div>", text: html)
        
        parseTitleAndURL(html: html, model: highlightModel)
        
        html = StringUtility.trimToEndOf(phrase:"</a>", text: html)
        
        parseDescription(html: html, model: highlightModel)
        
        if ( html.contains("class=\"amount\"") )
        {
            html = StringUtility.trimToEndOf(phrase:"class=\"amount\"", text: html)
        
            parsePrice(html: html, model: highlightModel)
        }
        
        html = StringUtility.trimToEndOf(phrase:"icon-calendar\"></span>", text: html)
        
        parseTime(html: html, model: highlightModel)
        
        
        return highlightModel
    }
    
    private func parseHTMLContent(data: String)
    {
        let trimmedHtml = trimUnnecessaryData(html: data)
        let thumbItems = splitItems(html: trimmedHtml)
        
        print(thumbItems)
        
        for item in thumbItems
        {
            gumtreeHighlights.append(buildHighlightModel(itemHtml: item))
        }
    }
}
