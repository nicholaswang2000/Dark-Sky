//
//  APIManager.swift
//  Dark Sky
//
//  Created by Nicholas Wang on 3/5/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class APIManager {
    
    static func getLocation(_ myLocation:CLLocation, _ completion: @escaping (Weather) -> ()) {
        let urlStr = "https://api.darksky.net/forecast/8d29ba93fca67043efd36cda49c585e6/\(myLocation.coordinate.latitude),\(myLocation.coordinate.longitude)"
        
        guard let url = URL(string: urlStr) else {
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            // Decode JSON and serialization
            let request = try! JSONDecoder().decode(WeatherRequest.self, from: data)
            
            print(request.currently)
            
            completion(request.currently)
            
        }
        task.resume()
    }
}