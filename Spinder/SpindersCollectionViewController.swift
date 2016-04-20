//
//  SpindersCollectionViewController.swift
//  Spinder
//
//  Created by Kyle on 4/18/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class SpindersCollectionViewController: UICollectionViewController {

    @IBOutlet var spinderCollectionView: UICollectionView!
    
    
    var user = [Users]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        loadUsers()

        // Register cell classes
//        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    func loadUsers() {
        FirebaseService.firebaseSerivce.FirebaseUserRef.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value)
            
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
            self.spinderCollectionView.reloadData()
        })
        
    }

    
    
    

    // MARK: UICollectionViewDataSource

//    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(user.count)

        return user.count
        
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as? SpinderCell
        let users = user[indexPath.row]
        cell?.nameLabel.text = users.userName
        cell?.ageLabel.text = users.userAge
        cell?.imageView.image = conversion(users.userPhoto)
        return cell!
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
