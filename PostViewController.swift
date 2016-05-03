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

class PostViewController: UIViewController, CLLocationManagerDelegate{

    var locationMnager:CLLocationManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationMnager = CLLocationManager()
        locationMnager.delegate = self


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

}


















