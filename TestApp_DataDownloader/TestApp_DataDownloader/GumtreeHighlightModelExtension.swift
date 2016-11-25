//
//  UIImageViewExtension.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 22/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

extension GumtreeHighlightModel {
    func downloadedFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                        self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url)
    }
}
