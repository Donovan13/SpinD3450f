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

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var messagesButton: BadgeButton!
    @IBOutlet weak var genderTextField: UITextField!
    

    @IBOutlet weak var activityTableView: ActivityTableView!
    var users = [User]()
    var filterGender = String()
    var filteredUsers = [User]()
    var locationRef: Firebase!
    var lastOffsetY :CGFloat = 0
    var hamburgerView: HamburgerView?

    var currentUser = Dictionary<String, AnyObject>?()
    
    var cUser: String!
    
    var receieverKey = String()
    var receieverName = String()
    var receieverGender = String()
    var receieverAge = String()
    var receieverHomeTown = String()
    var receieverDescription = String()
    var receieverProfilePicture = String()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadUsers()
        filterUsers()

        messagesButton.badgeString = "19"
        messagesButton.badgeTextColor = UIColor.whiteColor()
        messagesButton.badgeEdgeInsets = UIEdgeInsetsMake(10, 6, 0, 0)
        
        loadUserProfile()
        

        
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "DirectMessageSegue" {
            let chatVc = segue.destinationViewController as! ChatViewController
            chatVc.senderId = FirebaseService.firebaseSerivce.currentUserRef.authData.uid
            chatVc.senderDisplayName = ""
            chatVc.receieverID = receieverKey
            chatVc.receieverName = receieverName
            print(receieverKey)
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
        for user in users {
            if "\(user.userName)" == cell.nameAgeLabel.titleLabel?.text {
                self.receieverName = user.userName
                self.receieverGender = user.userGender
                self.receieverAge = user.userAge
                self.receieverHomeTown = user.userZipCode
                self.receieverDescription = user.userDescription
                self.receieverProfilePicture = user.userPhoto
                
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
//                print("\(user.userKey)")
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
            return users.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath) as! ActivityTableViewCell;
        if filteredUsers.count > 0 {
            let user = filteredUsers[indexPath.row]
            cell.nameAgeLabel.setTitle(user.userName, forState: .Normal)
            cell.photoImageView.image = conversion(user.userPhoto)
        } else {
            let user = users[indexPath.row]
            cell.nameAgeLabel.setTitle(user.userName, forState: .Normal)
            cell.photoImageView.image = conversion(user.userPhoto)
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
//        FirebaseService.firebaseSerivce.FirebaseUserRef.observeEventType
        FirebaseService.firebaseSerivce.FirebaseActiveUserRef.observeEventType(.Value, withBlock: { snapshot in
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
    
    func filterUsers(){
        for user in users {
            if user.userGender == "" {
                filteredUsers.append(user)
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
    
    
    @IBAction func dismiss(segue: UIStoryboardSegue) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}


