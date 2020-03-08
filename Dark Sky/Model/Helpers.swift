//
//  File.swift
//  Dark Sky
//
//  Created by Nicholas Wang on 3/7/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import Foundation
import UIKit

class Helpers {
    static func designButtons(_ btn: UIButton) {
        btn.backgroundColor = UIColor.systemBlue
        btn.layer.cornerRadius = 4
        btn.setTitleColor(UIColor.white, for: .normal)
    }
    
    static func goToSchool(_ curr: Weather) -> String {
        if curr.temperature < 30 && curr.temperature > 80 {
            return "Temperature too extreme"
        } else if curr.humidity < 0.3 || curr.humidity > 2 {
            return "Humidity too extreme"
        } else if curr.windSpeed > 8 {
            return "Wind Speed too high"
        } else if curr.visibility < 7.5 {
            return "Visibility too high"
        } else {
            return ""
        }
    }
}
