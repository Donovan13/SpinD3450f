//
//  ActivityViewController.swift
//  Spinder
//
//  Created by Mingu Chu on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var activity = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity = ["Basketball", "Soccer", "VolleyBall", "BaseBall", "Fitness"]
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath)
        cell.textLabel?.text = activity[indexPath.row]
        return cell
    }
    
}
