//
//  DetailViewController.swift
//  Dark Sky
//
//  Created by Nicholas Wang on 3/6/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var curr:Weather!

    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var nearestStormDistance: UILabel!
    @IBOutlet weak var nearestStormbearing: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var apparentTemperature: UILabel!
    @IBOutlet weak var dewPoint: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windGust: UILabel!
    @IBOutlet weak var windBearing: UILabel!
    @IBOutlet weak var cloudCover: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var ozone: UILabel!
    @IBOutlet weak var uvindex: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        time.text = "\(NSDate(timeIntervalSince1970: Double(curr?.time ?? 1583510400)))"
        summary.text = curr.summary
        nearestStormDistance.text = "\(curr.nearestStormDistance)"
        nearestStormbearing.text = "\(curr.nearestStormBearing)"
        temperature.text = "\(curr.temperature)"
        apparentTemperature.text = "\(curr.apparentTemperature)"
        dewPoint.text = "\(curr.dewPoint)"
        humidity.text = "\(curr.humidity)"
        pressure.text = "\(curr.pressure)"
        windSpeed.text = "\(curr.windSpeed)"
        windGust.text = "\(curr.windGust)"
        windBearing.text = "\(curr.windBearing)"
        cloudCover.text = "\(curr.cloudCover)"
        visibility.text = "\(curr.visibility)"
        ozone.text = "\(curr.ozone)"
        uvindex.text = "\(curr.uvIndex)"
        iconImg.image = UIImage(named: curr.icon)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
