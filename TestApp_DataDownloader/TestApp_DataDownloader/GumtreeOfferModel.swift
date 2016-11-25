//
//  GumtreeOfferModel.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 23/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import Foundation

class GumtreeOfferModel
{
    var description: String? = nil
    var title: String? = nil
    var phoneNumber: String? = nil
    var price: String? = nil
    var images: [String] = []
    
    // Calculated
    var estimatedPriceString: String? = nil
    
}
