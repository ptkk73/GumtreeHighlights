//
//  FilterFlyoutViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 29/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class FilterFlyoutViewController : UIViewController
{
    
    @IBOutlet weak var btnApplyFilter: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var filterData: GumtreeFilterData? = nil
    
    @IBOutlet weak var edtSearchPhrase: UITextField!
    @IBOutlet weak var edtMinPrice: UITextField!
    @IBOutlet weak var edtMaxPrice: UITextField!
    
    var onRefreshAction: ((GumtreeFilterData) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let filterModel = GumtreeFilterData.loadData()?.first
        {
            edtMinPrice.text = filterModel.priceFrom
            edtMaxPrice.text = filterModel.priceTo
            edtSearchPhrase.text = filterModel.text
            filterData = filterModel
        }
        else
        {
            filterData = GumtreeFilterData()
        }
        
        edtMinPrice.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
        edtMaxPrice.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
        edtSearchPhrase.addTarget(self, action: #selector(textChanged), for: UIControlEvents.editingChanged)
    }
    
    func textChanged()
    {
        filterData?.priceFrom = edtMinPrice.text
        filterData?.priceTo = edtMaxPrice.text
        filterData?.text = edtSearchPhrase.text
    }
    
    
    @IBAction func submitFilter(_ sender: UIButton)
    {
        let _ = GumtreeFilterData.saveData(filters: [filterData!])
        
        if let refreshAction = self.onRefreshAction
            {refreshAction(filterData!)}
        
        dismissFilter(sender)
        
    }
    
    @IBAction func dismissFilter(_ sender: UIButton)
    {
        dismiss(animated: true)
    }
}

