//
//  ActivityViewController.swift
//  SpinderFB
//
//  Created by Kyle on 4/25/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase

var currentUserName: String!
var currentUserAge: String!
var currentUserGender: String!
var currentUserProfilePicture: String!
var currentUserZipcode: String!
var currentUserDescription: String!

protocol FilterDelegate {
    func filterOnActivity (activity: String)
}

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, FilterDelegate {
    
    @IBOutlet weak var messagesButton: BadgeButton!
    @IBOutlet weak var activityTableView: ActivityTableView!
    
    var users = [User]()
    var activeUsers = [ActiveUser]()
    var filterGender = String()
    var filteredUsers = [ActiveUser]()
    var locationRef: Firebase!
    var lastOffsetY :CGFloat = 0
    var hamburgerView: HamburgerView?
    var currentUser = Dictionary<String, AnyObject>?()
    var receieverKey = String()
    var receieverName = String()
    var receieverGender = String()
    var receieverAge = String()
    var receieverHomeTown = String()
    var receieverDescription = String()
    var receieverProfilePicture = String()

    var filterActivity = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
        loadUserProfile()
        filterUsers()

        messagesButton.badgeString = "19"
        messagesButton.badgeTextColor = UIColor.whiteColor()
        messagesButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 6, 0, 0)
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ActivityViewController.hamburgerViewTapped))
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
    }
//    MARK : FilterDelegate
    func filterOnActivity(activity: String) {
        print(activity)
        filterActivity = activity
        print("\(filterActivity)")
    }
    
