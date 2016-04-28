//
//  ActivityViewController.swift
//  SpinderFB
//
//  Created by Kyle on 4/25/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase

class ActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    @IBOutlet weak var activityTableView: ActivityTableView!
    var genderPickerView = UIPickerView()
    let agePickerView = UIPickerView()
    let distancePickerView = UIPickerView()
    var toolBar = UIToolbar()
    var genderOption = ["Male", "Female"]
    var distanceOption = ["Within 1 Miles", "Within 2 Miles", "Within 3 Miles", "Within 4 Miles", "Within 5 Miles"]
    var activity = ["Fitness", "Sports", "Gaming", "Dog Walks", "Coding"]
    var users = [User]()
    var chatUser = []
    var filterGender = String()
    var filteredUsers = [User]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
        buttons()
        filterUsers()
        
        
        genderPickerView.showsSelectionIndicator = true
        toolBar.barStyle = UIBarStyle.Default
        
        //        let doneButton = UIBarButtonItem(title: "Done", style:.Plain, target: self, action:#selector(ActivityViewController.doneButton))
        //        toolBar.setItems([doneButton], animated: false)
        //        toolBar.userInteractionEnabled = true
        
        
        
        
        genderPickerView.delegate = self
        genderPickerView.dataSource = self
        distancePickerView.delegate = self
        genderPickerView.tag = 101
        distancePickerView.tag = 102
        genderTextField.inputView = genderPickerView
        genderTextField.inputAccessoryView = toolBar
        distanceTextField.inputView = distancePickerView
        
        
        
    }
    
    
    
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 363.0;
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
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 101 {
            return genderOption.count
        } else if pickerView.tag == 102 {
            return distanceOption.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 101 {
            return genderOption[row]
        } else if pickerView.tag == 102 {
            return distanceOption[row]
        }
        
        return " "
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 101 {
            genderTextField.text = genderOption[row]
        } else if pickerView.tag == 102 {
            distanceTextField.text = distanceOption[row]
        }
        print("Users picked")
        
        self.activityTableView.reloadData()
        self.view.endEditing(true)
        
        
        
        
        
    }
    //        MARK : CUSTOM FUNC
    func buttons() {
        let menuItemImage = UIImage(named: "bg-menuitem")!
        let menuItemHighlitedImage = UIImage(named: "bg-menuitem-highlighted")!
        let basketballImage = UIImage(named: "footballc40")!
        let baseballImage = UIImage(named: "bikec40")!
        let volleyballImage = UIImage(named: "weightsc40")!
        let soccerImage = UIImage(named: "gamepadc40")!
        let bowlingImage = UIImage(named: "dogc40")!
        
        
        let menuItem1 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: basketballImage)
        
        let menuItem2 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: baseballImage)
        
        let menuItem3 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: volleyballImage)
        
        let menuItem4 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: soccerImage)
        
        let menuItem5 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: bowlingImage)
        
        
        
        
        
        let items = [menuItem1, menuItem2, menuItem3, menuItem4, menuItem5]
        
        let startItem = PathMenuItem(image: UIImage(named: "bg-addbutton")!,
                                     highlightedImage: UIImage(named: "bg-addbutton-highlighted"),
                                     contentImage: UIImage(named: "icon-plus"),
                                     highlightedContentImage: UIImage(named: "icon-plus-highlighted"))
        
        let menu = PathMenu(frame: view.bounds, startItem: startItem, items: items)
        menu.delegate = self
        menu.startPoint     = CGPointMake(UIScreen.mainScreen().bounds.width/2, view.frame.size.height - 30.0)
        menu.menuWholeAngle = (CGFloat(M_PI) - CGFloat(M_PI/5))
        menu.rotateAngle    = -CGFloat(M_PI_2) + CGFloat(M_PI/5) * 1/2
        menu.timeOffset     = 0.05
        menu.farRadius      = 110.0
        menu.nearRadius     = 90.0
        menu.endRadius      = 80.0
        menu.animationDuration = 0.5
        
        view.addSubview(menu)
        view.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
        
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
    
    
    
    
}

extension ActivityViewController: PathMenuDelegate {
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        print("Select the index : \(idx)")
    }
    
    func pathMenuWillAnimateOpen(menu: PathMenu) {
        print("Menu will open")
    }
    
    func pathMenuWillAnimateClose(menu: PathMenu) {
        print("Menu will close")
    }
    
    func pathMenuDidFinishAnimationOpen(menu: PathMenu) {
        print("Menu was open")
    }
    
    func pathMenuDidFinishAnimationClose(menu: PathMenu) {
        print("Menu was closed")
    }
    
    func doneButton() {
        genderTextField.resignFirstResponder()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
}

