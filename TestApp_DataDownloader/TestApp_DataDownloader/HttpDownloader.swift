//
//  HttpDownloader.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 18/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class HTTPDownloader
{
    public static func downloadHTML(url: String) -> String?
    {
        guard let myURL = URL(string: url) else {
            print("Error: \(url) doesn't seem to be a valid URL")
            return nil
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: String.Encoding.utf8)
            return myHTMLString
        } catch let error {
            print(error)
            return nil
        }
    }
}
