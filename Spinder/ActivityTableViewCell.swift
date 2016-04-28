//
//  ActivityTableViewCell.swift
//  TableViewPop
//
//  Created by Kyle on 4/26/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

class ActivityTableViewCell:UITableViewCell, ActivityTableViewTransform {
    let miniumScale:CGFloat = 0.9
;
    
    @IBOutlet weak var activityDescription: UITextView!
    @IBOutlet weak var nameAgeLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var scaleView: UIView!
    override func prepareForReuse() {
        super.prepareForReuse();
        self.scaleView.transform = CGAffineTransformMakeScale(self.miniumScale, self.miniumScale);
    }
    
    func transformCell(forScale scale: CGFloat) {
        self.scaleView.transform = CGAffineTransformMakeScale(1.0 - scale, 1.0 - scale);
    }
}