//
//  MainViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 18/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class MainViewController : UIViewController
{
    let filterModel = GumtreeFilterData()
    
    var downloadURL: String = ""
    
    @IBOutlet weak var lblBuiltURL: UITextView!
    @IBOutlet weak var lblStatus: UITextView!
    
    @IBOutlet weak var progressDownload: UIActivityIndicatorView!
    @IBOutlet weak var btnDownloadData: UIButton!
    
    @IBOutlet weak var edtMinPrice: UITextField!
    @IBOutlet weak var edtMaxPrice: UITextField!
    
    override func viewDidLoad() {
        updateURL()
        
        edtMinPrice.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
        edtMaxPrice.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
        
        progressDownload.stopAnimating()
        progressDownload.isHidden = true;
    }
    
    func textChanged()
    {
        updateURL()
    }
    
    
    func onDownloadSuccessful(result : String)
    {
        lblStatus.text = "Download Successful"
        progressDownload.stopAnimating()
        progressDownload.isHidden = true;
        btnDownloadData.isEnabled = true;
        
        let gumtreeProcessingEngine = GumtreeHighlightProcessorEngine(htmlContent: result)
        
        let tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExampleTableViewController") as? ExampleTableViewController
        
        tableViewController?.highlightModels = gumtreeProcessingEngine.gumtreeHighlights
        tableViewController?.downloadURL = lblBuiltURL.text;
        navigationController?.pushViewController(tableViewController!, animated: true)
    }
    
    func onDownloadFailed()
    {
        lblStatus.text = "Download Failed"
        progressDownload.isHidden = true;
        btnDownloadData.isEnabled = true;
    }
    
    func onDownloadStarted()
    {
        progressDownload.startAnimating()
        progressDownload.isHidden = false;
        btnDownloadData.isEnabled = false;
        
    }
    
    
    
    @IBAction func inputMinPriceAction(_ sender: UITextField)
    {
        updateURL()
    }
    
    @IBAction func inputMaxPriceAction(_ sender: UITextField)
    {
        updateURL()
    }
    
    func updateURL()
    {
        filterModel.priceFrom = edtMinPrice.text
        filterModel.priceTo = edtMaxPrice.text
        downloadURL = GumtreeURLBuilder.build(filterData: filterModel)
        lblBuiltURL.text = downloadURL
    }
    
    @IBAction func onDownloadContent(_ sender: Any)
    {
        if let url = lblBuiltURL.text
        {
            onDownloadStarted()
            
            DispatchQueue.global().async
            {
                if let downloadedHTML = HTTPDownloader.downloadHTML(url: url)
                {
                    DispatchQueue.main.sync
                    {
                        self.onDownloadSuccessful(result: downloadedHTML)
                    }
                }
                else
                {
                    DispatchQueue.main.sync
                    {
                        self.onDownloadFailed()
                    }
                }
            }
            
        }
        
    }
}
