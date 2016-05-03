//
//  ActivityViewController.swift
//  SpinderFB
//
//  Created by Kyle on 4/25/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    
    @IBOutlet weak var activityTableView: ActivityTableView!
    
    var users = [User]()
    var chatUser = []
    var filterGender = String()
    var filteredUsers = [User]()
    var locationRef: Firebase!
    var lastOffsetY :CGFloat = 0
    var hamburgerView: HamburgerView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        loadUsers()
        filterUsers()
        
        
        // Side Menu
        navigationController!.navigationBar.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ActivityViewController.hamburgerViewTapped))
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
        
    }
    
    
    func hamburgerViewTapped() {
        let navigationController = parentViewController as! UINavigationController
        let containerViewController = navigationController.parentViewController as! ContainerViewController
        containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
    }
    
    var menuItem: NSDictionary? {
        didSet {
            if let newMenuItem = menuItem {
                view.backgroundColor = UIColor(colorArray: newMenuItem["colors"] as! NSArray)
            }
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView){
        lastOffsetY = scrollView.contentOffset.y
    }
    
//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView){
//        
//        let hide = scrollView.contentOffset.y > self.lastOffsetY
//        self.navigationController?.setNavigationBarHidden(hide, animated: true)
//    }
    
    
    func filterUsers(){
        for user in users {
            if user.userGender == filterGender {
                filteredUsers.append(user)
                activityTableView?.reloadData()
                print("Users reloading")
            }
        }
    }
    
    // DataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredUsers.count > 0 {
            return filteredUsers.count
        } else {
            return users.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityTableViewCell;
        if filteredUsers.count > 0 {
            let user = filteredUsers[indexPath.row]
            cell.nameAgeLabel.text = "\(user.userName), \(user.userAge), \(user.userGender)"
            cell.photoImageView.image = conversion(user.userPhoto)
        } else {
            let user = users[indexPath.row]
            cell.nameAgeLabel.text = "\(user.userName), \(user.userAge), \(user.userGender)"
            cell.photoImageView.image = conversion(user.userPhoto)
        }
        return cell
        
    }
    
    
    func loadUsers() {
        FirebaseService.firebaseSerivce.FirebaseUserRef.observeEventType(.Value, withBlock: { snapshot in
            self.users = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let user = User(key: key, dictionary: userDictionary)
                        self.users.insert(user, atIndex: 0)
                        
                    }
                }
            }
            print("Total Number of Registered Users: \(self.users.count.description)")
            print("Total Number of Filtered Users: \(self.filteredUsers.count.description)")
            
            self.filterUsers()
            self.activityTableView.reloadData()
        })
    }
    
    func conversion(photo: String) -> UIImage {
        let imageData = NSData(base64EncodedString: photo, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }
    

    
    // Dismiss PostViewController
    @IBAction func dismiss(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}




