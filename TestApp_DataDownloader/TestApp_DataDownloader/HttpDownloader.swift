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
    
    public static func makePOSTRequest(url: String, paramsDictionary: [String: String])
    {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        var postString = paramsDictionary.reduce("")
        {
            name, value in "\(name)=\(value)&"
        }

        postString = postString.substring(to: postString.index(before: postString.endIndex))
        
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            return
        }
        task.resume()
    }
}
