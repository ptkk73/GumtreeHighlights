//
//  PassedTextViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 17/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class PassedTextViewController: UIViewController,
        UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imgPhotoPicker: UIImageView!
    @IBOutlet weak var lblPassedText: UITextView!

    var passedEditTextValue: String = ""
    
   let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        imagePicker.delegate = self
        
        lblPassedText.text = passedEditTextValue;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let takePhotoButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(showCamera))
        
        let pickPhotoButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showImagePicker))
    
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        setToolbarItems([ spacer, pickPhotoButton, spacer, takePhotoButton, spacer]
, animated: true)
        
    }
    
    @IBAction func goBack()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showImagePicker()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func showCamera()
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    /// IMAGE PICKER
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPhotoPicker.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        dismiss(animated: true, completion: nil)
    }
    
}
