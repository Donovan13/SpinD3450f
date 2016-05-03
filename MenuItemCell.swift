//
//  MenuItemCell.swift
//  Spinder
//
//  Created by Kyle on 5/1/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    @IBOutlet weak var menuItemImageView: UIImageView!
    
    func configureForMenuItem(menuItem: NSDictionary) {
        menuItemImageView.image = UIImage(named: menuItem["image"] as! String)
        backgroundColor = UIColor(colorArray: menuItem["colors"] as! NSArray)
    }
    
}
