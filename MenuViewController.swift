//
//  MenuViewController.swift
//  Spinder
//
//  Created by Kyle on 5/1/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit




class MenuViewController: UITableViewController {
    var filterSelected: String!
    
    
    var filterDelegate: FilterDelegate?
    
    lazy var menuItems: NSArray = {
        let path = NSBundle.mainBundle().pathForResource("MenuItems", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    }()
    
    var containerViewController: ContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove the drop shadow from the navigation bar
        //        navigationController!.navigationBar.clipsToBounds = true
        
        (navigationController!.parentViewController as! ContainerViewController).menuItem = (menuItems[0] as! NSDictionary)
        for childVC in (navigationController?.parentViewController?.childViewControllers)! {
            for granchildVC in childVC.childViewControllers {
                if granchildVC is ActivityViewController {
                    self.filterDelegate = (granchildVC as! ActivityViewController)
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        print("yo")
    }
    
    //  UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        (navigationController!.parentViewController as! ContainerViewController).menuItem = menuItem
        //        print(indexPath.row)
        
        
        if "\(indexPath.row)" == "0" {
            filterSelected = "Baseball"
            print("\(filterSelected)")
        } else if "\(indexPath.row)" == "1" {
            filterSelected = "Basketball"
        } else if "\(indexPath.row)" == "2" {
            filterSelected = "Bike Ride"
        } else if "\(indexPath.row)" == "3" {
            filterSelected = "Bowling"
        } else if "\(indexPath.row)" == "4" {
            filterSelected = "Fighting"
        } else if "\(indexPath.row)" == "5" {
            filterSelected = "Golf"
        } else if "\(indexPath.row)" == "6" {
            filterSelected = "Hockey"
        } else if "\(indexPath.row)" == "7" {
            filterSelected = "Lifting"
        } else if "\(indexPath.row)" == "8" {
            filterSelected = "Ping Pong"
        } else if "\(indexPath.row)" == "9" {
            filterSelected = "Running"
        } else if "\(indexPath.row)" == "10" {
            filterSelected = "Skateboard"
        } else if "\(indexPath.row)" == "11" {
            filterSelected = "Soccer"
        } else if "\(indexPath.row)" == "12" {
            filterSelected = "Tennis"
        } else if "\(indexPath.row)" == "13" {
            filterSelected = "Volleyball"
        } else if "\(indexPath.row)" == "14" {
            filterSelected = "Yoga"
        }
        
//        if (delegate) != nil {
//            delegate?.menuItemSelected(filterSelected)
//        }
        self.filterDelegate?.filterOnActivity(filterSelected)
        
        //        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        //        let controller = storyboard.instantiateViewControllerWithIdentifier("ActivityViewController") as! ActivityViewController
        //        controller.selectedActivity = selectedNumber
        //        print("\(selectedNumber)")
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        let navC = segue.destinationViewController as? UINavigationController
    //        containerViewController = navC?.topViewController as? ContainerViewController
    //        containerViewController!.selectedNumber = selectedNumber
    //    }
    
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
