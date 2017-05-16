//
//  UITabBarController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 30/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class OfferDetailsPageViewController : UITabBarController
{
    var highlightModel: GumtreeHighlightModel? = nil
    var detailsModel: GumtreeOfferModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabViewControllers = viewControllers
        {
            for item in tabViewControllers
            {
                if let galleryViewController = item as? OfferDetailGalleryViewController
                {
                    galleryViewController.highlightModel = highlightModel
                    galleryViewController.detailModel = detailsModel
                    
                    if let imagesCount = detailsModel?.images.count
                    {
                        galleryViewController.tabBarItem!.badgeValue = "\(imagesCount)"
                    }
                    
                    print("Gallery found")
                }
                else
                {
                    if let detailsViewController = item as? GumtreeOfferDetailsViewController
                    {
                        detailsViewController.highlightModel = highlightModel
                        detailsViewController.detailsModel = detailsModel
                    }
                }
            }
        }
    }
    
    
}
