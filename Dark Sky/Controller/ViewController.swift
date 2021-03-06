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
    
    @IBOutlet weak var otherSetting: UIButton!
    @IBOutlet weak var exitBut: UIButton!
    @IBOutlet weak var confirmBut: UIButton!
    @IBOutlet weak var moreInfo: UIButton!
    @IBOutlet weak var picker: UIDatePicker!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var summaryLbl: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var exitBtn: UIButton!
    @IBOutlet weak var fjeowapijfiwoefp: UILabel!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var coordLbl: UILabel!
    @IBOutlet weak var dateView: UIView!
    
    var myLocation:CLLocation!      // Current Location
    var curr: Weather!              // Current Weather
    var defaultUrl: String!
    var url: String!
    var locUrl: String!
    var withTime: Bool!
    var withLoc: Bool!
    var urlKey = "https://api.darksky.net/forecast/8d29ba93fca67043efd36cda49c585e6/"
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        myLocation = locations[0]
        
        manager.stopUpdatingLocation()
        defaultUrl = "\(urlKey)\(myLocation.coordinate.latitude),\(myLocation.coordinate.longitude)"

        if withTime {
            coordLbl.text = "\(myLocation.coordinate.latitude), \(myLocation.coordinate.longitude)"
            if withLoc {
                getApi(locUrl)
            } else {
                getApi(url)
            }
        } else {
            getApi(defaultUrl)
        }
        
    }
    
    func getApi(_ urlStr: String) {
        APIManager.getLocation(urlStr, { data in
            self.curr = data
            DispatchQueue.main.async {
                self.loadVC()
            }
        })
    }
    
    func loadVC() {
        temperatureLabel.text = "\(String(describing: curr!.temperature))˚F"
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        let nsdate = NSDate(timeIntervalSince1970: Double(curr?.time ?? 1583510400))
        let date = Date(date: nsdate)
        let dateStr = df.string(from: date)
        timeLbl.text = "\(dateStr)"
        summaryLbl.text = curr?.summary
        iconImg.image = UIImage(named: curr!.icon)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateView.isHidden = true
        withTime = false
        
        Helpers.designButtons(moreInfo)
        Helpers.designButtons(exitBut)
        Helpers.designButtons(confirmBut)
        Helpers.designButtons(otherSetting)
        picker.setValue(UIColor.white, forKeyPath: "textColor")
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    @IBAction func MoreDetails(_ sender: Any) {
        self.performSegue(withIdentifier: "MoreDetail", sender: self)
    }
    
    @IBAction func prevCond(_ sender: Any) {
        dateView.isHidden = false
    }
    
    @IBAction func exit(_ sender: Any) {
        dateView.isHidden = true
    }
    
    @IBAction func confirm(_ sender: Any) {
        
        let unixDate = Int(picker.date.timeIntervalSince1970)
        
        if (unixDate > Int(NSDate().timeIntervalSince1970)) {
            presentAlert("Please provide a date before today")
        }
        
        else {
            withTime = true
            
            if locationField.text == "" {
                withLoc = false
                url = defaultUrl + ",\(unixDate)"
                
                locationManager(self.manager, didUpdateLocations: [self.myLocation])
                
                self.viewDidLoad()
                dateView.isHidden = true
            } else {
                withLoc = true
                
                getCoordinateFrom(address: locationField.text!) { coordinate, error in
                    guard let coordinate = coordinate, error == nil else {
                        self.presentAlert("Please enter a valid location")
                        return
                    }
                    // don't forget to update the UI from the main thread
                    DispatchQueue.main.async {
                        print(self.locationField.text!, "Location:", coordinate) // Rio de Janeiro, Brazil Location: CLLocationCoordinate2D(latitude: -22.9108638, longitude: -43.2045436)
                        
                        self.locUrl = "\(self.urlKey)\(coordinate.latitude),\(coordinate.longitude),\(unixDate)"
                        
                        self.myLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        
                        self.locationManager(self.manager, didUpdateLocations: [self.myLocation])
                        self.viewDidLoad()
                        self.dateView.isHidden = true
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailViewController {
            dest.curr = self.curr
        }
    }
    
    func presentAlert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
}

extension Date {
    init(date: NSDate) {
        self.init(timeIntervalSinceReferenceDate: date.timeIntervalSinceReferenceDate)
    }
}
