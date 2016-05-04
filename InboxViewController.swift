//
//  InboxViewController.swift
//  Spinder
//
//  Created by Mingu Chu on 5/4/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase

class InboxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var messages = [Message]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeMessages()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InboxCell", forIndexPath: indexPath)
        let message = messages[indexPath.row]
        if message.senderName == message.senderName {
            cell.textLabel?.text = message.senderName
        }
        
//        if cell.textLabel?.text != message.senderName {
//                cell.textLabel?.text = message.senderName
//        } else if message.senderName == message.senderName {
//            print("already printed")
//        }
        return cell
    }
    
    
    
    private func observeMessages() {
        FirebaseService.firebaseSerivce.FirebaseMessageRef.observeEventType(.Value) { (snapshot:FDataSnapshot!) in
            self.messages = []
            if let snapshots = snapshot.children.allObjects as? [FDataSnapshot] {
                for snap in snapshots {
                    if (snap.value["senderId"] as! String) == (NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String) || (snap.value["receieverId"] as! String) == (NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String) {
                        let userDictionary = snap.value as! Dictionary<String, AnyObject>
                            let key = snap.key
//                        for message in self.messages {
//                            if snap.value["senderId"] || snap.value["receieverId"] == (NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String) {
                            
//                            }
//                        }
                            let message = Message(key: key, dictionary: userDictionary)
                            self.messages.insert(message, atIndex: 0)
                   
                    }
                }
                
                
            }
            self.tableView.reloadData()
            print(self.messages.count)
        }
        
    }
    
    
}

