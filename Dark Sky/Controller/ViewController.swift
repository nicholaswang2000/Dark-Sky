//
//  ViewController.swift
//  Dark Sky
//
//  Created by Nicholas Wang on 3/3/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    
    
    var myLocation:CLLocation!      // Current Location
    var curr: Weather!        // Current Weather
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        myLocation = locations[0]
        print(myLocation.coordinate.latitude, myLocation.coordinate.longitude)
        
        manager.stopUpdatingLocation()
        
            APIManager.getLocation(self.myLocation, { data in
                self.curr = data
                DispatchQueue.main.async {
                    self.loadVC()
                }
                
            })
        
    }
    
    func loadVC() {
        
        print(curr?.temperature)
        temperatureLabel.text = "\(curr?.temperature) degrees Celsius"
        print(NSDate(timeIntervalSince1970: Double(curr?.time ?? 1583510400)))
        timeLbl.text = "\(NSDate(timeIntervalSince1970: Double(curr?.time ?? 1583510400)))"
        summaryLbl.text = curr?.summary
        iconImg.image = UIImage(named: curr!.icon)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    @IBAction func MoreDetails(_ sender: Any) {
        self.performSegue(withIdentifier: "MoreDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController {
            dest.curr = self.curr
        }
    }
    
    
}

