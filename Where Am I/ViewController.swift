//
//  ViewController.swift
//  Where Am I
//
//  Created by Peter & Liz  on 2/17/15.
//  Copyright (c) 2015 P&L Studios. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitude: UILabel!
    @IBOutlet var longitude: UILabel!
    @IBOutlet var altitude: UILabel!
    @IBOutlet var speed: UILabel!
    @IBOutlet var heading: UILabel!
    @IBOutlet var address: UILabel!
    
    var manager:CLLocationManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [AnyObject]) {
        
        var userLocation:CLLocation = locations[0] as CLLocation
        
        latitude.text = "\(userLocation.coordinate.latitude)"
        
        longitude.text = "\(userLocation.coordinate.longitude)"
        
        heading.text = "\(userLocation.course)"
        
        speed.text = "\(userLocation.speed)"
        
        altitude.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: {(placemarks, error) in
            
            var subThoroughfare:String
            
            if error != nil { println("Error: \(error)") }
            
            else {
                
                let p = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                
                if (p.subThoroughfare != nil) {
                    subThoroughfare = p.subThoroughfare
                
                } else {
                    subThoroughfare = ""
                
                }
                
                self.address.text = "\(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \(p.country)"

                
            }
        
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

