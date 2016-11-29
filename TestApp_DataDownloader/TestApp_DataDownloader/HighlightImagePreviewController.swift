//
//  HighlightImagePreviewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 23/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class HighlightImagePreviewController : UIPageViewController
{
    var imgUrlArray: [String] = []
    
    var photoViews: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        photoViews = []
        var index = 0
        for _ in imgUrlArray
        {
            photoViews.append(self.newPhotoViewController(imageURLs: imgUrlArray, index: index))
            index += 1
        }
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        if let firstViewController = photoViews.first {

            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
         }
        
        
    }
    
   
    private func newPhotoViewController(imageURLs: [String], index: Int) -> UIViewController {
        let photoView = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "HighlightPhotosViewController") as! SinglePhotoFullScreenViewController
        photoView.imageURLs = imageURLs
        photoView.index = index
        return photoView
    }
}



extension HighlightImagePreviewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = photoViews.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard photoViews.count > previousIndex else {
            return nil
        }
        
        return photoViews[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = photoViews.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = photoViews.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return photoViews[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        print("count")
        return photoViews.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        print("index")
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = photoViews.index(of: firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
