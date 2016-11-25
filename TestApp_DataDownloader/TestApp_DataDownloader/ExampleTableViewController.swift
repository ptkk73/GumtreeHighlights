//
//  ExampleTableViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 22/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//
import Nuke
import UIKit

class ExampleCell : UITableViewCell
{
    
    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var lblPhotoCount: UITextView!

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var lblPrice: UITextView!
    @IBOutlet weak var lblTime: UITextView!
    
    @IBOutlet weak var numberStackView: UIStackView!
    
}

class ExampleTableViewController: UITableViewController, IHTMLDownloader{

    var downloadURL: String? = nil
    var highlightModels: [GumtreeHighlightModel] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightButton = UIBarButtonItem(title: "Filtry", style: .plain, target: self, action: #selector(onFiltersClicked))
        navigationItem.rightBarButtonItems = [ rightButton ]
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControlEvents.valueChanged)
    }

    func showCancellableMessage()
    {
        let alert = UIAlertController(title: "My Alert",
        message: "This is an alert.",
        preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertActionStyle.cancel,
                                      handler:
            {(alert: UIAlertAction!) in self.dismiss(animated: true, completion: nil)}))
        
        
        present(alert, animated: true)
        
    }
    
    func onFiltersClicked()
    {
        let myViewController = storyboard?.instantiateViewController(withIdentifier: "FiltersViewController")
//        myModalViewController?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//        myModalViewController?.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        navigationController?.pushViewController(myViewController!, animated: true)
    }
    
    func onDownloadStarted()
    {
        
        
    }
    
    func onDownloadSuccessful(result: String?)
    {
        if let data = result
        {
            self.highlightModels = GumtreeHighlightProcessorEngine(htmlContent: data).gumtreeHighlights
            self.tableView.reloadData()
        }
        
        self.refreshControl?.endRefreshing()
        print("Download successful")
    }
    
    func onDownloadFailed()
    {
        
        self.refreshControl?.endRefreshing()
        print("Download failed")
    }
    
    func refreshTable()
    {
        onDownloadStarted()
        
        DispatchQueue.global().async
        {
            if let _ = self.downloadURL, let downloadResult = HTTPDownloader.downloadHTML(url: self.downloadURL!)
            {
                DispatchQueue.main.sync
                {
                    self.onDownloadSuccessful(result: downloadResult)
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
    
    func refresh(sender:AnyObject)
    {
        refreshTable()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigateToWebsite(url: URL)
    {
        UIApplication.shared.open(url, options: [:])
        {
            success in
            print("Opened \(success)")
        }
    }
    

    
    
    func onClicked(row: Int)
    {
        let currentModel = highlightModels[row]
        if let _ = currentModel.articleURL, let url = URL(string: currentModel.articleURL!)
        {
            navigateToWebsite(url: url)
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onClicked(row: indexPath.row)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highlightModels.count
    }

    @IBAction func phoneClicked(sender: AnyObject)
    {
        if let rowInfo = sender.view?.tag
        {
            print("phone clicked \(rowInfo)")
        }
    }
    
    @IBAction func imageClicked(sender: AnyObject)
    {
        if let rowInfo = sender.view?.tag
        {
            let model = highlightModels[rowInfo]
            
            let photosViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImagePreviewController") as? HighlightImagePreviewController
            
            if let url = model.articleURL
            {
                if let result = HTTPDownloader.downloadHTML(url: url)
                {
                    let gumtreeOffer = GumtreeOfferProcessorEngine(htmlContent: result, url: url)
            
                    photosViewController?.imgUrlArray = gumtreeOffer.offerModel.images
                    navigationController?.pushViewController(photosViewController!, animated: true)
                }
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! ExampleCell
        
        cell.numberStackView.tag = indexPath.row
        cell.numberStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(phoneClicked)))
        
        cell.imgThumb.isUserInteractionEnabled = true
        cell.imgThumb.tag = indexPath.row
        cell.imgThumb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageClicked)))
        
        let currentModel = highlightModels[indexPath.row]
        
        // default to no photo image
        cell.imgThumb.image = UIImage(named: "nophoto")
        
        if let _ = currentModel.imgURL, let url = URL(string: currentModel.imgURL!)
        {
            print("imgPath \(url)")
            Nuke.loadImage(with: url, into: cell.imgThumb)
        }
        else
        {
            print("imgPath NOT FOUND \(currentModel.imgURL)")
        }

        
        cell.lblTitle.text = currentModel.title
        
        cell.lblDescription.text = currentModel.description
        if let pCount = currentModel.photosCount
        {
            cell.lblPhotoCount.text = String(pCount)
        }
        else
        {
            cell.lblPhotoCount.text = "---"
        }
        
        if let price = currentModel.price
        {
            cell.lblPrice.text = price
        }
        else
        {
            cell.lblPrice.text = "To negotiate"
        }
        
        if let time = currentModel.timeString
        {
            cell.lblTime.text = time
        }
        else
        {
            cell.lblTime.text = "---"
        }

        return cell
    }
 

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return "Najnowsze"
        default:
            return ""
        }
    }
    
}
