//
//  Weather.swift
//  Dark Sky
//
//  Created by Nicholas Wang on 3/5/20.
//  Copyright © 2020 Nicholas Wang. All rights reserved.
//

import Foundation

class WeatherRequest: Decodable {
    let currently: Weather
    
    enum CodingKeys: String, CodingKey {
        case currently
    }
    
    enum DataKeys: String, CodingKey {
        case time, summary, icon, nearestStormDistance, nearestStormBearing, temperature, apparentTemperature, dewPoint, humidity, pressure, windSpeed, windGust, windBearing, cloudCover, visibility, ozone, uvIndex
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        currently = try valueContainer.decode(Weather.self, forKey: .currently)
        
//        let currentlyContainer = try valueContainer.nestedContainer(keyedBy: DataKeys.self, forKey: .currently)
//        
//        currently = try currentlyContainer.decode(Weather.self, forKey: DataKeys.temperature)
    }
}

struct Weather: Decodable {
    
    let time:Int
    let summary:String
    let icon:String
    let nearestStormDistance:Int
    let nearestStormBearing:Int
    let temperature:Double
    let apparentTemperature:Double
    let dewPoint:Double
    let humidity:Double
    let pressure:Double
    let windSpeed:Double
    let windGust:Double
    let windBearing:Int
    let cloudCover:Double
    let visibility:Int
    let ozone:Double
    let uvIndex:Int
    
}
