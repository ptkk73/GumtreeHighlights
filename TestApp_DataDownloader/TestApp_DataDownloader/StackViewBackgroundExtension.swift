//
//  StackViewBackgroundExtension.swift
//  TestApp_DataDownloader
//
//  Created by Piotr Kożuch on 29/11/2016.
//  Copyright © 2016 Piotr Kożuch. All rights reserved.
//

import UIKit
class StackViewWithBackground: UIStackView {
    private var color: UIColor?
    override var backgroundColor: UIColor? {
        get { return color }
        set { color = newValue }
    }
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }
}
