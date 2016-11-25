//
//  SinglePhotoFullScreenViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 23/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit
import Nuke

class SinglePhotoFullScreenViewController : UIViewController
{
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    var imageURLs: [String] = []
    var index: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = imageURLs.count
        pageControl.currentPage = index;
        
        let imgURL = imageURLs[index]
        if let url = URL(string: imgURL) {
            Nuke.loadImage(with: url, into: imgPhoto)
        }
    }
}
