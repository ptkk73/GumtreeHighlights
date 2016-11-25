//
//  CellSelectableTextView.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 23/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit

class CellSelectableTextView : UITextView
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        if let t = touches
        {
            self.superview?.touchesCancelled(t, with: event)
        }
    }
}
