//
//  Extensions.swift
//  Spinder
//
//  Created by Kyle on 5/1/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(colorArray array: NSArray) {
        let r = array[0] as! CGFloat
        let g = array[1] as! CGFloat
        let b = array[2] as! CGFloat
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha:1.0)
    }
}
