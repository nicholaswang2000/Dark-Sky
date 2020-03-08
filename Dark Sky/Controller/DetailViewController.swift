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
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var dewPoint: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windBearing: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var uvindex: UILabel!
    @IBOutlet weak var exitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Helpers.designButtons(exitBtn)
        
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        let nsdate = NSDate(timeIntervalSince1970: Double(curr?.time ?? 1583510400))
        let date = Date(date: nsdate)
        let dateStr = df.string(from: date)
        
        time.text = dateStr
        summary.text = curr.summary
        temperature.text = "Temp: \(curr.temperature)"
        dewPoint.text = "Dew Point: \(curr.dewPoint)"
        humidity.text = "Humidity: \(curr.humidity)"
        pressure.text = "Pressure: \(curr.pressure)"
        windSpeed.text = "Wind Speed: \(curr.windSpeed)"
        windBearing.text = "Wind Bearing: \(curr.windBearing)"
        visibility.text = "Visibility: \(curr.visibility)"
        uvindex.text = "UV Index: \(curr.uvIndex)"
        iconImg.image = UIImage(named: curr.icon)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exit(_ sender: Any) {
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
