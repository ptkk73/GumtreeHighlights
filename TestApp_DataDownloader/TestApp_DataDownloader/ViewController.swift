//
//  ViewController.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 16/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblHeader: UITextView!
    @IBOutlet weak var edtText: UITextField!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var btnGoToTableView: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtText.delegate = self
        
        let rightButton = UIBarButtonItem(title: "Go Back", style: .plain, target: self, action: #selector(doNothing))
        let rightButton2 = UIBarButtonItem(title: "Go", style: .plain, target: self, action: #selector(doNothing))
        navigationItem.rightBarButtonItems = [ rightButton, rightButton2 ]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("DID END \(textField.text)")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("AFTER \(textField.text)")
        return true
    }

    @IBAction func goToAnotherPage(_ sender: UIButton) {
        
        if edtText.text != nil
        {
            let passedTextViewController = self.storyboard?.instantiateViewController(withIdentifier: "PassedTextViewController") as? PassedTextViewController
            passedTextViewController?.passedEditTextValue = edtText.text!
            navigationController?.pushViewController(passedTextViewController!, animated: true)
            
        }
        
    }
    
    @IBAction func scaleTextPinchGesture(_ sender: UIPinchGestureRecognizer) {
        lblDescription.font = UIFont(name: (lblDescription.font?.fontName)!, size: sender.scale + 5.0)
    }
    
    @IBAction func doNothing()
    {
        
    }
}

