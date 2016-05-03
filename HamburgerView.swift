//
//  HamburgerView.swift
//  Spinder
//
//  Created by Kyle on 5/1/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

class HamburgerView: UIView {
    
    let imageView: UIImageView! = UIImageView(image: UIImage(named: "Hamburger"))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // RotatingView
    
    func rotate(fraction: CGFloat) {
        let angle = Double(fraction) * M_PI_2
        imageView.transform = CGAffineTransformMakeRotation(CGFloat(angle))
    }
        
    private func configure() {
        imageView.contentMode = UIViewContentMode.Center
        addSubview(imageView)
    }
    
}
