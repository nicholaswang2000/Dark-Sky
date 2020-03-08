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
}
