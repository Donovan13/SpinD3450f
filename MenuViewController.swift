//
//  MenuViewController.swift
//  Spinder
//
//  Created by Kyle on 5/1/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    lazy var menuItems: NSArray = {
        let path = NSBundle.mainBundle().pathForResource("MenuItems", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Remove the drop shadow from the navigation bar
        navigationController!.navigationBar.clipsToBounds = true
        
        (navigationController!.parentViewController as! ContainerViewController).menuItem = (menuItems[0] as! NSDictionary)
    }
    
    //  UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        (navigationController!.parentViewController as! ContainerViewController).menuItem = menuItem
        print(indexPath.row)
        
    }
    
    //  Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return max(80, CGRectGetHeight(view.bounds) / CGFloat(menuItems.count))
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell") as! MenuItemCell
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        cell.configureForMenuItem(menuItem)
        return cell
    }
    
}
