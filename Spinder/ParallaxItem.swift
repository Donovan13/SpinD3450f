//
//  ParallaxItem.swift
//  SpinderFB
//
//  Created by Kyle on 4/25/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

class ParallaxItem: NSObject {

    var image: UIImage!
    var text: String!
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    
}
