//
//  SpindersCollectionViewController.swift
//  Spinder
//
//  Created by Kyle on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase
import JavaScriptCore

private let reuseIdentifier = "Cell"

class SpindersCollectionViewController: UICollectionViewController {

    @IBOutlet var spinderCollectionView: UICollectionView!
    
    var filterAge = String()
    var filterGender = String()
    var filterDistance = String()
    var filterHomeTown = String()
    
    
    var user = [Users]()
    var chatUser = []
    
    var filteredUsers = [Users]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        loadUsers()

    }
    
    func filterUsers(){
        for userSingular in user {
            if userSingular.userGender == filterGender && userSingular.userHomeTown == filterHomeTown {
                filteredUsers.append(userSingular)
                collectionView?.reloadData()
                
//                if Int(userSingular.userAge) > filterAge && userSingular.userGender = filterGender {
//                    filteredUsers.append(userSingular)

            }
        }
    }
    
    func loadUsers() {
        FirebaseService.firebaseSerivce.FirebaseUserRef.observeEventType(.Value, withBlock: { snapshot in
            self.user = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if let userDictionary = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let user = Users(key: key, dictionary: userDictionary)
                        self.user.insert(user, atIndex: 0)
                        
                    }
                }
            }
            print("Total Number of Registered Users: \(self.user.count.description)")
            print("Total Number of Filtered Users: \(self.filteredUsers.count.description)")

            self.filterUsers()
            self.spinderCollectionView.reloadData()
        })
    }

    
    


    // MARK: UICollectionViewDataSource

//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(user.count)
        if filteredUsers.count > 0 {
            return filteredUsers.count
        } else {
        return user.count
        }
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? SpinderCell
        if filteredUsers.count > 0 {
        let users = filteredUsers[indexPath.row]
            cell?.nameAgeLabel.text = "\(users.userName), \(users.userAge), \(users.userGender)"
            cell?.imageView.image = conversion(users.userPhoto)
        } else {
        let users = user[indexPath.row]
            cell?.nameAgeLabel.text = "\(users.userName), \(users.userAge), \(users.userGender)"
            cell?.imageView.image = conversion(users.userPhoto)
        }
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        let navVc = segue.destinationViewController as! UINavigationController
        let chatVc = navVc.viewControllers.first as! ChatViewController
        chatVc.senderId = FirebaseService.firebaseSerivce.currentUserRef.authData.uid
        chatVc.senderDisplayName = ""
    }
    
    func conversion(photo: String) -> UIImage {
        let imageData = NSData(base64EncodedString: photo, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
