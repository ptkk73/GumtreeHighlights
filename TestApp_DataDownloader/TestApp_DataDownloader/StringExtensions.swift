//
//  StringExtensions.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 22/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

extension String
{
    func removeUnicodeChars() -> String
    {
        return replacingOccurrences(of: "&#43;", with: "+", options: .literal)
            .replacingOccurrences(of: "&#34;", with: "\"", options: .literal)
            .replacingOccurrences(of: "&#39;", with: "'", options: .literal)
        .replacingOccurrences(of: "&#61;", with: "=", options: .literal)
        .replacingOccurrences(of: "&gt;", with: ">", options: .literal)
        .replacingOccurrences(of: "&lt;", with: "<", options: .literal)
        .replacingOccurrences(of: "&amp;", with: "&", options: .literal)
    }
}
