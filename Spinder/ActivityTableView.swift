//
//  ActivityTableView.swift
//  TableViewPop
//
//  Created by Kyle on 4/26/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

@objc protocol ActivityTableViewTransform {
    var miniumScale:CGFloat {get};
    func transformCell(forScale scale:CGFloat);
}

class ActivityTableView:UITableView {
    override func layoutSubviews() {
        super.layoutSubviews();
        self.transform();
    }
    
    private func transform()->Void {
        
        for indexPath in self.indexPathsForVisibleRows! as [NSIndexPath] {
            if let cell = self.cellForRowAtIndexPath(indexPath) as? ActivityTableViewTransform {
                let distanceFromCenter = self.computeDistanceFromCenter(indexPath);
                cell.transformCell(forScale: self.computeScale(distanceFromCenter, minScale: cell.miniumScale));
            }
        }
    }
    
    private func computeDistanceFromCenter(indexPath:NSIndexPath) -> CGFloat {
        let cellRect = self.rectForRowAtIndexPath(indexPath);
        let cellCenter = cellRect.origin.y + cellRect.size.height/2;
        let contentCenter = self.contentOffset.y + self.bounds.size.height/2;
        
        return fabs(cellCenter - contentCenter);
    }
    
    private func computeScale(distanceFromCenter:CGFloat, minScale:CGFloat)->CGFloat {
        return  (1.0 - minScale) * distanceFromCenter / self.bounds.size.height;
    }
}