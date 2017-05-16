//
//  GumtreeOferDetailsViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 01/12/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class GumtreeOfferDetailsViewController : UIViewController
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    
    var highlightModel: GumtreeHighlightModel? = nil
    var detailsModel: GumtreeOfferModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.text = highlightModel?.title
        tvDescription.text = detailsModel?.description
        
    }
}