//    func filteredUser(filter: String) {
//        for activeUser in activeUsers {
//            if activeUser.userActivity == filter {
//                filteredUsers.append(activeUser)
//                activityTableView.reloadData()
//            }
//        }
//
//    }
//    
    
    
    func hamburgerViewTapped() {
        let navigationController = parentViewController as! UINavigationController
        let containerViewController = navigationController.parentViewController as! ContainerViewController
        containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
        print("tapp")
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
        print("testScroll")
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "DirectMessageSegue" {
            let chatVc = segue.destinationViewController as! ChatViewController
            chatVc.senderId = FirebaseService.firebaseSerivce.currentUserRef.authData.uid
            chatVc.senderDisplayName = ""
            chatVc.receieverID = receieverKey
            chatVc.receieverName = receieverName
        } else if segue.identifier == "PostSegue" {
            let postVc = segue.destinationViewController as! PostViewController
            postVc.currentUser = self.currentUser
        } else if segue.identifier == "ViewProfileSegue" {
            let profileVc = segue.destinationViewController as! ViewProfileViewController
            profileVc.receieverName = self.receieverName
            profileVc.receieverAge = self.receieverAge
            profileVc.receieverGender = self.receieverGender
            profileVc.receieverUserProfilePicture = self.receieverProfilePicture
            profileVc.receieverUserHomeTown = self.receieverHomeTown
            profileVc.receieverDescription = self.receieverDescription
        } else if segue.identifier == "InboxSegue" {
            
        }
    }
    
    @IBAction func postButtonSegue(sender: AnyObject) {
        performSegueWithIdentifier("PostSegue", sender: nil)
    }
    
    @IBAction func viewProfileButton(sender: AnyObject) {
        let cell = sender.superview!!.superview as! ActivityTableViewCell
        for activeUser in activeUsers {
            if "\(activeUser.userName)" == cell.nameAgeLabel.titleLabel?.text {
                self.receieverName = activeUser.userName
                self.receieverGender = activeUser.userGender
                self.receieverAge = activeUser.userAge
                self.receieverHomeTown = activeUser.userZipCode
                self.receieverDescription = activeUser.userDescription
                self.receieverProfilePicture = activeUser.userPhoto
            }
        }
        performSegueWithIdentifier("ViewProfileSegue", sender: nil)
    }
    
    @IBAction func inboxButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("InboxSegue", sender: nil)
    }
    
    @IBAction func DirectMessageButton(sender: AnyObject) {
        let cell = sender.superview!!.superview as! ActivityTableViewCell
        for user in users {
            if "\(user.userName)" == cell.nameAgeLabel.titleLabel?.text {
                self.receieverKey = user.userKey
                self.receieverName = user.userName
            }
        }
        performSegueWithIdentifier("DirectMessageSegue", sender: nil)
    }
    
    // MARK : TABLEVIEW DELEGATE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredUsers.count > 0 {
            return filteredUsers.count
        } else {
            return activeUsers.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityTableViewCell;
        if filteredUsers.count > 0 {
            let user = filteredUsers[indexPath.row]
            cell.nameAgeLabel.setTitle(user.userName, forState: .Normal)
            cell.photoImageView.image = conversion(user.userPhoto)
        } else {
            let activeUser = activeUsers[indexPath.row]
            cell.nameAgeLabel.setTitle(activeUser.userName, forState: .Normal)
            cell.photoImageView.image = conversion(activeUser.userPhoto)
            cell.activityList.text = activeUser.userActivity
            cell.activityDescription.text = activeUser.activityDetail
            if activeUser.userActivity == "Baseball" {
                cell.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1.0)
            } else if activeUser.userActivity == "Basketball" {
                cell.backgroundColor = UIColor(red: 300/255, green: 59/255, blue: 55/255, alpha: 1.0)
            } else if activeUser.userActivity == "Bike Ride" {
                cell.backgroundColor = UIColor(red: 44/255, green: 194/255, blue: 7/255, alpha: 1.0)
            } else if activeUser.userActivity == "Bowling" {
                cell.backgroundColor = UIColor(red: 99/255, green: 22/255, blue: 122/255, alpha: 1.0)
            } else if activeUser.userActivity == "Fighting" {
                cell.backgroundColor = UIColor(red: 207/255, green: 34/255, blue: 156/255, alpha: 1.0)
            } else if activeUser.userActivity == "Golf" {
                cell.backgroundColor = UIColor(red: 14/255, green: 222/255, blue: 149/255, alpha: 1.0)
            } else if activeUser.userActivity == "Hockey" {
                cell.backgroundColor = UIColor(red: 150/255, green: 193/255, blue: 231/255, alpha: 1.0)
            } else if activeUser.userActivity == "Lifting" {
                cell.backgroundColor = UIColor(red: 240/255, green: 122/255, blue: 180/255, alpha: 1.0)
            } else if activeUser.userActivity == "Ping Pong" {
                cell.backgroundColor = UIColor(red: 201/255, green: 199/255, blue: 32/255, alpha: 1.0)
            } else if activeUser.userActivity == "Running" {
                cell.backgroundColor = UIColor(red: 126/255, green: 100/255, blue: 222/255, alpha: 1.0)
            } else if activeUser.userActivity == "Skateboard" {
                cell.backgroundColor = UIColor(red: 165/255, green: 172/255, blue: 44/255, alpha: 1.0)
            } else if activeUser.userActivity == "Soccer" {
                cell.backgroundColor = UIColor(red: 100/255, green: 200/255, blue: 100/255, alpha: 1.0)
            } else if activeUser.userActivity == "Tennis" {
                cell.backgroundColor = UIColor(red: 100/255, green: 99/255, blue: 199/255, alpha: 1.0)
            } else if activeUser.userActivity == "Volleyball" {
                cell.backgroundColor = UIColor(red: 110/255, green: 166/255, blue: 66/255, alpha: 1.0)
            } else if activeUser.userActivity == "Yoga" {
                cell.backgroundColor = UIColor(red: 134/255, green: 44/255, blue: 233/255, alpha: 1.0)
            }
        }
        return cell
    }
    
       //    MARK : LOAD ALL USERS / NO FILTERS
    func loadUserProfile () {
        FirebaseService.firebaseSerivce.currentUserRef.observeEventType(.Value) { (snapshot: FDataSnapshot!) in
            self.currentUser = snapshot.value as? Dictionary<String, AnyObject>
            currentUserName = self.currentUser!["name"] as? String
            currentUserGender = self.currentUser!["gender"] as? String
            currentUserAge = self.currentUser!["age"] as? String
            currentUserZipcode = self.currentUser!["zipCode"] as? String
            currentUserDescription = self.currentUser!["description"] as? String
            currentUserProfilePicture = self.currentUser!["profilePicture"] as! String
        }
    }
    
    func loadUsers() {
        FirebaseService.firebaseSerivce.FirebaseActiveUserRef.observeEventType(.Value, withBlock: { snapshot in
            self.activeUsers = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let activeUser = ActiveUser(dictionary: userDictionary)
                        self.activeUsers.insert(activeUser, atIndex: 0)
                    }
                }
            }
            print("Total Number of Registered Users: \(self.activeUsers.count.description)")
            print("Total Number of Filtered Users: \(self.filteredUsers.count.description)")
            self.filterUsers()
            self.activityTableView.reloadData()
        })
    }
    
    func filterUsers() {
        for activeUser in activeUsers {
            if activeUser.userActivity == self.filterActivity {
                print(activeUser.userActivity)
                print(self.filterActivity)
                filteredUsers.append(activeUser)
                activityTableView?.reloadData()
                print("Users reloading")
            }
        }
        
    }
    
    
    //    MARK : PHOTO STRING -> IMAGE / CONVERSION
    func conversion(photo: String) -> UIImage {
        let imageData = NSData(base64EncodedString: photo, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }
}


