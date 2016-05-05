//
//  PostViewController.swift
//  Spinder
//
//  Created by Mingu Chu on 4/30/16.
//  Copyright © 2016 Kyle. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class PostViewController: UIViewController, CLLocationManagerDelegate, UIViewControllerTransitioningDelegate{
    var startItem: PathMenuItem?
    var locationMnager:CLLocationManager!
    var activeUser:ActiveUser!
    var currentUser = Dictionary<String, AnyObject>?()
    var activity: String!
    
    
    @IBOutlet weak var activityTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationMnager = CLLocationManager()
        locationMnager.delegate = self
        buttons()
        
//        print("\(currentUser)")
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//        print("\(activity)")
    }
    
    @IBAction func postButtonTapped(sender: AnyObject) {
        self.activeUser = ActiveUser.init(activity: activity, detail: activityTextView.text, locationPlacemark: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func locationButton(sender: AnyObject) {
        locationMnager.requestWhenInUseAuthorization()
        locationMnager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.first
        if location?.verticalAccuracy < 500 && location?.horizontalAccuracy < 500 {
            reverseGeocode(location!)
            locationMnager.stopUpdatingLocation()
        }
    }
    func reverseGeocode(location:CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks: [CLPlacemark]?, error:NSError?) in
            let placemark = placemarks?.first
            let address = "\(placemark?.postalCode)"
            print(address)
        }
    }
    
    func errorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    func commonInit() {
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
    
    // ---- UIViewControllerTransitioningDelegate methods
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        if presented == self {
            return CustomPresentationController(presentedViewController: presented, presentingViewController: presenting)
        }
        return nil
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented == self {
            return CustomPresentationAnimationController(isPresenting: true)
        }
        return nil
    }
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed == self {
            return CustomPresentationAnimationController(isPresenting: false)
        }
        return nil
    }
    
    // SweetButtons!
    func buttons() {
        let menuItemImage           = UIImage(named: "bg-menuitem")!
        let menuItemHighlitedImage  = UIImage(named: "bg-menuitem-highlighted")!
        let baseball                = UIImage(named: "baseballWhite")!
        let basketball              = UIImage(named: "basketballWhite")!
        let bike                    = UIImage(named: "bikeWhite")!
        let bowl                    = UIImage(named: "bowlWhite")!
        let fight                   = UIImage(named: "fightWhite")!
        let golf                    = UIImage(named: "golfWhite")!
        let hockey                  = UIImage(named: "hockeyWhite")!
        let lift                    = UIImage(named: "liftWhite")!
        let pingpong                = UIImage(named: "pingpongWhite")!
        let run                     = UIImage(named: "runWhite")!
        let skateboard              = UIImage(named: "skateboardWhite")!
        let soccer                  = UIImage(named: "soccerWhite")!
        let tennis                  = UIImage(named: "tennisWhite")!
        let volleyball              = UIImage(named: "volleyballWhite")!
        let yoga                    = UIImage(named: "yogaWhite")!
        
        let menuItem1  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: baseball)
        let menuItem2  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: basketball)
        let menuItem3  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: bike)
        let menuItem4  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: bowl)
        let menuItem5  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: fight)
        let menuItem6  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: golf)
        let menuItem7  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: hockey)
        let menuItem8  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: lift)
        let menuItem9  = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: pingpong)
        let menuItem10 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: run)
        let menuItem11 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: skateboard)
        let menuItem12 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: soccer)
        let menuItem13 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: tennis)
        let menuItem14 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: volleyball)
        let menuItem15 = PathMenuItem(image: menuItemImage, highlightedImage: menuItemHighlitedImage, contentImage: yoga)
        
        let items = [menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6, menuItem7, menuItem8, menuItem9, menuItem10, menuItem11, menuItem12, menuItem13, menuItem14, menuItem15]
        startItem = PathMenuItem(image: UIImage(named: "bigcircle")!, highlightedImage: UIImage(named: "bigcircleselected"), contentImage: UIImage(named: "addwhite"), highlightedContentImage: UIImage(named: "addwhiteselected"))
        let menu = PathMenu(frame: view.bounds, startItem: startItem, items: items)
        menu.delegate = self
        menu.startPoint     = CGPointMake(UIScreen.mainScreen().bounds.width - 260, view.frame.size.height - 425)
        menu.menuWholeAngle = (CGFloat(M_PI) - CGFloat(M_PI/5)) * 2.5
        menu.rotateAngle    = -CGFloat(M_PI_2) + CGFloat(M_PI/5) * 1/2
        menu.timeOffset     = 0.05
        menu.farRadius      = 110.0
        menu.nearRadius     = 130.0
        menu.endRadius      = 130.0
        menu.animationDuration = 0.5
        view.addSubview(menu)
        view.backgroundColor = UIColor(red:0.96, green:0.94, blue:0.92, alpha:1)
        
        
    }
    
}

extension PostViewController: PathMenuDelegate {
    func pathMenu(menu: PathMenu, didSelectIndex idx: Int) {
        let item = menu.menuItems[idx]
        startItem?.contentImageView?.image = item.contentImageView?.image
//        print("Select the index : \(idx)")
        if idx == 0 {
            activity = "Baseball"
        } else if idx == 1 {
            activity = "Basketball"
        } else if idx == 2 {
            activity = "Bike Ride"
        } else if idx == 3 {
            activity = "Bowling"
        } else if idx == 4 {
            activity = "Fighting"
        } else if idx == 5 {
            activity = "Golf"
        } else if idx == 6 {
            activity = "Hockey"
        } else if idx == 7 {
            activity = "Lifting"
        } else if idx == 8 {
            activity = "Ping Pong"
        } else if idx == 9 {
            activity = "Running"
        } else if idx == 10 {
            activity = "Skateboard"
        } else if idx == 11 {
            activity = "Soccer"
        } else if idx == 12 {
            activity = "Tennis"
        } else if idx == 13 {
            activity = "Volleyball"
        } else if idx == 14 {
            activity = "Yoga"
        }
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
}



