//
//  OfferDetailGalleryViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 30/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit
import Nuke

class OfferDetailCell : UICollectionViewCell
{
    @IBOutlet weak var imgPhoto: UIImageView!
}

class OfferDetailGalleryViewController : UICollectionViewController
{
    var highlightModel: GumtreeHighlightModel? = nil
    var detailModel: GumtreeOfferModel? = nil
    
    let itemsPerRow = 1
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailModel?.images.count ?? 0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! OfferDetailCell
        
        if let model = detailModel
        {
            Nuke.loadImage(with: URL(string: model.images[indexPath.row])!, into: cell.imgPhoto)
        }
        
        return cell
        
    }
}


extension OfferDetailGalleryViewController : UICollectionViewDelegateFlowLayout {
    //1
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView!.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
